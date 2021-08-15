build: fetch rename-installer-folder

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

install:
	echo I | ./install-tl/install-tl
