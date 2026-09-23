# BastiaOS BusyBox configuration hook
# This file provides the custom BusyBox configuration for BastiaOS

define BUSYBOX_BASTIAOS_CONFIG
	cp $(BUSYBOX_PKGDIR)/bastiaos.config $(@D)/.config
endef

BUSYBOX_POST_PATCH_HOOKS += BUSYBOX_BASTIAOS_CONFIG