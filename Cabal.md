# Cabal

```bash
# 更新库列表
cabal update

# 在当前目录下生成初始化的项目文件，dirname.cabal 以及其他文件。
cabal init
```

如今 Cabal 已经是 版本 3.x ，早先的 v2-* 开头命令在第 Cabal2 版本已经成为标准。

```bash
# 执行默认程序
cabal run

# 构建全部
cabal build

# 指定项目
cabal build [name]
```

cabal 的包都是卸载 *.cabal 文件下 build-depends 里面，没有安装包命令，也没有项目包目录。

注：Cabal 搜索源文件，模块名字和目录文件名是对应的。

## 国内镜像

创建 ~/.cabal/config 文件，写下国内源，不然下载很慢。
注：Windows 下该文件已经移动到安装目录下 config 文件，而非 ~/.cabal/config 。
```ini
repository mirrors.ustc.edu.cn
  url: https://mirrors.ustc.edu.cn/hackage/
  secure: True
```
