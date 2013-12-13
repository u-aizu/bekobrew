#
# Bekobrew Installer (Version 0.0.0)
#
# Copyright (c) 2013 Hiroyuki Sano
#
# Licensed under MIT License.
# http://opensource.org/licenses/MIT
#

# コマンドが0以外のステータスで終了した場合、一部の場合を除いて即座に終了する
set -e
# 未定義の変数を参照するとエラー・メッセージを表示する
set -u

#
# オプション
#

# インストール先のディレクトリ(Default: ~/.bekobrew)
BEKOBREW_HOME=${BEKOBREW_HOME:-~/.bekobrew}
readonly BEKOBREW_HOME

# アーカイブのURL
BEKOBREW_ARCHIVE=${BEKOBREW_ARCHIVE:-https://github.com/u-aizu/bekobrew/archive/latest.tar.gz}
readonly BEKOBREW_ARCHIVE

# 処理の開始(Default: 0)
# 0: 開始する, 1: 開始しない
BEKOBREW_NOSTART=${BEKOBREW_NOSTART:-0}
readonly BEKOBREW_NOSTART

#
# 変数
#

# 作業用ディレクトリ
tmpdir=

#
# 関数
#

# ここから開始
install_start() {
  echo Install: start
  init_install

  # 最新版のアーカイブをダウンロードして展開する
  archive_file=${tmpdir}/latest.tar.gz
  wget -o ${archive_file} ${BEKOBREW_ARCHIVE} \
    && tar --directory ${tmpdir} -xf ${archive_file} \
    && cp -R ${tmpdir}/bekobrew-latest/* ${BEKOBREW_HOME}
  result=$?
  if [ $result -eq 0 ]; then
    echo Install: success
  else
    echo Install: fail
  fi

  echo Install: finish
}

# 初期化
init_install() {
  # 作業用のディレクトリを作成する
  tmpdir=`mktemp -d /tmp/bekobrew.XXXXXX`

  # インストール先のディレクトリを準備する
  if [ -d ${BEKOBREW_HOME} ]; then
    # TODO: 確認
    rm -r ${BEKOBREW_HOME}
  fi
  mkdir ${BEKOBREW_HOME}
  echo Install: init
}

if [ $BEKOBREW_NOSTART -eq 0 ]; then
  install_start
fi

