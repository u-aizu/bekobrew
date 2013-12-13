# テスト用

# wget mock
wget() {
  # wget -o {dest} {url}
  echo wget: this is dummy
  echo args: $@
  dest=$2
  url=$3
  cp ./bekobrew-latest.tar.gz ${dest}
}

BEKOBREW_NOSTART=0

# install.shを実行する
. install.sh

