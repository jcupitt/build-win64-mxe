PKG             := vips-all
$(PKG)_WEBSITE  := https://jcupitt.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.7.0
$(PKG)_CHECKSUM := 4a0aee9b64f7fabebb8f3cef0cb5cabeb5897ec8f3e59ac6844d4369631aee08
$(PKG)_GH_CONF  := jcupitt/libvips/releases/latest,v
$(PKG)_SUBDIR   := libvips-add-exif-string-write
$(PKG)_FILE     := add-exif-string-write.zip
$(PKG)_URL      := https://github.com/jcupitt/libvips/archive/$($(PKG)_FILE)
$(PKG)_DEPS     := cc matio libwebp librsvg giflib poppler glib pango fftw libgsf \
                   libjpeg-turbo tiff openslide lcms libexif imagemagick libpng

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && ./autogen.sh \
        $(MXE_CONFIGURE_OPTS) \
        --enable-debug=no \
        --without-OpenEXR \
        --disable-introspection \
        --with-jpeg-includes='$(PREFIX)/$(TARGET)/include/libjpeg-turbo' \
        --with-jpeg-libraries='$(PREFIX)/$(TARGET)/lib/libjpeg-turbo' \
        CFLAGS='-O3' \
        CXXFLAGS='-O3'
    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 install
endef