#color constants
COLOR_NONE = \x1b[0m
COLOR_GREEN = \x1b[32;01m
COLOR_RED = \x1b[31;01m

previews:
	@echo -e '$(COLOR_RED)* rendering previews $(COLOR_NONE)'
	mkdir -p look-and-feel/lliurex-desktop/contents/previews/
	mkdir -p look-and-feel/lliurex-desktop-classic/contents/previews/
	
	rsvg-convert -f png --width=300 --height=169 -o look-and-feel/lliurex-desktop-classic/contents/previews/preview.png preview-classic.svg 
	
	rsvg-convert -f png --width=300 --height=169 -o look-and-feel/lliurex-desktop/contents/previews/preview.png preview-default.svg

%.render:
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	mkdir -p wallpapers/$(basename $@)/contents/images
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1920x1080.png -w 1920 -h 1080 wallpapers/$(subst render,svg,$@)
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1408x792.png -w 1408 -h 792 wallpapers/$(subst render,svg,$@)
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1280x720.png -w 1280 -h 720 wallpapers/$(subst render,svg,$@)
	rsvg-convert -f png -o wallpapers/$(basename $@)/contents/images/1152x648.png -w 1152 -h 648 wallpapers/$(subst render,svg,$@)

lliurex-desktop: lliurex-desktop.render

wallpapers: lliurex-desktop

build: wallpapers previews

all: build

clean:
	rm -rf wallpapers/lliurex-desktop/contents
	rm -rf look-and-feel/lliurex-desktop/contents/previews
	rm -rf look-and-feel/lliurex-desktop-classic/contents/previews

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
	mkdir -p $(DESTDIR)/usr/share/kservices5/searchproviders/
	mkdir -p $(DESTDIR)/usr/share/sddm/themes/
	mkdir -p $(DESTDIR)/usr/lib/sddm/sddm.conf.d/
	mkdir -p $(DESTDIR)/usr/lib/systemd/system/sddm.conf.d/
	mkdir -p $(DESTDIR)/etc/dconf/profile/
	mkdir -p $(DESTDIR)/etc/dconf/db/lliurex.d/

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
	cp -r defaults/skel/.?* $(DESTDIR)/etc/skel/

#xdg files
	cp -r defaults/xdg/lliurex/ $(DESTDIR)/etc/xdg/

#color scheme
	cp -r color-schemes/* $(DESTDIR)/usr/share/color-schemes/

#search providers
	cp -r defaults/searchproviders/* $(DESTDIR)/usr/share/kservices5/searchproviders/

#sddm themes
	cp -r sddm/* $(DESTDIR)/usr/share/sddm/themes/

#sddm settings
	cp -r defaults/sddm/* $(DESTDIR)/usr/lib/sddm/sddm.conf.d/

#sddm service override
	cp -r defaults/systemd/* $(DESTDIR)/usr/lib/systemd/system/

#dconf
	cp -r defaults/dconf/lliurex $(DESTDIR)/etc/dconf/profile/
	cp -r defaults/dconf/*settings $(DESTDIR)/etc/dconf/db/lliurex.d/
	
	@echo -e "You may want to perfom a dconf update as root"

#icon theme
	cp -r icons/lliurex $(DESTDIR)/usr/share/icons/

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

#color scheme
	rm -rf $(DESTDIR)/usr/share/color-schemes/lliurex.colors

#searchproviders
	rm -rf $(DESTDIR)/usr/share/kservices5/searchproviders/foroLliurex.desktop

#sddm themes
	rm -rf $(DESTDIR)/usr/share/sddm/themes/lliurex-*
	
#sddm settings
	rm -rf $(DESTDIR)/usr/lib/sddm/sddm.conf.d/*lliurex*

#sddm service override
	rm -rf $(DESTDIR)/usr/lib/systemd/system/sddm.service.d/*lliurex*

#dconf
	rm -rf $(DESTDIR)/etc/dconf/profile/lliurex
	rm -rf $(DESTDIR)/etc/dconf/db/lliurex.d

#icon theme
	rm -rf $(DESTDIR)/usr/share/icons/lliurex

.PHONY: all clean install uninstall build
