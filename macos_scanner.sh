#!/bin/bash
# 银狐木马排查工具 - macOS版本
echo -e "\033[36m=== 银狐木马排查工具 (macOS) ===\033[0m"

# 1. 检查可疑进程
echo -e "\n\033[33m[1/5] 检查可疑进程...\033[0m"
ps aux | grep -iE "silverfox|foxservice|svchost" | grep -v grep
if [ $? -eq 0 ]; then
    echo -e "\033[31m发现可疑进程，请重点检查上述进程\033[0m"
fi

# 2. 检查启动项与LoginHook
echo -e "\n\033[33m[2/5] 检查开机启动项...\033[0m"
launchctl list | grep -iE "silverfox|unknown|malware"
defaults read com.apple.loginwindow LoginHook 2>/dev/null
defaults read com.apple.loginwindow LogoutHook 2>/dev/null

# 3. 检查LaunchAgents/LaunchDaemons
echo -e "\n\033[33m[3/5] 检查Launch配置...\033[0m"
launch_dirs=(
    "/Library/LaunchAgents"
    "/Library/LaunchDaemons"
    "$HOME/Library/LaunchAgents"
)
for dir in "${launch_dirs[@]}"; do
    echo "检查 $dir..."
    ls -la "$dir" | grep -iE "silverfox|foxservice|unknown"
done

# 4. 扫描恶意文件
echo -e "\n\033[33m[4/5] 扫描恶意文件...\033[0m"
scan_dirs=("/tmp" "/var/tmp" "$HOME/Downloads" "$HOME/Documents" "/Applications")
for dir in "${scan_dirs[@]}"; do
    find "$dir" -type f \( -name "*.silverfox" -o -name "*silverfox*" -o -name "SilverFox.app" \) 2>/dev/null
done

# 5. 检查网络连接
echo -e "\n\033[33m[5/5] 检查可疑网络连接...\033[0m"
lsof -i -P | grep -iE "listen|established" | grep -v ":22\|:80\|:443" | grep -v "127.0.0.1"

echo -e "\n\033[36m排查完成，若发现可疑项建议使用专业安全工具进一步扫描\033[0m"
