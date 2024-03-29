# [trial-haskell](https://github.com/chaosannals/trial-haskell)

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