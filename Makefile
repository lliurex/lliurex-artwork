#color constants
COLOR_NONE = \x1b[0m
COLOR_GREEN = \x1b[32;01m
COLOR_RED = \x1b[31;01m

%.render:
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	mkdir -p wallpapers/$(basename $@)/contents
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/1920x1080.png -w 1920 -h 1080 wallpapers/$(subst render,svg,$@)
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/1280x720.png -w 1280 -h 720 wallpapers/$(subst render,svg,$@)

lliurex-desktop: lliurex-desktop.render

wallpapers: lliurex-desktop

build: wallpapers

all: build

clean:
	rm -rf wallpapers/lliurex-desktop/contents

install: build
	@echo -e '$(COLOR_RED)* creating paths... $(COLOR_NONE)'
	mkdir -p /usr/share/wallpapers
	mkdir -p /usr/share/aurorae/themes
	mkdir -p /usr/share/plasma/desktoptheme

	@echo -e '$(COLOR_RED)* installing... $(COLOR_NONE)'
	#plasma theme
	cp -r themes/lliurex-desktop /usr/share/plasma/desktoptheme/
	
	#wallpapers
	cp -r wallpapers/lliurex-desktop /usr/share/wallpapers/
	
	#xdg files
	cp -r defaults/xdg/* /etc/xdg/
	
	#skel files
	cp -r defaults/skel/* /etc/skel/
	
	#kwin theme
	cp -r aurorae/lliurex /usr/share/aurorae/themes/
	
	#color scheme
	cp -r color-schemes/* /usr/share/color-schemes/

uninstall:
	rm -rf /usr/share/plasma/desktoptheme/lliurex-desktop
	rm -rf /usr/share/wallpapers/lliurex-desktop


.PHONY: all clean install uninstall build