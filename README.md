# zsh 配置

## 安装

```bash
./link.sh
```

这会自动创建 `~/.zshrc` 和 `~/.p10k.zsh` 的符号链接。

然后在 `.bashrc` 或其他 shell 配置文件中添加：

```bash
exec zsh
```

这样打开终端时会自动切换到 zsh。