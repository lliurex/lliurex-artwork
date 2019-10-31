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
	rsvg-convert -f png --width=300 --height=169 -o look-and-feel/lliurex-desktop/contents/previews/splash.png preview-splash.svg 

wallpapers/lliurex-%-background.png: wallpapers/lliurex-%.svg
	@echo -e '$(COLOR_RED)* rendering background [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<

wallpapers/lliurex-%.png: wallpapers/lliurex-%-background.png wallpapers/base.png
	@echo -e '$(COLOR_RED)* composing [$(basename $@)] $(COLOR_NONE)'
	convert $^ -composite $@

wallpapers/base.png: wallpapers/base.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<

wallpapers/xiquets.png: wallpapers/xiquets.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<

wallpapers/xiquet.png: wallpapers/xiquet.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<

wallpapers/lliurex-sunset.png: wallpapers/lliurex-sunset-background.png
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	cp $< $@

wallpapers/lliurex-xiquets.png: wallpapers/lliurex-neutral-background.png wallpapers/xiquets.png
	@echo -e '$(COLOR_RED)* composing [$(basename $@)] $(COLOR_NONE)'
	convert $^ -composite $@

wallpapers/lliurex-xiquet.png: wallpapers/lliurex-neutral-background.png wallpapers/xiquet.png
	@echo -e '$(COLOR_RED)* composing [$(basename $@)] $(COLOR_NONE)'
	convert $^ -composite $@

%.render: wallpapers/%.png
	@echo -e '$(COLOR_RED)* creating [$(basename $@)] $(COLOR_NONE)'
	mkdir -p wallpapers/$(basename $@)/contents/images
	cp $< wallpapers/$(basename $@)/contents/images/1920x1080.png
	convert $< -resize 1408x792 wallpapers/$(basename $@)/contents/images/1408x792.png
	convert $< -resize 1280x720 wallpapers/$(basename $@)/contents/images/1280x720.png
	convert $< -resize 1152x648 wallpapers/$(basename $@)/contents/images/1152x648.png

lliurex-desktop: lliurex-desktop.render
lliurex-classroom: lliurex-classroom.render
lliurex-infantil: lliurex-infantil.render
lliurex-musica: lliurex-musica.render
lliurex-sunset: lliurex-sunset.render
lliurex-xiquets: lliurex-xiquets.render
lliurex-xiquet: lliurex-xiquet.render

wallpapers: lliurex-desktop lliurex-classroom lliurex-infantil lliurex-musica lliurex-sunset lliurex-xiquets lliurex-xiquet

build: wallpapers previews

all: build

clean:
	rm -rf wallpapers/*.png
	rm -rf wallpapers/lliurex-desktop/contents
	rm -rf wallpapers/lliurex-classroom/contents
	rm -rf wallpapers/lliurex-infantil/contents
	rm -rf wallpapers/lliurex-musica/contents
	rm -rf wallpapers/lliurex-sunset/contents
	rm -rf wallpapers/lliurex-xiquets/contents
	rm -rf wallpapers/lliurex-xiquet/contents
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
	mkdir -p $(DESTDIR)/etc/dconf/profile/
	mkdir -p $(DESTDIR)/etc/dconf/db/lliurex.d/

	@echo -e '$(COLOR_RED)* installing... $(COLOR_NONE)'
#plasma theme
	cp -r desktoptheme/lliurex-desktop $(DESTDIR)/usr/share/plasma/desktoptheme/
	cp -r desktoptheme/lliurex-classroom $(DESTDIR)/usr/share/plasma/desktoptheme/
	cp -r look-and-feel/lliurex-desktop $(DESTDIR)/usr/share/plasma/look-and-feel/
	cp -r look-and-feel/lliurex-desktop-classic $(DESTDIR)/usr/share/plasma/look-and-feel/
#wallpapers
	cp -r wallpapers/lliurex-desktop $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-classroom $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-sunset $(DESTDIR)/usr/share/wallpapers/

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

#dconf
	cp -r defaults/dconf/lliurex $(DESTDIR)/etc/dconf/profile/
	cp -r defaults/dconf/*settings $(DESTDIR)/etc/dconf/db/lliurex.d/
	
	@echo -e "You may want to perfom a dconf update as root"

#icon theme
	cp -r icons/lliurex $(DESTDIR)/usr/share/icons/

uninstall:

#plasma theme
	rm -rf $(DESTDIR)/usr/share/plasma/desktoptheme/lliurex-desktop
	rm -rf $(DESTDIR)/usr/share/plasma/desktoptheme/lliurex-classroom
	rm -rf $(DESTDIR)/usr/share/plasma/look-and-feel/lliurex-desktop
	rm -rf $(DESTDIR)/usr/share/plasma/look-and-feel/lliurex-desktop-classic

#wallpaper
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-desktop
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-classroom
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-infantil
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-musica
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-sunset

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

#dconf
	rm -rf $(DESTDIR)/etc/dconf/profile/lliurex
	rm -rf $(DESTDIR)/etc/dconf/db/lliurex.d

#icon theme
	rm -rf $(DESTDIR)/usr/share/icons/lliurex

.PHONY: all clean install uninstall build
