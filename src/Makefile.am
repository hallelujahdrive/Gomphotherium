AUTOMAKE_OPTIONS = subdir-objects

AM_CPPFLAGS = $(GOM_CFLAGS)

BUILT_SOURCES = libgomphoterium_la_vala.stamp

lib_LTLIBRARIES = libgomphoterium.la

include_HEADERS = gomphoterium.h

pc_DATA = gomphoterium.pc

vapi_DATA = \
						gomphoterium.deps \
						gomphoterium.vapi 

sources = \
				Account.vala \
				Application.vala \
				Methods.vala \
				Options.vala \
				methods/regstering_app.vala

csources = $(sources:.vala=.c)

gomphoterium.vapi gomphoterium.h libgomphoterium_la_vala.stamp : $(sources)
	@$(VALAC) $^ --vapi=gomphoterium.vapi -C --header gomphoterium.h @GOM_VALA_FLAGS@
	
libgomphoterium_la_LIBADD = @GOM_LIBS@
libgomphoterium_la_LDFLAGS= -X -shared -X -fPIC -vsrsion-info 0:0:0
libgomphoterium_la_VALASOURCES = $(sources)
libgomphoterium_la_SOURCES = libgomphoterium_la_vala.stamp \
															 $(csources)

CLEANFILES = *.c *.h *.o *.lo *.lib *.vapi .libs/* 
EXTRA_DIST = $(sources)
