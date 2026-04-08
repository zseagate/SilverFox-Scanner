<#
.SYNOPSIS
银狐木马排查工具 - Windows版本
#>
Write-Host "=== 银狐木马排查工具 (Windows) ===" -ForegroundColor Cyan

# 1. 检查常见恶意进程
Write-Host "`n[1/6] 检查可疑进程..." -ForegroundColor Yellow
$maliciousProcesses = @("foxservice.exe", "xfolder32*", "svchost.exe", "*silverfox*", "pXDc9LSz.exe", "pQpfOm.exe")
$foundProcesses = Get-Process | Where-Object { $processName = $_.Name; $maliciousProcesses | Where-Object { $processName -like $_ } }
if ($foundProcesses) {
    Write-Host "发现可疑进程:" -ForegroundColor Red
    $foundProcesses | Format-Table Id, Name, Path, StartTime -AutoSize
} else {
    Write-Host "未发现已知恶意进程" -ForegroundColor Green
}

# 2. 检查注册表持久化项
Write-Host "`n[2/6] 检查注册表持久化项..." -ForegroundColor Yellow
$runKeys = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\AppInit_DLLs",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
)
foreach ($key in $runKeys) {
    Write-Host "检查 $key..."
    try {
        Get-ItemProperty -Path $key -ErrorAction Stop | Select-Object * | Format-List
    } catch {
        Write-Host "无法读取该注册表项" -ForegroundColor Gray
    }
}

# 3. 检查WMI事件订阅（银狐常用持久化方式）
Write-Host "`n[3/6] 检查WMI事件订阅..." -ForegroundColor Yellow
Get-WmiObject -Namespace root\subscription -Class __EventFilter -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "发现WMI事件过滤器: $($_.Name)" -ForegroundColor Red
    Write-Host "查询语句: $($_.Query)"
}

# 4. 检查计划任务
Write-Host "`n[4/6] 检查计划任务..." -ForegroundColor Yellow
Get-ScheduledTask | Where-Object { $_.TaskName -like "*Task1*" -or $_.Description -like "*SilverFox*" } | Format-Table TaskName, State, Description -AutoSize

# 5. 检查常见恶意文件路径
Write-Host "`n[5/6] 扫描恶意文件路径..." -ForegroundColor Yellow
$scanPaths = @(
    "C:\ProgramData\xfolder32",
    "C:\Users\Public\Documents\",
    $env:TEMP,
    "C:\Users\$env:USERNAME\AppData\Local\Temp"
)
foreach ($path in $scanPaths) {
    if (Test-Path $path) {
        Write-Host "扫描 $path..."
        Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "svchost64\.exe|.*\.silverfox|!!!文件恢复指南.*" } | ForEach-Object {
            Write-Host "发现可疑文件: $($_.FullName)" -ForegroundColor Red
        }
    }
}

# 6. 检查Windows Defender排除项（银狐常篡改此配置）
Write-Host "`n[6/6] 检查Windows Defender排除路径..." -ForegroundColor Yellow
$exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
if ($exclusions) {
    Write-Host "发现排除路径:" -ForegroundColor Red
    $exclusions | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "未发现异常排除路径" -ForegroundColor Green
}

Write-Host "`n排查完成，若发现上述可疑项目，请立即断网并使用专杀工具清理" -ForegroundColor Cyan
