From ubuntu:18.04

# Localtime
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update

RUN apt-get -y install build-essential asciidoc binutils bzip2 gawk \
               gettext git libncurses5-dev libz-dev patch python3.5 \
               python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 \
               subversion flex uglifyjs git-core gcc-multilib p7zip \
               p7zip-full msmtp libssl-dev texinfo libglib2.0-dev \
               xmlto qemu-utils upx libelf-dev autoconf automake \
               libtool autopoint device-tree-compiler g++-multilib \
               antlr3 gperf wget swig rsync sudo

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch User
RUN adduser --disabled-password --shell /bin/bash --home /data/lede --gecos "" builder && \
    echo "builder ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/builder && \
    chmod 0440 /etc/sudoers.d/builder

USER builder

WORKDIR /data/lede
