include $(TOPDIR)/rules.mk

TARGET_DIR	:=

ifeq ($(TARGET_DIR),)
TARGET_DIR	:= $(KDIR)
endif


PKG_NAME:=rdloader
PKG_VERSION:=1.0.1
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3
PKG_BUILD_DEPENDS:=util-linux e2fsprogs

PKG_BUILD_DIR := $(KDIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

.PHONY : loader-compile

$(PKG_BUILD_DIR)/.prepared:
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
	touch $@

loader-compile:
	CMAKE_OPTIONS += -DCMAKE_BUILD_TYPE=Release

	mkdir -p $(STAGING_DIR)/rdloader/{bin,lib,etc}

	$(CP) $(PKG_BUILD_DIR)/rdloader $(STAGING_DIR)/rdloader/bin/
	$(CP) $(STAGING_DIR_ROOT)/usr/sbin/e2fsck $(STAGING_DIR)/rdloader/bin/
	$(CP) $(STAGING_DIR_ROOT)/etc/e2fsck.conf $(STAGING_DIR)/rdloader/etc/

	( \
		export \
			READELF=$(TARGET_CROSS)readelf \
			OBJCOPY=$(TARGET_CROSS)objcopy \
			XARGS="$(XARGS)"; \
		find $(STAGING_DIR)/rdloader/bin/ -type f -a -exec \
		$(SCRIPT_DIR)/gen-rddependencies.sh {} \; ; \
	) | while read FILE; do \
		cp $(STAGING_DIR_ROOT)/lib/$$$$FILE $(STAGING_DIR)/rdloader/lib/ || \
		cp $(STAGING_DIR_ROOT)/usr/lib/$$$$FILE $(STAGING_DIR)/rdloader/lib/ \
		; \
	done;

download:
prepare: $(PKG_BUILD_DIR)/.prepared
compile: loader-compile

install:

clean:
	rm -fR $(STAGING_DIR)/rdloader
