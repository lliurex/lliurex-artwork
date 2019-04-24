#color constants
COLOR_NONE = \x1b[0m
COLOR_GREEN = \x1b[32;01m
COLOR_RED = \x1b[31;01m

%.render:
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	mkdir -p wallpapers/$(basename $@)/contents/images
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1920x1080.png -w 1920 -h 1080 wallpapers/$(subst render,svg,$@)
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1408x792.png -w 1408 -h 792 wallpapers/$(subst render,svg,$@)
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1280x720.png -w 1280 -h 720 wallpapers/$(subst render,svg,$@)
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1152x648.png -w 1152 -h 648 wallpapers/$(subst render,svg,$@)

lliurex-desktop: lliurex-desktop.render

wallpapers: lliurex-desktop

build: wallpapers

all: build

clean:
	rm -rf wallpapers/lliurex-desktop/contents

install: build
	@echo -e '$(COLOR_RED)* creating paths... $(COLOR_NONE)'
	mkdir -p $(DESTDIR)/usr/share/wallpapers
	mkdir -p $(DESTDIR)/usr/share/color-schemes
	mkdir -p $(DESTDIR)/usr/share/aurorae/themes
	mkdir -p $(DESTDIR)/usr/share/plasma/desktoptheme
	mkdir -p $(DESTDIR)/usr/share/plasma/look-and-feel/
	mkdir -p $(DESTDIR)/etc/X11/Xsession.d
	mkdir -p $(DESTDIR)/etc/xdg
	mkdir -p $(DESTDIR)/etc/skel/

	@echo -e '$(COLOR_RED)* installing... $(COLOR_NONE)'
#plasma theme
	cp -r desktoptheme/lliurex-desktop $(DESTDIR)/usr/share/plasma/desktoptheme/
	cp -r look-and-feel/lliurex-desktop $(DESTDIR)/usr/share/plasma/look-and-feel/
	cp -r look-and-feel/lliurex-desktop-classic $(DESTDIR)/usr/share/plasma/look-and-feel/
#wallpapers
	cp -r wallpapers/lliurex-desktop $(DESTDIR)/usr/share/wallpapers/

#xsession files
	cp -r defaults/xsession/* $(DESTDIR)/etc/X11/Xsession.d/

#skel files
	cp -r defaults/skel/. $(DESTDIR)/etc/skel/

#xdg files
	cp -r defaults/xdg/lliurex/ $(DESTDIR)/etc/xdg/

#kwin theme
	cp -r aurorae/lliurex $(DESTDIR)/usr/share/aurorae/themes/

#color scheme
	cp -r color-schemes/* $(DESTDIR)/usr/share/color-schemes/

uninstall:

#plasma theme
	rm -rf $(DESTDIR)/usr/share/plasma/desktoptheme/lliurex-desktop
	rm -rf $(DESTDIR)/usr/share/plasma/look-and-feel/lliurex-desktop
	rm -rf $(DESTDIR)/usr/share/plasma/look-and-feel/lliurex-desktop-classic

#wallpaper
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-desktop

#xsession
	rm -rf $(DESTDIR)/etc/X11/Xsession.d/*lliurex*

#skel
	rm -rf $(DESTDIR)/etc/skel/.local/share/konsole

#xdg
	rm -rf $(DESTDIR)/etc/xdg/lliurex

#kwin theme
	rm -rf $(DESTDIR)/usr/share/aurorae/themes/lliurex

#color scheme
	rm -rf $(DESTDIR)/usr/share/color-schemes/lliurex.colors

.PHONY: all clean install uninstall build
