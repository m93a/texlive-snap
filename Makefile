DESTDIR ?= /usr/local/texlive

build:
	make clean
	make fetch
	make rename-installer-folder

fetch:
	wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
	tar -xzf install-tl-unx.tar.gz
	rm install-tl-unx.tar.gz

rename-installer-folder:
	find -name install-tl* -type d -execdir bash -c 'mv {} install-tl' \; || true

clean:
	rm -f install-tl-unx.tar.gz
	rm -f install-tl-unx.tar.gz.*
	rm -rf install-tl*/
	rm -f texlive.profile

install:
	make configure
	make install-configured

configure:
	rm -f texlive.profile
	echo selected_scheme scheme-basic >> texlive.profile
	echo TEXDIR $(DESTDIR)/dist >> texlive.profile
	echo TEXMFLOCAL $(DESTDIR)/texmf-local >> texlive.profile
	echo TEXMFSYSVAR $(DESTDIR)/dist/texmf-var >> texlive.profile
	echo TEXMFSYSCONFIG $(DESTDIR)/dist/texmf-config >> texlive.profile

install-configured:
	echo I | ./install-tl/install-tl -no-cls -profile texlive.profile
