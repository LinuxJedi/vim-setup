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
all: syntax/m4.vim bundle/vundle

.PHONY: install
install: all ${HOME}/.vimrc
	@vim +BundleClean! +qall < `tty` > `tty`
	@vim +BundleInstall +qall < `tty` > `tty`
	@vim +BundleClean! +qall < `tty` > `tty`
	@$(MAKE) check

.PHONY: check
check: all
	@vim -u vimrc +qall < `tty` > `tty`

bundle/vundle: bundle/$(dirstamp)
	@if [ -d bundle/vundle ]; then cd $@ && git pull --quiet; fi
	@if [ ! -d bundle/vundle ]; then git clone https://github.com/gmarik/vundle.git $@; fi
#	@if [ -d bundle/vundle ]; then \
#		git --work-tree $@ pull \
#	else \
#		git clone https://github.com/gmarik/vundle.git $@ \
	
${HOME}/.vimrc: vimrc
	-@cp vimrc $@

syntax/m4.vim: syntax/$(dirstamp)
	@curl --silent --show-error -o $@ http://www.vim.org/scripts/download_script.php?src_id=5158

.PHONY: uninstall
uninstall: clean
	@if [ -L $(HOME)/.vimrc ]; then rm $(HOME)/.vimrc; fi

.PHONY: clean
clean:
	@vim +BundleClean! +qall < `tty` > `tty`
	@if [ -L $(HOME)/.vimrc ]; then rm $(HOME)/.vimrc; fi
	@rm -rf bundle
