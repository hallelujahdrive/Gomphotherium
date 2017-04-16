#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([gomphoterium], [0], [hallelujahdrive@gmail.com])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign])

# Checks for programs.
LT_PREREQ([2.4.2])
LT_INIT
AC_PROG_CC
AC_PROG_CC_STDC
AM_PROG_LIBTOOL
AM_PROG_VALAC([0.32])
AC_PROG_INSTALL

# Checks for libraries.
pkg_modules="
	glib-2.0
	json-glib-1.0
	libsoup-2.4
	rest-0.7
	"

PKG_CHECK_MODULES(GOM,[$pkg_modules])

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
GOM_VALA_FLAGS=" \
	--pkg glib-2.0 \
	--pkg json-glib-1.0 \
	--pkg libsoup-2.4 \
	--pkg rest-0.7
	"

#includedir=${prefix}/include
libdir=${prefix}/lib
pcdir=${prefix}/lib/pkgconfig
vapidir=${prefix}/share/vala/vapi

AC_SUBST(GOM_CFLAGS)
AC_SUBST(GOM_LIBS)
AC_SUBST(GOM_VALA_FLAGS)
AC_SUBST(includedir)
AC_SUBST(libdir)
AC_SUBST(pcdir)
AC_SUBST(vapidir)

AC_CHECK_FUNCS([atexit memchr memset setlocale strstr])

AC_CONFIG_FILES([Makefile
                 src/Makefile
								 src/gomphoterium.pc
								 tests/Makefile])
AC_OUTPUT

echo "$GOM_LIBS"
