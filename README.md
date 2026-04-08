# 银狐木马排查工具 (SilverFox Scanner)
 
跨平台银狐(SilverFox)木马检测工具，支持Windows、Linux、macOS三大操作系统，快速识别木马感染风险。
 
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-blue.svg)]()
[![Version](https://img.shields.io/badge/version-1.0-green.svg)]()
 
---
 
## 🔍 工具介绍
银狐木马是近年活跃的恶意软件，常通过钓鱼邮件、恶意Office文档、漏洞利用等方式传播，具备文件加密、数据窃取、横向渗透等危害。本工具针对银狐木马的典型行为特征开发，可帮助用户快速检测系统是否被感染。
帮我生成 项目顶部图片 
### 检测能力
- ✅ 已知恶意进程检测
- ✅ 持久化机制扫描（注册表、计划任务、WMI、启动服务等）
- ✅ 恶意文件特征匹配
- ✅ 系统配置异常检测（杀毒软件排除项、登录钩子等）
- ✅ 异常网络连接识别
 
---
 
## 📋 支持平台
| 操作系统 | 脚本路径 | 运行要求 |
|----------|----------|----------|
| Windows | scanners/windows_scanner.ps1 | PowerShell 5.1+，管理员权限 |
| Linux | scanners/linux_scanner.sh | Bash 4.0+，root权限 |
| macOS | scanners/macos_scanner.sh | Bash 4.0+，sudo权限 |
 
---
 
## 🚀 快速使用
 
### Windows系统
1. 右键点击开始菜单，选择「Windows PowerShell (管理员)」
2. 执行以下命令允许脚本运行（首次运行需要）：
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
下载脚本并运行：
powershell

cd 脚本所在目录
.\windows_scanner.ps1

### Linux系统
bash

# 下载脚本
wget https://raw.githubusercontent.com/zseagate/SilverFox-Scanner/main/scanners/linux_scanner.sh
 
# 添加执行权限
chmod +x linux_scanner.sh
 
# 运行扫描
sudo ./linux_scanner.sh

### macOS系统
bash

# 下载脚本
curl -O https://raw.githubusercontent.com/zseagate/SilverFox-Scanner/main/scanners/macos_scanner.sh
 
# 添加执行权限
chmod +x macos_scanner.sh
 
# 运行扫描
sudo ./macos_scanner.sh


⚠️ 结果解读
扫描结果中若出现红色⚠️标记的可疑项，请按照以下优先级处置：

紧急处置步骤
立即断网：断开受感染设备的网络连接，防止木马进一步扩散
隔离设备：将设备从企业内网隔离，避免横向渗透
数据恢复：清理完成后，使用备份恢复未受感染的文件
系统加固：修改所有账号密码、更新系统补丁、禁用Office宏

🛡️ 防护建议
❌ 不打开来源不明的邮件附件、压缩包和可执行文件
❌ 不随意点击陌生链接，不扫描来源不明的二维码
✅ 禁用Office默认宏功能，打开陌生文档前确认安全性
✅ 保持操作系统和杀毒软件病毒库为最新版本
✅ 服务器避免使用弱密码，关闭不必要的对外端口
✅ 定期备份重要文件，采用3-2-1备份策略（3份备份、2种介质、1份离线）


⚠️ 结果解读
扫描结果中若出现红色⚠️标记的可疑项，请按照以下优先级处置：

紧急处置步骤
立即断网：断开受感染设备的网络连接，防止木马进一步扩散
隔离设备：将设备从企业内网隔离，避免横向渗透

使用专杀工具清理：
火绒银狐专杀：下载地址：https://down5.huorong.cn/tools/Hrkill-SilverFox.exe
深信服专杀工具：下载地址：https://download.sangfor.com.cn/download/product/edr/antivirus_tool/sfakiller_x64.exe

数据恢复：清理完成后，使用备份恢复未受感染的文件
系统加固：修改所有账号密码、更新系统补丁、禁用Office宏

🛡️ 防护建议
❌ 不打开来源不明的邮件附件、压缩包和可执行文件
❌ 不随意点击陌生链接，不扫描来源不明的二维码
✅ 禁用Office默认宏功能，打开陌生文档前确认安全性
✅ 保持操作系统和杀毒软件病毒库为最新版本
✅ 服务器避免使用弱密码，关闭不必要的对外端口
✅ 定期备份重要文件，采用3-2-1备份策略（3份备份、2种介质、1份离线）
🤝 贡献指南
欢迎提交Issue和Pull Request来完善本项目：

Fork本项目到自己的GitHub账号
创建功能分支：git checkout -b feature/新功能名称
提交修改：git commit -m '添加xxx功能'
推送到分支：git push origin feature/新功能名称
提交Pull Request等待审核
提交前请确保代码符合对应平台的语法规范，并经过基本测试。

📄 开源协议
本项目采用 MIT 开源协议，你可以自由使用、修改和分发本项目，但请保留原作者信息。

⚠️ 免责声明
本工具仅用于安全检测和研究目的，请勿用于非法用途。使用本工具造成的任何后果由使用者自行承担。
