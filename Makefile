NAME = generic-logos
XML = backgrounds/desktop-backgrounds-fedora.xml

all: update-po archive

archive: 
	export VERSION=`awk --field-separator=' ' '/^Version:/ { print $$2 }' generic-logos.spec` ; \
	export CVSTAG=GENERIC_LOGOS_`echo $$VERSION | sed s/\\\./_/g` ; \
	export TMPCVS=cvs-checkout-$$VERSION ; \
	export DISTDIR=generic-logos-$$VERSION ; \
	export SRCDIR=../$$TMPCVS/generic-logos ; \
	echo VERSION=$$VERSION CVSTAG=$$CVSTAG TMPCVS=$$TMPCVS DISTDIR=$$DISTDIR ; \
	export CVSROOT=`cat CVS/Root` ; \
	cvs tag -F $$CVSTAG . ; \
	/bin/rm -rf $$DISTDIR ; \
	/bin/rm -rf $$TMPCVS ; \
	mkdir -p $$TMPCVS ; \
	(cd $$TMPCVS && cvs -Q -d $$CVSROOT export -r$$CVSTAG generic-logos && cd $$SRCDIR && make update-po) ; \
	mkdir -p $$DISTDIR ; \
	mkdir -p $$DISTDIR/redhat-pixmaps ; \
	mkdir -p $$DISTDIR/bootloader ; \
	mkdir -p $$DISTDIR/firstboot ; \
	mkdir -p $$DISTDIR/rhgb ; \
	mkdir -p $$DISTDIR/gnome-splash ; \
	mkdir -p $$DISTDIR/kde-splash/BlueCurve ; \
	mkdir -p $$DISTDIR/kde-splash/Echo ; \
	mkdir -p $$DISTDIR/kde-splash/FedoraInfinity ; \
	mkdir -p $$DISTDIR/pixmaps ; \
	mkdir -p $$DISTDIR/gdm ; \
	mkdir -p $$DISTDIR/anaconda ; \
	mkdir -p $$DISTDIR/icons/hicolor/16x16/apps ; \
	mkdir -p $$DISTDIR/icons/hicolor/24x24/apps ; \
	mkdir -p $$DISTDIR/icons/hicolor/32x32/apps ; \
	mkdir -p $$DISTDIR/icons/hicolor/36x36/apps ; \
	mkdir -p $$DISTDIR/icons/hicolor/48x48/apps ; \
	mkdir -p $$DISTDIR/icons/hicolor/96x96/apps ; \
	mkdir -p $$DISTDIR/gnome-screensaver/ ; \
	mkdir -p $$DISTDIR/applications/screensavers/ ; \
	mkdir -p $$DISTDIR/backgrounds/images ; \
	cd $$DISTDIR ; \
	cp -f $$SRCDIR/generic-logos.spec . ; \
	cp -f $$SRCDIR/Makefile . ; \
	cp -f $$SRCDIR/COPYING . ; \
	cp -f $$SRCDIR/redhat-pixmaps/*.{png,xbm,xpm,tif} redhat-pixmaps ; \
	cp -f $$SRCDIR/bootloader/*.{png,xpm.gz,pcx} bootloader ; \
	cp -f $$SRCDIR/firstboot/*.png firstboot ; \
	cp -f $$SRCDIR/rhgb/*.png rhgb ; \
	cp -f $$SRCDIR/gnome-splash/*.png gnome-splash ; \
	cp -f $$SRCDIR/kde-splash/BlueCurve/* kde-splash/BlueCurve/ ; \
	cp -f $$SRCDIR/kde-splash/Echo/* kde-splash/Echo/ ; \
	cp -f $$SRCDIR/kde-splash/FedoraInfinity/* kde-splash/FedoraInfinity/ ; \
	cp -f $$SRCDIR/pixmaps/*.{png,svg} pixmaps ; \
	cp -af $$SRCDIR/gdm/* gdm; \
	cp -f $$SRCDIR/anaconda/* anaconda ; \
	cp -f $$SRCDIR/icons/hicolor/16x16/apps/* icons/hicolor/16x16/apps ; \
	cp -f $$SRCDIR/icons/hicolor/24x24/apps/* icons/hicolor/24x24/apps ; \
	cp -f $$SRCDIR/icons/hicolor/32x32/apps/* icons/hicolor/32x32/apps ; \
	cp -f $$SRCDIR/icons/hicolor/36x36/apps/* icons/hicolor/36x36/apps ; \
	cp -f $$SRCDIR/icons/hicolor/48x48/apps/* icons/hicolor/48x48/apps ; \
	cp -f $$SRCDIR/icons/hicolor/96x96/apps/* icons/hicolor/96x96/apps ; \
	cp -f $$SRCDIR/gnome-screensaver/lock-dialog-* gnome-screensaver ; \
	cp -f $$SRCDIR/gnome-screensaver/system.desktop applications/screensavers ; \
	cp -f $$SRCDIR/backgrounds/*.xml backgrounds/ ; \
	cp -f $$SRCDIR/backgrounds/images/* backgrounds/images ; \
	cd ..; \
	tar -cv --bzip2 -f generic-logos-$$VERSION.tar.bz2 $$DISTDIR ; \
	echo "Wrote generic-logos-$$VERSION.tar.bz2"

update-po:
	@echo "updating pot files..."
	sed -e "s/_name/name/g" $(XML).in > $(XML)
	# FIXME need to handle translations
	#
	#( cd po && intltool-update --gettext-package=$(NAME) --pot )
	#@echo "merging existing po files to xml..."
	#intltool-merge -x po $(XML).in $(XML)
