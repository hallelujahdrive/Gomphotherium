AUTOMAKE_OPTIONS = subdir-objects

AM_CPPFLAGS = $(GOM_CFLAGS)

BUILT_SOURCES = libgomphotherium_la_vala.stamp

lib_LTLIBRARIES = libgomphotherium.la

include_HEADERS = gomphotherium.h

pc_DATA = gomphotherium.pc

vapi_DATA = \
						gomphotherium.deps \
						gomphotherium.vapi

sources = \
				Account.vala \
				Application.vala \
				AsyncGomphoApp.vala \
				Attachment.vala \
				Card.vala \
				Context.vala \
				Delete.vala \
				GomphoApp.vala \
				GomphoAppBase.vala \
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
				methods/regster_app.vala \
				utils/file_utils.vala \
				utils/json_utils.vala \
				utils/soup_utils.vala

csources = $(sources:.vala=.c)

gomphotherium.vapi gomphotherium.h libgomphotherium_la_vala.stamp : $(sources)
	@$(VALAC) $^ --vapi=gomphotherium.vapi -C --header gomphotherium.h @GOM_VALA_FLAGS@
	
libgomphotherium_la_LIBADD = @GOM_LIBS@
libgomphotherium_la_LDFLAGS= -X -shared -X -fPIC -vsrsion-info 0:0:0
libgomphotherium_la_VALASOURCES = $(sources)
libgomphotherium_la_SOURCES = libgomphotherium_la_vala.stamp \
															 $(csources)

CLEANFILES = *.c *.h *.o *.lo *.lib *.vapi .libs/* 
EXTRA_DIST = $(sources)
