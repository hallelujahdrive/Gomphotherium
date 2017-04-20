AUTOMAKE_OPTIONS = subdir-objects

AM_CPPFLAGS = \
						$(GOM_CFLAGS) \
						-I$(top_builddir)/src \
						-I$(top_srcdir)/src \
						-I. \
						-g \
						-O0
						
AM_VALAFLAGS = \
						--enable-checking \
						--enable-experimental \
						--vapidir $(top_builddir)/src \
						--vapidir $(top_builddir)/tests \
						-C \
						-g
						
check_PROGRAMS = \
							getaccount \
							getfollowers \
							getfollowing \
							getstatuses \
							oauthtoken \
							registeringapp \
							verifycredentials
						
tests_VALASOURCES = \
				getaccount.vala \
				getfollowers.vala \
				getfollowing.vala \
				getstatuses.vala \
				oauthtoken.vala \
				registeringapp.vala \
				verifycredentials.vala
				
testlib_VALASOURCES = \
				loadfunctions.vala

$(tests_VALASOURCES:.vala=.c) : test_vala.stamp

test.vapi test.h : $(testlib_VALASOURCES)
	@$(VALAC) $(testlib_VALASOURCES) --vapi=test.vapi -C --header test.h

test_vala.stamp : $(tests_VALASOURCES) $(top_builddir)/src/libgomphotherium.la $(top_builddir)/src/gomphotherium.vapi Makefile test.vapi test.h
	for s in $(filter %.vala, $(tests_VALASOURCES)); do \
		$(VALAC) \
			$(AM_VALAFLAGS) $(GOM_VALA_FLAGS) \
			--pkg gomphotherium \
			--pkg test \
			--enable-deprecated \
			$$s; \
		done; \
		touch $@
		
nodist_getaccount_SOURCES = getaccount.c
getaccount_LDADD =$(top_builddir)/src/libgomphotherium.la

nodist_getfollowers_SOURCES = getfollowers.c
getfollowers_LDADD = $(top_builddir)/src/libgomphotherium.la

nodist_getfollowing_SOURCES = getfollowing.c
getfollowing_LDADD = $(top_builddir)/src/libgomphotherium.la

nodist_getstatuses_SOURCES = getstatuses.c
getstatuses_LDADD = $(top_builddir)/src/libgomphotherium.la

nodist_oauthtoken_SOURCES = oauthtoken.c
oauthtoken_LDADD = $(top_builddir)/src/libgomphotherium.la

nodist_registeringapp_SOURCES = registeringapp.c
registeringapp_LDADD = $(top_builddir)/src/libgomphotherium.la

nodist_verifycredentials_SOURCES = verifycredentials.c
verifycredentials_LDADD = $(top_builddir)/src/libgomphotherium.la
		
CLEANFILES = \
						tests_vala.stamp \
						$(tests_VALASOURCES:.vala=.c) \
						$(testlib_VALASOURCES:.vala=.c)
EXTRA_DIST = $(tests_VALASOURCES)
