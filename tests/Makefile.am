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
						--vapidir . \
						-C \
						-g
						
check_PROGRAMS = \
							getaccount \
							getfollowers \
							getfollowing \
							getrelationships \
							getstatuses \
							oauthtoken \
							registeringapp \
							verifycredentials
							
check_LTLIBRARIES = libtestmod.la
						
tests_VALASOURCES = \
				getaccount.vala \
				getfollowers.vala \
				getfollowing.vala \
				getrelationships.vala \
				getstatuses.vala \
				oauthtoken.vala \
				registeringapp.vala \
				verifycredentials.vala
				
testmod_VALASOURCES = \
											loadfunctions.vala \
											outputfunctions.vala

libgomphotherium = \
							$(top_builddir)/src/libgomphotherium.la \
							$(top_builddir)/src/gomphotherium.vapi

$(tests_VALASOURCES:.vala=.c) : test_vala.stamp
$(testmod_VALASOURCES:.vala=.c) : libtestmod_la_vala.stamp

testmod.vapi testmod.h libtestmod_la_vala.stamp : $(testmod_VALASOURCES) $(libgomphotherium)
	@$(VALAC) $(testmod_VALASOURCES) \
	--vapidir $(top_builddir)/src \
	--pkg gomphotherium \
	--vapi=testmod.vapi -C --header testmod.h \
	@GOM_VALA_FLAGS@

test_vala.stamp : $(tests_VALASOURCES) $(libgomphotherium) Makefile libtestmod_la_vala.stamp
	for s in $(tests_VALASOURCES); do \
		$(VALAC) \
			$(AM_VALAFLAGS) $(GOM_VALA_FLAGS) \
			--pkg gomphotherium \
			--pkg testmod \
			--enable-deprecated \
			$$s; \
		done; \
		touch $@

libtestmod_la_VALASOURCES = $(testmod_VALASOURCES)
libtestmod_la_LIBADD = @GOM_LIBS@
libtestmod_la_SOURCES = libtestmod_la_vala.stamp \
												$(testmod_VALASOURCES:.vala=.c)
		
nodist_getaccount_SOURCES = \
														libtestmod_la_vala.stamp \
														getaccount.c 
getaccount_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libgomphotherium.la

nodist_getfollowers_SOURCES = \
															libtestmod_la_vala.stamp \
															getfollowers.c
getfollowers_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la

nodist_getfollowing_SOURCES = \
															libtestmod_la_vala.stamp \
															getfollowing.c
getfollowing_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la

nodist_getrelationships_SOURCES = \
															libtestmod_la_vala.stamp \
															getrelationships.c
getrelationships_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la

nodist_getstatuses_SOURCES = \
															libtestmod_la_vala.stamp \
															getstatuses.c
getstatuses_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la

nodist_oauthtoken_SOURCES = \
														libtestmod_la_vala.stamp \
														oauthtoken.c
oauthtoken_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libgomphotherium.la

nodist_registeringapp_SOURCES = \
																	libtestmod_la_vala.stamp \
																	registeringapp.c
registeringapp_LDADD = \
											libtestmod.la \
											$(top_builddir)/src/libgomphotherium.la

nodist_verifycredentials_SOURCES = \
																		libtestmod_la_vala.stamp \
																		verifycredentials.c
verifycredentials_LDADD = \
													libtestmod.la \
													$(top_builddir)/src/libgomphotherium.la
		
CLEANFILES = \
						tests_vala.stamp \
						$(tests_VALASOURCES:.vala=.c) \
						$(testmod_VALASOURCES:.vala=.c) \
						*.lo *.lib *.vapi .libs/* 
EXTRA_DIST = $(tests_VALASOURCES)
