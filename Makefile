# #!/usr/bin/env make -f
# See LICENSE file for copyright and license details.

VERSION = $(shell git tag -l|tail -n 1|sed -e 's/^v//')
DESTDIR = /usr
SRC = vmux/__main__.py

all: install-wrapper

clean:
	@echo cleaning
	@rm -f vmux-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	mkdir -p vmux-${VERSION}
	cp -R LICENSE Makefile README.md ${SRC} vmux-${VERSION}
	tar -zcf vmux-${VERSION}.tar.gz vmux-${VERSION}
	rm -rf vmux-${VERSION}

install: vmux
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f ${SRC} ${DESTDIR}${PREFIX}/bin/vmux
	chmod 755 ${DESTDIR}${PREFIX}/bin/vmux

uninstall:
	@echo removing executable files from ${DESTDIR}${PREFIX}/bin
	rm -f ${DESTDIR}${PREFIX}/bin/vmux

.PHONY: clean dist install uninstall
