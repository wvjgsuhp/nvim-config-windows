SHELL = /bin/bash
nvim ?= nvim
nvim_version := '${shell $(nvim) --version}'

update: update-plugins

upgrade: update

# create-dirs:
# 	@mkdir -vp ./spell "$(VIM_DATA_HOME)"/{backup,sessions,swap,undo,vsnip}

# update-repo:
# 	git pull --ff --ff-only

update-plugins:
	$(nvim) -V1 -es -i NONE -n --noplugin -u config/init.vim \
		-c "try | call dein#clear_state() | call dein#update() | finally | messages | qall! | endtry"
	@echo

# uninstall:
# 	rm -rf "$(VIM_DATA_HOME)"/dein
