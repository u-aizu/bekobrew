# Usage: makepkg [...]

function beko_config() {
  ./configure --prefix=${HOME}/local/`uname -s`-`uname -m` $@
}

function is_function() {
  [[ `type -t $1` == 'function' ]]
}

function is_http_url() {
  [[ "$1" =~ ^https?:\/\/ ]]
}

function is_ftp_url() {
  [[ "$1" =~ ^ftp:\/\/ ]]
}

function makepkg_main() {
  local current_dir=`pwd`

  shopt -u extglob
  source ${current_dir}/BEKOBUILD
  shopt -s extglob

  local tmpdir=`mktemp -d /tmp/bekobrew-XXXXXX`
  local source_dir=${tmpdir}/source
  local package_dir=${tmpdir}/package

  pushd ${tmpdir}

  # create source dir
  mkdir -p "${source_dir}"
  chmod a-s "${source_dir}"

  cd ${source_dir}

  for item in ${source[@]}; do
    if is_http_url ${item} || is_ftp_url ${item}; then
      wget --no-check-certificate -c ${item}
      [[ "${item}" =~ .*\/(.+)$ ]]
      filename=${BASH_REMATCH[1]}
      tar xvf ${filename}
    else
      cp ${current_dir}/${item} ${source_dir}
    fi
  done

  echo '==> Preparing...'
  is_function prepare && cd ${current_dir} && prepare

  echo '==> Building...'
  cd ${current_dir} && build

  echo '==> Checking...'
  is_function check && cd ${current_dir} && check

  echo '==> Packaging...'
  cd ${current_dir} && package

  popd

  rm -rf ${tmpdir}
}

