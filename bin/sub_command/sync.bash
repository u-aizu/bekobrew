# Usage: bekobrew sync

function sync_main() {
  mkdir -p ~/.bekobrew || true
  curl https://u-aizu.github.io/bekobrew/packages.db > ~/.bekobrew/packages.db
}
