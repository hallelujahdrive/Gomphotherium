AUTOMAKE_OPTIONS = subdir-objects

AM_CPPFLAGS = \
						$(GOM_CFLAGS) \
						-I$(top_builddir)/src \
						-I$(top_srcdir)/src \
						-g \
						-O0
						
AM_VALAFLAGS = \
						--enable-checking \
						--enable-experimental \
						--vapidir $(top_builddir)/src \
						-C \
						-g
						
check_PROGRAMS = \
							getaccount \
							getfollowers \
							getfollowing \
							oauthtoken \
							registeringapp \
							verifycredentials
						
tests_VALASOURCES = \
				getaccount.vala \
				getfollowers.vala \
				getfollowing.vala \
				oauthtoken.vala \
				registeringapp.vala \
				verifycredentials.vala

$(tests_VALASOURCES:.vala=.c) : test_vala.stamp

test_vala.stamp : $(tests_VALASOURCES) $(top_builddir)/src/libgomphoterium.la $(top_builddir)/src/gomphoterium.vapi Makefile
	for s in $(filter %.vala, $^); do \
		$(VALAC) \
			$(AM_VALAFLAGS) $(GOM_VALA_FLAGS) \
			--pkg gomphoterium \
			--enable-deprecated \
			$$s; \
		done; \
		touch $@
		
nodist_getaccount_SOURCES = getaccount.c
getaccount_LDADD = $(top_builddir)/src/libgomphoterium.la

nodist_getfollowers_SOURCES = getfollowers.c
getfollowers_LDADD = $(top_builddir)/src/libgomphoterium.la

nodist_getfollowing_SOURCES = getfollowing.c
getfollowing_LDADD = $(top_builddir)/src/libgomphoterium.la

nodist_oauthtoken_SOURCES = oauthtoken.c
oauthtoken_LDADD = $(top_builddir)/src/libgomphoterium.la

nodist_registeringapp_SOURCES = registeringapp.c
registeringapp_LDADD = $(top_builddir)/src/libgomphoterium.la

nodist_verifycredentials_SOURCES = verifycredentials.c
verifycredentials_LDADD = $(top_builddir)/src/libgomphoterium.la
		
CLEANFILES = \
						tests_vala.stamp \
						$(tests_VALASOURCES:.vala=.c)
EXTRA_DIST = $(tests_VALASOURCES)
