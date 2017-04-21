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
							getblocks \
							getcard \
							getcontext \
							getfavouritedby \
							getfavourites \
							getfollowers \
							getfollowing \
							getfollowrequests \
							gethometimeline \
							getinstance \
							getmutes \
							getnotification \
							getnotifications \
							getpublictimeline \
							getrebloggedby \
							getrelationships \
							getreports \
							getstatus \
							getstatuses \
							gettagtimeline \
							oauthtoken \
							registeringapp \
							search \
							searchaccounts \
							verifycredentials
							
check_LTLIBRARIES = libtestmod.la
						
tests_VALASOURCES = \
				getaccount.vala \
				getblocks.vala \
				getcard.vala \
				getcontext.vala \
				getfavouritedby.vala \
				getfavourites.vala \
				getfollowers.vala \
				getfollowing.vala \
				getfollowrequests.vala \
				getinstance.vala \
				gethometimeline.vala \
				getmutes.vala \
				getnotification.vala \
				getnotifications.vala \
				getpublictimeline.vala \
				getrebloggedby.vala \
				getrelationships.vala \
				getreports.vala \
				getstatus.vala \
				getstatuses.vala \
				gettagtimeline.vala \
				oauthtoken.vala \
				registeringapp.vala \
				search.vala \
				searchaccounts.vala \
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
									
nodist_getblocks_SOURCES = \
												libtestmod_la_vala.stamp \
												getblocks.c 
getblocks_LDADD = \
								libtestmod.la \
								$(top_builddir)/src/libgomphotherium.la

nodist_getcard_SOURCES = \
													libtestmod_la_vala.stamp \
													getcard.c 
getcard_LDADD = \
							libtestmod.la \
							$(top_builddir)/src/libgomphotherium.la
							
nodist_getcontext_SOURCES = \
														libtestmod_la_vala.stamp \
														getcontext.c 
getcontext_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libgomphotherium.la
									
nodist_getfavouritedby_SOURCES = \
														libtestmod_la_vala.stamp \
														getfavouritedby.c
getfavouritedby_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la

nodist_getfavourites_SOURCES = \
														libtestmod_la_vala.stamp \
														getfavourites.c
getfavourites_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la
										
nodist_getfollowrequests_SOURCES = \
																libtestmod_la_vala.stamp \
																getfollowrequests.c
getfollowrequests_LDADD = \
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

nodist_getinstance_SOURCES = \
													libtestmod_la_vala.stamp \
													getinstance.c
getinstance_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libgomphotherium.la
									
nodist_gethometimeline_SOURCES = \
													libtestmod_la_vala.stamp \
													gethometimeline.c
gethometimeline_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libgomphotherium.la

nodist_getmutes_SOURCES = \
												libtestmod_la_vala.stamp \
												getmutes.c
getmutes_LDADD = \
							libtestmod.la \
							$(top_builddir)/src/libgomphotherium.la
							
nodist_getnotifications_SOURCES = \
															libtestmod_la_vala.stamp \
															getnotifications.c
getnotifications_LDADD = \
											libtestmod.la \
											$(top_builddir)/src/libgomphotherium.la
											
nodist_getnotification_SOURCES = \
															libtestmod_la_vala.stamp \
															getnotification.c
getnotification_LDADD = \
											libtestmod.la \
											$(top_builddir)/src/libgomphotherium.la

nodist_getpublictimeline_SOURCES = \
													libtestmod_la_vala.stamp \
													getpublictimeline.c
getpublictimeline_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libgomphotherium.la

nodist_getrebloggedby_SOURCES = \
															libtestmod_la_vala.stamp \
															getrebloggedby.c
getrebloggedby_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la

nodist_getrelationships_SOURCES = \
															libtestmod_la_vala.stamp \
															getrelationships.c
getrelationships_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la

nodist_getreports_SOURCES = \
												libtestmod_la_vala.stamp \
												getreports.c
getreports_LDADD = \
								libtestmod.la \
								$(top_builddir)/src/libgomphotherium.la
								
nodist_getstatus_SOURCES = \
														libtestmod_la_vala.stamp \
														getstatus.c
getstatus_LDADD = \
									libtestmod.la \
									$(top_builddir)/src/libgomphotherium.la

nodist_getstatuses_SOURCES = \
															libtestmod_la_vala.stamp \
															getstatuses.c
getstatuses_LDADD = \
										libtestmod.la \
										$(top_builddir)/src/libgomphotherium.la
										
nodist_gettagtimeline_SOURCES = \
													libtestmod_la_vala.stamp \
													gettagtimeline.c
gettagtimeline_LDADD = \
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

nodist_search_SOURCES = \
											libtestmod_la_vala.stamp \
											search.c
search_LDADD = \
						libtestmod.la \
						$(top_builddir)/src/libgomphotherium.la

nodist_searchaccounts_SOURCES = \
															libtestmod_la_vala.stamp \
															searchaccounts.c
searchaccounts_LDADD = \
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
