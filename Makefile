#color constants
COLOR_NONE = \x1b[0m
COLOR_GREEN = \x1b[32;01m
COLOR_RED = \x1b[31;01m

previews:
	@echo -e '$(COLOR_RED)* rendering previews $(COLOR_NONE)'
	mkdir -p look-and-feel/net.lliurex.default/contents/previews/
	mkdir -p look-and-feel/net.lliurex.classic/contents/previews/
	
	rsvg-convert -f png --width=300 --height=169 -o look-and-feel/net.lliurex.classic/contents/previews/preview.png preview-classic.svg 
	
	rsvg-convert -f png --width=300 --height=169 -o look-and-feel/net.lliurex.default/contents/previews/preview.png preview-default.svg
	rsvg-convert -f png --width=300 --height=169 -o look-and-feel/net.lliurex.default/contents/previews/splash.png preview-splash.svg 
	cp look-and-feel/net.lliurex.default/contents/previews/splash.png look-and-feel/net.lliurex.default/contents/previews/lockscreen.png
	cp look-and-feel/net.lliurex.default/contents/previews/splash.png look-and-feel/net.lliurex.classic/contents/previews/splash.png
	cp look-and-feel/net.lliurex.default/contents/previews/lockscreen.png look-and-feel/net.lliurex.classic/contents/previews/lockscreen.png

wallpapers/lliurex-%-background.png: wallpapers/%-background.svg
	@echo -e '$(COLOR_RED)* rendering background [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<

wallpapers/lliurex-%.png: wallpapers/lliurex-%-background.png wallpapers/base.png
	@echo -e '$(COLOR_RED)* composing [$(basename $@)] $(COLOR_NONE)'
	convert $^ -composite $@

wallpapers/base.png: wallpapers/21.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<

wallpapers/xiquets.png: wallpapers/xiquets.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<

wallpapers/xiquet.png: wallpapers/xiquet.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<

wallpapers/lliurex-sunset.png: wallpapers/lliurex-sunset.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<
	cp $< $@

wallpapers/lliurex-xiquets.png: wallpapers/lliurex-neutral-background.png wallpapers/xiquets.png
	@echo -e '$(COLOR_RED)* composing [$(basename $@)] $(COLOR_NONE)'
	convert $^ -composite $@

wallpapers/lliurex-xiquet.png: wallpapers/lliurex-neutral-background.png wallpapers/xiquet.png
	@echo -e '$(COLOR_RED)* composing [$(basename $@)] $(COLOR_NONE)'
	convert $^ -composite $@

wallpapers/lliurex-fp.png: wallpapers/lliurex-fp.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o $@ -w 1920 -h 1080 $<
	cp $< $@

wallpapers/lliurex-19.png: wallpapers/base.svg wallpapers/lliurex-desktop.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o wallpapers/base-19.png -w 1920 -h 1080 wallpapers/base.svg
	rsvg-convert -f png -o wallpapers/lliurex-19.png -w 1920 -h 1080 wallpapers/lliurex-desktop.svg
	convert wallpapers/lliurex-19.png  wallpapers/base-19.png -composite wallpapers/lliurex-19.png

wallpapers/lliurex-19+1.png: wallpapers/19+1.svg wallpapers/lliurex-desktop.svg
	@echo -e '$(COLOR_RED)* rendering [$(basename $@)] $(COLOR_NONE)'
	rsvg-convert -f png -o wallpapers/base-19+1.png -w 1920 -h 1080 wallpapers/19+1.svg
	rsvg-convert -f png -o wallpapers/lliurex-19+1.png -w 1920 -h 1080 wallpapers/lliurex-desktop.svg
	convert wallpapers/lliurex-19+1.png  wallpapers/base-19+1.png -composite wallpapers/lliurex-19+1.png

wallpapers/21.png: wallpapers/21.svg
	@echo -e '$(COLOR_RED)* rendering [$@] $(COLOR_NONE)'
	rsvg-convert -f png -o wallpapers/21.png -w 5000 -h 2813 wallpapers/21.svg

wallpapers/22.png: wallpapers/22.svg
	@echo -e '$(COLOR_RED)* rendering [$@] $(COLOR_NONE)'
	rsvg-convert -f png -o wallpapers/22.png -w 5000 -h 2813 wallpapers/22.svg

wallpapers/22.4.3.png: wallpapers/22.4.3.svg
	@echo -e '$(COLOR_RED)* rendering [$@] $(COLOR_NONE)'
	rsvg-convert -f png -o wallpapers/22.4.3.png -w 3750 -h 2813 wallpapers/22.4.3.svg

wallpapers/21.4.3.png: wallpapers/21.4.3.svg
	@echo -e '$(COLOR_RED)* rendering [$@] $(COLOR_NONE)'
	rsvg-convert -f png -o wallpapers/21.4.3.png -w 3750 -h 2813 wallpapers/21.4.3.svg

%.render: wallpapers/%.png
	@echo -e '$(COLOR_RED)* creating [$(basename $@)] $(COLOR_NONE)'
	mkdir -p wallpapers/$(basename $@)/contents/images
	cp $< wallpapers/$(basename $@)/contents/images/1920x1080.png
	convert $< -resize 1408x792 wallpapers/$(basename $@)/contents/images/1408x792.png
	convert $< -resize 1280x720 wallpapers/$(basename $@)/contents/images/1280x720.png
	convert $< -resize 1152x648 wallpapers/$(basename $@)/contents/images/1152x648.png

wallpapers/lliurex-%.4.3.jpg: wallpapers/%.jpg wallpapers/21.4.3.png
	@echo -e '$(COLOR_RED)* composing [$@] $(COLOR_NONE)'
	#convert $< -resize 3750x2813 $@
	convert $< -crop 3750x2813+625+0 $@
	convert $@  wallpapers/21.4.3.png -composite $@

wallpapers/lliurex-%.jpg: wallpapers/%.jpg wallpapers/21.png
	@echo -e '$(COLOR_RED)* composing [$@] $(COLOR_NONE)'
	convert $<  wallpapers/21.png -composite $@

wallpapers/lliurex-21.jpg: wallpapers/21/escriptori.jpg wallpapers/21.png
	@echo -e '$(COLOR_RED)* composing [$@] $(COLOR_NONE)'
	convert wallpapers/21/escriptori.jpg wallpapers/21.png -composite $@

wallpapers/lliurex-21.22.jpg: wallpapers/21.22/escriptori.jpg wallpapers/22.png
	@echo -e '$(COLOR_RED)* composing [$@] $(COLOR_NONE)'
	convert wallpapers/21.22/escriptori.jpg wallpapers/22.png -composite $@

lliurex-%.render.22.16.9: wallpapers/lliurex-%.jpg
	@echo -e '$(COLOR_RED)* creating [$@] $(COLOR_NONE)'
	mkdir -p wallpapers/lliurex-$*/contents/images
	cp $< wallpapers/lliurex-$*/contents/images/5000x2813.jpg
	convert $< -resize 1920x1080 wallpapers/lliurex-$*/contents/images/1920x1080.jpg
	convert $< -resize 1408x792 wallpapers/lliurex-$*/contents/images/1408x792.jpg
	convert $< -resize 1280x720 wallpapers/lliurex-$*/contents/images/1280x720.jpg
	convert $< -resize 1152x648 wallpapers/lliurex-$*/contents/images/1152x648.jpg

lliurex-%.render.22.4.3: wallpapers/lliurex-%.4.3.jpg
	@echo -e '$(COLOR_RED)* creating [$@] $(COLOR_NONE)'
	mkdir -p wallpapers/lliurex-$*/contents/images
	cp $< wallpapers/lliurex-$*/contents/images/3750x2813.jpg
	convert $< -resize 1024x768 wallpapers/lliurex-$*/contents/images/1024x768.jpg

lliurex-21.render: wallpapers/lliurex-21.jpg wallpapers/21.png
	@echo -e '$(COLOR_RED)* creating [$@] $(COLOR_NONE)'
	mkdir -p wallpapers/lliurex-21/contents/images
	cp $< wallpapers/lliurex-21/contents/images/5000x2813.jpg
	convert $< -resize 1920x1080 wallpapers/lliurex-21/contents/images/1920x1080.jpg
	convert $< -resize 1408x792 wallpapers/lliurex-21/contents/images/1408x792.jpg
	convert $< -resize 1280x720 wallpapers/lliurex-21/contents/images/1280x720.jpg
	convert $< -resize 1152x648 wallpapers/lliurex-21/contents/images/1152x648.jpg

lliurex-21.22.render: wallpapers/lliurex-21.22.jpg wallpapers/22.png
	@echo -e '$(COLOR_RED)* creating [$@] $(COLOR_NONE)'
	mkdir -p wallpapers/lliurex-21.22/contents/images
	cp $< wallpapers/lliurex-21.22/contents/images/5000x2813.jpg
	convert $< -resize 1920x1080 wallpapers/lliurex-21.22/contents/images/1920x1080.jpg
	convert $< -resize 1408x792 wallpapers/lliurex-21.22/contents/images/1408x792.jpg
	convert $< -resize 1280x720 wallpapers/lliurex-21.22/contents/images/1280x720.jpg
	convert $< -resize 1152x648 wallpapers/lliurex-21.22/contents/images/1152x648.jpg

lliurex-escriptori: lliurex-escriptori.render.22.16.9 lliurex-escriptori.render.22.4.3
lliurex-aula: lliurex-aula.render.22.16.9 lliurex-aula.render.22.4.3
lliurex-server: lliurex-server.render.22.16.9 lliurex-server.render.22.4.3
#lliurex-touch: lliurex-touch.render.22.16.9 lliurex-touch.render.22.4.3
#lliurex-infantil: lliurex-infantil.render.21.16.9 lliurex-infantil.render.21.4.3
#lliurex-musica: lliurex-musica.render.21.16.9 lliurex-musica.render.21.4.3
lliurex-neutro: lliurex-neutro.render.22.16.9 lliurex-neutro.render.22.4.3

lliurex-sunset: lliurex-sunset.render
lliurex-xiquets: lliurex-xiquets.render
lliurex-xiquet: lliurex-xiquet.render
lliurex-fp: neutro.render
lliurex-19: lliurex-19.render
lliurex-19+1: lliurex-19+1.render
lliurex-21: lliurex-21.render
lliurex-21.22: lliurex-21.22.render

w21: lliurex-escriptori lliurex-aula lliurex-infantil lliurex-musica lliurex-neutro
	@echo -e '$(COLOR_RED)* creating [$^] $(COLOR_NONE)'

w22: lliurex-escriptori lliurex-aula lliurex-server lliurex-neutro
	@echo -e '$(COLOR_RED)* creating [$^] $(COLOR_NONE)'

wallpapers:w22 lliurex-sunset lliurex-xiquets lliurex-xiquet lliurex-19 lliurex-19+1 lliurex-21 lliurex-21.22

locale/%.mo:
	@echo -e '$(COLOR_RED)* msgfmt [$*] $(COLOR_NONE)'
	mkdir -p locale/mos/$*/LC_MESSAGES
	msgfmt locale/$*.po -o locale/mos/$*/LC_MESSAGES/lliurex-plasma-theme.mo

locales: locale/es.mo locale/ca@valencia.mo

get-po:
	@echo -e '$(COLOR_RED)* Extracting locale strings... $(COLOR_NONE)'
	xgettext -kde -ki18nd:2 look-and-feel/net.lliurex.default/contents/lockscreen/*.qml look-and-feel/net.lliurex.default/contents/logout/*.qml look-and-feel/net.lliurex.default/contents/splash/*.qml -o locale/messages.po

build: wallpapers previews locales

all: build

clean:
	rm -rf wallpapers/*.png
	rm -rf wallpapers/lliurex-escriptori/contents
#	rm -rf wallpapers/lliurex-touch/contents
	rm -rf wallpapers/lliurex-aula/contents
	rm -rf wallpapers/lliurex-server/contents
	rm -rf wallpapers/lliurex-neutro/contents
	rm -rf wallpapers/lliurex-sunset/contents
	rm -rf wallpapers/lliurex-xiquets/contents
	rm -rf wallpapers/lliurex-xiquet/contents
	rm -rf wallpapers/lliurex-fp/contents
	rm -rf wallpapers/lliurex-19/contents
	rm -rf wallpapers/lliurex-19+1/contents
	rm -rf wallpapers/lliurex-21/contents
	rm -rf wallpapers/lliurex-21.22/contents
	rm -rf look-and-feel/net.lliurex.default/contents/previews
	rm -rf look-and-feel/net.lliurex.classic/contents/previews

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
	cp -r desktoptheme/net.lliurex.desktop $(DESTDIR)/usr/share/plasma/desktoptheme/
	cp -r look-and-feel/net.lliurex.default $(DESTDIR)/usr/share/plasma/look-and-feel/
	cp -r look-and-feel/net.lliurex.classic $(DESTDIR)/usr/share/plasma/look-and-feel/
	cp -r look-and-feel/net.lliurex.default/contents/lockscreen $(DESTDIR)/usr/share/plasma/look-and-feel/net.lliurex.classic/contents/
	cp -r look-and-feel/net.lliurex.default/contents/logout $(DESTDIR)/usr/share/plasma/look-and-feel/net.lliurex.classic/contents/
	cp -r look-and-feel/net.lliurex.default/contents/splash $(DESTDIR)/usr/share/plasma/look-and-feel/net.lliurex.classic/contents/
#wallpapers
	cp -r wallpapers/lliurex-escriptori $(DESTDIR)/usr/share/wallpapers/
#	cp -r wallpapers/lliurex-touch $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-aula $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-server $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-neutro $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-xiquet $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-xiquets $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-sunset $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-fp $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-19 $(DESTDIR)/usr/share/wallpapers/
	cp -r wallpapers/lliurex-19+1 $(DESTDIR)/usr/share/wallpapers/

	cp -r wallpapers/net.lliurex.wallpaper $(DESTDIR)/usr/share/plasma/wallpapers/
	
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

#avatars
	mkdir -p $(DESTDIR)/usr/share/plasma/avatars/lliurex
	cp -r avatars/*.png $(DESTDIR)/usr/share/plasma/avatars/lliurex
	
#locale
	mkdir -p $(DESTDIR)/usr/share/locale/
	cp -r locale/mos/* $(DESTDIR)/usr/share/locale/
	
uninstall:

#plasma theme
	rm -rf $(DESTDIR)/usr/share/plasma/desktoptheme/net.lliurex.desktop
	rm -rf $(DESTDIR)/usr/share/plasma/look-and-feel/net.lliurex.default
	rm -rf $(DESTDIR)/usr/share/plasma/look-and-feel/net.lliurex.classic

#wallpaper
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-escriptori
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-touch
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-aula
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-server
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-neutro
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-sunset
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-fp
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-19
	rm -rf $(DESTDIR)/usr/share/wallpapers/lliurex-19+1
	
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

#avatars
	rm -rf $(DESTDIR)/usr/share/plasma/avatars/lliurex

.PHONY: all clean install uninstall build
