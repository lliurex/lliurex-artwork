#color constants
COLOR_NONE = \x1b[0m
COLOR_GREEN = \x1b[32;01m
COLOR_RED = \x1b[31;01m

#default install path
PREFIX = /usr/local

%.png : %.svg
	@echo -e '$(COLOR_RED)* rendering [$@] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ $<

wallpapers: wallpapers/lliurex-19-mountains.png

build: wallpapers

all: build

clean:
	rm -rf wallpapers/*.png

install: build
	@echo -e '$(COLOR_RED)* creating paths... $(COLOR_NONE)'
	mkdir -p /usr/share/wallpapers
	mkdir -p /usr/share/aurorae/themes

	@echo -e '$(COLOR_RED)* installing... $(COLOR_NONE)'
	cp wallpapers/*.png /usr/share/wallpapers/
	
	cp -r defaults/xdg/* /etc/xdg/
	
	cp -r defaults/skel/* /etc/skel/
	
	cp -r aurorae/lliurex /usr/share/aurorae/themes/
	
	cp -r color-schemes/* /usr/share/color-schemes/

uninstall:
	rm -f /usr/share/wallpapers/lliurex*


.PHONY: all clean install uninstall build