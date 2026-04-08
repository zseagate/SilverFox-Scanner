#!/bin/bash
# 银狐木马排查工具 - Linux版本
echo -e "\033[36m=== 银狐木马排查工具 (Linux) ===\033[0m"

# 1. 检查可疑进程
echo -e "\n\033[33m[1/5] 检查可疑进程...\033[0m"
ps aux | grep -iE "silverfox|foxservice|svchost|minerd|xmrig" | grep -v grep
if [ $? -eq 0 ]; then
    echo -e "\033[31m发现可疑进程，请重点检查上述进程\033[0m"
fi

# 2. 检查开机启动项
echo -e "\n\033[33m[2/5] 检查开机启动项...\033[0m"
systemctl list-unit-files --type=service | grep -iE "silverfox|malware|unknown"
crontab -l 2>/dev/null | grep -iE "curl|wget|bash|python.*http"
cat /etc/crontab | grep -iE "curl|wget|bash|python.*http"

# 3. 检查恶意文件
echo -e "\n\033[33m[3/5] 扫描常见恶意路径...\033[0m"
scan_dirs=("/tmp" "/var/tmp" "/dev/shm" "/root" "/home")
for dir in "${scan_dirs[@]}"; do
    echo "扫描 $dir..."
    find "$dir" -type f \( -name "*.silverfox" -o -name "*silverfox*" -o -name "foxservice" \) 2>/dev/null
done

# 4. 检查网络连接
echo -e "\n\033[33m[4/5] 检查可疑网络连接...\033[0m"
netstat -antp 2>/dev/null | grep -iE "estab|listen" | grep -v ":22\|:80\|:443" | grep -v "127.0.0.1"

# 5. 检查最近修改的文件
echo -e "\n\033[33m[5/5] 检查最近24小时修改的可执行文件...\033[0m"
find / -type f -mtime -1 -perm /u+x 2>/dev/null | grep -vE "/bin|/sbin|/usr/bin|/usr/sbin" | head -20

echo -e "\n\033[36m排查完成，若发现可疑项请及时隔离并清理\033[0m"
