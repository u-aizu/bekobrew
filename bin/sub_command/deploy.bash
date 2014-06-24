# Usage: bekobrew deploy {archive-file}
# e.g. bekobrew deploy hello-2.9-1.tar.bz

function deploy_main() {
  local archive_file=$1
  local local_dir=${HOME}/local/`uname -s`-`uname -m`
  mkdir -p ${local_dir} || true
  tar xvf ${archive_file} -C ${local_dir}
}

