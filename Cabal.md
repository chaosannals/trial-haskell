# Cabal

如今 Cabal 已经是 版本 3.x ，早先的 v2-* 开头命令在第 Cabal2 版本已经成为标准。

```bash
# 构建全部
cabal build

# 指定项目
cabal build [name]
```

注：Cabal 搜索源文件，模块名字和目录文件名是对应的。

## 国内镜像

创建 ~/.cabal/config 文件，写下国内源，不然下载很慢。
```ini
repository mirrors.ustc.edu.cn
  url: https://mirrors.ustc.edu.cn/hackage/
  secure: True
```
