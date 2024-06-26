# [trial-haskell](https://github.com/chaosannals/trial-haskell)

这个语言有个比 C++ 还严重的问题。因为允许函数名由几个基本操作符随意组合（下划线被算作字母了，不在操作符之列），导致 ++ >>= &&. 各种自定义的符号函数名。而操作符在少量时方便使用，当大量的库拥有各自的符号，或者各个库的符号冲突时就很混乱。这点和数学语言很像，只有 + = * / 时非常好用，之后的越来越多各种 ∫ ∑ 奇怪的符号就会使得记忆困难。

## 安装

注：这里是使用了国内 科大源 进行安装，不然速度慢到会失败。

直接在 [科大镜像](https://mirrors.ustc.edu.cn/) 找，以下版本老的话是无效的。找最新的。

[镜像使用文档](https://mirrors.ustc.edu.cn/help/ghcup.html)

```pwsh
$env:BOOTSTRAP_HASKELL_YAML = 'https://mirrors.ustc.edu.cn/ghcup/ghcup-metadata/ghcup-0.0.6.yaml'
Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest https://mirrors.ustc.edu.cn/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -ArgumentList $true
```

注：Windows 下的 ghcup 的配置文件，文档提及是在 ~/.ghcup/config.yaml 下，但实测是放在安装目录下 config.yaml 文件。

注：Cabal 在源卡住时可以配置如下，然后再执行，不过执行后还是要再改一次。
Cabal 源，安装后，可以在 cabal 的安装目录下找到 config 文件。

找到下面配置：
```yaml
repository hackage.haskell.org
  url: http://hackage.haskell.org/
  -- secure: True
  -- root-keys:
  -- keys-threshold: 3
```

替换源为下面 科大源：

```yaml
repository mirrors.ustc.edu.cn
  url: https://mirrors.ustc.edu.cn/hackage/
  secure: True
```

## 语法

do 是一个链式，每一行都必须是相同的尾式。
当 do 被作为参数时，尾式由调用函数参数推到出来。
