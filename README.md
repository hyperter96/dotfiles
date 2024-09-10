# 💤 My LazyVim

## Features

- Programming Languages: Go, Rust, Haskell, Python, Java, Typescript, C++, Zig
- System Management: Bigfile, perfanno
- Artificial Intelligence: Ollama
- Color Theme Picker
- Leetcode
- DB Connection
- Source code Management: Octo, LazyGit

## WSL2 Ubuntu Setup

### Programming Languages

<details open>
<summary>Go</summary>
<li>
    <a href="https://go.dev/dl/">Go Download Page</a>
</li>
Rewrite go env if you wanna switch GOPROXY:
<pre>
$ go env -w GO111MODULE=on
$ go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct
</pre>
</details>

<details open>
<summary>Java</summary>
Install Java with the following:
<pre>
$ sudo apt install openjdk-21-jdk -y
</pre>
<li>
  <a href="https://maven.apache.org/download.cgi">Maven Download Page</a>
</li>
</details>

After installing Maven, add the mirror such as,

<pre>
$ vi ~/.maven/conf/settings.xml
</pre>

with the following settings edited,

```xml
<settings>
    <mirrors>
        <mirror>
            <id>alimaven</id>
            <name>aliyun maven</name>
            <mirrorOf>central</mirrorOf>
            <url>https://maven.aliyun.com/repository/central</url>
        </mirror>
    </mirrors>
</settings>
```

<details open>
<summary>Python 3.12</summary>
<pre>
// Install Python
$ apt update && apt upgrade -y
$ apt install software-properties-common -y
$ add-apt-repository ppa:deadsnakes/ppa
$ apt update
$ apt install python3.12

// Install pip
$ curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12

</pre>
If you wanna install packages with mirrors:
<pre>
$ cat ~/.pip/pip.conf
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host = mirrors.aliyun.com

ssl_verify: false

</pre>
add venv package,
<pre>$ apt install python3.10-venv</pre>
</details>

<details open>
<summary>Rust</summary>
<pre>$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh</pre>
If you wanna install packages with mirrors:
<pre>
$ cat ~/.cargo/config.toml
[source.crates-io]
replace-with = 'aliyun'

[source.aliyun]
registry = "sparse+https://mirrors.aliyun.com/crates.io-index/"

[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"

</pre>
</details>

<details open>
<summary>Lua</summary>
<li>
    Download LuaBinaries: <a href="https://sourceforge.net/projects/luabinaries/">LuaBinaries Download Page</a>
</li>
<li> 
    Download Lua: <a href="https://lua.org/download.html">Lua Download Page</a>
</li>
<li>
    Download LuaJit: <a href="http://luajit.org/download.html">LuaJit Download Page</a>
</li>
<li>Install Dependencies
<pre>$ sudo apt install build-essential libreadline-dev unzip libssl-dev</pre>
</li>
<li>Install Lua
<pre>
$ cd $lua_folder
$ make
$ sudo make install
</pre>
</li>
<li> Install LuaJit
<pre>
$ tar zxf LuaJIT-2.1.0-beta2.tar.gz 
$ cd LuaJIT-2.1.0-beta2
$ make
$ make install
</pre>
</li>
<li> Install LuaRocks & Dependencies
<pre>
$ sudo apt install luarocks
$ luarocks install lua-curl
$ luarocks install luafilesystem
$ luarocks install say
$ luarocks install luarocks-build-treesitter-paser
$ luarocks install luassert
$ luarocks install magick
$ luarocks install mimetypes
$ luarocks install nvim-nio
$ luarocks install xml2lua
</pre>
  </li>
</details>

<details open>
<summary>Vue</summary>
In order to use Volar, please add the following to the file:
<pre>
// tsconfig.json
{
  "compilerOptions": {
    // ...
    "types": ["element-plus/global"]
  }
}
</pre>
</details>

### Tools

<details>
<summary>fzf</summary>
<pre>$ sudo apt install fzf</pre>
</details>

<details>
<summary>ripgrep</summary>
<pre>$ sudo apt install ripgrep</pre>
</details>

<details>
<summary>proto_language_server</summary>
<pre>$ go install github.com/lasorda/protobuf-language-server@latest</pre>
</details>

<details>
<summary>chrome</summary>
<pre>
<code lang="bash">

$ curl -O https://packages.cloud.google.com/apt/doc/apt-key.gpg && sudo apt-key add apt-key.gpg
$ sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

$ sudo apt-get update
$ sudo apt-get install google-chrome-stable
</code>

</pre>
</details>

<details>
<summary>lazygit</summary>
<li>
Lazygit: <a href="https://sourceforge.net/projects/lazygit.mirror/">Lazygit Download Page</a>
</li>
<li>
Installation of delta: <pre> $cargo install git-delta </pre>
</li>
<li>
Lazygit Config file for side-by-side diff view:
<pre>
git: 
  paging:
    colorArg: always
    pager: delta --dark --paging=never --syntax-theme base16-256 -s
</pre>
</li>
</details>

<details>
<summary>git</summary>
<li>
git: <a href="https://git-scm.com/download/win">git Download Page</a>
</li>
</details>

<details>
<summary>cmake</summary>
<li>
cmake: <a href="https://cmake.org/download/">cmake Download Page</a>
</li>
</details>

<details>
<summary>gh</summary>
<pre>$ (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
</pre>
then use the following command to login:
<pre>$ gh auth login
</pre>
</details>

<details>
<summary>gcc</summary>
<pre>$ sudo apt install build-essential </pre>
</details>

<details>
<summary>ca-certificates, curl, gnupg</summary>
<pre>$ sudo apt install -y ca-certificates curl gnupg</pre>
</details>

<details>
<summary>nvm</summary>
Install `nvm` package manager & node.js:
<pre>
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
$ nvm install 21
</pre>
After finishing installed, config the npm mirror if you like,
<pre>$ npm config set registry http://mirrors.cloud.tencent.com/npm/</pre>
</details>

<details>
<summary>yarn</summary>
<pre>$ npm install --global yarn</pre>
</details>

<details>
<summary>ollama</summary>
<pre>$ curl -fsSL https://ollama.com/install.sh | sh</pre>
</details>

<details>
<summary>ImageMagick</summary>
<pre>$ sudo apt install libmagickwand-dev</pre>
</details>

<details>
<summary>wasm_nvim</summary>
Build from source:
<pre>
$ cd ~/.local/share/nvim/lazy/wasm_nvim/
$ cargo make build
</pre>
</details>

### Terminal UI

<details>
<summary>neovide</summary>
<li>
    Requirements: nvim & neovide installed on Windows
</li>
<li>
    Add the Environment Variable for nvim in the file .profile on WSL2
</li>
<li>
  Install neovide on Windows by:
    <pre>scoop install neovide</pre>
</li>
<li>Edit the config.toml of neovide on Windows:
  <pre>
  $ vi C:\Users\${username}\AppData\Roaming\neovide\config.toml
  frame = "none"
  wsl = true
  </pre>
</li>
</details>
