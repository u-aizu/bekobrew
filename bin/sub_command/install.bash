# Usage: bekobrew install {package-name}
# e.g. bekobrew install hello

function install_main() {
  local tmpdir=`mktemp -d /tmp/bekobrew-XXXXXX`
  local package_name=''
  local package_version=''
  local package_release=''
  local package_depends=()

  pushd ${tmpdir}
  bekobrew get $1
  cd $1
  source BEKOBUILD

  local package_fullname=${package_name}-${package_version}-${package_release}

  # installed?
  grep ${package_fullname} ~/.bekobrew/installed_packages
  local ret=$?
  if [ ${ret} -ne 0 ]; then
    for dep in ${package_depends[@]}; do
      install_package ${dep}
    done
    bekobrew makepkg
    echo ${package_fullname} > ~/.bekobrew/installed_packages
  fi

  popd
  rm -rf ${tmpdir}
}

