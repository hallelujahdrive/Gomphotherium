AUTOMAKE_OPTIONS = subdir-objects

AM_CPPFLAGS = \
						$(VD_CFLAGS) \
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
							credentialstest \
							favouritereblogtest \
							followtest \
							gettest \
							notificationstest \
							oauthtokentest \
							posttest \
							registerapptest \
							relationshiptest \
							reporttest \
							uploadtest \
							resetcredentials \
							streamingpublic \
							streaminguser
							
check_LTLIBRARIES = libtestmod.la
						
tests_VALASOURCES = \
									credentialstest.vala \
									favouritereblogtest.vala \
									followtest.vala \
									gettest.vala \
									notificationstest.vala \
									oauthtokentest.vala \
									posttest.vala \
									registerapptest.vala \
									relationshiptest.vala \
									reporttest.vala \
									uploadtest.vala \
									resetcredentials.vala \
									streamingpublic.vala \
									streaminguser.vala
				
testmod_VALASOURCES = \
											loadfunctions.vala \
											outputfunctions.vala

libvalastodon = \
							$(top_builddir)/src/libvalastodon.la \
							$(top_builddir)/src/valastodon.vapi

$(tests_VALASOURCES:.vala=.c) : test_vala.stamp
$(testmod_VALASOURCES:.vala=.c) : libtestmod_la_vala.stamp

testmod.vapi testmod.h libtestmod_la_vala.stamp : $(testmod_VALASOURCES) $(libvalastodon)
	@$(VALAC) $(testmod_VALASOURCES) \
	--vapidir $(top_builddir)/src \
	--pkg valastodon \
	--vapi=testmod.vapi -C --header testmod.h \
	@VD_VALA_FLAGS@

test_vala.stamp : $(tests_VALASOURCES) $(libvalastodon) Makefile libtestmod_la_vala.stamp
	for s in $(tests_VALASOURCES); do \
		$(VALAC) \
			$(AM_VALAFLAGS) $(VD_VALA_FLAGS) \
			--pkg valastodon \
			--pkg testmod \
			--enable-deprecated \
			$$s; \
		done; \
		touch $@

libtestmod_la_VALASOURCES = $(testmod_VALASOURCES)
libtestmod_la_LIBADD = @VD_LIBS@
libtestmod_la_SOURCES = libtestmod_la_vala.stamp \
												$(testmod_VALASOURCES:.vala=.c)

nodist_credentialstest_SOURCES = \
																	libtestmod_la_vala.stamp \
																	credentialstest.c 
credentialstest_LDADD = \
												libtestmod.la \
												$(top_builddir)/src/libvalastodon.la

nodist_favouritereblogtest_SOURCES = \
																				libtestmod_la_vala.stamp \
																				favouritereblogtest.c 
favouritereblogtest_LDADD = \
															libtestmod.la \
															$(top_builddir)/src/libvalastodon.la

nodist_followtest_SOURCES = \
														libtestmod_la_vala.stamp \
														followtest.c 
followtest_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libvalastodon.la

gettest_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libvalastodon.la

nodist_notificationstest_SOURCES = \
																			libtestmod_la_vala.stamp \
																			notificationstest.c

notificationstest_LDADD = \
														libtestmod.la \
														$(top_builddir)/src/libvalastodon.la

nodist_oauthtokentest_SOURCES = \
																libtestmod_la_vala.stamp \
																oauthtokentest.c
oauthtokentest_LDADD = \
											libtestmod.la \
											$(top_builddir)/src/libvalastodon.la

nodist_posttest_SOURCES = \
													libtestmod_la_vala.stamp \
													posttest.c
posttest_LDADD = \
								libtestmod.la \
								$(top_builddir)/src/libvalastodon.la

nodist_registerapptest_SOURCES = \
																	libtestmod_la_vala.stamp \
																	registerapptest.c
registerapptest_LDADD = \
												libtestmod.la \
												$(top_builddir)/src/libvalastodon.la

nodist_relationshiptest_SOURCES = \
																		libtestmod_la_vala.stamp \
																		relationshiptest.c 
relationshiptest_LDADD = \
													libtestmod.la \
													$(top_builddir)/src/libvalastodon.la

nodist_reporttest_SOURCES = \
														libtestmod_la_vala.stamp \
														reporttest.c 
reporttest_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libvalastodon.la

nodist_uploadtest_SOURCES = \
														libtestmod_la_vala.stamp \
														uploadtest.c 
uploadtest_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libvalastodon.la
									
nodist_resetcredentials_SOURCES = \
																		libtestmod_la_vala.stamp \
																		resetcredentials.c 
resetcredentials_LDADD = \
													libtestmod.la \
													$(top_builddir)/src/libvalastodon.la
													

nodist_streamingpublic_SOURCES = \
																		libtestmod_la_vala.stamp \
																		streamingpublic.c 
streamingpublic_LDADD = \
													libtestmod.la \
													$(top_builddir)/src/libvalastodon.la

nodist_streaminguser_SOURCES = \
																		libtestmod_la_vala.stamp \
																		streaminguser.c 
streaminguser_LDADD = \
													libtestmod.la \
													$(top_builddir)/src/libvalastodon.la

CLEANFILES = \
						tests_vala.stamp \
						*.c *.o *.h *.lo *.lib *.vapi .libs/* 
EXTRA_DIST = $(tests_VALASOURCES)
