AUTOMAKE_OPTIONS = subdir-objects

AM_CPPFLAGS = $(VD_CFLAGS)

BUILT_SOURCES = libvalastodon_la_vala.stamp

lib_LTLIBRARIES = libvalastodon.la

include_HEADERS = valastodon.h

pc_DATA = valastodon.pc

vapi_DATA = \
			valastodon.deps \
			valastodon.vapi

sources = \
			Account.vala \
			Application.vala \
			AsyncValastodonApp.vala \
			Attachment.vala \
			Card.vala \
			Context.vala \
			Delete.vala \
			ValastodonApp.vala \
			ValastodonAppBase.vala \
			Instance.vala \
			Mention.vala \
			Notification.vala \
			RangingParams.vala \
			Relationship.vala \
			Report.vala \
			Results.vala \
			Status.vala \
			Stream.vala \
			StreamHead.vala \
			Tag.vala \
			endpoints.vala \
			event_types.vala \
			params.vala \
			methods/authorize.vala \
			methods/regster_app.vala \
			utils/file_utils.vala \
			utils/json_utils.vala \
			utils/soup_utils.vala

csources = $(sources:.vala=.c)

valastodon.vapi valastodon.h libvalastodon_la_vala.stamp : $(sources)
	@$(VALAC) $^ --vapi=valastodon.vapi -C --header valastodon.h @VD_VALA_FLAGS@
	
libvalastodon_la_LIBADD = @VD_LIBS@
libvalastodon_la_LDFLAGS= -X -shared -X -fPIC -vsrsion-info 0:0:0
libvalastodon_la_VALASOURCES = $(sources)
libvalastodon_la_SOURCES = libvalastodon_la_vala.stamp \
			$(csources)

CLEANFILES = *.c *.h *.o *.lo *.lib *.vapi .libs/* 
EXTRA_DIST = $(sources)
