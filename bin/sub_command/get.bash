# Usage: bekobrew get {package name}

function get_package_info() {
  grep "^$1	" ~/.bekobrew/packages.db
  package_name=`grep "^$1	" ~/.bekobrew/packages.db     | cut -f1`
  package_version=`grep "^$1	" ~/.bekobrew/packages.db  | cut -f2`
  package_release=`grep "^$1	" ~/.bekobrew/packages.db  | cut -f3`
  package_url=`grep "^$1	" ~/.bekobrew/packages.db      | cut -f4`
  package_desc=`grep "^$1	" ~/.bekobrew/packages.db     | cut -f5`
  package_fullname=${package_name}-${package_version}-${package_release}
}

function get_main() {
  local tmpdir=`mktemp -d /tmp/bekobrew-XXXXXX`
  pushd ${tmpdir}
  get_package_info $1
  echo Download: ${package_fullname}
  wget --no-check-certificate -c ${package_url}
  tar xvf ${package_fullname}.tar.bz2
  popd
  mkdir -p ./${package_name} || true
  cp ${tmpdir}/${package_name}/BEKOBUILD ./${package_name}/
  rm -rf ${tmpdir}
}
