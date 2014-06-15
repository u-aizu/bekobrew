all: bekobrew installer

bekobrew: tmp/bekobrew

tmp/bekobrew: src/bekobrew.sh src/bekobrew/*.sh
	./script/build_bekobrew

gh-pages: installer

installer: tmp/installer.sh

tmp/installer.sh: src/installer.sh
	./script/build_installer

publish_bekobrew: bekobrew
	./script/travis/publish_bekobrew

publish_installer: installer
	./script/travis/publish_installer
