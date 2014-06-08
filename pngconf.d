module libpng.pngconf;

/* pngconf.h - machine configurable file for libpng
 *
 * libpng version 1.2.50 - July 10, 2012
 * Copyright (c) 1998-2012 Glenn Randers-Pehrson
 * (Version 0.96 Copyright (c) 1996, 1997 Andreas Dilger)
 * (Version 0.88 Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.)
 *
 * This code is released under the libpng license.
 * For conditions of distribution and use, see the disclaimer
 * and license in png.h
 */

/* Any machine specific code is near the front of this file, so if you
 * are configuring libpng for a machine, you may want to read the section
 * starting here down to where it starts to typedef png_color, png_text,
 * and png_info.
 */

version = PNG_1_2_X;

/*
 * PNG_USER_CONFIG has to be defined on the compiler command line. This
 * includes the resource compiler for Windows DLL configurations.
 */
version (PNG_USER_CONFIG) {
   version (PNG_USER_PRIVATEBUILD) {
   } else {
      version = PNG_USER_PRIVATEBUILD;
   } // PNG_USER_PRIVATEBUILD

   import pngusr;
} // PNG_USER_CONFIG

/* PNG_CONFIGURE_LIBPNG is set by the "configure" script. */
version (PNG_CONFIGURE_LIBPNG) {
   version (HAVE_CONFIG_H) {
      import config;
   } // HAVE_CONFIG_H
} // PNG_CONFIGURE_LIBPNG

/*
 * Added at libpng-1.2.8
 *
 * If you create a private DLL you need to define in "pngusr.h" the followings:
 * #define PNG_USER_PRIVATEBUILD <Describes by whom and why this version of
 *        the DLL was built>
 *  e.g. #define PNG_USER_PRIVATEBUILD "Build by MyCompany for xyz reasons."
 * #define PNG_USER_DLLFNAME_POSTFIX <two-letter postfix that serve to
 *        distinguish your DLL from those of the official release. These
 *        correspond to the trailing letters that come after the version
 *        number and must match your private DLL name>
 *  e.g. // private DLL "libpng13gx.dll"
 *       #define PNG_USER_DLLFNAME_POSTFIX "gx"
 *
 * The following macros are also at your disposal if you want to complete the
 * DLL VERSIONINFO structure.
 * - PNG_USER_VERSIONINFO_COMMENTS
 * - PNG_USER_VERSIONINFO_COMPANYNAME
 * - PNG_USER_VERSIONINFO_LEGALTRADEMARKS
 */

version (__STDC__) {
   version (SPECIALBUILD) {
      pragma(msg, "PNG_LIBPNG_SPECIALBUILD (and deprecated SPECIALBUILD)
         are now LIBPNG reserved macros. Use PNG_USER_PRIVATEBUILD instead.");
   } // SPECIALBUILD

   version (PRIVATEBUILD) {
      pragma(msg, "PRIVATEBUILD is deprecated. Use PNG_USER_PRIVATEBUILD instead.")
      version = PNG_USER_PRIVATEBUILD;
   } // PRIVATEBUILD
} // __STDC__

version (PNG_VERSION_INFO_ONLY) {
} else {

/* End of material added to libpng-1.2.8 */

/* Added at libpng-1.2.19, removed at libpng-1.2.20 because it caused trouble
   Restored at libpng-1.2.21 */
version (PNG_NO_WARN_UNINITIALIZED_ROW) {
} else {
   version = PNG_WARN_UNINITIALIZED_ROW;
} // PNG_NO_WARN_UNINITIALIZED_ROW
/* End of material added at libpng-1.2.19/1.2.21 */

/* This is the size of the compression buffer, and thus the size of
 * an IDAT chunk.  Make this whatever size you feel is best for your
 * machine.  One of these will be allocated per png_struct.  When this
 * is full, it writes the data to the disk, and does some other
 * calculations.  Making this an extremely small size will slow
 * the library down, but you may want to experiment to determine
 * where it becomes significant, if you are concerned with memory
 * usage.  Note that zlib allocates at least 32Kb also.  For readers,
 * this describes the size of the buffer available to read the data in.
 * Unless this gets smaller than the size of a row (compressed),
 * it should not make much difference how big this is.
 */

enum PNG_ZBUF_SIZE = 8192;

/* Enable if you want a write-only libpng */

version (PNG_NO_READ_SUPPORTED) {
} else {
   version = PNG_READ_SUPPORTED;
} // PNG_NO_READ_SUPPORTED

/* Enable if you want a read-only libpng */

version (PNG_NO_WRITE_SUPPORTED) {
} else {
   version = PNG_WRITE_SUPPORTED;
} // PNG_NO_WRITE_SUPPORTED

/* Enabled in 1.2.41. */
// version (PNG_ALLOW_BENIGN_ERRORS) {
//    alias png_benign_error = png_warning;
//    alias png_chunk_benign_error = png_chunk_warning;
// } else {
//    version (PNG_BENIGN_ERRORS_SUPPORTED) {
//    } else {
//       alias png_benign_error = png_error;
//       alias png_chunk_benign_error = png_chunk_error;
//    } // PNG_BENIGN_ERRORS_SUPPORTED
// } // PNG_ALLOW_BENIGN_ERRORS

/* Added in libpng-1.2.41 */
version (PNG_NO_WARNINGS) {
} else {
   version = PNG_WARNINGS_SUPPORTED;
} // PNG_NO_WARNINGS

version (PNG_NO_ERROR_TEXT) {
} else {
   version = PNG_ERROR_TEXT_SUPPORTED;
} // PNG_NO_ERROR_TEXT

version (PNG_NO_CHECK_cHRM) {
} else {
   version = PNG_CHECK_cHRM_SUPPORTED;
} // PNG_NO_CHECK_cHRM

/* Enabled by default in 1.2.0.  You can disable this if you don't need to
 * support PNGs that are embedded in MNG datastreams
 */
version (PNG_1_0_X) {
} else {
   version (PNG_NO_MNG_FEATURES) {
   } else {
      version = PNG_MNG_FEATURES_SUPPORTED;
   } // PNG_NO_MNG_FEATURES
} // PNG_1_0_X

version (PNG_NO_FLOATING_POINT_SUPPORTED) {
} else {
   version = PNG_FLOATING_POINT_SUPPORTED;
} // PNG_NO_FLOATING_POINT_SUPPORTED

/* If you are running on a machine where you cannot allocate more
 * than 64K of memory at once, uncomment this.  While libpng will not
 * normally need that much memory in a chunk (unless you load up a very
 * large file), zlib needs to know how big of a chunk it can use, and
 * libpng thus makes sure to check any memory allocation to verify it
 * will fit into memory.
#define PNG_MAX_MALLOC_64K
 */
version (MAXSEG_64K) {
   version (PNG_MAX_MALLOC_64K) {
   } else {
      version = PNG_MAX_MALLOC_64K;
   } // PNG_MAX_MALLOC_64K
} // MAXSEG_64K

/* Special munging to support doing things the 'cygwin' way:
 * 'Normal' png-on-win32 defines/defaults:
 *   PNG_BUILD_DLL -- building dll
 *   PNG_USE_DLL   -- building an application, linking to dll
 *   (no define)   -- building static library, or building an
 *                    application and linking to the static lib
 * 'Cygwin' defines/defaults:
 *   PNG_BUILD_DLL -- (ignored) building the dll
 *   (no define)   -- (ignored) building an application, linking to the dll
 *   PNG_STATIC    -- (ignored) building the static lib, or building an
 *                    application that links to the static lib.
 *   ALL_STATIC    -- (ignored) building various static libs, or building an
 *                    application that links to the static libs.
 * Thus,
 * a cygwin user should define either PNG_BUILD_DLL or PNG_STATIC, and
 * this bit of #ifdefs will define the 'correct' config variables based on
 * that. If a cygwin user *wants* to define 'PNG_USE_DLL' that's okay, but
 * unnecessary.
 *
 * Also, the precedence order is:
 *   ALL_STATIC (since we can't #undef something outside our namespace)
 *   PNG_BUILD_DLL
 *   PNG_STATIC
 *   (nothing) == PNG_USE_DLL
 *
 * CYGWIN (2002-01-20): The preceding is now obsolete. With the advent
 *   of auto-import in binutils, we no longer need to worry about
 *   __declspec(dllexport) / __declspec(dllimport) and friends.  Therefore,
 *   we don't need to worry about PNG_STATIC or ALL_STATIC when it comes
 *   to __declspec() stuff.  However, we DO need to worry about
 *   PNG_BUILD_DLL and PNG_STATIC because those change some defaults
 *   such as CONSOLE_IO and whether GLOBAL_ARRAYS are allowed.
 */
// #ifdef __CYGWIN__
// #  ifdef ALL_STATIC
// #    ifdef PNG_BUILD_DLL
// #      undef PNG_BUILD_DLL
// #    endif
// #    ifdef PNG_USE_DLL
// #      undef PNG_USE_DLL
// #    endif
// #    ifdef PNG_DLL
// #      undef PNG_DLL
// #    endif
// #    ifndef PNG_STATIC
// #      define PNG_STATIC
// #    endif
// #  else
// #    ifdef PNG_BUILD_DLL
// #      ifdef PNG_STATIC
// #        undef PNG_STATIC
// #      endif
// #      ifdef PNG_USE_DLL
// #        undef PNG_USE_DLL
// #      endif
// #      ifndef PNG_DLL
// #        define PNG_DLL
// #      endif
// #    else
// #      ifdef PNG_STATIC
// #        ifdef PNG_USE_DLL
// #          undef PNG_USE_DLL
// #        endif
// #        ifdef PNG_DLL
// #          undef PNG_DLL
// #        endif
// #      else
// #        ifndef PNG_USE_DLL
// #          define PNG_USE_DLL
// #        endif
// #        ifndef PNG_DLL
// #          define PNG_DLL
// #        endif
// #      endif
// #    endif
// #  endif
// #endif

/* This protects us against compilers that run on a windowing system
 * and thus don't have or would rather us not use the stdio types:
 * stdin, stdout, and stderr.  The only one currently used is stderr
 * in png_error() and png_warning().  #defining PNG_NO_CONSOLE_IO will
 * prevent these from being compiled and used. #defining PNG_NO_STDIO
 * will also prevent these, plus will prevent the entire set of stdio
 * macros and functions (FILE *, printf, etc.) from being compiled and used,
 * unless (PNG_DEBUG > 0) has been #defined.
 *
 * #define PNG_NO_CONSOLE_IO
 * #define PNG_NO_STDIO
 */

version (PNG_NO_STDIO) {
} else {
   version = PNG_STDIO_SUPPORTED;
} // PNG_NO_STDIO

version (_WIN32_WCE) {
   import core.sys.windows.windows;
   /* Console I/O functions are not supported on WindowsCE */
   version = PNG_NO_CONSOLE_IO;
   /* abort() may not be supported on some/all Windows CE platforms */
   auto PNG_ABORT() {
      exit(-1);
   }
// #  ifdef PNG_DEBUG
// #    undef PNG_DEBUG
// #  endif
} // _WIN32_WCE

version (PNG_BUILD_DLL) {
   version (PNG_CONSOLE_IO_SUPPORTED) {
   } else {
      version (PNG_NO_CONSOLE_IO) {
      } else {
         version = PNG_NO_CONSOLE_IO;
      } // PNG_NO_CONSOLE_IO
   } // PNG_CONSOLE_IO_SUPPORTED
} // PNG_BUILD_DLL

version (PNG_NO_STDIO) {
   version = PNG_NO_CONSOLE_IO;

// #    ifdef PNG_DEBUG
// #      if (PNG_DEBUG > 0)
// #        include <stdio.h>
// #      endif
// #    endif
} else {
   version (_WIN32_WCE) {
   } else {
      /* "stdio.h" functions are not supported on WindowsCE */
      import std.c.stdio;
   }
} // PNG_NO_STDIO

version (PNG_NO_CONSOLE_IO) {
} else {
   version (PNG_CONSOLE_IO_SUPPORTED) {
      version = PNG_CONSOLE_IO_SUPPORTED;
   } // PNG_CONSOLE_IO_SUPPORTED
} // PNG_NO_CONSOLE_IO

/* This macro protects us against machines that don't have function
 * prototypes (ie K&R style headers).  If your compiler does not handle
 * function prototypes, define this macro and use the included ansi2knr.
 * I've always been able to use _NO_PROTO as the indicator, but you may
 * need to drag the empty declaration out in front of here, or change the
 * ifdef to suit your own needs.
 */
// #ifndef PNGARG
// 
// #ifdef OF /* zlib prototype munger */
// #  define PNGARG(arglist) OF(arglist)
// #else
// 
// #ifdef _NO_PROTO
// #  define PNGARG(arglist) ()
// #  ifndef PNG_TYPECAST_NULL
// #     define PNG_TYPECAST_NULL
// #  endif
// #else
// #  define PNGARG(arglist) arglist
// #endif /* _NO_PROTO */
// 
// 
// #endif /* OF */
// 
// #endif /* PNGARG */

/* Try to determine if we are compiling on a Mac.  Note that testing for
 * just __MWERKS__ is not good enough, because the Codewarrior is now used
 * on non-Mac platforms.
 */
version (MACOS) {
} else {
   version (__MWERKS__) {
      version (macintosh) {
         version = MACOS;
      } else version (applec) {
         version = MACOS;
      } else version (THINK_C) {
         version = MACOS;
      } else version (__SC__) {
         version = MACOS;
      } else version (TARGET_OS_MAC) {
         version = MACOS;
      } // TARGET_OS_MAC
   } // __MWERKS__
} // MACOS

/* enough people need this for various reasons to include it here */
version (MACOS) {
} else {
   version (RISCOS) {
   } else {
      version (_WIN32_WCE) {
         import core.sys.posix.sys.types;
      } // _WIN32_WCE
   } // RISCOS
} // MACOS

version (PNG_SETJMP_NOT_SUPPORTED) {
} else {
   version = PNG_NO_SETJMP_SUPPORTED;
} // PNG_SETJMP_NOT_SUPPORTED

version (PNG_SETJMP_SUPPORTED) {
/* This is an attempt to force a single setjmp behaviour on Linux.  If
 * the X config stuff didn't define _BSD_SOURCE we wouldn't need this.
 *
 * You can bypass this test if you know that your application uses exactly
 * the same setjmp.h that was included when libpng was built.  Only define
 * PNG_SKIP_SETJMP_CHECK while building your application, prior to the
 * application's '#include "png.h"'. Don't define PNG_SKIP_SETJMP_CHECK
 * while building a separate libpng library for general use.
 */

version (PNG_SKIP_SETJMP_CHECK) {
} else {
// #    ifdef __linux__
// #      ifdef _BSD_SOURCE
// #        define PNG_SAVE_BSD_SOURCE
// #        undef _BSD_SOURCE
// #      endif
// #      ifdef _SETJMP_H
//        /* If you encounter a compiler error here, see the explanation
//         * near the end of INSTALL.
//         */
//            __pngconf.h__ in libpng already includes setjmp.h;
//            __dont__ include it again.;
// #      endif
// #    endif /* __linux__ */
} // PNG_SKIP_SETJMP_CHECK

   /* include setjmp.h for error handling */
import core.sys.posix.setjmp;

// #  ifdef __linux__
// #    ifdef PNG_SAVE_BSD_SOURCE
// #      ifndef _BSD_SOURCE
// #        define _BSD_SOURCE
// #      endif
// #      undef PNG_SAVE_BSD_SOURCE
// #    endif
// #  endif /* __linux__ */
} /* PNG_SETJMP_SUPPORTED */

// #ifdef BSD
// #  include <strings.h>
// #else
// #  include <string.h>
// #endif

import std.c.string;

/* Other defines for things like memory and the like can go here.  */
version (PNG_INTERNAL) {

import std.c.stdlib;

/* The functions exported by PNG_EXTERN are PNG_INTERNAL functions, which
 * aren't usually used outside the library (as far as I know), so it is
 * debatable if they should be exported at all.  In the future, when it is
 * possible to have run-time registry of chunk-handling functions, some of
 * these will be made available again.
#define PNG_EXTERN extern
 */
// #define PNG_EXTERN

/* Other defines specific to compilers can go here.  Try to keep
 * them inside an appropriate ifdef/endif pair for portability.
 */

version (PNG_FLOATING_POINT_SUPPORTED) {
   version (MACOS) {
     /* We need to check that <math.h> hasn't already been included earlier
      * as it seems it doesn't agree with <fp.h>, yet we should really use
      * <fp.h> if possible.
      */
// #    if !defined(__MATH_H__) && !defined(__MATH_H) && !defined(__cmath__)
// #      include <fp.h>
// #    endif
   } else {
      import core.sys.math;
   } // MACOS
// #  if defined(_AMIGA) && defined(__SASC) && defined(_M68881)
//      /* Amiga SAS/C: We must include builtin FPU functions when compiling using
//       * MATH=68881
//       */
// #    include <m68881.h>
// #  endif
} // PNG_FLOATING_POINT_SUPPORTED

/* Codewarrior on NT has linking problems without this. */
version (__MWERKS__) {
   version (WIN32) {
      version = PNG_ALWAYS_EXTERN;
   } // WIN32
} else version (__STDC__) {
   version = PNG_ALWAYS_EXTERN;
} // __STDC__

/* This provides the non-ANSI (far) memory allocation routines. */
// #if defined(__TURBOC__) && defined(__MSDOS__)
// #  include <mem.h>
// #  include <alloc.h>
// #endif

/* I have no idea why is this necessary... */
// #if defined(_MSC_VER) && (defined(WIN32) || defined(_Windows) || \
//     defined(_WINDOWS) || defined(_WIN32) || defined(__WIN32__))
// #  include <malloc.h>
// #endif

/* This controls how fine the dithering gets.  As this allocates
 * a largish chunk of memory (32K), those who are not as concerned
 * with dithering quality can decrease some or all of these.
 */
enum PNG_DITHER_RED_BITS = 5;
enum PNG_DITHER_GREEN_BITS = 5;
enum PNG_DITHER_BLUE_BITS = 5;

/* This controls how fine the gamma correction becomes when you
 * are only interested in 8 bits anyway.  Increasing this value
 * results in more memory being used, and more pow() functions
 * being called to fill in the gamma tables.  Don't set this value
 * less then 8, and even that may not work (I haven't tested it).
 */

enum PNG_MAX_GAMMA_8 = 11;

/* This controls how much a difference in gamma we can tolerate before
 * we actually start doing gamma conversion.
 */
enum PNG_GAMMA_THRESHOLD = 0.05;

} // PNG_INTERNAL

/* The following uses const char * instead of char * for error
 * and warning message functions, so some compilers won't complain.
 * If you do not want to use const, define PNG_NO_CONST here.
 */

// #ifndef PNG_NO_CONST
// #  define PNG_CONST const
// #else
// #  define PNG_CONST
// #endif

/* The following defines give you the ability to remove code from the
 * library that you will not be using.  I wish I could figure out how to
 * automate this, but I can't do that without making it seriously hard
 * on the users.  So if you are not using an ability, change the #define
 * to and #undef, and that part of the library will not be compiled.  If
 * your linker can't find a function, you may want to make sure the
 * ability is defined here.  Some of these depend upon some others being
 * defined.  I haven't figured out all the interactions here, so you may
 * have to experiment awhile to get everything to compile.  If you are
 * creating or using a shared library, you probably shouldn't touch this,
 * as it will affect the size of the structures, and this will cause bad
 * things to happen if the library and/or application ever change.
 */

/* Any features you will not be using can be undef'ed here */

/* GR-P, 0.96a: Set "*TRANSFORMS_SUPPORTED as default but allow user
 * to turn it off with "*TRANSFORMS_NOT_SUPPORTED" or *PNG_NO_*_TRANSFORMS
 * on the compile line, then pick and choose which ones to define without
 * having to edit this file. It is safe to use the *TRANSFORMS_NOT_SUPPORTED
 * if you only want to have a png-compliant reader/writer but don't need
 * any of the extra transformations.  This saves about 80 kbytes in a
 * typical installation of the library. (PNG_NO_* form added in version
 * 1.0.1c, for consistency)
 */

/* The size of the png_text structure changed in libpng-1.0.6 when
 * iTXt support was added.  iTXt support was turned off by default through
 * libpng-1.2.x, to support old apps that malloc the png_text structure
 * instead of calling png_set_text() and letting libpng malloc it.  It
 * will be turned on by default in libpng-1.4.0.
 */

version (PNG_1_0_X) {
   version = PNG_NO_iTXt_SUPPORTED;
   version = PNG_NO_READ_iTXt;
   version = PNG_NO_WRITE_iTXt;
} else version (PNG_1_2_X) {
   version = PNG_NO_iTXt_SUPPORTED;
   version = PNG_NO_READ_iTXt;
   version = PNG_NO_WRITE_iTXt;
}

version (PNG_NO_iTXt_SUPPORTED) {
} else {
   version (PNG_READ_iTXt_SUPPORTED) {
   } else {
      version (PNG_NO_READ_iTXt) {
      } else {
         version = PNG_READ_iTXt;
      } // PNG_NO_READ_iTXt
   } // PNG_READ_iTXt_SUPPORTED

   version (PNG_WRITE_iTXt_SUPPORTED) {
   } else {
      version (PNG_NO_WRITE_iTXt) {
      } else {
         version = PNG_WRITE_iTXt;
      } // PNG_NO_WRITE_iTXt
   } // PNG_WRITE_iTXt_SUPPORTED 
} // PNG_NO_iTXt_SUPPORTED

/* The following support, added after version 1.0.0, can be turned off here en
 * masse by defining PNG_LEGACY_SUPPORTED in case you need binary compatibility
 * with old applications that require the length of png_struct and png_info
 * to remain unchanged.
 */

version (PNG_LEGACY_SUPPORTED) {
   version = PNG_NO_FREE_ME;
   version = PNG_NO_READ_UNKNOWN_CHUNKS;
   version = PNG_NO_WRITE_UNKNOWN_CHUNKS;
   version = PNG_NO_HANDLE_AS_UNKNOWN;
   version = PNG_NO_READ_USER_CHUNKS;
   version = PNG_NO_READ_iCCP;
   version = PNG_NO_WRITE_iCCP;
   version = PNG_NO_READ_iTXt;
   version = PNG_NO_WRITE_iTXt;
   version = PNG_NO_READ_sCAL;
   version = PNG_NO_WRITE_sCAL;
   version = PNG_NO_READ_sPLT;
   version = PNG_NO_WRITE_sPLT;
   version = PNG_NO_INFO_IMAGE;
   version = PNG_NO_READ_RGB_TO_GRAY;
   version = PNG_NO_READ_USER_TRANSFORM;
   version = PNG_NO_WRITE_USER_TRANSFORM;
   version = PNG_NO_USER_MEM;
   version = PNG_NO_READ_EMPTY_PLTE;
   version = PNG_NO_MNG_FEATURES;
   version = PNG_NO_FIXED_POINT_SUPPORTED;
} // PNG_LEGACY_SUPPORTED

/* Ignore attempt to turn off both floating and fixed point support */
version (PNG_FLOATING_POINT_SUPPORTED) {
} else {
   version (PNG_NO_FIXED_POINT_SUPPORTED) {
   } else {
      version = PNG_FIXED_POINT_SUPPORTED;
   } // PNG_NO_FIXED_POINT_SUPPORTED
} // PNG_FLOATING_POINT_SUPPORTED

version (PNG_NO_FREE_ME) {
   version = PNG_FREE_ME_SUPPORTED;
} // PNG_NO_FREE_ME

version (PNG_READ_SUPPORTED) {

version (PNG_READ_TRANSFORMS_NOT_SUPPORTED) {
} else {
   version (PNG_NO_READ_TRANSFORMS) {
   } else {
      version = PNG_READ_TRANSFORMS_SUPPORTED;
   }
}

version (PNG_READ_TRANSFORMS_SUPPORTED) {
   version (PNG_NO_READ_EXPAND) {
   } else {
      version = PNG_READ_EXPAND_SUPPORTED;
   } // PNG_NO_READ_EXPAND
   version (PNG_NO_READ_SHIFT) {
   } else {
      version = PNG_READ_SHIFT_SUPPORTED;
   } // PNG_NO_READ_SHIFT
   version (PNG_NO_READ_PACK) {
   } else {
      version = PNG_READ_PACK_SUPPORTED;
   } // PNG_NO_READ_PACK
   version (PNG_NO_READ_BGR) {
   } else {
      version = PNG_READ_BGR_SUPPORTED;
   } // PNG_NO_READ_BGR
   version (PNG_NO_READ_SWAP) {
   } else {
      version = PNG_READ_SWAP_SUPPORTED;
   } // PNG_NO_READ_SWAP
   version (PNG_NO_READ_PACKSWAP) {
   } else {
      version = PNG_READ_PACKSWAP_SUPPORTED;
   } // PNG_NO_READ_PACKSWAP
   version (PNG_NO_READ_INVERT) {
   } else {
      version = PNG_READ_INVERT_SUPPORTED;
   } // PNG_NO_READ_INVERT
   version (PNG_NO_READ_DITHER) {
   } else {
      version = PNG_READ_DITHER_SUPPORTED;
   } // PNG_NO_READ_DITHER
   version (PNG_NO_READ_BACKGROUND) {
   } else {
      version = PNG_READ_BACKGROUND_SUPPORTED;
   } // PNG_NO_READ_BACKGROUND
   version (PNG_NO_READ_16_TO_8) {
   } else {
      version = PNG_READ_16_TO_8_SUPPORTED;
   } // PNG_NO_READ_16_TO_8
   version (PNG_NO_READ_FILLER) {
   } else {
      version = PNG_READ_FILLER_SUPPORTED;
   } // PNG_NO_READ_FILLER
   version (PNG_NO_READ_GAMMA) {
   } else {
      version = PNG_READ_GAMMA_SUPPORTED;
   } // PNG_NO_READ_GAMMA
   version (PNG_NO_READ_GRAY_TO_RGB) {
   } else {
      version = PNG_READ_GRAY_TO_RGB_SUPPORTED;
   } // PNG_NO_READ_GRAY_TO_RGB
   version (PNG_NO_READ_SWAP_ALPHA) {
   } else {
      version = PNG_READ_SWAP_ALPHA_SUPPORTED;
   } // PNG_NO_READ_SWAP_ALPHA
   version (PNG_NO_READ_INVERT_ALPHA) {
   } else {
      version = PNG_READ_INVERT_ALPHA_SUPPORTED;
   } // PNG_NO_READ_INVERT_ALPHA
   version (PNG_NO_READ_STRIP_ALPHA) {
   } else {
      version = PNG_READ_STRIP_ALPHA_SUPPORTED;
   } // PNG_NO_READ_STRIP_ALPHA
   version (PNG_NO_READ_USER_TRANSFORM) {
   } else {
      version = PNG_READ_USER_TRANSFORM_SUPPORTED;
   } // PNG_NO_READ_USER_TRANSFORM
   version (PNG_NO_READ_RGB_TO_GRAY) {
   } else {
      version = PNG_READ_RGB_TO_GRAY_SUPPORTED;
   } // PNG_NO_READ_RGB_TO_GRAY
} // PNG_READ_TRANSFORMS_SUPPORTED

/* PNG_PROGRESSIVE_READ_NOT_SUPPORTED is deprecated. */
version (PNG_NO_PROGRESSIVE_READ) {
} else {
   version = PNG_PROGRESSIVE_READ_NOT_SUPPORTED;
} // PNG_NO_PROGRESSIVE_READ

/* if you don't do progressive reading.  This is not talking
 * about interlacing capability!  You'll still have interlacing unless you change the
 following define: */
version = PNG_READ_INTERLACING_SUPPORTED; /* required for PNG-compliant decoders */

/* PNG_NO_SEQUENTIAL_READ_SUPPORTED is deprecated. */
version (PNG_NO_SEQUENTIAL_READ) {
} else {
   version (PNG_NO_SEQUENTIAL_READ_SUPPORTED) {
   } else {
      version = PNG_SEQUENTIAL_READ_SUPPORTED;
   } // PNG_NO_SEQUENTIAL_READ_SUPPORTED
} // PNG_NO_SEQUENTIAL_READ

version (PNG_NO_READ_COMPOSITE_NODIV) {
} else {
   version (PNG_NO_READ_COMPOSITED_NODIV) {
   } else {
      version = PNG_READ_COMPOSITE_NODIV_SUPPORTED;  /* well tested on Intel, SGI */

   } // PNG_NO_READ_COMPOSITED_NODIV
} // PNG_NO_READ_COMPOSITE_NODIV

version (PNG_1_0_X) {
   /* Deprecated, will be removed from version 2.0.0.
      Use PNG_MNG_FEATURES_SUPPORTED instead. */
   version (PNG_NO_READ_EMPTY_PLTE) {
   } else {
      version = PNG_READ_EMPTY_PLTE_SUPPORTED;
   } // PNG_NO_READ_EMPTY_PLTE
} else version (PNG_1_2_X) {
   /* Deprecated, will be removed from version 2.0.0.
      Use PNG_MNG_FEATURES_SUPPORTED instead. */
   version (PNG_NO_READ_EMPTY_PLTE) {
   } else {
      version = PNG_READ_EMPTY_PLTE_SUPPORTED;
   } // PNG_NO_READ_EMPTY_PLTE
} // PNG_1_2_X

} // PNG_READ_SUPPORTED

version (PNG_WRITE_SUPPORTED) {

version (PNG_WRITE_TRANSFORMS_NOT_SUPPORTED) {
} else {
   version (PNG_NO_WRITE_TRANSFORMS) {
   } else {
      version = PNG_WRITE_TRANSFORMS_SUPPORTED;
   } // PNG_NO_WRITE_TRANSFORMS
} // PNG_WRITE_TRANSFORMS_NOT_SUPPORTED

version (PNG_WRITE_TRANSFORMS_SUPPORTED) {
   version (PNG_NO_WRITE_SHIFT) {
   } else {
      version = PNG_WRITE_SHIFT_SUPPORTED;
   } // PNG_NO_WRITE_SHIFT
   version (PNG_NO_WRITE_PACK) {
   } else {
      version = PNG_WRITE_PACK_SUPPORTED;
   } // PNG_NO_WRITE_PACK
   version (PNG_NO_WRITE_BGR) {
   } else {
      version = PNG_WRITE_BGR_SUPPORTED;
   } // PNG_NO_WRITE_BGR
   version (PNG_NO_WRITE_SWAP) {
   } else {
      version = PNG_WRITE_SWAP_SUPPORTED;
   } // PNG_NO_WRITE_SWAP
   version (PNG_NO_WRITE_PACKSWAP) {
   } else {
      version = PNG_WRITE_PACKSWAP_SUPPORTED;
   } // PNG_NO_WRITE_PACKSWAP
   version (PNG_NO_WRITE_INVERT) {
   } else {
      version = PNG_WRITE_INVERT_SUPPORTED;
   } // PNG_NO_WRITE_INVERT
   version (PNG_NO_WRITE_FILLER) {
   } else {
      version = PNG_WRITE_FILLER_SUPPORTED   /* same as WRITE_STRIP_ALPHA */;
   } // PNG_NO_WRITE_FILLER
   version (PNG_NO_WRITE_SWAP_ALPHA) {
   } else {
      version = PNG_WRITE_SWAP_ALPHA_SUPPORTED;
   } // PNG_NO_WRITE_SWAP_ALPHA
   version (PNG_1_0_X) {
   } else {
      version (PNG_NO_WRITE_INVERT_ALPHA) {
      } else {
         version = PNG_WRITE_INVERT_ALPHA_SUPPORTED;
      } // PNG_NO_WRITE_INVERT_ALPHA
   } // PNG_1_0_X
   version (PNG_NO_WRITE_USER_TRANSFORM) {
   } else {
      version = PNG_WRITE_USER_TRANSFORM_SUPPORTED;
   } // PNG_NO_WRITE_USER_TRANSFORM
} // PNG_WRITE_TRANSFORMS_SUPPORTED

version (PNG_NO_WRITE_INTERLACING_SUPPORTED) {
} else {
   /* Not required for PNG-compliant encoders, but can cause trouble
    * if left undefined
    */
   version = PNG_WRITE_INTERLACING_SUPPORTED;
} // PNG_NO_WRITE_INTERLACING_SUPPORTED

version (PNG_NO_WRITE_WEIGHTED_FILTER) {
} else {
   version (PNG_WRITE_WEIGHTED_FILTER) {
   } else {
      version (PNG_FLOATING_POINT_SUPPORTED) {
         version = PNG_WRITE_WEIGHTED_FILTER_SUPPORTED;
     } // PNG_FLOATING_POINT_SUPPORTED
   } // PNG_WRITE_WEIGHTED_FILTER
} // PNG_NO_WRITE_WEIGHTED_FILTER 

version (PNG_NO_WRITE_FLUSH) {
   version = PNG_WRITE_FLUSH_SUPPORTED;
} // PNG_NO_WRITE_FLUSH

version (PNG_1_0_X) {
   /* Deprecated, see PNG_MNG_FEATURES_SUPPORTED, above */
   version (PNG_NO_WRITE_EMPTY_PLTE) {
   } else {
      version = PNG_WRITE_EMPTY_PLTE_SUPPORTED;
   }
} else version (PNG_1_2_X) {
   /* Deprecated, see PNG_MNG_FEATURES_SUPPORTED, above */
   version (PNG_NO_WRITE_EMPTY_PLTE) {
   } else {
      version = PNG_WRITE_EMPTY_PLTE_SUPPORTED;
   }
} // PNG_1_2_X

} // PNG_WRITE_SUPPORTED */

version (PNG_1_0_X) {
} else {
   version (PNG_NO_ERROR_NUMBERS) {
   } else {
      version = PNG_ERROR_NUMBERS_SUPPORTED;
   } // PNG_NO_ERROR_NUMBERS
} // PNG_1_0_X

version (PNG_READ_USER_TRANSFORM_SUPPORTED) {
   version (PNG_NO_USER_TRANSFORM_PTR) {
   } else {
      version = PNG_USER_TRANSFORM_PTR_SUPPORTED;
   } // PNG_NO_USER_TRANSFORM_PTR
} else version (PNG_WRITE_USER_TRANSFORM_SUPPORTED) {
   version (PNG_NO_USER_TRANSFORM_PTR) {
   } else {
      version = PNG_USER_TRANSFORM_PTR_SUPPORTED;
   } // PNG_NO_USER_TRANSFORM_PTR
} // PNG_WRITE_USER_TRANSFORM_SUPPORTED

version (PNG_NO_STDIO) {
} else {
   version = PNG_TIME_RFC1123_SUPPORTED;
}

/* This adds extra functions in pngget.c for accessing data from the
 * info pointer (added in version 0.99)
 * png_get_image_width()
 * png_get_image_height()
 * png_get_bit_depth()
 * png_get_color_type()
 * png_get_compression_type()
 * png_get_filter_type()
 * png_get_interlace_type()
 * png_get_pixel_aspect_ratio()
 * png_get_pixels_per_meter()
 * png_get_x_offset_pixels()
 * png_get_y_offset_pixels()
 * png_get_x_offset_microns()
 * png_get_y_offset_microns()
 */
version (PNG_NO_EASY_ACCESS) {
} else {
   version = PNG_EASY_ACCESS_SUPPORTED;
} // PNG_NO_EASY_ACCESS

/* PNG_ASSEMBLER_CODE was enabled by default in version 1.2.0
 * and removed from version 1.2.20.  The following will be removed
 * from libpng-1.4.0
*/

version (PNG_READ_SUPPORTED) {
   version (PNG_NO_OPTIMIZED_CODE) {
   } else {
      version = PNG_OPTIMIZED_CODE_SUPPORTED;
   } // PNG_NO_OPTIMIZED_CODE

   version (PNG_NO_ASSEMBLER_CODE) {
   } else {
      version = PNG_ASSEMBLER_CODE_SUPPORTED;
   } // PNG_NO_ASSEMBLER_CODE
} // PNG_READ_SUPPORTED

version (PNG_READ_SUPPORTED) {
   version (PNG_NO_ASSEMBLER_CODE) {
   } else {
      version = PNG_ASSEMBLER_CODE_SUPPORTED;

// #  if defined(__GNUC__) && defined(__x86_64__) && (__GNUC__ < 4)
//      /* work around 64-bit gcc compiler bugs in gcc-3.x */
// #    if !defined(PNG_MMX_CODE_SUPPORTED) && !defined(PNG_NO_MMX_CODE)
// #      define PNG_NO_MMX_CODE
// #    endif
// #  endif

// #  ifdef __APPLE__
// #    if !defined(PNG_MMX_CODE_SUPPORTED) && !defined(PNG_NO_MMX_CODE)
// #      define PNG_NO_MMX_CODE
// #    endif
// #  endif

// #  if (defined(__MWERKS__) && ((__MWERKS__ < 0x0900) || macintosh))
// #    if !defined(PNG_MMX_CODE_SUPPORTED) && !defined(PNG_NO_MMX_CODE)
// #      define PNG_NO_MMX_CODE
// #    endif
// #  endif

      version (PNG_NO_MMX_CODE) {
      } else {
         version = PNG_MMX_CODE_SUPPORTED;
      } // PNG_NO_MMX_CODE
   } // PNG_NO_ASSEMBLER_CODE
} // PNG_READ_SUPPORTED
/* end of obsolete code to be removed from libpng-1.4.0 */

/* Added at libpng-1.2.0 */
version (PNG_1_0_X) {
} else {
   version (PNG_NO_USER_MEM) {
   } else {
      version = PNG_USER_MEM_SUPPORTED;
   } // (PNG_NO_USER_MEM)
} // PNG_1_0_X

/* Added at libpng-1.2.6 */
version (PNG_1_0_X) {
} else {
   version (PNG_NO_SET_USER_LIMITS) {
   } else {
      version = PNG_SET_USER_LIMITS_SUPPORTED;
   } // PNG_NO_SET_USER_LIMITS
} // PNG_1_0_X

/* Added at libpng-1.0.53 and 1.2.43 */
version (PNG_NO_USER_LIMITS) {
   version = PNG_USER_LIMITS_SUPPORTED;
} // PNG_NO_USER_LIMITS

/* Added at libpng-1.0.16 and 1.2.6.  To accept all valid PNGS no matter
 * how large, set these limits to 0x7fffffffL
 */
enum PNG_USER_WIDTH_MAX = 1000000L;
enum PNG_USER_HEIGHT_MAX = 1000000L;

/* Added at libpng-1.2.43.  To accept all valid PNGs no matter
 * how large, set these two limits to 0.
 */
enum PNG_USER_CHUNK_CACHE_MAX = 0;

/* Added at libpng-1.2.43 */
enum PNG_USER_CHUNK_MALLOC_MAX = 0;

enum PNG_LITERAL_SHARP = 0x23;
enum PNG_LITERAL_LEFT_SQUARE_BRACKET = 0x5b;
enum PNG_LITERAL_RIGHT_SQUARE_BRACKET = 0x5d;

/* Added at libpng-1.2.34 */
enum PNG_STRING_NEWLINE = "\n";

/* These are currently experimental features, define them if you want */

/* very little testing */
/*
#ifdef PNG_READ_SUPPORTED
#  ifndef PNG_READ_16_TO_8_ACCURATE_SCALE_SUPPORTED
#    define PNG_READ_16_TO_8_ACCURATE_SCALE_SUPPORTED
#  endif
#endif
*/

/* This is only for PowerPC big-endian and 680x0 systems */
/* some testing */
/*
#ifndef PNG_READ_BIG_ENDIAN_SUPPORTED
#  define PNG_READ_BIG_ENDIAN_SUPPORTED
#endif
*/

/* Buggy compilers (e.g., gcc 2.7.2.2) need this */
/*
#define PNG_NO_POINTER_INDEXING
*/

version (PNG_NO_POINTER_INDEXING) {
} else {
   version = PNG_POINTER_INDEXING_SUPPORTED;
} // PNG_NO_POINTER_INDEXING

/* These functions are turned off by default, as they will be phased out. */
/*
#define  PNG_USELESS_TESTS_SUPPORTED
#define  PNG_CORRECT_PALETTE_SUPPORTED
*/

/* Any chunks you are not interested in, you can undef here.  The
 * ones that allocate memory may be expecially important (hIST,
 * tEXt, zTXt, tRNS, pCAL).  Others will just save time and make png_info
 * a bit smaller.
 */

version (PNG_READ_SUPPORTED) {
   version (PNG_READ_ANCILLARY_CHUNKS_NOT_SUPPORTED) {
   } else {
      version (PNG_NO_READ_ANCILLARY_CHUNKS) {
      } else {
         version = PNG_READ_ANCILLARY_CHUNKS_SUPPORTED;
      } // PNG_NO_READ_ANCILLARY_CHUNKS
   } // PNG_READ_ANCILLARY_CHUNKS_NOT_SUPPORTED
} // PNG_READ_SUPPORTED

version (PNG_WRITE_SUPPORTED) {
   version (PNG_WRITE_ANCILLARY_CHUNKS_NOT_SUPPORTED) {
   } else {
      version (PNG_NO_WRITE_ANCILLARY_CHUNKS) {
      } else {
         version = PNG_WRITE_ANCILLARY_CHUNKS_SUPPORTED;
      } // PNG_NO_WRITE_ANCILLARY_CHUNKS
   } // PNG_WRITE_ANCILLARY_CHUNKS_NOT_SUPPORTED
} // PNG_WRITE_SUPPORTED

version (PNG_READ_ANCILLARY_CHUNKS_SUPPORTED) {

version (PNG_NO_READ_TEXT) {
   version = PNG_NO_READ_iTXt;
   version = PNG_NO_READ_tEXt;
   version = PNG_NO_READ_zTXt;
} // PNG_NO_READ_TEXT
version (PNG_NO_READ_bKGD) {
} else {
   version = PNG_READ_bKGD_SUPPORTED;
   version = PNG_bKGD_SUPPORTED;
} // PNG_NO_READ_bKGD
version (PNG_NO_READ_cHRM) {
} else {
   version = PNG_READ_cHRM_SUPPORTED;
   version = PNG_cHRM_SUPPORTED;
} // PNG_NO_READ_cHRM
version (PNG_NO_READ_gAMA) {
} else {
   version = PNG_READ_gAMA_SUPPORTED;
   version = PNG_gAMA_SUPPORTED;
} // PNG_NO_READ_gAMA
version (PNG_NO_READ_hIST) {
   version = PNG_READ_hIST_SUPPORTED;
   version = PNG_hIST_SUPPORTED;
} // PNG_NO_READ_hIST
version (PNG_NO_READ_iCCP) {
} else {
   version = PNG_READ_iCCP_SUPPORTED;
   version = PNG_iCCP_SUPPORTED;
} // PNG_NO_READ_iCCP
version (PNG_NO_READ_iTXt) {
} else {
   version = PNG_READ_iTXt_SUPPORTED;
   version = PNG_iTXt_SUPPORTED;
} // PNG_NO_READ_iTXt
version (PNG_NO_READ_oFFs) {
} else {
   version = PNG_READ_oFFs_SUPPORTED;
   version = PNG_oFFs_SUPPORTED;
} // PNG_NO_READ_oFFs
version (PNG_NO_READ_pCAL) {
} else {
   version = PNG_READ_pCAL_SUPPORTED;
   version = PNG_pCAL_SUPPORTED;
} // PNG_NO_READ_pCAL
version (PNG_NO_READ_sCAL) {
} else {
   version = PNG_READ_sCAL_SUPPORTED;
   version = PNG_sCAL_SUPPORTED;
} // PNG_NO_READ_sCAL
version (PNG_NO_READ_pHYs) {
} else {
   version = PNG_READ_pHYs_SUPPORTED;
   version = PNG_pHYs_SUPPORTED;
} // PNG_NO_READ_pHYs
version (PNG_NO_READ_sBIT) {
} else {
   version = PNG_READ_sBIT_SUPPORTED;
   version = PNG_sBIT_SUPPORTED;
} // PNG_NO_READ_sBIT
version (PNG_NO_READ_sPLT) {
} else {
   version = PNG_READ_sPLT_SUPPORTED;
   version = PNG_sPLT_SUPPORTED;
} // PNG_NO_READ_sPLT
version (PNG_NO_READ_sRGB) {
} else {
   version = PNG_READ_sRGB_SUPPORTED;
   version = PNG_sRGB_SUPPORTED;
} // PNG_NO_READ_sRGB
version (PNG_NO_READ_tEXt) {
} else {
   version = PNG_READ_tEXt_SUPPORTED;
   version = PNG_tEXt_SUPPORTED;
} // PNG_NO_READ_tEXt
version (PNG_NO_READ_tIME) {
} else {
   version = PNG_READ_tIME_SUPPORTED;
   version = PNG_tIME_SUPPORTED;
} // PNG_NO_READ_tIME
version (PNG_NO_READ_tRNS) {
} else {
   version = PNG_READ_tRNS_SUPPORTED;
   version = PNG_tRNS_SUPPORTED;
} // PNG_NO_READ_tRNS
version (PNG_NO_READ_zTXt) {
} else {
   version = PNG_READ_zTXt_SUPPORTED;
   version = PNG_zTXt_SUPPORTED;
} // PNG_NO_READ_zTXt
version (PNG_NO_READ_OPT_PLTE) {
} else {
   /* only affects support of the optional PLTE chunk in RGB and RGBA images */
   version = PNG_READ_OPT_PLTE_SUPPORTED; 
}
version (PNG_READ_iTXt_SUPPORTED) {
   version = PNG_READ_TEXT_SUPPORTED;
   version = PNG_TEXT_SUPPORTED;
} else version (PNG_READ_tEXt_SUPPORTED) {
   version = PNG_READ_TEXT_SUPPORTED;
   version = PNG_TEXT_SUPPORTED;
} else version (PNG_READ_zTXt_SUPPORTED) {
   version = PNG_READ_TEXT_SUPPORTED;
   version = PNG_TEXT_SUPPORTED;
}

} // PNG_READ_ANCILLARY_CHUNKS_SUPPORTED

version (PNG_NO_READ_UNKNOWN_CHUNKS) {
} else {
   version = PNG_READ_UNKNOWN_CHUNKS_SUPPORTED;
   version = PNG_UNKNOWN_CHUNKS_SUPPORTED;
} // PNG_NO_READ_UNKNOWN_CHUNKS

version (PNG_NO_READ_USER_CHUNKS) {
} else {
   version (PNG_READ_UNKNOWN_CHUNKS_SUPPORTED) {
      version = PNG_READ_USER_CHUNKS_SUPPORTED;
      version = PNG_USER_CHUNKS_SUPPORTED;
// #  ifdef PNG_NO_READ_UNKNOWN_CHUNKS
// #    undef PNG_NO_READ_UNKNOWN_CHUNKS
// #  endif
// #  ifdef PNG_NO_HANDLE_AS_UNKNOWN
// #    undef PNG_NO_HANDLE_AS_UNKNOWN
// #  endif
   } // PNG_READ_UNKNOWN_CHUNKS_SUPPORTED
} // PNG_NO_READ_USER_CHUNKS

version (PNG_NO_HANDLE_AS_UNKNOWN) {
} else {
   version = PNG_HANDLE_AS_UNKNOWN_SUPPORTED;
} // PNG_NO_HANDLE_AS_UNKNOWN

version (PNG_WRITE_SUPPORTED) {
version (PNG_WRITE_ANCILLARY_CHUNKS_SUPPORTED) {

version (PNG_NO_WRITE_TEXT) {
   version = PNG_NO_WRITE_iTXt;
   version = PNG_NO_WRITE_tEXt;
   version = PNG_NO_WRITE_zTXt;
} // PNG_NO_WRITE_TEXT
version (PNG_NO_WRITE_bKGD) {
} else {
   version = PNG_WRITE_bKGD_SUPPORTED;
   version = PNG_bKGD_SUPPORTED;
} // PNG_NO_WRITE_bKGD
version (PNG_NO_WRITE_cHRM) {
} else {
   version = PNG_WRITE_cHRM_SUPPORTED;
   version = PNG_cHRM_SUPPORTED;
} // PNG_NO_WRITE_cHRM
version (PNG_NO_WRITE_gAMA) {
} else {
   version =  PNG_WRITE_gAMA_SUPPORTED;
   version = PNG_gAMA_SUPPORTED;
} // PNG_NO_WRITE_gAMA
version (PNG_NO_WRITE_hIST) {
} else {
   version = PNG_WRITE_hIST_SUPPORTED;
   version = PNG_hIST_SUPPORTED;
} // PNG_NO_WRITE_hIST
version (PNG_NO_WRITE_iCCP) {
} else {
   version = PNG_WRITE_iCCP_SUPPORTED;
   version = PNG_iCCP_SUPPORTED;
} // PNG_NO_WRITE_iCCP
version (PNG_NO_WRITE_iTXt) {
} else {
   version = PNG_WRITE_iTXt_SUPPORTED;
   version = PNG_iTXt_SUPPORTED;
} // PNG_NO_WRITE_iTXt
version (PNG_NO_WRITE_oFFs) {
} else {
   version = PNG_WRITE_oFFs_SUPPORTED;
   version = PNG_oFFs_SUPPORTED;
} // PNG_NO_WRITE_oFFs
version (PNG_NO_WRITE_pCAL) {
} else {
   version = PNG_WRITE_pCAL_SUPPORTED;
   version = PNG_pCAL_SUPPORTED;
} // PNG_NO_WRITE_pCAL
version (PNG_NO_WRITE_sCAL) {
} else {
   version = PNG_WRITE_sCAL_SUPPORTED;
   version = PNG_sCAL_SUPPORTED;
} // PNG_NO_WRITE_sCAL
version (PNG_NO_WRITE_pHYs) {
} else {
   version = PNG_WRITE_pHYs_SUPPORTED;
   version = PNG_pHYs_SUPPORTED;
} // PNG_NO_WRITE_pHYs
version (PNG_NO_WRITE_sBIT) {
} else {
   version = PNG_WRITE_sBIT_SUPPORTED;
   version = PNG_sBIT_SUPPORTED;
} // PNG_NO_WRITE_sBIT
version (PNG_NO_WRITE_sPLT) {
} else {
   version = PNG_WRITE_sPLT_SUPPORTED;
   version = PNG_sPLT_SUPPORTED;
} // PNG_NO_WRITE_sPLT
version (PNG_NO_WRITE_sRGB) {
} else {
   version = PNG_WRITE_sRGB_SUPPORTED;
   version = PNG_sRGB_SUPPORTED;
} // PNG_NO_WRITE_sRGB
version (PNG_NO_WRITE_tEXt) {
} else {
   version = PNG_WRITE_tEXt_SUPPORTED;
   version = PNG_tEXt_SUPPORTED;
} // PNG_NO_WRITE_tEXt
version (PNG_NO_WRITE_tIME) {
} else {
   version = PNG_WRITE_tIME_SUPPORTED;
   version = PNG_tIME_SUPPORTED;
} // PNG_NO_WRITE_tIME
version (PNG_NO_WRITE_tRNS) {
} else {
   version = PNG_WRITE_tRNS_SUPPORTED;
   version = PNG_tRNS_SUPPORTED;
} // PNG_NO_WRITE_tRNS
version (PNG_NO_WRITE_zTXt) {
} else {
   version = PNG_WRITE_zTXt_SUPPORTED;
   version = PNG_zTXt_SUPPORTED;
} // PNG_NO_WRITE_zTXt
version (PNG_WRITE_iTXt_SUPPORTED) {
   version = PNG_WRITE_TEXT_SUPPORTED;
   version = PNG_TEXT_SUPPORTED;
} else version (PNG_WRITE_tEXt_SUPPORTED) {
   version = PNG_WRITE_TEXT_SUPPORTED;
   version = PNG_TEXT_SUPPORTED;
} else version (PNG_WRITE_zTXt_SUPPORTED) {
   version = PNG_WRITE_TEXT_SUPPORTED;
   version = PNG_TEXT_SUPPORTED;
} // PNG_WRITE_zTXt_SUPPORTED

version (PNG_WRITE_tIME_SUPPORTED) {
   version (PNG_NO_CONVERT_tIME) {
   } else {
      version (_WIN32_WCE) {
      } else {
         /*   The "tm" structure is not supported on WindowsCE */
         version = PNG_CONVERT_tIME_SUPPORTED;
      } // _WIN32_WCE
   } // PNG_NO_CONVERT_tIME
} // PNG_WRITE_tIME_SUPPORTED

} // PNG_WRITE_ANCILLARY_CHUNKS_SUPPORTED

version (PNG_NO_WRITE_FILTER) {
} else {
   version = PNG_WRITE_FILTER_SUPPORTED;
} // PNG_NO_WRITE_FILTER

version (PNG_NO_WRITE_UNKNOWN_CHUNKS) {
} else {
   version = PNG_WRITE_UNKNOWN_CHUNKS_SUPPORTED;
   version = PNG_UNKNOWN_CHUNKS_SUPPORTED;
} // PNG_NO_WRITE_UNKNOWN_CHUNKS

version (PNG_NO_HANDLE_AS_UNKNOWN) {
} else {
   version = PNG_HANDLE_AS_UNKNOWN_SUPPORTED;
} // PNG_NO_HANDLE_AS_UNKNOWN

} // PNG_WRITE_SUPPORTED

/* Turn this off to disable png_read_png() and
 * png_write_png() and leave the row_pointers member
 * out of the info structure.
 */
version (PNG_NO_INFO_IMAGE) {
} else {
   version = PNG_INFO_IMAGE_SUPPORTED;
} // PNG_NO_INFO_IMAGE

/* Need the time information for converting tIME chunks */
version (PNG_CONVERT_tIME_SUPPORTED) {
   /* "time.h" functions are not supported on WindowsCE */
   import core.sys.posix.time;
} // PNG_CONVERT_tIME_SUPPORTED

/* Some typedefs to get us started.  These should be safe on most of the
 * common platforms.  The typedefs should be at least as large as the
 * numbers suggest (a png_uint_32 must be at least 32 bits long), but they
 * don't have to be exactly that size.  Some compilers dislike passing
 * unsigned shorts as function parameters, so you may be better off using
 * unsigned int for png_uint_16.  Likewise, for 64-bit systems, you may
 * want to have unsigned int for png_uint_32 instead of unsigned long.
 */

alias ulong png_uint_32;
alias long png_int_32;
alias ushort png_uint_16;
alias short png_int_16;
alias ubyte png_byte;

/* This is usually size_t.  It is typedef'ed just in case you need it to
   change (I'm not sure if you will or not, so I thought I'd be safe) */
version (PNG_SIZE_T) {
   alias png_size_t = PNG_SIZE_T;
   auto png_sizeof(T)(T x) { return png_convert_size(x.sizeof); }
} else {
   alias png_size_t = size_t;
   auto png_sizeof(T)(T x) { return x.sizeof; }
} // PNG_SIZE_T

/* The following is needed for medium model support.  It cannot be in the
 * PNG_INTERNAL section.  Needs modification for other compilers besides
 * MSC.  Model independent support declares all arrays and pointers to be
 * large using the far keyword.  The zlib version used must also support
 * model independent data.  As of version zlib 1.0.4, the necessary changes
 * have been made in zlib.  The USE_FAR_KEYWORD define triggers other
 * changes that are needed. (Tim Wegner)
 */

/* Separate compiler dependencies (problem here is that zlib.h always
   defines FAR. (SJT) */
// #ifdef __BORLANDC__
// #  if defined(__LARGE__) || defined(__HUGE__) || defined(__COMPACT__)
// #    define LDATA 1
// #  else
// #    define LDATA 0
// #  endif
//    /* GRR:  why is Cygwin in here?  Cygwin is not Borland C... */
// #  if !defined(__WIN32__) && !defined(__FLAT__) && !defined(__CYGWIN__)
// #    define PNG_MAX_MALLOC_64K
// #    if (LDATA != 1)
// #      ifndef FAR
// #        define FAR __far
// #      endif
// #      define USE_FAR_KEYWORD
// #    endif   /* LDATA != 1 */
//      /* Possibly useful for moving data out of default segment.
//       * Uncomment it if you want. Could also define FARDATA as
//       * const if your compiler supports it. (SJT)
// #    define FARDATA FAR
//       */
// #  endif  /* __WIN32__, __FLAT__, __CYGWIN__ */
// #endif   /* __BORLANDC__ */

/* Suggest testing for specific compiler first before testing for
 * FAR.  The Watcom compiler defines both __MEDIUM__ and M_I86MM,
 * making reliance oncertain keywords suspect. (SJT)
 */

/* MSC Medium model */
// #ifdef FAR
// #  ifdef M_I86MM
// #    define USE_FAR_KEYWORD
// #    define FARDATA FAR
// #    include <dos.h>
// #  endif
// #endif

/* SJT: default case */
// #ifndef FAR
// #  define FAR
// #endif

/* Typedef for floating-point numbers that are converted
   to fixed-point with a multiple of 100,000, e.g., int_gamma */
alias png_int_32 png_fixed_point;

/* Add typedefs for pointers */
alias void            * png_voidp;
alias png_byte        * png_bytep;
alias png_uint_32     * png_uint_32p;
alias png_int_32      * png_int_32p;
alias png_uint_16     * png_uint_16p;
alias png_int_16      * png_int_16p;
alias const char      * png_const_charp;
alias char            * png_charp;
alias png_fixed_point * png_fixed_point_p;

version (PNG_NO_STDIO) {
} else {
   version (_WIN32_WCE) {
      alias HANDLE                png_FILE_p;
   } else {
      alias FILE                * png_FILE_p;
   } // _WIN32_WCE
} // PNG_NO_STDIO

version (PNG_FLOATING_POINT_SUPPORTED) {
   alias double          * png_doublep;
} // PNG_FLOATING_POINT_SUPPORTED

/* Pointers to pointers; i.e. arrays */
alias png_byte        ** png_bytepp;
alias png_uint_32     ** png_uint_32pp;
alias png_int_32      ** png_int_32pp;
alias png_uint_16     ** png_uint_16pp;
alias png_int_16      ** png_int_16pp;
alias const char      ** png_const_charpp;
alias char            ** png_charpp;
alias png_fixed_point ** png_fixed_point_pp;
version (PNG_FLOATING_POINT_SUPPORTED) {
   alias double       ** png_doublepp;
} // PNG_FLOATING_POINT_SUPPORTED

/* Pointers to pointers to pointers; i.e., pointer to array */
alias char            *** png_charppp;

version (PNG_1_0_X) {
   /* SPC -  Is this stuff deprecated? */
   /* It'll be removed as of libpng-1.4.0 - GR-P */
   /* libpng typedefs for types in zlib. If zlib changes
    * or another compression library is used, then change these.
    * Eliminates need to change all the source files.
    */
   import etc.c.zlib;
   // alias charf *    png_zcharp;
   // alias charf **   png_zcharpp;
   alias z_stream * png_zstreamp;
} else version (PNG_1_2_X) {
   /* SPC -  Is this stuff deprecated? */
   /* It'll be removed as of libpng-1.4.0 - GR-P */
   /* libpng typedefs for types in zlib. If zlib changes
    * or another compression library is used, then change these.
    * Eliminates need to change all the source files.
    */
   import etc.c.zlib;
   // alias charf *    png_zcharp;
   // alias charf **   png_zcharpp;
   alias z_stream * png_zstreamp;
} // PNG_1_2_X

/*
 * Define PNG_BUILD_DLL if the module being built is a Windows
 * LIBPNG DLL.
 *
 * Define PNG_USE_DLL if you want to *link* to the Windows LIBPNG DLL.
 * It is equivalent to Microsoft predefined macro _DLL that is
 * automatically defined when you compile using the share
 * version of the CRT (C Run-Time library)
 *
 * The cygwin mods make this behavior a little different:
 * Define PNG_BUILD_DLL if you are building a dll for use with cygwin
 * Define PNG_STATIC if you are building a static library for use with cygwin,
 *   -or- if you are building an application that you want to link to the
 *   static library.
 * PNG_USE_DLL is defined by default (no user action needed) unless one of
 *   the other flags is defined.
 */

version (PNG_BUILD_DLL) {
   version = PNG_DLL;
} else version (PNG_USE_DLL) {
   version = PNG_DLL;
} // PNG_USE_DLL

/* If CYGWIN, then disallow GLOBAL ARRAYS unless building a static lib.
 * When building a static lib, default to no GLOBAL ARRAYS, but allow
 * command-line override
 */
// #ifdef __CYGWIN__
// #  ifndef PNG_STATIC
// #    ifdef PNG_USE_GLOBAL_ARRAYS
// #      undef PNG_USE_GLOBAL_ARRAYS
// #    endif
// #    ifndef PNG_USE_LOCAL_ARRAYS
// #      define PNG_USE_LOCAL_ARRAYS
// #    endif
// #  else
// #    if defined(PNG_USE_LOCAL_ARRAYS) || defined(PNG_NO_GLOBAL_ARRAYS)
// #      ifdef PNG_USE_GLOBAL_ARRAYS
// #        undef PNG_USE_GLOBAL_ARRAYS
// #      endif
// #    endif
// #  endif
// #  if !defined(PNG_USE_LOCAL_ARRAYS) && !defined(PNG_USE_GLOBAL_ARRAYS)
// #    define PNG_USE_LOCAL_ARRAYS
// #  endif
// #endif

/* Do not use global arrays (helps with building DLL's)
 * They are no longer used in libpng itself, since version 1.0.5c,
 * but might be required for some pre-1.0.5c applications.
 */
version (PNG_NO_GLOBAL_ARRAYS) {
   version = PNG_USE_LOCAL_ARRAYS;
} else version(__GNUC__) {
   version = PNG_USE_LOCAL_ARRAYS;
} else version (PNG_DLL) {
   version = PNG_USE_LOCAL_ARRAYS;
} else version (_MSC_VER) {
   version = PNG_USE_LOCAL_ARRAYS;
} else {
   version = PNG_USE_GLOBAL_ARRAYS;
}

// #ifdef __CYGWIN__
// #  undef PNGAPI
// #  define PNGAPI __cdecl
// #  undef PNG_IMPEXP
// #  define PNG_IMPEXP
// #endif

/* If you define PNGAPI, e.g., with compiler option "-DPNGAPI=__stdcall",
 * you may get warnings regarding the linkage of png_zalloc and png_zfree.
 * Don't ignore those warnings; you must also reset the default calling
 * convention in your compiler to match your PNGAPI, and you must build
 * zlib and your applications the same way you build libpng.
 */

version (__MINGW32__) {
   version (PNG_MODULEDEF) {
   } else {
      version = PNG_NO_MODULEDEF;
   } // PNG_MODULEDEF
} // __MINGW32__

version (PNG_BUILD_DLL) {
   version (PNG_NO_MODULEDEF) {
   } else {
      version = PNG_IMPEXP;
   } // PNG_NO_MODULEDEF
} // PNG_BUILD_DLL

// #if defined(PNG_DLL) || defined(_DLL) || defined(__DLL__ ) || \
//     (( defined(_Windows) || defined(_WINDOWS) || \
//        defined(WIN32) || defined(_WIN32) || defined(__WIN32__) ))
// 
// #  ifndef PNGAPI
// #     if defined(__GNUC__) || (defined (_MSC_VER) && (_MSC_VER >= 800))
// #        define PNGAPI __cdecl
// #     else
// #        define PNGAPI _cdecl
// #     endif
// #  endif
// 
// #  if !defined(PNG_IMPEXP) && (!defined(PNG_DLL) || \
//        0 /* WINCOMPILER_WITH_NO_SUPPORT_FOR_DECLIMPEXP */)
// #     define PNG_IMPEXP
// #  endif
// 
// #  ifndef PNG_IMPEXP
// 
// #     define PNG_EXPORT_TYPE1(type,symbol)  PNG_IMPEXP type PNGAPI symbol
// #     define PNG_EXPORT_TYPE2(type,symbol)  type PNG_IMPEXP PNGAPI symbol
// 
//       /* Borland/Microsoft */
// #     if defined(_MSC_VER) || defined(__BORLANDC__)
// #        if (_MSC_VER >= 800) || (__BORLANDC__ >= 0x500)
// #           define PNG_EXPORT PNG_EXPORT_TYPE1
// #        else
// #           define PNG_EXPORT PNG_EXPORT_TYPE2
// #           ifdef PNG_BUILD_DLL
// #              define PNG_IMPEXP __export
// #           else
// #              define PNG_IMPEXP /*__import */ /* doesn't exist AFAIK in
//                                                  VC++ */
// #           endif                             /* Exists in Borland C++ for
//                                                  C++ classes (== huge) */
// #        endif
// #     endif
// 
// #     ifndef PNG_IMPEXP
// #        ifdef PNG_BUILD_DLL
// #           define PNG_IMPEXP __declspec(dllexport)
// #        else
// #           define PNG_IMPEXP __declspec(dllimport)
// #        endif
// #     endif
// #  endif  /* PNG_IMPEXP */
// #else /* !(DLL || non-cygwin WINDOWS) */
// #   if (defined(__IBMC__) || defined(__IBMCPP__)) && defined(__OS2__)
// #      ifndef PNGAPI
// #         define PNGAPI _System
// #      endif
// #   else
// #      if 0 /* ... other platforms, with other meanings */
// #      endif
// #   endif
// #endif

// #ifndef PNGAPI
// #  define PNGAPI
// #endif
// #ifndef PNG_IMPEXP
// #  define PNG_IMPEXP
// #endif
//
// #ifdef PNG_BUILDSYMS
// #  ifndef PNG_EXPORT
// #    define PNG_EXPORT(type,symbol) PNG_FUNCTION_EXPORT symbol END
// #  endif
// #  ifdef PNG_USE_GLOBAL_ARRAYS
// #    ifndef PNG_EXPORT_VAR
// #      define PNG_EXPORT_VAR(type) PNG_DATA_EXPORT
// #    endif
// #  endif
// #endif
//
// #ifndef PNG_EXPORT
// #  define PNG_EXPORT(type,symbol) PNG_IMPEXP type PNGAPI symbol
// #endif
//
// #ifdef PNG_USE_GLOBAL_ARRAYS
// #  ifndef PNG_EXPORT_VAR
// #    define PNG_EXPORT_VAR(type) extern PNG_IMPEXP type
// #  endif
// #endif

version (PNG_PEDANTIC_WARNINGS) {
   version = PNG_PEDANTIC_WARNINGS_SUPPORTED;
} // PNG_PEDANTIC_WARNINGS

// #ifdef PNG_PEDANTIC_WARNINGS_SUPPORTED
// /* Support for compiler specific function attributes.  These are used
//  * so that where compiler support is available incorrect use of API
//  * functions in png.h will generate compiler warnings.  Added at libpng
//  * version 1.2.41.
//  */
// #  ifdef __GNUC__
// #    ifndef PNG_USE_RESULT
// #      define PNG_USE_RESULT __attribute__((__warn_unused_result__))
// #    endif
// #    ifndef PNG_NORETURN
// #      define PNG_NORETURN   __attribute__((__noreturn__))
// #    endif
// #    ifndef PNG_ALLOCATED
// #      define PNG_ALLOCATED  __attribute__((__malloc__))
// #    endif
// 
//     /* This specifically protects structure members that should only be
//      * accessed from within the library, therefore should be empty during
//      * a library build.
//      */
// #    ifndef PNG_DEPRECATED
// #      define PNG_DEPRECATED __attribute__((__deprecated__))
// #    endif
// #    ifndef PNG_DEPSTRUCT
// #      define PNG_DEPSTRUCT  __attribute__((__deprecated__))
// #    endif
// #    ifndef PNG_PRIVATE
// #      if 0 /* Doesn't work so we use deprecated instead*/
// #        define PNG_PRIVATE \
//           __attribute__((warning("This function is not exported by libpng.")))
// #      else
// #        define PNG_PRIVATE \
//           __attribute__((__deprecated__))
// #      endif
// #    endif /* PNG_PRIVATE */
// #  endif /* __GNUC__ */
// #endif /* PNG_PEDANTIC_WARNINGS */
// 
// #ifndef PNG_DEPRECATED
// #  define PNG_DEPRECATED  /* Use of this function is deprecated */
// #endif
// #ifndef PNG_USE_RESULT
// #  define PNG_USE_RESULT  /* The result of this function must be checked */
// #endif
// #ifndef PNG_NORETURN
// #  define PNG_NORETURN    /* This function does not return */
// #endif
// #ifndef PNG_ALLOCATED
// #  define PNG_ALLOCATED   /* The result of the function is new memory */
// #endif
// #ifndef PNG_DEPSTRUCT
// #  define PNG_DEPSTRUCT   /* Access to this struct member is deprecated */
// #endif
// #ifndef PNG_PRIVATE
// #  define PNG_PRIVATE     /* This is a private libpng function */
// #endif

/* User may want to use these so they are not in PNG_INTERNAL. Any library
 * functions that are passed far data must be model independent.
 */

// #ifndef PNG_ABORT
// #  define PNG_ABORT() abort()
// #endif

// version (PNG_SETJMP_SUPPORTED) {
//    jmp_buf png_jmpbuf(png_structp png_ptr) { return png_ptr.jmpbuf; }
// } else {
//    jmp_buf png_jmpbuf(png_structp png_ptr) {
//       assert(0, "Library compiled with PNG_SETJMP not supported");
//    }
// } // PNG_SETJMP_SUPPORTED

version (USE_FAR_KEYWORD) {  /* memory model independent fns */
/* Use this to make far-to-near assignments */
// #  define CHECK   1
// #  define NOCHECK 0
// #  define CVT_PTR(ptr) (png_far_to_near(png_ptr,ptr,CHECK))
// #  define CVT_PTR_NOCHECK(ptr) (png_far_to_near(png_ptr,ptr,NOCHECK))
// #  define png_snprintf _fsnprintf   /* Added to v 1.2.19 */
// #  define png_strlen  _fstrlen
// #  define png_memcmp  _fmemcmp    /* SJT: added */
// #  define png_memcpy  _fmemcpy
// #  define png_memset  _fmemset
} else { /* Use the usual functions */
   auto CVT_PTR(T)(T ptr) { return ptr; }
   auto CVT_PTR_NOCHECK(T)(T ptr) { return ptr; }
   version (PNG_NO_SNPRINTF) {
     /* You don't have or don't want to use snprintf().  Caution: Using
      * sprintf instead of snprintf exposes your application to accidental
      * or malevolent buffer overflows.  If you don't have snprintf()
      * as a general rule you should provide one (you can get one from
      * Portable OpenSSH).
      */
      auto png_snprintf(auto s1, auto n, auto fmt, auto x1) {
         return sprintf(s1, fmt, x1);
      }

      auto png_snprintf2(auto s1, auto n, auto fmt, auto x1, auto x2) {
         return sprintf(s1, fmt, x1, x2);
      }

      auto png_snprintf6(auto s1,
            auto n,
            auto fmt,
            auto x1,
            auto x2,
            auto x3,
            auto x4,
            auto x5,
            auto x6) {
         return sprintf(s1, fmt, x1, x2, x3, x4, x5, x6);
      }
   } else {
      version (_MSC_VER) {
         alias png_snprintf = _snprintf;   /* Added to v 1.2.19 */
         alias png_snprintf2 = _snprintf;
         alias png_snprintf6 = _snprintf;
      } else {
         alias png_snprintf = snprintf;   /* Added to v 1.2.19 */
         alias png_snprintf2 = snprintf;
         alias png_snprintf6 = snprintf;
      } // _MSC_VER
   }

   alias png_strlen = strlen;
   alias png_memcmp = memcmp;      /* SJT: added */
   alias png_memcpy = memcpy;
   alias png_memset = memset;
} // USE_FAR_KEYWORD
/* End of memory model independent support */

/* Just a little check that someone hasn't tried to define something
 * contradictory.
 */
// #if (PNG_ZBUF_SIZE > 65536L) && defined(PNG_MAX_MALLOC_64K)
// #  undef PNG_ZBUF_SIZE
// #  define PNG_ZBUF_SIZE 65536L
// #endif

/* Added at libpng-1.2.8 */
} // PNG_VERSION_INFO_ONLY
