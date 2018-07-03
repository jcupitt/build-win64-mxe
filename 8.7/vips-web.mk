PKG             := vips-web
$(PKG)_WEBSITE  := https://jcupitt.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.7.0
$(PKG)_CHECKSUM := 4a0aee9b64f7fabebb8f3cef0cb5cabeb5897ec8f3e59ac6844d4369631aee08
$(PKG)_GH_CONF  := jcupitt/libvips/releases/latest,v
$(PKG)_SUBDIR   := libvips-add-exif-string-write
$(PKG)_FILE     := add-exif-string-write.zip
$(PKG)_URL      := https://github.com/jcupitt/libvips/archive/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libwebp librsvg giflib glib pango fftw \
                   libgsf libjpeg-turbo tiff lcms libexif libpng

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && ./autogen.sh \
        $(MXE_CONFIGURE_OPTS) \
        --enable-debug=no \
        --without-magick \
        --without-openslide \
        --without-poppler \
        --without-OpenEXR \
        --without-matio \
        --without-ppm \
        --without-analyze \
        --without-radiance \
        --disable-introspection \
        --with-jpeg-includes='$(PREFIX)/$(TARGET)/include/libjpeg-turbo' \
        --with-jpeg-libraries='$(PREFIX)/$(TARGET)/lib/libjpeg-turbo' \
        CFLAGS='-O3' \
        CXXFLAGS='-O3'
    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 install
endef