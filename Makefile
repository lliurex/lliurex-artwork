#color constants
COLOR_NONE = \x1b[0m
COLOR_GREEN = \x1b[32;01m
COLOR_RED = \x1b[31;01m

%.render:
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	mkdir -p wallpapers/$(basename $@)/contents/images
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1920x1080.png -w 1920 -h 1080 wallpapers/$(subst render,svg,$@)
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1280x720.png -w 1280 -h 720 wallpapers/$(subst render,svg,$@)

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
	cp -r desktoptheme/lliurex-desktop /usr/share/plasma/desktoptheme/
	cp -r look-and-feel/lliurex-desktop /usr/share/plasma/look-and-feel/
	cp -r look-and-feel/lliurex-desktop-classic /usr/share/plasma/look-and-feel/
#wallpapers
	cp -r wallpapers/lliurex-desktop /usr/share/wallpapers/

#xsession files
	cp -r defaults/xsession/* /etc/X11/Xsession.d/

#xdg files
	cp -r defaults/xdg/lliurex/ /etc/xdg/

#kwin theme
	cp -r aurorae/lliurex /usr/share/aurorae/themes/

#color scheme
	cp -r color-schemes/* /usr/share/color-schemes/

uninstall:

#plasma theme
	rm -rf /usr/share/plasma/desktoptheme/lliurex-desktop
	rm -rf /usr/share/plasma/look-and-feel/lliurex-desktop
	rm -rf /usr/share/plasma/look-and-feel/lliurex-desktop-classic

#wallpaper
	rm -rf /usr/share/wallpapers/lliurex-desktop

#xsession
	rm -rf /etc/X11/Xsession.d/*lliurex*

#xdg
	rm -rf /etc/xdg/lliurex

#kwin theme
	rm -rf /usr/share/aurorae/themes/lliurex

#color scheme
	rm -rf /usr/share/color-schemes/lliurex.colors

.PHONY: all clean install uninstall build