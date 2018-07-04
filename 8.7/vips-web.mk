PKG             := vips-web
$(PKG)_WEBSITE  := https://jcupitt.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.7.0
$(PKG)_CHECKSUM := 2860a43a85ddff00b92e45566ee13a5618d926fb22dd1a4b2f6df44894a84b86
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