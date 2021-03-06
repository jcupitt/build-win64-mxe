PKG             := openslide
$(PKG)_WEBSITE  := https://openslide.org/
$(PKG)_DESCR    := C library for reading virtual slide images.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.4.1
$(PKG)_CHECKSUM := fed08fab8a9b1ded95a34e196652291127ebe392c11f9bc13d26e760295a102d
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := openslide/openslide/releases/latest,v
$(PKG)_DEPS     := cc zlib cairo gdk-pixbuf libjpeg-turbo tiff openjpeg sqlite

define $(PKG)_BUILD
    # This can be removed once the patch "openslide-3-fixes.patch" is accepted by upstream
    cd '$(SOURCE_DIR)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        CFLAGS="`'$(TARGET)-pkg-config' --cflags jpeg-turbo`" \
        LIBS="`'$(TARGET)-pkg-config' --libs jpeg-turbo`"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' noinst_SCRIPTS=
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install noinst_SCRIPTS=
endef
