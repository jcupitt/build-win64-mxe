# Rust toolchain is needed for librsvg
FROM rust:stretch

RUN \
    apt-get update && \
    apt-get install -y \
        # http://mxe.cc/#requirements-debian
        autoconf automake autopoint bash bison bzip2 flex g++ \
        g++-multilib gettext git gperf intltool libc6-dev-i386 \
        libgdk-pixbuf2.0-dev libltdl-dev libssl-dev libtool-bin \
        libxml-parser-perl make openssl p7zip-full patch perl \
        pkg-config python ruby scons sed unzip wget xz-utils

# Install Wine to test the build
RUN \
    apt-get install -y \
         wine

# Add Windows target for cross-compilation
# TODO: Switch to i686-pc-windows-gnu if 32-bit is needed.
RUN rustup target add x86_64-pc-windows-gnu

# The versioned subdirectory is mounted here
WORKDIR /data
