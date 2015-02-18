# vim:ft=make
#

HOME:= $(shell cd ~; pwd)
mkdir_p= mkdir -p
dirstamp= .dirstamp
EDITOR=vim

.SUFFIXES:

VPATH= ${HOME}

bundle: bundle/$(dirstamp)
syntax: syntax/$(dirstamp)

syntax/$(dirstamp) bundle/$(dirstamp):
	@$(mkdir_p) $(@D)
	@touch $@


.PHONY: all
all: syntax/m4.vim bundle/Vundle.vim

.PHONY: install
install: all ${HOME}/.vimrc ${HOME}/.vim/gvimrc
	@cp -a bundle $(HOME)/.vim/
	@cp -a syntax $(HOME)/.vim/
	@vim +PluginClean! +qall < `tty` > `tty`
	@vim +PluginInstall +qall < `tty` > `tty`
	@$(MAKE) check

.PHONY: check
check: all
	@vim -u vimrc +qall < `tty` > `tty`

.PHONY: update
update:
	@vim +PluginInstall! +qall < `tty` > `tty`

bundle/Vundle.vim: bundle/$(dirstamp)
	@if [ -d bundle/Vundle.vim ]; then cd $@ && git pull --quiet; fi
	@if [ ! -d bundle/Vundle.vim ]; then git clone https://github.com/gmarik/vundle.git $@; fi
	
${HOME}/.vimrc: vimrc
	-@cp vimrc $@

${HOME}/.vim/gvimrc: gvimrc
	-@cp gvimrc $@

syntax/m4.vim: syntax/$(dirstamp)
	@curl --silent --show-error -o $@ http://www.vim.org/scripts/download_script.php?src_id=5158

.PHONY: uninstall
uninstall:
	@if [ -a $(HOME)/.vimrc ]; then rm $(HOME)/.vimrc; fi
	@if [ -a $(HOME)/.vim/gvimrc ]; then rm $(HOME)/.vim/gvimrc; fi
	@if [ -d $(HOME)/.vim/bundle ]; then rm -rf $(HOME)/.vim/bundle; fi
	@if [ -d $(HOME)/.vim/syntax ]; then rm -rf $(HOME)/.vim/syntax; fi

.PHONY: clean
clean:
	@vim +PluginClean +qall < `tty` > `tty`
	@rm -rf bundle
	@rm -rf syntax
