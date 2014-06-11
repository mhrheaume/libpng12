module libpng12.png;

/* png.h - header file for PNG reference library
 *
 * libpng version 1.2.50 - July 10, 2012
 * Copyright (c) 1998-2012 Glenn Randers-Pehrson
 * (Version 0.96 Copyright (c) 1996, 1997 Andreas Dilger)
 * (Version 0.88 Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.)
 *
 * This code is released under the libpng license (See LICENSE, below)
 *
 * Authors and maintainers:
 *  libpng versions 0.71, May 1995, through 0.88, January 1996: Guy Schalnat
 *  libpng versions 0.89c, June 1996, through 0.96, May 1997: Andreas Dilger
 *  libpng versions 0.97, January 1998, through 1.2.50 - July 10, 2012: Glenn
 *  See also "Contributing Authors", below.
 *
 * Note about libpng version numbers:
 *
 *    Due to various miscommunications, unforeseen code incompatibilities
 *    and occasional factors outside the authors' control, version numbering
 *    on the library has not always been consistent and straightforward.
 *    The following table summarizes matters since version 0.89c, which was
 *    the first widely used release:
 *
 *    source                 png.h  png.h  shared-lib
 *    version                string   int  version
 *    -------                ------ -----  ----------
 *    0.89c "1.0 beta 3"     0.89      89  1.0.89
 *    0.90  "1.0 beta 4"     0.90      90  0.90  [should have been 2.0.90]
 *    0.95  "1.0 beta 5"     0.95      95  0.95  [should have been 2.0.95]
 *    0.96  "1.0 beta 6"     0.96      96  0.96  [should have been 2.0.96]
 *    0.97b "1.00.97 beta 7" 1.00.97   97  1.0.1 [should have been 2.0.97]
 *    0.97c                  0.97      97  2.0.97
 *    0.98                   0.98      98  2.0.98
 *    0.99                   0.99      98  2.0.99
 *    0.99a-m                0.99      99  2.0.99
 *    1.00                   1.00     100  2.1.0 [100 should be 10000]
 *    1.0.0      (from here on, the   100  2.1.0 [100 should be 10000]
 *    1.0.1       png.h string is   10001  2.1.0
 *    1.0.1a-e    identical to the  10002  from here on, the shared library
 *    1.0.2       source version)   10002  is 2.V where V is the source code
 *    1.0.2a-b                      10003  version, except as noted.
 *    1.0.3                         10003
 *    1.0.3a-d                      10004
 *    1.0.4                         10004
 *    1.0.4a-f                      10005
 *    1.0.5 (+ 2 patches)           10005
 *    1.0.5a-d                      10006
 *    1.0.5e-r                      10100 (not source compatible)
 *    1.0.5s-v                      10006 (not binary compatible)
 *    1.0.6 (+ 3 patches)           10006 (still binary incompatible)
 *    1.0.6d-f                      10007 (still binary incompatible)
 *    1.0.6g                        10007
 *    1.0.6h                        10007  10.6h (testing xy.z so-numbering)
 *    1.0.6i                        10007  10.6i
 *    1.0.6j                        10007  2.1.0.6j (incompatible with 1.0.0)
 *    1.0.7beta11-14        DLLNUM  10007  2.1.0.7beta11-14 (binary compatible)
 *    1.0.7beta15-18           1    10007  2.1.0.7beta15-18 (binary compatible)
 *    1.0.7rc1-2               1    10007  2.1.0.7rc1-2 (binary compatible)
 *    1.0.7                    1    10007  (still compatible)
 *    1.0.8beta1-4             1    10008  2.1.0.8beta1-4
 *    1.0.8rc1                 1    10008  2.1.0.8rc1
 *    1.0.8                    1    10008  2.1.0.8
 *    1.0.9beta1-6             1    10009  2.1.0.9beta1-6
 *    1.0.9rc1                 1    10009  2.1.0.9rc1
 *    1.0.9beta7-10            1    10009  2.1.0.9beta7-10
 *    1.0.9rc2                 1    10009  2.1.0.9rc2
 *    1.0.9                    1    10009  2.1.0.9
 *    1.0.10beta1              1    10010  2.1.0.10beta1
 *    1.0.10rc1                1    10010  2.1.0.10rc1
 *    1.0.10                   1    10010  2.1.0.10
 *    1.0.11beta1-3            1    10011  2.1.0.11beta1-3
 *    1.0.11rc1                1    10011  2.1.0.11rc1
 *    1.0.11                   1    10011  2.1.0.11
 *    1.0.12beta1-2            2    10012  2.1.0.12beta1-2
 *    1.0.12rc1                2    10012  2.1.0.12rc1
 *    1.0.12                   2    10012  2.1.0.12
 *    1.1.0a-f                 -    10100  2.1.1.0a-f (branch abandoned)
 *    1.2.0beta1-2             2    10200  2.1.2.0beta1-2
 *    1.2.0beta3-5             3    10200  3.1.2.0beta3-5
 *    1.2.0rc1                 3    10200  3.1.2.0rc1
 *    1.2.0                    3    10200  3.1.2.0
 *    1.2.1beta1-4             3    10201  3.1.2.1beta1-4
 *    1.2.1rc1-2               3    10201  3.1.2.1rc1-2
 *    1.2.1                    3    10201  3.1.2.1
 *    1.2.2beta1-6            12    10202  12.so.0.1.2.2beta1-6
 *    1.0.13beta1             10    10013  10.so.0.1.0.13beta1
 *    1.0.13rc1               10    10013  10.so.0.1.0.13rc1
 *    1.2.2rc1                12    10202  12.so.0.1.2.2rc1
 *    1.0.13                  10    10013  10.so.0.1.0.13
 *    1.2.2                   12    10202  12.so.0.1.2.2
 *    1.2.3rc1-6              12    10203  12.so.0.1.2.3rc1-6
 *    1.2.3                   12    10203  12.so.0.1.2.3
 *    1.2.4beta1-3            13    10204  12.so.0.1.2.4beta1-3
 *    1.0.14rc1               13    10014  10.so.0.1.0.14rc1
 *    1.2.4rc1                13    10204  12.so.0.1.2.4rc1
 *    1.0.14                  10    10014  10.so.0.1.0.14
 *    1.2.4                   13    10204  12.so.0.1.2.4
 *    1.2.5beta1-2            13    10205  12.so.0.1.2.5beta1-2
 *    1.0.15rc1-3             10    10015  10.so.0.1.0.15rc1-3
 *    1.2.5rc1-3              13    10205  12.so.0.1.2.5rc1-3
 *    1.0.15                  10    10015  10.so.0.1.0.15
 *    1.2.5                   13    10205  12.so.0.1.2.5
 *    1.2.6beta1-4            13    10206  12.so.0.1.2.6beta1-4
 *    1.0.16                  10    10016  10.so.0.1.0.16
 *    1.2.6                   13    10206  12.so.0.1.2.6
 *    1.2.7beta1-2            13    10207  12.so.0.1.2.7beta1-2
 *    1.0.17rc1               10    10017  10.so.0.1.0.17rc1
 *    1.2.7rc1                13    10207  12.so.0.1.2.7rc1
 *    1.0.17                  10    10017  10.so.0.1.0.17
 *    1.2.7                   13    10207  12.so.0.1.2.7
 *    1.2.8beta1-5            13    10208  12.so.0.1.2.8beta1-5
 *    1.0.18rc1-5             10    10018  10.so.0.1.0.18rc1-5
 *    1.2.8rc1-5              13    10208  12.so.0.1.2.8rc1-5
 *    1.0.18                  10    10018  10.so.0.1.0.18
 *    1.2.8                   13    10208  12.so.0.1.2.8
 *    1.2.9beta1-3            13    10209  12.so.0.1.2.9beta1-3
 *    1.2.9beta4-11           13    10209  12.so.0.9[.0]
 *    1.2.9rc1                13    10209  12.so.0.9[.0]
 *    1.2.9                   13    10209  12.so.0.9[.0]
 *    1.2.10beta1-8           13    10210  12.so.0.10[.0]
 *    1.2.10rc1-3             13    10210  12.so.0.10[.0]
 *    1.2.10                  13    10210  12.so.0.10[.0]
 *    1.2.11beta1-4           13    10211  12.so.0.11[.0]
 *    1.0.19rc1-5             10    10019  10.so.0.19[.0]
 *    1.2.11rc1-5             13    10211  12.so.0.11[.0]
 *    1.0.19                  10    10019  10.so.0.19[.0]
 *    1.2.11                  13    10211  12.so.0.11[.0]
 *    1.0.20                  10    10020  10.so.0.20[.0]
 *    1.2.12                  13    10212  12.so.0.12[.0]
 *    1.2.13beta1             13    10213  12.so.0.13[.0]
 *    1.0.21                  10    10021  10.so.0.21[.0]
 *    1.2.13                  13    10213  12.so.0.13[.0]
 *    1.2.14beta1-2           13    10214  12.so.0.14[.0]
 *    1.0.22rc1               10    10022  10.so.0.22[.0]
 *    1.2.14rc1               13    10214  12.so.0.14[.0]
 *    1.0.22                  10    10022  10.so.0.22[.0]
 *    1.2.14                  13    10214  12.so.0.14[.0]
 *    1.2.15beta1-6           13    10215  12.so.0.15[.0]
 *    1.0.23rc1-5             10    10023  10.so.0.23[.0]
 *    1.2.15rc1-5             13    10215  12.so.0.15[.0]
 *    1.0.23                  10    10023  10.so.0.23[.0]
 *    1.2.15                  13    10215  12.so.0.15[.0]
 *    1.2.16beta1-2           13    10216  12.so.0.16[.0]
 *    1.2.16rc1               13    10216  12.so.0.16[.0]
 *    1.0.24                  10    10024  10.so.0.24[.0]
 *    1.2.16                  13    10216  12.so.0.16[.0]
 *    1.2.17beta1-2           13    10217  12.so.0.17[.0]
 *    1.0.25rc1               10    10025  10.so.0.25[.0]
 *    1.2.17rc1-3             13    10217  12.so.0.17[.0]
 *    1.0.25                  10    10025  10.so.0.25[.0]
 *    1.2.17                  13    10217  12.so.0.17[.0]
 *    1.0.26                  10    10026  10.so.0.26[.0]
 *    1.2.18                  13    10218  12.so.0.18[.0]
 *    1.2.19beta1-31          13    10219  12.so.0.19[.0]
 *    1.0.27rc1-6             10    10027  10.so.0.27[.0]
 *    1.2.19rc1-6             13    10219  12.so.0.19[.0]
 *    1.0.27                  10    10027  10.so.0.27[.0]
 *    1.2.19                  13    10219  12.so.0.19[.0]
 *    1.2.20beta01-04         13    10220  12.so.0.20[.0]
 *    1.0.28rc1-6             10    10028  10.so.0.28[.0]
 *    1.2.20rc1-6             13    10220  12.so.0.20[.0]
 *    1.0.28                  10    10028  10.so.0.28[.0]
 *    1.2.20                  13    10220  12.so.0.20[.0]
 *    1.2.21beta1-2           13    10221  12.so.0.21[.0]
 *    1.2.21rc1-3             13    10221  12.so.0.21[.0]
 *    1.0.29                  10    10029  10.so.0.29[.0]
 *    1.2.21                  13    10221  12.so.0.21[.0]
 *    1.2.22beta1-4           13    10222  12.so.0.22[.0]
 *    1.0.30rc1               10    10030  10.so.0.30[.0]
 *    1.2.22rc1               13    10222  12.so.0.22[.0]
 *    1.0.30                  10    10030  10.so.0.30[.0]
 *    1.2.22                  13    10222  12.so.0.22[.0]
 *    1.2.23beta01-05         13    10223  12.so.0.23[.0]
 *    1.2.23rc01              13    10223  12.so.0.23[.0]
 *    1.2.23                  13    10223  12.so.0.23[.0]
 *    1.2.24beta01-02         13    10224  12.so.0.24[.0]
 *    1.2.24rc01              13    10224  12.so.0.24[.0]
 *    1.2.24                  13    10224  12.so.0.24[.0]
 *    1.2.25beta01-06         13    10225  12.so.0.25[.0]
 *    1.2.25rc01-02           13    10225  12.so.0.25[.0]
 *    1.0.31                  10    10031  10.so.0.31[.0]
 *    1.2.25                  13    10225  12.so.0.25[.0]
 *    1.2.26beta01-06         13    10226  12.so.0.26[.0]
 *    1.2.26rc01              13    10226  12.so.0.26[.0]
 *    1.2.26                  13    10226  12.so.0.26[.0]
 *    1.0.32                  10    10032  10.so.0.32[.0]
 *    1.2.27beta01-06         13    10227  12.so.0.27[.0]
 *    1.2.27rc01              13    10227  12.so.0.27[.0]
 *    1.0.33                  10    10033  10.so.0.33[.0]
 *    1.2.27                  13    10227  12.so.0.27[.0]
 *    1.0.34                  10    10034  10.so.0.34[.0]
 *    1.2.28                  13    10228  12.so.0.28[.0]
 *    1.2.29beta01-03         13    10229  12.so.0.29[.0]
 *    1.2.29rc01              13    10229  12.so.0.29[.0]
 *    1.0.35                  10    10035  10.so.0.35[.0]
 *    1.2.29                  13    10229  12.so.0.29[.0]
 *    1.0.37                  10    10037  10.so.0.37[.0]
 *    1.2.30beta01-04         13    10230  12.so.0.30[.0]
 *    1.0.38rc01-08           10    10038  10.so.0.38[.0]
 *    1.2.30rc01-08           13    10230  12.so.0.30[.0]
 *    1.0.38                  10    10038  10.so.0.38[.0]
 *    1.2.30                  13    10230  12.so.0.30[.0]
 *    1.0.39rc01-03           10    10039  10.so.0.39[.0]
 *    1.2.31rc01-03           13    10231  12.so.0.31[.0]
 *    1.0.39                  10    10039  10.so.0.39[.0]
 *    1.2.31                  13    10231  12.so.0.31[.0]
 *    1.2.32beta01-02         13    10232  12.so.0.32[.0]
 *    1.0.40rc01              10    10040  10.so.0.40[.0]
 *    1.2.32rc01              13    10232  12.so.0.32[.0]
 *    1.0.40                  10    10040  10.so.0.40[.0]
 *    1.2.32                  13    10232  12.so.0.32[.0]
 *    1.2.33beta01-02         13    10233  12.so.0.33[.0]
 *    1.2.33rc01-02           13    10233  12.so.0.33[.0]
 *    1.0.41rc01              10    10041  10.so.0.41[.0]
 *    1.2.33                  13    10233  12.so.0.33[.0]
 *    1.0.41                  10    10041  10.so.0.41[.0]
 *    1.2.34beta01-07         13    10234  12.so.0.34[.0]
 *    1.0.42rc01              10    10042  10.so.0.42[.0]
 *    1.2.34rc01              13    10234  12.so.0.34[.0]
 *    1.0.42                  10    10042  10.so.0.42[.0]
 *    1.2.34                  13    10234  12.so.0.34[.0]
 *    1.2.35beta01-03         13    10235  12.so.0.35[.0]
 *    1.0.43rc01-02           10    10043  10.so.0.43[.0]
 *    1.2.35rc01-02           13    10235  12.so.0.35[.0]
 *    1.0.43                  10    10043  10.so.0.43[.0]
 *    1.2.35                  13    10235  12.so.0.35[.0]
 *    1.2.36beta01-05         13    10236  12.so.0.36[.0]
 *    1.2.36rc01              13    10236  12.so.0.36[.0]
 *    1.0.44                  10    10044  10.so.0.44[.0]
 *    1.2.36                  13    10236  12.so.0.36[.0]
 *    1.2.37beta01-03         13    10237  12.so.0.37[.0]
 *    1.2.37rc01              13    10237  12.so.0.37[.0]
 *    1.2.37                  13    10237  12.so.0.37[.0]
 *    1.0.45                  10    10045  12.so.0.45[.0]
 *    1.0.46                  10    10046  10.so.0.46[.0]
 *    1.2.38beta01            13    10238  12.so.0.38[.0]
 *    1.2.38rc01-03           13    10238  12.so.0.38[.0]
 *    1.0.47                  10    10047  10.so.0.47[.0]
 *    1.2.38                  13    10238  12.so.0.38[.0]
 *    1.2.39beta01-05         13    10239  12.so.0.39[.0]
 *    1.2.39rc01              13    10239  12.so.0.39[.0]
 *    1.0.48                  10    10048  10.so.0.48[.0]
 *    1.2.39                  13    10239  12.so.0.39[.0]
 *    1.2.40beta01            13    10240  12.so.0.40[.0]
 *    1.2.40rc01              13    10240  12.so.0.40[.0]
 *    1.0.49                  10    10049  10.so.0.49[.0]
 *    1.2.40                  13    10240  12.so.0.40[.0]
 *    1.2.41beta01-18         13    10241  12.so.0.41[.0]
 *    1.0.51rc01              10    10051  10.so.0.51[.0]
 *    1.2.41rc01-03           13    10241  12.so.0.41[.0]
 *    1.0.51                  10    10051  10.so.0.51[.0]
 *    1.2.41                  13    10241  12.so.0.41[.0]
 *    1.2.42beta01-02         13    10242  12.so.0.42[.0]
 *    1.2.42rc01-05           13    10242  12.so.0.42[.0]
 *    1.0.52                  10    10052  10.so.0.52[.0]
 *    1.2.42                  13    10242  12.so.0.42[.0]
 *    1.2.43beta01-05         13    10243  12.so.0.43[.0]
 *    1.0.53rc01-02           10    10053  10.so.0.53[.0]
 *    1.2.43rc01-02           13    10243  12.so.0.43[.0]
 *    1.0.53                  10    10053  10.so.0.53[.0]
 *    1.2.43                  13    10243  12.so.0.43[.0]
 *    1.2.44beta01-03         13    10244  12.so.0.44[.0]
 *    1.2.44rc01-03           13    10244  12.so.0.44[.0]
 *    1.2.44                  13    10244  12.so.0.44[.0]
 *    1.2.45beta01-03         13    10245  12.so.0.45[.0]
 *    1.0.55rc01              10    10055  10.so.0.55[.0]
 *    1.2.45rc01              13    10245  12.so.0.45[.0]
 *    1.0.55                  10    10055  10.so.0.55[.0]
 *    1.2.45                  13    10245  12.so.0.45[.0]
 *    1.2.46rc01-02           13    10246  12.so.0.46[.0]
 *    1.0.56                  10    10056  10.so.0.56[.0]
 *    1.2.46                  13    10246  12.so.0.46[.0]
 *    1.2.47beta01            13    10247  12.so.0.47[.0]
 *    1.2.47rc01              13    10247  12.so.0.47[.0]
 *    1.0.57rc01              10    10057  10.so.0.57[.0]
 *    1.2.47                  13    10247  12.so.0.47[.0]
 *    1.0.57                  10    10057  10.so.0.57[.0]
 *    1.2.48beta01            13    10248  12.so.0.48[.0]
 *    1.2.48rc01-02           13    10248  12.so.0.48[.0]
 *    1.0.58                  10    10058  10.so.0.58[.0]
 *    1.2.48                  13    10248  12.so.0.48[.0]
 *    1.2.49rc01              13    10249  12.so.0.49[.0]
 *    1.0.59                  10    10059  10.so.0.59[.0]
 *    1.2.49                  13    10249  12.so.0.49[.0]
 *    1.0.60                  10    10060  10.so.0.60[.0]
 *    1.2.50                  13    10250  12.so.0.50[.0]
 *
 *    Henceforth the source version will match the shared-library major
 *    and minor numbers; the shared-library major version number will be
 *    used for changes in backward compatibility, as it is intended.  The
 *    PNG_LIBPNG_VER macro, which is not used within libpng but is available
 *    for applications, is an unsigned integer of the form xyyzz corresponding
 *    to the source version x.y.z (leading zeros in y and z).  Beta versions
 *    were given the previous public release number plus a letter, until
 *    version 1.0.6j; from then on they were given the upcoming public
 *    release number plus "betaNN" or "rcNN".
 *
 *    Binary incompatibility exists only when applications make direct access
 *    to the info_ptr or png_ptr members through png.h, and the compiled
 *    application is loaded with a different version of the library.
 *
 *    DLLNUM will change each time there are forward or backward changes
 *    in binary compatibility (e.g., when a new feature is added).
 *
 * See libpng.txt or libpng.3 for more information.  The PNG specification
 * is available as a W3C Recommendation and as an ISO Specification,
 * <http://www.w3.org/TR/2003/REC-PNG-20031110/
 */

/*
 * COPYRIGHT NOTICE, DISCLAIMER, and LICENSE:
 *
 * If you modify libpng you may insert additional notices immediately following
 * this sentence.
 *
 * This code is released under the libpng license.
 *
 * libpng versions 1.2.6, August 15, 2004, through 1.2.50, July 10, 2012, are
 * Copyright (c) 2004, 2006-2011 Glenn Randers-Pehrson, and are
 * distributed according to the same disclaimer and license as libpng-1.2.5
 * with the following individual added to the list of Contributing Authors:
 *
 *    Cosmin Truta
 *
 * libpng versions 1.0.7, July 1, 2000, through 1.2.5, October 3, 2002, are
 * Copyright (c) 2000-2002 Glenn Randers-Pehrson, and are
 * distributed according to the same disclaimer and license as libpng-1.0.6
 * with the following individuals added to the list of Contributing Authors:
 *
 *    Simon-Pierre Cadieux
 *    Eric S. Raymond
 *    Gilles Vollant
 *
 * and with the following additions to the disclaimer:
 *
 *    There is no warranty against interference with your enjoyment of the
 *    library or against infringement.  There is no warranty that our
 *    efforts or the library will fulfill any of your particular purposes
 *    or needs.  This library is provided with all faults, and the entire
 *    risk of satisfactory quality, performance, accuracy, and effort is with
 *    the user.
 *
 * libpng versions 0.97, January 1998, through 1.0.6, March 20, 2000, are
 * Copyright (c) 1998, 1999, 2000 Glenn Randers-Pehrson, and are
 * distributed according to the same disclaimer and license as libpng-0.96,
 * with the following individuals added to the list of Contributing Authors:
 *
 *    Tom Lane
 *    Glenn Randers-Pehrson
 *    Willem van Schaik
 *
 * libpng versions 0.89, June 1996, through 0.96, May 1997, are
 * Copyright (c) 1996, 1997 Andreas Dilger
 * Distributed according to the same disclaimer and license as libpng-0.88,
 * with the following individuals added to the list of Contributing Authors:
 *
 *    John Bowler
 *    Kevin Bracey
 *    Sam Bushell
 *    Magnus Holmgren
 *    Greg Roelofs
 *    Tom Tanner
 *
 * libpng versions 0.5, May 1995, through 0.88, January 1996, are
 * Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.
 *
 * For the purposes of this copyright and license, "Contributing Authors"
 * is defined as the following set of individuals:
 *
 *    Andreas Dilger
 *    Dave Martindale
 *    Guy Eric Schalnat
 *    Paul Schmidt
 *    Tim Wegner
 *
 * The PNG Reference Library is supplied "AS IS".  The Contributing Authors
 * and Group 42, Inc. disclaim all warranties, expressed or implied,
 * including, without limitation, the warranties of merchantability and of
 * fitness for any purpose.  The Contributing Authors and Group 42, Inc.
 * assume no liability for direct, indirect, incidental, special, exemplary,
 * or consequential damages, which may result from the use of the PNG
 * Reference Library, even if advised of the possibility of such damage.
 *
 * Permission is hereby granted to use, copy, modify, and distribute this
 * source code, or portions hereof, for any purpose, without fee, subject
 * to the following restrictions:
 *
 * 1. The origin of this source code must not be misrepresented.
 *
 * 2. Altered versions must be plainly marked as such and
 * must not be misrepresented as being the original source.
 *
 * 3. This Copyright notice may not be removed or altered from
 *    any source or altered source distribution.
 *
 * The Contributing Authors and Group 42, Inc. specifically permit, without
 * fee, and encourage the use of this source code as a component to
 * supporting the PNG file format in commercial products.  If you use this
 * source code in a product, acknowledgment is not required but would be
 * appreciated.
 */

/*
 * A "png_get_copyright" function is available, for convenient use in "about"
 * boxes and the like:
 *
 * printf("%s",png_get_copyright(NULL));
 *
 * Also, the PNG logo (in PNG format, of course) is supplied in the
 * files "pngbar.png" and "pngbar.jpg (88x31) and "pngnow.png" (98x31).
 */

/*
 * Libpng is OSI Certified Open Source Software.  OSI Certified is a
 * certification mark of the Open Source Initiative.
 */

/*
 * The contributing authors would like to thank all those who helped
 * with testing, bug fixes, and patience.  This wouldn't have been
 * possible without all of you.
 *
 * Thanks to Frank J. T. Wojcik for helping with the documentation.
 */

/*
 * Y2K compliance in libpng:
 * =========================
 *
 *    July 10, 2012
 *
 *    Since the PNG Development group is an ad-hoc body, we can't make
 *    an official declaration.
 *
 *    This is your unofficial assurance that libpng from version 0.71 and
 *    upward through 1.2.50 are Y2K compliant.  It is my belief that earlier
 *    versions were also Y2K compliant.
 *
 *    Libpng only has three year fields.  One is a 2-byte unsigned integer
 *    that will hold years up to 65535.  The other two hold the date in text
 *    format, and will hold years up to 9999.
 *
 *    The integer is
 *        "png_uint_16 year" in png_time_struct.
 *
 *    The strings are
 *        "png_charp time_buffer" in png_struct and
 *        "near_time_buffer", which is a local character string in png.c.
 *
 *    There are seven time-related functions:
 *        png.c: png_convert_to_rfc_1123() in png.c
 *          (formerly png_convert_to_rfc_1152() in error)
 *        png_convert_from_struct_tm() in pngwrite.c, called in pngwrite.c
 *        png_convert_from_time_t() in pngwrite.c
 *        png_get_tIME() in pngget.c
 *        png_handle_tIME() in pngrutil.c, called in pngread.c
 *        png_set_tIME() in pngset.c
 *        png_write_tIME() in pngwutil.c, called in pngwrite.c
 *
 *    All handle dates properly in a Y2K environment.  The
 *    png_convert_from_time_t() function calls gmtime() to convert from system
 *    clock time, which returns (year - 1900), which we properly convert to
 *    the full 4-digit year.  There is a possibility that applications using
 *    libpng are not passing 4-digit years into the png_convert_to_rfc_1123()
 *    function, or that they are incorrectly passing only a 2-digit year
 *    instead of "year - 1900" into the png_convert_from_struct_tm() function,
 *    but this is not under our control.  The libpng documentation has always
 *    stated that it works with 4-digit years, and the APIs have been
 *    documented as such.
 *
 *    The tIME chunk itself is also Y2K compliant.  It uses a 2-byte unsigned
 *    integer to hold the year, and can hold years as large as 65535.
 *
 *    zlib, upon which libpng depends, is also Y2K compliant.  It contains
 *    no date-related code.
 *
 *       Glenn Randers-Pehrson
 *       libpng maintainer
 *       PNG Development Group
 */

/* This is not the place to learn how to use libpng.  The file libpng.txt
 * describes how to use libpng, and the file example.c summarizes it
 * with some code on which to build.  This file is useful for looking
 * at the actual function definitions and structure components.
 */

enum PNG_LIBPNG_VER_STRING = "1.2.50";
enum PNG_HEADER_VERSION_STRING =
   " libpng version 1.2.50 - July 10, 2012\n";

enum PNG_LIBPNG_VER_SONUM = 0;
enum PNG_LIBPNG_VER_DLLNUM = 13;

/* These should match the first 3 components of PNG_LIBPNG_VER_STRING: */
enum PNG_LIBPNG_VER_MAJOR = 1;
enum PNG_LIBPNG_VER_MINOR = 2;
enum PNG_LIBPNG_VER_RELEASE = 50;

/* This should match the numeric part of the final component of
 * PNG_LIBPNG_VER_STRING, omitting any leading zero:
 */

enum PNG_LIBPNG_VER_BUILD = 0;

/* Release Status */
enum PNG_LIBPNG_BUILD_ALPHA = 1;
enum PNG_LIBPNG_BUILD_BETA = 2;
enum PNG_LIBPNG_BUILD_RC = 3;
enum PNG_LIBPNG_BUILD_STABLE = 4;
enum PNG_LIBPNG_BUILD_RELEASE_STATUS_MASK = 7;

/* Release-Specific Flags */
enum PNG_LIBPNG_BUILD_PATCH = 8;    /* Can be OR'ed with
                                       PNG_LIBPNG_BUILD_STABLE only */
enum PNG_LIBPNG_BUILD_PRIVATE = 16; /* Cannot be OR'ed with
                                       PNG_LIBPNG_BUILD_SPECIAL */
enum PNG_LIBPNG_BUILD_SPECIAL = 32; /* Cannot be OR'ed with
                                       PNG_LIBPNG_BUILD_PRIVATE */

alias PNG_LIBPNG_BUILD_BASE_TYPE = PNG_LIBPNG_BUILD_STABLE;

/* Careful here.  At one time, Guy wanted to use 082, but that would be octal.
 * We must not include leading zeros.
 * Versions 0.7 through 1.0.0 were in the range 0 to 100 here (only
 * version 1.0.0 was mis-numbered 100 instead of 10000).  From
 * version 1.0.1 it's    xxyyzz, where x=major, y=minor, z=release
 */
enum PNG_LIBPNG_VER = 10250; /* 1.2.50 */

version(PNG_VERSION_INFO_ONLY) {
} else {
/* Include the compression library's header */
	import etc.c.zlib;
} // PNG_VERSION_INFO_ONLY

/* Include all user configurable info, including optional assembler routines */
import libpng12.pngconf;

/*
 * Added at libpng-1.2.8 */
/* Ref MSDN: Private as priority over Special
 * VS_FF_PRIVATEBUILD File *was not* built using standard release
 * procedures. If this value is given, the StringFileInfo block must
 * contain a PrivateBuild string.
 *
 * VS_FF_SPECIALBUILD File *was* built by the original company using
 * standard release procedures but is a variation of the standard
 * file of the same version number. If this value is given, the
 * StringFileInfo block must contain a SpecialBuild string.
 */

version(PNG_USER_PRIVATEBUILD) {
	enum PNG_LIBPNG_BUILD_TYPE =
          (PNG_LIBPNG_BUILD_BASE_TYPE | PNG_LIBPNG_BUILD_PRIVATE);
} else {
	version(PNG_LIBPNG_SPECIALBUILD) {
		enum PNG_LIBPNG_BUILD_TYPE =
			(PNG_LIBPNG_BUILD_BASE_TYPE | PNG_LIBPNG_BUILD_SPECIAL);
	} else {
		enum PNG_LIBPNG_BUILD_TYPE = (PNG_LIBPNG_BUILD_BASE_TYPE);
	}
}

version(PNG_VERSION_INFO_ONLY) {
} else {

/* Inhibit C++ name-mangling for libpng functions but not for system calls. */
extern (C) {

/* This file is arranged in several sections.  The first section contains
 * structure and type definitions.  The second section contains the external
 * library functions, while the third has the internal library functions,
 * which applications aren't expected to use directly.
 */

version(PNG_NO_TYPECAST_NULL) {
enum int_p_NULL = null;
enum png_bytep_NULL = null;
enum png_bytepp_NULL = null;
enum png_doublep_NULL = null;
enum png_error_ptr_NULL = null;
enum png_flush_ptr_NULL = null;
enum png_free_ptr_NULL = null;
enum png_infopp_NULL = null;
enum png_malloc_ptr_NULL = null;
enum png_read_status_ptr_NULL = null;
enum png_rw_ptr_NULL = null;
enum png_structp_NULL = null;
enum png_uint_16p_NULL = null;
enum png_voidp_NULL = null;
enum png_write_status_ptr_NULL = null;
} else {
enum int_p_NULL = cast(int *)null;
enum png_bytep_NULL = cast(png_bytep)null;
enum png_bytepp_NULL = cast(png_bytepp)null;
enum png_doublep_NULL = cast(png_doublep)null;
enum png_error_ptr_NULL = cast(png_error_ptr)null;
enum png_flush_ptr_NULL = cast(png_flush_ptr)null;
enum png_free_ptr_NULL = cast(png_free_ptr)null;
enum png_infopp_NULL = cast(png_infopp)null;
enum png_malloc_ptr_NULL = cast(png_malloc_ptr)null;
enum png_read_status_ptr_NULL = cast(png_read_status_ptr)null;
enum png_rw_ptr_NULL = cast(png_rw_ptr)null;
enum png_structp_NULL = cast(png_structp)null;
enum png_uint_16p_NULL = cast(png_uint_16p)null;
enum png_voidp_NULL = cast(png_voidp)null;
enum png_write_status_ptr_NULL = cast(png_write_status_ptr)null;
} // !PNG_NO_TYPECAST_NULL

// /* Variables declared in png.c - only it needs to define PNG_NO_EXTERN */
version (PNG_NO_EXTERN) {
} else version (PNG_ALWAYS_EXTERN) {
   version(PNG_USE_GLOBAL_ARRAYS) {
      /* Need room for 99.99.99beta99z */
      extern const char png_libpng_ver[18];
   } else {
      @property auto png_libpng_ver() {
         return png_get_header_ver(null);
      }
   } // PNG_USE_GLOBAL_ARRAYS

   version(PNG_USE_GLOBAL_ARRAYS) {
      /* This was removed in version 1.0.5c */
      /* Structures to facilitate easy interlacing.  See png.c for more details */
      extern const int png_pass_start[7];
      extern const int png_pass_inc[7];
      extern const int png_pass_ystart[7];
      extern const int png_pass_yinc[7];
      extern const int png_pass_mask[7];
      extern const int png_pass_dsp_mask[7];
      /* This isn't currently used.  If you need it, see png.c for more details.
      extern const int png_pass_height[7];
      */
   }
} else {
   version(PNG_USE_GLOBAL_ARRAYS) {
      /* Need room for 99.99.99beta99z */
      extern const char png_libpng_ver[18];
   } else {
      @property auto png_libpng_ver() {
         return png_get_header_ver(null);
      }
   } // PNG_USE_GLOBAL_ARRAYS

   version(PNG_USE_GLOBAL_ARRAYS) {
      /* This was removed in version 1.0.5c */
      /* Structures to facilitate easy interlacing.  See png.c for more details */
      extern const int png_pass_start[7];
      extern const int png_pass_inc[7];
      extern const int png_pass_ystart[7];
      extern const int png_pass_yinc[7];
      extern const int png_pass_mask[7];
      extern const int png_pass_dsp_mask[7];
      /* This isn't currently used.  If you need it, see png.c for more details.
      extern const int png_pass_height[7];
      */
   }
} // !PNG_ALWAYS_EXTERN

struct png_color {
	png_byte red;
	png_byte green;
	png_byte blue;
}
alias png_color * png_colorp;
alias png_color ** png_colorpp;

struct png_color_16
{
   png_byte index;    /* used for palette files */
   png_uint_16 red;   /* for use in red green blue files */
   png_uint_16 green;
   png_uint_16 blue;
   png_uint_16 gray;  /* for use in grayscale files */
}
alias png_color_16 * png_color_16p;
alias png_color_16 ** png_color_16pp;

struct png_color_8
{
   png_byte red;   /* for use in red green blue files */
   png_byte green;
   png_byte blue;
   png_byte gray;  /* for use in grayscale files */
   png_byte alpha; /* for alpha channel files */
}
alias png_color_8 * png_color_8p;
alias png_color_8 ** png_color_8pp;

/*
 * The following two structures are used for the in-core representation
 * of sPLT chunks.
 */
struct png_sPLT_entry
{
   png_uint_16 red;
   png_uint_16 green;
   png_uint_16 blue;
   png_uint_16 alpha;
   png_uint_16 frequency;
}
alias png_sPLT_entry * png_sPLT_entryp;
alias png_sPLT_entry ** png_sPLT_entrypp;

/*  When the depth of the sPLT palette is 8 bits, the color and alpha samples
 *  occupy the LSB of their respective members, and the MSB of each member
 *  is zero-filled.  The frequency member always occupies the full 16 bits.
 */

struct png_sPLT
{
   png_charp name;           /* palette name */
   png_byte depth;           /* depth of palette samples */
   png_sPLT_entryp entries;  /* palette entries */
   png_int_32 nentries;      /* number of palette entries */
}
alias png_sPLT * png_sPLT_tp;
alias png_sPLT ** png_sPLT_tpp;

version(PNG_TEXT_SUPPORTED) {
/* png_text holds the contents of a text/ztxt/itxt chunk in a PNG file,
 * and whether that contents is compressed or not.  The "key" field
 * points to a regular zero-terminated C string.  The "text", "lang", and
 * "lang_key" fields can be regular C strings, empty strings, or NULL pointers.
 * However, the * structure returned by png_get_text() will always contain
 * regular zero-terminated C strings (possibly empty), never NULL pointers,
 * so they can be safely used in printf() and other string-handling functions.
 */
struct png_text
{
   int  compression;       /* compression value:
                             -1: tEXt, none
                              0: zTXt, deflate
                              1: iTXt, none
                              2: iTXt, deflate  */
   png_charp key;          /* keyword, 1-79 character description of "text" */
   png_charp text;         /* comment, may be an empty string (ie "")
                              or a NULL pointer */
   png_size_t text_length; /* length of the text string */
version(PNG_iTXt_SUPPORTED) {
   png_size_t itxt_length; /* length of the itxt string */
   png_charp lang;         /* language code, 0-79 characters
                              or a NULL pointer */
   png_charp lang_key;     /* keyword translated UTF-8 string, 0 or more
                              chars or a NULL pointer */
}
}
alias png_text * png_textp;
alias png_text ** png_textpp;
} // PNG_TEXT_SUPPORTED

/* Supported compression types for text in PNG files (tEXt, and zTXt).
 * The values of the PNG_TEXT_COMPRESSION_ defines should NOT be changed.
 */
enum PNG_TEXT_COMPRESSION_NONE_WR = -3;
enum PNG_TEXT_COMPRESSION_zTXt_WR = -2;
enum PNG_TEXT_COMPRESSION_NONE = -1;
enum PNG_TEXT_COMPRESSION_zTXt = 0;
enum PNG_ITXT_COMPRESSION_NONE = 1;
enum PNG_ITXT_COMPRESSION_zTXt = 2;
enum PNG_TEXT_COMPRESSION_LAST = 3;  /* Not a valid value */

/* png_time is a way to hold the time in an machine independent way.
 * Two conversions are provided, both from time_t and struct tm.  There
 * is no portable way to convert to either of these structures, as far
 * as I know.  If you know of a portable way, send it to me.  As a side
 * note - PNG has always been Year 2000 compliant!
 */
struct png_time
{
   png_uint_16 year; /* full year, as in, 1995 */
   png_byte month;   /* month of year, 1 - 12 */
   png_byte day;     /* day of month, 1 - 31 */
   png_byte hour;    /* hour of day, 0 - 23 */
   png_byte minute;  /* minute of hour, 0 - 59 */
   png_byte second;  /* second of minute, 0 - 60 (for leap seconds) */
}
alias png_time * png_timep;
alias png_time ** png_timepp;

version(PNG_UNKNOWN_CHUNKS_SUPPORTED) {
struct png_unknown_chunk
{
    png_byte name[5];
    png_byte *data;
    png_size_t size;

    /* libpng-using applications should NOT directly modify this byte. */
    png_byte location; /* mode of operation at read time */
}
alias png_unknown_chunk * png_unknown_chunkp;
alias png_unknown_chunk ** png_unknown_chunkpp;
} // PNG_UNKNOWN_CHUNKS_SUPPORTED

/* png_info is a structure that holds the information in a PNG file so
 * that the application can find out the characteristics of the image.
 * If you are reading the file, this structure will tell you what is
 * in the PNG file.  If you are writing the file, fill in the information
 * you want to put into the PNG file, then call png_write_info().
 * The names chosen should be very close to the PNG specification, so
 * consult that document for information about the meaning of each field.
 *
 * With libpng < 0.95, it was only possible to directly set and read the
 * the values in the png_info_struct, which meant that the contents and
 * order of the values had to remain fixed.  With libpng 0.95 and later,
 * however, there are now functions that abstract the contents of
 * png_info_struct from the application, so this makes it easier to use
 * libpng with dynamic libraries, and even makes it possible to use
 * libraries that don't have all of the libpng ancillary chunk-handing
 * functionality.
 *
 * In any case, the order of the parameters in png_info_struct should NOT
 * be changed for as long as possible to keep compatibility with applications
 * that use the old direct-access method with png_info_struct.
 *
 * The following members may have allocated storage attached that should be
 * cleaned up before the structure is discarded: palette, trans, text,
 * pcal_purpose, pcal_units, pcal_params, hist, iccp_name, iccp_profile,
 * splt_palettes, scal_unit, row_pointers, and unknowns.   By default, these
 * are automatically freed when the info structure is deallocated, if they were
 * allocated internally by libpng.  This behavior can be changed by means
 * of the png_data_freer() function.
 *
 * More allocation details: all the chunk-reading functions that
 * change these members go through the corresponding png_set_*
 * functions.  A function to clear these members is available: see
 * png_free_data().  The png_set_* functions do not depend on being
 * able to point info structure members to any of the storage they are
 * passed (they make their own copies), EXCEPT that the png_set_text
 * functions use the same storage passed to them in the text_ptr or
 * itxt_ptr structure argument, and the png_set_rows and png_set_unknowns
 * functions do not make their own copies.
 */
struct png_info
{
   /* The following are necessary for every PNG file */
   deprecated png_uint_32 width;       /* width of image in pixels (from IHDR) */
   deprecated png_uint_32 height;      /* height of image in pixels (from IHDR) */
   deprecated png_uint_32 valid;       /* valid chunk data (see PNG_INFO_ below) */
   deprecated png_uint_32 rowbytes;    /* bytes needed to hold an untransformed row */
   deprecated png_colorp palette;      /* array of color values (valid & PNG_INFO_PLTE) */
   deprecated png_uint_16 num_palette; /* number of color entries in "palette" (PLTE) */
   deprecated png_uint_16 num_trans;   /* number of transparent palette color (tRNS) */
   deprecated png_byte bit_depth;      /* 1, 2, 4, 8, or 16 bits/channel (from IHDR) */
   deprecated png_byte color_type;     /* see PNG_COLOR_TYPE_ below (from IHDR) */
   /* The following three should have been named *_method not *_type */
   deprecated png_byte compression_type; /* must be PNG_COMPRESSION_TYPE_BASE (IHDR) */
   deprecated png_byte filter_type;    /* must be PNG_FILTER_TYPE_BASE (from IHDR) */
   deprecated png_byte interlace_type; /* One of PNG_INTERLACE_NONE, PNG_INTERLACE_ADAM7 */

   /* The following is informational only on read, and not used on writes. */
   deprecated png_byte channels;       /* number of data channels per pixel (1, 2, 3, 4) */
   deprecated png_byte pixel_depth;    /* number of bits per pixel */
   deprecated png_byte spare_byte;     /* to align the data, and for future use */
   deprecated png_byte signature[8];   /* magic bytes read by libpng from start of file */

   /* The rest of the data is optional.  If you are reading, check the
    * valid field to see if the information in these are valid.  If you
    * are writing, set the valid field to those chunks you want written,
    * and initialize the appropriate fields below.
    */

version(PNG_gAMA_SUPPORTED) {
version(PNG_FLOATING_POINT_SUPPORTED) {
   /* The gAMA chunk describes the gamma characteristics of the system
    * on which the image was created, normally in the range [1.0, 2.5].
    * Data is valid if (valid & PNG_INFO_gAMA) is non-zero.
    */
   deprecated float gamma; /* gamma value of image, if (valid & PNG_INFO_gAMA) */
} // PNG_FLOATING_POINT_SUPPORTED
} // PNG_gAMA_SUPPORTED

version(PNG_sRGB_SUPPORTED) {
    /* GR-P, 0.96a */
    /* Data valid if (valid & PNG_INFO_sRGB) non-zero. */
   deprecated png_byte srgb_intent; /* sRGB rendering intent [0, 1, 2, or 3] */
} // PNG_sRGB_SUPPORTED

version(PNG_TEXT_SUPPORTED) {
   /* The tEXt, and zTXt chunks contain human-readable textual data in
    * uncompressed, compressed, and optionally compressed forms, respectively.
    * The data in "text" is an array of pointers to uncompressed,
    * null-terminated C strings. Each chunk has a keyword that describes the
    * textual data contained in that chunk.  Keywords are not required to be
    * unique, and the text string may be empty.  Any number of text chunks may
    * be in an image.
    */
   deprecated int num_text; /* number of comments read/to write */
   deprecated int max_text; /* current size of text array */
   deprecated png_textp text; /* array of comments read/to write */
} // PNG_TEXT_SUPPORTED

version(PNG_tIME_SUPPORTED) {
   /* The tIME chunk holds the last time the displayed image data was
    * modified.  See the png_time struct for the contents of this struct.
    */
   deprecated png_time mod_time;
} // PNG_tIME_SUPPORTED

version(PNG_sBIT_SUPPORTED) {
   /* The sBIT chunk specifies the number of significant high-order bits
    * in the pixel data.  Values are in the range [1, bit_depth], and are
    * only specified for the channels in the pixel data.  The contents of
    * the low-order bits is not specified.  Data is valid if
    * (valid & PNG_INFO_sBIT) is non-zero.
    */
   deprecated png_color_8 sig_bit; /* significant bits in color channels */
} // PNG_sBIT_SUPPORTED

   /* The tRNS chunk supplies transparency data for paletted images and
    * other image types that don't need a full alpha channel.  There are
    * "num_trans" transparency values for a paletted image, stored in the
    * same order as the palette colors, starting from index 0.  Values
    * for the data are in the range [0, 255], ranging from fully transparent
    * to fully opaque, respectively.  For non-paletted images, there is a
    * single color specified that should be treated as fully transparent.
    * Data is valid if (valid & PNG_INFO_tRNS) is non-zero.
    */
version(PNG_tRNS_SUPPORTED) {
   deprecated png_bytep trans; /* transparent values for paletted image */
   deprecated png_color_16 trans_values; /* transparent color for non-palette image */
} else version(PNG_READ_EXPAND_SUPPORTED) {
   deprecated png_bytep trans; /* transparent values for paletted image */
   deprecated png_color_16 trans_values; /* transparent color for non-palette image */
} else version(PNG_READ_BACKGROUND_SUPPORTED) {
   deprecated png_bytep trans; /* transparent values for paletted image */
   deprecated png_color_16 trans_values; /* transparent color for non-palette image */
} // PNG_READ_BACKGROUND_SUPPORTED

   /* The bKGD chunk gives the suggested image background color if the
    * display program does not have its own background color and the image
    * is needs to composited onto a background before display.  The colors
    * in "background" are normally in the same color space/depth as the
    * pixel data.  Data is valid if (valid & PNG_INFO_bKGD) is non-zero.
    */
version(PNG_bKGD_SUPPORTED) {
   deprecated png_color_16 background;
} else version(PNG_READ_BACKGROUND_SUPPORTED) {
   deprecated png_color_16 background;
} // PNG_READ_BACKGROUND_SUPPORTED

version(PNG_oFFs_SUPPORTED) {
   /* The oFFs chunk gives the offset in "offset_unit_type" units rightwards
    * and downwards from the top-left corner of the display, page, or other
    * application-specific co-ordinate space.  See the PNG_OFFSET_ defines
    * below for the unit types.  Valid if (valid & PNG_INFO_oFFs) non-zero.
    */
   deprecated png_int_32 x_offset; /* x offset on page */
   deprecated png_int_32 y_offset; /* y offset on page */
   deprecated png_byte offset_unit_type; /* offset units type */
} // PNG_oFFs_SUPPORTED

version(PNG_pHYs_SUPPORTED) {
   /* The pHYs chunk gives the physical pixel density of the image for
    * display or printing in "phys_unit_type" units (see PNG_RESOLUTION_
    * defines below).  Data is valid if (valid & PNG_INFO_pHYs) is non-zero.
    */
   deprecated png_uint_32 x_pixels_per_unit; /* horizontal pixel density */
   deprecated png_uint_32 y_pixels_per_unit; /* vertical pixel density */
   deprecated png_byte phys_unit_type; /* resolution type (see PNG_RESOLUTION_ below) */
} // PNG_pHYs_SUPPORTED

version(PNG_hIST_SUPPORTED) {
   /* The hIST chunk contains the relative frequency or importance of the
    * various palette entries, so that a viewer can intelligently select a
    * reduced-color palette, if required.  Data is an array of "num_palette"
    * values in the range [0,65535]. Data valid if (valid & PNG_INFO_hIST)
    * is non-zero.
    */
   deprecated png_uint_16p hist;
} // PNG_hIST_SUPPORTED

version(PNG_cHRM_SUPPORTED) {
   /* The cHRM chunk describes the CIE color characteristics of the monitor
    * on which the PNG was created.  This data allows the viewer to do gamut
    * mapping of the input image to ensure that the viewer sees the same
    * colors in the image as the creator.  Values are in the range
    * [0.0, 0.8].  Data valid if (valid & PNG_INFO_cHRM) non-zero.
    */
version(PNG_FLOATING_POINT_SUPPORTED) {
   deprecated float x_white;
   deprecated float y_white;
   deprecated float x_red;
   deprecated float y_red;
   deprecated float x_green;
   deprecated float y_green;
   deprecated float x_blue;
   deprecated float y_blue;
} // PNG_FLOATING_POINT_SUPPORTED
} // PNG_cHRM_SUPPORTED

version(PNG_pCAL_SUPPORTED) {
   /* The pCAL chunk describes a transformation between the stored pixel
    * values and original physical data values used to create the image.
    * The integer range [0, 2^bit_depth - 1] maps to the floating-point
    * range given by [pcal_X0, pcal_X1], and are further transformed by a
    * (possibly non-linear) transformation function given by "pcal_type"
    * and "pcal_params" into "pcal_units".  Please see the PNG_EQUATION_
    * defines below, and the PNG-Group's PNG extensions document for a
    * complete description of the transformations and how they should be
    * implemented, and for a description of the ASCII parameter strings.
    * Data values are valid if (valid & PNG_INFO_pCAL) non-zero.
    */
   deprecated png_charp pcal_purpose;  /* pCAL chunk description string */
   deprecated png_int_32 pcal_X0;      /* minimum value */
   deprecated png_int_32 pcal_X1;      /* maximum value */
   deprecated png_charp pcal_units;    /* Latin-1 string giving physical units */
   deprecated png_charpp pcal_params;  /* ASCII strings containing parameter values */
   deprecated png_byte pcal_type;      /* equation type (see PNG_EQUATION_ below) */
   deprecated png_byte pcal_nparams;   /* number of parameters given in pcal_params */
} // PNG_pCAL_SUPPORTED

/* New members added in libpng-1.0.6 */
version(PNG_FREE_ME_SUPPORTED) {
   deprecated png_uint_32 free_me;     /* flags items libpng is responsible for freeing */
} // PNG_FREE_ME_SUPPORTED

   /* Storage for unknown chunks that the library doesn't recognize. */
version(PNG_UNKNOWN_CHUNKS_SUPPORTED) {
   deprecated png_unknown_chunkp unknown_chunks;
   deprecated png_size_t unknown_chunks_num;
} else version(PNG_HANDLE_AS_UNKNOWN_SUPPORTED) {
   deprecated png_unknown_chunkp unknown_chunks;
   deprecated png_size_t unknown_chunks_num;
} // PNG_HANDLE_AS_UNKNOWN_SUPPORTED

version(PNG_iCCP_SUPPORTED) {
   /* iCCP chunk data. */
   deprecated png_charp iccp_name;     /* profile name */
   deprecated png_charp iccp_profile;  /* International Color Consortium profile data */
                            /* Note to maintainer: should be png_bytep */
   deprecated png_uint_32 iccp_proflen;  /* ICC profile data length */
   deprecated png_byte iccp_compression; /* Always zero */
} // PNG_iCCP_SUPPORTED

version(PNG_sPLT_SUPPORTED) {
   /* Data on sPLT chunks (there may be more than one). */
   deprecated png_sPLT_tp splt_palettes;
   deprecated png_uint_32 splt_palettes_num;
} // PNG_sPLT_SUPPORTED

version(PNG_sCAL_SUPPORTED) {
   /* The sCAL chunk describes the actual physical dimensions of the
    * subject matter of the graphic.  The chunk contains a unit specification
    * a byte value, and two ASCII strings representing floating-point
    * values.  The values are width and height corresponsing to one pixel
    * in the image.  This external representation is converted to double
    * here.  Data values are valid if (valid & PNG_INFO_sCAL) is non-zero.
    */
   deprecated png_byte scal_unit;         /* unit of physical scale */
version(PNG_FLOATING_POINT_SUPPORTED) {
   deprecated double scal_pixel_width;    /* width of one pixel */
   deprecated double scal_pixel_height;   /* height of one pixel */
} // PNG_FLOATING_POINT_SUPPORTED

version(PNG_FIXED_POINT_SUPPORTED) {
   deprecated png_charp scal_s_width;     /* string containing height */
   deprecated png_charp scal_s_height;    /* string containing width */
} // PNG_FIXED_POINT_SUPPORTED
} // PNG_sCAL_SUPPORTED

version(PNG_INFO_IMAGE_SUPPORTED) {
   /* Memory has been allocated if (valid & PNG_ALLOCATED_INFO_ROWS) non-zero */
   /* Data valid if (valid & PNG_INFO_IDAT) non-zero */
   deprecated png_bytepp row_pointers;        /* the image bits */
}

version(PNG_FIXED_POINT_SUPPORTED) {
version(PNG_gAMA_SUPPORTED) {
   deprecated png_fixed_point int_gamma; /* gamma of image, if (valid & PNG_INFO_gAMA) */
}
}

version(PNG_cHRM_SUPPORTED) {
version(PNG_FIXED_POINT_SUPPORTED) {
   deprecated png_fixed_point int_x_white;
   deprecated png_fixed_point int_y_white;
   deprecated png_fixed_point int_x_red;
   deprecated png_fixed_point int_y_red;
   deprecated png_fixed_point int_x_green;
   deprecated png_fixed_point int_y_green;
   deprecated png_fixed_point int_x_blue;
   deprecated png_fixed_point int_y_blue;
}
}

}
alias png_info * png_infop;
alias png_info ** png_infopp;

/* Maximum positive integer used in PNG is (2^31)-1 */
enum PNG_UINT_31_MAX = (cast(png_uint_32)0x7fffffffL);
enum PNG_UINT_32_MAX = (cast(png_uint_32)(-1));
enum PNG_SIZE_MAX = (cast(png_size_t)(-1));

/* PNG_MAX_UINT is deprecated; use PNG_UINT_31_MAX instead. */
version(PNG_1_0_X) {
	alias PNG_MAX_UINT PNG_UINT_31_MAX;
} else version(PNG_1_2_X) {
	alias PNG_MAX_UINT PNG_UINT_31_MAX;
}

/* These describe the color_type field in png_info. */
/* color type masks */
enum PNG_COLOR_MASK_PALETTE = 1;
enum PNG_COLOR_MASK_COLOR = 2;
enum PNG_COLOR_MASK_ALPHA = 4;

/* color types.  Note that not all combinations are legal */
enum PNG_COLOR_TYPE_GRAY = 0;
enum PNG_COLOR_TYPE_PALETTE = (PNG_COLOR_MASK_COLOR | PNG_COLOR_MASK_PALETTE);
enum PNG_COLOR_TYPE_RGB = (PNG_COLOR_MASK_COLOR);
enum PNG_COLOR_TYPE_RGB_ALPHA = (PNG_COLOR_MASK_COLOR | PNG_COLOR_MASK_ALPHA);
enum PNG_COLOR_TYPE_GRAY_ALPHA = (PNG_COLOR_MASK_ALPHA);
/* aliases */
alias PNG_COLOR_TYPE_RGB_ALPHA PNG_COLOR_TYPE_RGBA; 
alias PNG_COLOR_TYPE_GRAY_ALPHA PNG_COLOR_TYPE_GA;

/* This is for compression type. PNG 1.0-1.2 only define the single type. */
enum PNG_COMPRESSION_TYPE_BASE = 0; /* Deflate method 8, 32K window */
enum PNG_COMPRESSION_TYPE_DEFAULT = PNG_COMPRESSION_TYPE_BASE;

/* This is for filter type. PNG 1.0-1.2 only define the single type. */
enum PNG_FILTER_TYPE_BASE = 0; /* Single row per-byte filtering */
enum PNG_INTRAPIXEL_DIFFERENCING = 64; /* Used only in MNG datastreams */
enum PNG_FILTER_TYPE_DEFAULT = PNG_FILTER_TYPE_BASE;

/* These are for the interlacing type.  These values should NOT be changed. */
enum PNG_INTERLACE_NONE =      0; /* Non-interlaced image */
enum PNG_INTERLACE_ADAM7 =     1; /* Adam7 interlacing */
enum PNG_INTERLACE_LAST =      2; /* Not a valid value */

/* These are for the oFFs chunk.  These values should NOT be changed. */
enum PNG_OFFSET_PIXEL =        0; /* Offset in pixels */
enum PNG_OFFSET_MICROMETER =   1; /* Offset in micrometers (1/10^6 meter) */
enum PNG_OFFSET_LAST =         2; /* Not a valid value */

/* These are for the pCAL chunk.  These values should NOT be changed. */
enum PNG_EQUATION_LINEAR =     0; /* Linear transformation */
enum PNG_EQUATION_BASE_E =     1; /* Exponential base e transform */
enum PNG_EQUATION_ARBITRARY =  2; /* Arbitrary base exponential transform */
enum PNG_EQUATION_HYPERBOLIC = 3; /* Hyperbolic sine transformation */
enum PNG_EQUATION_LAST =       4; /* Not a valid value */

/* These are for the sCAL chunk.  These values should NOT be changed. */
enum PNG_SCALE_UNKNOWN =       0; /* unknown unit (image scale) */
enum PNG_SCALE_METER =         1; /* meters per pixel */
enum PNG_SCALE_RADIAN =        2; /* radians per pixel */
enum PNG_SCALE_LAST =          3; /* Not a valid value */

/* These are for the pHYs chunk.  These values should NOT be changed. */
enum PNG_RESOLUTION_UNKNOWN =  0; /* pixels/unknown unit (aspect ratio) */
enum PNG_RESOLUTION_METER =    1; /* pixels/meter */
enum PNG_RESOLUTION_LAST =     2; /* Not a valid value */

/* These are for the sRGB chunk.  These values should NOT be changed. */
enum PNG_sRGB_INTENT_PERCEPTUAL = 0;
enum PNG_sRGB_INTENT_RELATIVE =   1;
enum PNG_sRGB_INTENT_SATURATION = 2;
enum PNG_sRGB_INTENT_ABSOLUTE =   3;
enum PNG_sRGB_INTENT_LAST =       4; /* Not a valid value */

/* This is for text chunks */
enum PNG_KEYWORD_MAX_LENGTH =   79;

/* Maximum number of entries in PLTE/sPLT/tRNS arrays */
enum PNG_MAX_PALETTE_LENGTH =  256;

/* These determine if an ancillary chunk's data has been successfully read
 * from the PNG header, or if the application has filled in the corresponding
 * data in the info_struct to be written into the output file.  The values
 * of the PNG_INFO_<chunk> defines should NOT be changed.
 */
enum PNG_INFO_gAMA = 0x0001;
enum PNG_INFO_sBIT = 0x0002;
enum PNG_INFO_cHRM = 0x0004;
enum PNG_INFO_PLTE = 0x0008;
enum PNG_INFO_tRNS = 0x0010;
enum PNG_INFO_bKGD = 0x0020;
enum PNG_INFO_hIST = 0x0040;
enum PNG_INFO_pHYs = 0x0080;
enum PNG_INFO_oFFs = 0x0100;
enum PNG_INFO_tIME = 0x0200;
enum PNG_INFO_pCAL = 0x0400;
enum PNG_INFO_sRGB = 0x0800;   /* GR-P, 0.96a */
enum PNG_INFO_iCCP = 0x1000;   /* ESR, 1.0.6 */
enum PNG_INFO_sPLT = 0x2000;   /* ESR, 1.0.6 */
enum PNG_INFO_sCAL = 0x4000;   /* ESR, 1.0.6 */
enum PNG_INFO_IDAT = 0x8000;   /* ESR, 1.0.6 */

/* This is used for the transformation routines, as some of them
 * change these values for the row.  It also should enable using
 * the routines for other purposes.
 */
struct png_row_info
{
   png_uint_32 width; /* width of row */
   png_uint_32 rowbytes; /* number of bytes in row */
   png_byte color_type; /* color type of row */
   png_byte bit_depth; /* bit depth of row */
   png_byte channels; /* number of channels (1, 2, 3, or 4) */
   png_byte pixel_depth; /* bits per pixel (depth * channels) */
}

alias png_row_info * png_row_infop;
alias png_row_info ** png_row_infopp;

/* These are the function types for the I/O functions and for the functions
 * that allow the user to override the default I/O functions with his or her
 * own.  The png_error_ptr type should match that of user-supplied warning
 * and error functions, while the png_rw_ptr type should match that of the
 * user read/write data functions.
 */
alias png_struct_def png_struct;
alias png_struct * png_structp;

alias void function(png_structp, png_const_charp) png_error_ptr;
alias void function(png_structp, png_bytep, png_size_t) png_rw_ptr;
alias void function(png_structp) png_flush_ptr;
alias void function(png_structp, png_uint_32, int) png_read_status_ptr;
alias void function(png_structp, png_uint_32, int) png_write_status_ptr;

version(PNG_PROGRESSIVE_READ_SUPPORTED) {
alias void function(png_structp, png_infop) png_progressive_info_ptr;
alias void function(png_structp, png_infop) png_progressive_end_ptr;
alias void function(png_structp, png_bytep, png_uint_32, int) png_progressive_row_ptr;
} // PNG_PROGRESSIVE_READ_SUPPORTED

version(PNG_READ_USER_TRANSFORM_SUPPORTED) {
	alias void function(png_structp, png_row_infop, png_bytep) png_user_transform_ptr;
} else version(PNG_WRITE_USER_TRANSFORM_SUPPORTED) {
	alias void function(png_structp, png_row_infop, png_bytep) png_user_transform_ptr;
} else version(PNG_LEGACY_SUPPORTED) {
	alias void function(png_structp, png_row_infop, png_bytep) png_user_transform_ptr;
}

version(PNG_USER_CHUNKS_SUPPORTED) {
	alias int function(png_structp, png_unknown_chunkp) png_user_chunk_ptr;
}

version(PNG_UNKNOWN_CHUNKS_SUPPORTED) {
	alias void function(png_structp) png_unknown_chunk_ptr;
}

/* Transform masks for the high-level interface */
enum PNG_TRANSFORM_IDENTITY =     0x0000;    /* read and write */
enum PNG_TRANSFORM_STRIP_16 =     0x0001;    /* read only */
enum PNG_TRANSFORM_STRIP_ALPHA =  0x0002;    /* read only */
enum PNG_TRANSFORM_PACKING =      0x0004;    /* read and write */
enum PNG_TRANSFORM_PACKSWAP =     0x0008;    /* read and write */
enum PNG_TRANSFORM_EXPAND =       0x0010;    /* read only */
enum PNG_TRANSFORM_INVERT_MONO =  0x0020;    /* read and write */
enum PNG_TRANSFORM_SHIFT =        0x0040;    /* read and write */
enum PNG_TRANSFORM_BGR =          0x0080;    /* read and write */
enum PNG_TRANSFORM_SWAP_ALPHA =   0x0100;    /* read and write */
enum PNG_TRANSFORM_SWAP_ENDIAN =  0x0200;    /* read and write */
enum PNG_TRANSFORM_INVERT_ALPHA = 0x0400;    /* read and write */
enum PNG_TRANSFORM_STRIP_FILLER = 0x0800;    /* write only, deprecated */
/* Added to libpng-1.2.34 */
enum PNG_TRANSFORM_STRIP_FILLER_BEFORE = 0x0800;  /* write only */
enum PNG_TRANSFORM_STRIP_FILLER_AFTER  = 0x1000;  /* write only */
/* Added to libpng-1.2.41 */
enum PNG_TRANSFORM_GRAY_TO_RGB = 0x2000;      /* read only */

/* Flags for MNG supported features */
enum PNG_FLAG_MNG_EMPTY_PLTE =   0x01;
enum PNG_FLAG_MNG_FILTER_64 =    0x04;
enum PNG_ALL_MNG_FEATURES =      0x05;

alias png_voidp function(png_structp, png_size_t) png_malloc_ptr;
alias void function(png_structp, png_voidp) png_free_ptr;

/* The structure that holds the information to read and write PNG files.
 * The only people who need to care about what is inside of this are the
 * people who will be modifying the library for their own special needs.
 * It should NOT be accessed directly by an application, except to store
 * the jmp_buf.
 */

struct png_struct_def
{
version(PNG_SETJMP_SUPPORTED) {
   import core.sys.posix.setjmp;
   jmp_buf jmpbuf;            /* used in png_error */
} // PNG_SETJMP_SUPPORTED
   deprecated png_error_ptr error_fn;    /* function for printing errors and aborting */
   deprecated png_error_ptr warning_fn;  /* function for printing warnings */
   deprecated png_voidp error_ptr;       /* user supplied struct for error functions */
   deprecated png_rw_ptr write_data_fn;  /* function for writing output data */
   deprecated png_rw_ptr read_data_fn;   /* function for reading input data */
   deprecated png_voidp io_ptr;          /* ptr to application struct for I/O functions */

version(PNG_READ_USER_TRANSFORM_SUPPORTED) {
   deprecated png_user_transform_ptr read_user_transform_fn; /* user read transform */
} // PNG_READ_USER_TRANSFORM_SUPPORTED

version(PNG_WRITE_USER_TRANSFORM_SUPPORTED) {
   deprecated png_user_transform_ptr write_user_transform_fn; /* user write transform */
}

/* These were added in libpng-1.0.2 */
version(PNG_USER_TRANSFORM_PTR_SUPPORTED) {
version(PNG_READ_USER_TRANSFORM_SUPPORTED) {
   deprecated png_voidp user_transform_ptr; /* user supplied struct for user transform */
   deprecated png_byte user_transform_depth;    /* bit depth of user transformed pixels */
   deprecated png_byte user_transform_channels; /* channels in user transformed pixels */
} else version(PNG_WRITE_USER_TRANSFORM_SUPPORTED) {
   deprecated png_voidp user_transform_ptr; /* user supplied struct for user transform */
   deprecated png_byte user_transform_depth;    /* bit depth of user transformed pixels */
   deprecated png_byte user_transform_channels; /* channels in user transformed pixels */
} // PNG_WRITE_USER_TRANSFORM_SUPPORTED
} // PNG_USER_TRANSFORM_PTR_SUPPORTED

   deprecated png_uint_32 mode;          /* tells us where we are in the PNG file */
   deprecated png_uint_32 flags;         /* flags indicating various things to libpng */
   deprecated png_uint_32 transformations; /* which transformations to perform */

   deprecated z_stream zstream;          /* pointer to decompression structure (below) */
   deprecated png_bytep zbuf;            /* buffer for zlib */
   deprecated png_size_t zbuf_size;      /* size of zbuf */
   deprecated int zlib_level;            /* holds zlib compression level */
   deprecated int zlib_method;           /* holds zlib compression method */
   deprecated int zlib_window_bits;      /* holds zlib compression window bits */
   deprecated int zlib_mem_level;        /* holds zlib compression memory level */
   deprecated int zlib_strategy;         /* holds zlib compression strategy */

   deprecated png_uint_32 width;         /* width of image in pixels */
   deprecated png_uint_32 height;        /* height of image in pixels */
   deprecated png_uint_32 num_rows;      /* number of rows in current pass */
   deprecated png_uint_32 usr_width;     /* width of row at start of write */
   deprecated png_uint_32 rowbytes;      /* size of row in bytes */
static if(0) { /* Replaced with the following in libpng-1.2.43 */
   png_size_t irowbytes;
}
/* Added in libpng-1.2.43 */
version(PNG_USER_LIMITS_SUPPORTED) {
   /* Added in libpng-1.4.0: Total number of sPLT, text, and unknown
    * chunks that can be stored (0 means unlimited).
    */
   deprecated png_uint_32 user_chunk_cache_max;
} // PNG_USER_LIMITS_SUPPORTED
   deprecated png_uint_32 iwidth;        /* width of current interlaced row in pixels */
   deprecated png_uint_32 row_number;    /* current row in interlace pass */
   deprecated png_bytep prev_row;        /* buffer to save previous (unfiltered) row */
   deprecated png_bytep row_buf;         /* buffer to save current (unfiltered) row */
version(PNG_NO_WRITE_FILTER) {
} else {
   deprecated png_bytep sub_row;         /* buffer to save "sub" row when filtering */
   deprecated png_bytep up_row;          /* buffer to save "up" row when filtering */
   deprecated png_bytep avg_row;         /* buffer to save "avg" row when filtering */
   deprecated png_bytep paeth_row;       /* buffer to save "Paeth" row when filtering */
} // !PNG_NO_WRITE_FILTER
   deprecated png_row_info row_info;     /* used for transformation routines */

   deprecated png_uint_32 idat_size;     /* current IDAT size for read */
   deprecated png_uint_32 crc;           /* current chunk CRC value */
   deprecated png_colorp palette;        /* palette from the input file */
   deprecated png_uint_16 num_palette;   /* number of color entries in palette */
   deprecated png_uint_16 num_trans;     /* number of transparency values */
   deprecated png_byte chunk_name[5];    /* null-terminated name of current chunk */
   deprecated png_byte compression;      /* file compression type (always 0) */
   deprecated png_byte filter;           /* file filter type (always 0) */
   deprecated png_byte interlaced;       /* PNG_INTERLACE_NONE, PNG_INTERLACE_ADAM7 */
   deprecated png_byte pass;             /* current interlace pass (0 - 6) */
   deprecated png_byte do_filter;        /* row filter flags (see PNG_FILTER_ below ) */
   deprecated png_byte color_type;       /* color type of file */
   deprecated png_byte bit_depth;        /* bit depth of file */
   deprecated png_byte usr_bit_depth;    /* bit depth of users row */
   deprecated png_byte pixel_depth;      /* number of bits per pixel */
   deprecated png_byte channels;         /* number of channels in file */
   deprecated png_byte usr_channels;     /* channels at start of write */
   deprecated png_byte sig_bytes;        /* magic bytes read/written from start of file */

version(PNG_READ_FILLER_SUPPORTED) {
   version(PNG_LEGACY_SUPPORTED) {
      deprecated png_byte filler;           /* filler byte for pixel expansion */
   } else {
      deprecated png_uint_16 filler;           /* filler bytes for pixel expansion */
   }
}

version(PNG_WRITE_FILLER_SUPPORTED) {
   version(PNG_LEGACY_SUPPORTED) {
      deprecated png_byte filler;           /* filler byte for pixel expansion */
   } else {
      deprecated png_uint_16 filler;           /* filler bytes for pixel expansion */
   }
} // PNG_WRITE_FILLER_SUPPORTED

version(PNG_bKGD_SUPPORTED) {
   deprecated png_byte background_gamma_type;
   version(PNG_FLOATING_POINT_SUPPORTED) {
      deprecated float background_gamma;
   } // PNG_FLOATING_POINT_SUPPORTED
   deprecated png_color_16 background;   /* background color in screen gamma space */
   version(PNG_READ_GAMMA_SUPPORTED) {
      deprecated png_color_16 background_1; /* background normalized to gamma 1.0 */
   } // PNG_READ_GAMMA_SUPPORTED
} // PNG_bKGD_SUPPORTED

version(PNG_WRITE_FLUSH_SUPPORTED) {
   deprecated png_flush_ptr output_flush_fn; /* Function for flushing output */
   deprecated png_uint_32 flush_dist;    /* how many rows apart to flush, 0 - no flush */
   deprecated png_uint_32 flush_rows;    /* number of rows written since last flush */
}

version(PNG_READ_GAMMA_SUPPORTED) {
   deprecated int gamma_shift;      /* number of "insignificant" bits 16-bit gamma */
version(PNG_FLOATING_POINT_SUPPORTED) {
   deprecated float gamma;          /* file gamma value */
   deprecated float screen_gamma;   /* screen gamma value (display_exponent) */
} // PNG_FLOATING_POINT_SUPPORTED
} else version(PNG_READ_BACKGROUND_SUPPORTED) {
   deprecated int gamma_shift;      /* number of "insignificant" bits 16-bit gamma */
version(PNG_FLOATING_POINT_SUPPORTED) {
   deprecated float gamma;          /* file gamma value */
   deprecated float screen_gamma;   /* screen gamma value (display_exponent) */
} // PNG_FLOATING_POINT_SUPPORTED
} // PNG_READ_BACKGROUND_SUPPORTED

version(PNG_READ_GAMMA_SUPPORTED) {
   deprecated png_bytep gamma_table;     /* gamma table for 8-bit depth files */
   deprecated png_bytep gamma_from_1;    /* converts from 1.0 to screen */
   deprecated png_bytep gamma_to_1;      /* converts from file to 1.0 */
   deprecated png_uint_16pp gamma_16_table; /* gamma table for 16-bit depth files */
   deprecated png_uint_16pp gamma_16_from_1; /* converts from 1.0 to screen */
   deprecated png_uint_16pp gamma_16_to_1; /* converts from file to 1.0 */
} else version(PNG_READ_BACKGROUND_SUPPORTED) {
   deprecated png_bytep gamma_table;     /* gamma table for 8-bit depth files */
   deprecated png_bytep gamma_from_1;    /* converts from 1.0 to screen */
   deprecated png_bytep gamma_to_1;      /* converts from file to 1.0 */
   deprecated png_uint_16pp gamma_16_table; /* gamma table for 16-bit depth files */
   deprecated png_uint_16pp gamma_16_from_1; /* converts from 1.0 to screen */
   deprecated png_uint_16pp gamma_16_to_1; /* converts from file to 1.0 */
} // PNG_READ_BACKGROUND_SUPPORTED

version(PNG_READ_GAMMA_SUPPORTED) {
   deprecated png_color_8 sig_bit;       /* significant bits in each available channel */
} else version(PNG_sBIT_SUPPORTED) {
   deprecated png_color_8 sig_bit;       /* significant bits in each available channel */
} // PNG_sBIT_SUPPORTED

version(PNG_READ_SHIFT_SUPPORTED) {
   deprecated png_color_8 shift;         /* shift for significant bit tranformation */
} else version(PNG_WRITE_SHIFT_SUPPORTED) {
   deprecated png_color_8 shift;         /* shift for significant bit tranformation */
}

version(PNG_tRNS_SUPPORTED) {
   deprecated png_bytep trans;           /* transparency values for paletted files */
   deprecated png_color_16 trans_values; /* transparency values for non-paletted files */
} else version(PNG_READ_BACKGROUND_SUPPORTED) {
   deprecated png_bytep trans;           /* transparency values for paletted files */
   deprecated png_color_16 trans_values; /* transparency values for non-paletted files */
} else version(PNG_READ_EXPAND_SUPPORTED) {
   deprecated png_bytep trans;           /* transparency values for paletted files */
   deprecated png_color_16 trans_values; /* transparency values for non-paletted files */
} else version(PNG_READ_BACKGROUND_SUPPORTED) {
   deprecated png_bytep trans;           /* transparency values for paletted files */
   deprecated png_color_16 trans_values; /* transparency values for non-paletted files */
}
   deprecated png_read_status_ptr read_row_fn;   /* called after each row is decoded */
   deprecated png_write_status_ptr write_row_fn; /* called after each row is encoded */
version(PNG_PROGRESSIVE_READ_SUPPORTED) {
   deprecated png_progressive_info_ptr info_fn; /* called after header data fully read */
   deprecated png_progressive_row_ptr row_fn;   /* called after each prog. row is decoded */
   deprecated png_progressive_end_ptr end_fn;   /* called after image is complete */
   deprecated png_bytep save_buffer_ptr;        /* current location in save_buffer */
   deprecated png_bytep save_buffer;            /* buffer for previously read data */
   deprecated png_bytep current_buffer_ptr;     /* current location in current_buffer */
   deprecated png_bytep current_buffer;         /* buffer for recently used data */
   deprecated png_uint_32 push_length;          /* size of current input chunk */
   deprecated png_uint_32 skip_length;          /* bytes to skip in input data */
   deprecated png_size_t save_buffer_size;      /* amount of data now in save_buffer */
   deprecated png_size_t save_buffer_max;       /* total size of save_buffer */
   deprecated png_size_t buffer_size;           /* total amount of available input data */
   deprecated png_size_t current_buffer_size;   /* amount of data now in current_buffer */
   deprecated int process_mode;                 /* what push library is currently doing */
   deprecated int cur_palette;                  /* current push library palette index */

   version(PNG_TEXT_SUPPORTED) {
     deprecated png_size_t current_text_size;   /* current size of text input data */
     deprecated png_size_t current_text_left;   /* how much text left to read in input */
     deprecated png_charp current_text;         /* current text chunk buffer */
     deprecated png_charp current_text_ptr;     /* current location in current_text */
   } //  PNG_TEXT_SUPPORTED
} // PNG_PROGRESSIVE_READ_SUPPORTED

version(__TURBOC__) {
   version(_Windows) {
   } else {
      version(__FLAT__) {
      } else {
         // defined(__TURBOC__) && !defined(_Windows) && !defined(__FLAT__)
         /* for the Borland special 64K segment handler */
         deprecated png_bytepp offset_table_ptr;
         deprecated png_bytep offset_table;
         deprecated png_uint_16 offset_table_number;
         deprecated png_uint_16 offset_table_count;
         deprecated png_uint_16 offset_table_count_free;
      }
   }
}

version(PNG_READ_DITHER_SUPPORTED) {
   deprecated png_bytep palette_lookup;         /* lookup table for dithering */
   deprecated png_bytep dither_index;           /* index translation for palette files */
}

version(PNG_READ_DITHER_SUPPORTED) {
   deprecated png_uint_16p hist;                /* histogram */
} else version(PNG_hIST_SUPPORTED) {
   deprecated png_uint_16p hist;                /* histogram */
}

version(PNG_WRITE_WEIGHTED_FILTER_SUPPORTED) {
   deprecated png_byte heuristic_method;        /* heuristic for row filter selection */
   deprecated png_byte num_prev_filters;        /* number of weights for previous rows */
   deprecated png_bytep prev_filters;           /* filter type(s) of previous row(s) */
   deprecated png_uint_16p filter_weights;      /* weight(s) for previous line(s) */
   deprecated png_uint_16p inv_filter_weights;  /* 1/weight(s) for previous line(s) */
   deprecated png_uint_16p filter_costs;        /* relative filter calculation cost */
   deprecated png_uint_16p inv_filter_costs;    /* 1/relative filter calculation cost */
}

version(PNG_TIME_RFC1123_SUPPORTED) {
   deprecated png_charp time_buffer;            /* String to hold RFC 1123 time text */
}

/* New members added in libpng-1.0.6 */

version(PNG_FREE_ME_SUPPORTED) {
   deprecated png_uint_32 free_me;   /* flags items libpng is responsible for freeing */
} // PNG_FREE_ME_SUPPORTED

version(PNG_USER_CHUNKS_SUPPORTED) {
   deprecated png_voidp user_chunk_ptr;
   deprecated png_user_chunk_ptr read_user_chunk_fn; /* user read chunk handler */
} // PNG_USER_CHUNKS_SUPPORTED

version(PNG_HANDLE_AS_UNKNOWN_SUPPORTED) {
   deprecated int num_chunk_list;
   deprecated png_bytep chunk_list;
} // PNG_HANDLE_AS_UNKNOWN_SUPPORTED

/* New members added in libpng-1.0.3 */
version(PNG_READ_RGB_TO_GRAY_SUPPORTED) {
   deprecated png_byte rgb_to_gray_status;
   /* These were changed from png_byte in libpng-1.0.6 */
   deprecated png_uint_16 rgb_to_gray_red_coeff;
   deprecated png_uint_16 rgb_to_gray_green_coeff;
   deprecated png_uint_16 rgb_to_gray_blue_coeff;
} // PNG_READ_RGB_TO_GRAY_SUPPORTED

/* New member added in libpng-1.0.4 (renamed in 1.0.9) */
version (PNG_MNG_FEATURES_SUPPORTED) {
   /* Changed from png_byte to png_uint_32 at version 1.2.0 */
   version (PNG_1_0_X) {
      deprecated png_byte mng_features_permitted;
   } else {
      deprecated png_uint_32 mng_features_permitted;
   } // PNG_1_0_X
} else version (PNG_READ_EMPTY_PLTE_SUPPORTED) {
   /* Changed from png_byte to png_uint_32 at version 1.2.0 */
   version (PNG_1_0_X) {
      deprecated png_byte mng_features_permitted;
   } else {
      deprecated png_uint_32 mng_features_permitted;
   } // PNG_1_0_X
} else version (PNG_WRITE_EMPTY_PLTE_SUPPORTED) {
   /* Changed from png_byte to png_uint_32 at version 1.2.0 */
   version (PNG_1_0_X) {
      deprecated png_byte mng_features_permitted;
   } else {
      deprecated png_uint_32 mng_features_permitted;
   } // PNG_1_0_X
}

/* New member added in libpng-1.0.7 */
version(PNG_READ_GAMMA_SUPPORTED) {
   deprecated png_fixed_point int_gamma;
} else version(PNG_READ_BACKGROUND_SUPPORTED) {
   deprecated png_fixed_point int_gamma;
}

/* New member added in libpng-1.0.9, ifdef'ed out in 1.0.12, enabled in 1.2.0 */
version(PNG_MNG_FEATURES_SUPPORTED) {
   deprecated png_byte filter_type;
}

version(PNG_1_0_X) {
/* New member added in libpng-1.0.10, ifdef'ed out in 1.2.0 */
   deprecated png_uint_32 row_buf_size;
}

/* New members added in libpng-1.2.0 */
version(PNG_ASSEMBLER_CODE_SUPPORTED) {
   version(PNG_1_0_X) {
   } else {
      version(PNG_MMX_CODE_SUPPORTED) {
         deprecated png_byte     mmx_bitdepth_threshold;
         deprecated png_uint_32  mmx_rowbytes_threshold;
      } // PNG_MMX_CODE_SUPPORTED
      deprecated png_uint_32  asm_flags;
   } // !PNG_1_0_X
} // PNG_ASSEMBLER_CODE_SUPPORTED

/* New members added in libpng-1.0.2 but first enabled by default in 1.2.0 */
version(PNG_USER_MEM_SUPPORTED) {
   deprecated png_voidp mem_ptr;            /* user supplied struct for mem functions */
   deprecated png_malloc_ptr malloc_fn;     /* function for allocating memory */
   deprecated png_free_ptr free_fn;         /* function for freeing memory */
} // PNG_USER_MEM_SUPPORTED

/* New member added in libpng-1.0.13 and 1.2.0 */
   deprecated png_bytep big_row_buf;        /* buffer to save current (unfiltered) row */

version(PNG_READ_DITHER_SUPPORTED) {
/* The following three members were added at version 1.0.14 and 1.2.4 */
   deprecated png_bytep dither_sort;        /* working sort array */
   deprecated png_bytep index_to_palette;   /* where the original index currently is */
                                 /* in the palette */
   deprecated png_bytep palette_to_index;   /* which original index points to this */
                                 /* palette color */
} // PNG_READ_DITHER_SUPPORTED

/* New members added in libpng-1.0.16 and 1.2.6 */
   deprecated png_byte compression_type;

version(PNG_USER_LIMITS_SUPPORTED) {
   deprecated png_uint_32 user_width_max;
   deprecated png_uint_32 user_height_max;
} // PNG_USER_LIMITS_SUPPORTED

/* New member added in libpng-1.0.25 and 1.2.17 */
version(PNG_UNKNOWN_CHUNKS_SUPPORTED) {
   /* Storage for unknown chunk that the library doesn't recognize. */
   deprecated png_unknown_chunk unknown_chunk;
} // PNG_UNKNOWN_CHUNKS_SUPPORTED

/* New members added in libpng-1.2.26 */
  deprecated png_uint_32 old_big_row_buf_size;
  deprecated png_uint_32 old_prev_row_size;

/* New member added in libpng-1.2.30 */
  deprecated png_charp chunkdata;  /* buffer for reading chunk data */
}

/* This triggers a compiler error in png.c, if png.c and png.h
 * do not agree upon the version number.
 */
alias png_structp version_1_2_50;

alias png_struct ** png_structpp;

/* Here are the function definitions most commonly used.  This is not
 * the place to find out how to use libpng.  See libpng.txt for the
 * full explanation, see example.c for the summary.  This just provides
 * a simple one line description of the use of each function.
 */

/* Returns the version number of the library */
png_uint_32 png_access_version_number();

/* Tell lib we have already handled the first <num_bytes> magic bytes.
 * Handling more than 8 bytes from the beginning of the file is an error.
 */
void png_set_sig_bytes(png_structp png_ptr, int num_bytes);

/* Check sig[start] through sig[start + num_to_check - 1] to see if it's a
 * PNG file.  Returns zero if the supplied bytes match the 8-byte PNG
 * signature, and non-zero otherwise.  Having num_to_check == 0 or
 * start > 7 will always fail (ie return non-zero).
 */
int png_sig_cmp(png_bytep sig, png_size_t start, png_size_t num_to_check);

/* Simple signature checking function.  This is the same as calling
 * png_check_sig(sig, n) := !png_sig_cmp(sig, 0, n).
 */
deprecated int png_check_sig(png_bytep sig, int num);

/* Allocate and initialize png_ptr struct for reading, and any other memory. */
png_structp png_create_read_struct(png_const_charp user_png_ver,
   png_voidp error_ptr,
   png_error_ptr error_fn,
   png_error_ptr warn_fn);

/* Allocate and initialize png_ptr struct for writing, and any other memory */
png_structp png_create_write_struct(png_const_charp user_png_ver,
   png_voidp error_ptr,
   png_error_ptr error_fn,
   png_error_ptr warn_fn);

version(PNG_WRITE_SUPPORTED) {
png_uint_32 png_get_compression_buffer_size(png_structp png_ptr);
} // PNG_WRITE_SUPPORTED

version(PNG_WRITE_SUPPORTED) {
void png_set_compression_buffer_size(png_structp png_ptr, png_uint_32 size);
} // PNG_WRITE_SUPPORTED

/* Reset the compression stream */
int png_reset_zstream(png_structp png_ptr);

/* New functions added in libpng-1.0.2 (not enabled by default until 1.2.0) */
version(PNG_USER_MEM_SUPPORTED) {
png_structp png_create_read_struct_2(png_const_charp user_png_ver,
   png_voidp error_ptr,
    png_error_ptr error_fn,
    png_error_ptr warn_fn,
    png_voidp mem_ptr,
    png_malloc_ptr malloc_fn,
    png_free_ptr free_fn);
png_structp png_create_write_struct_2(png_const_charp user_png_ver,
    png_voidp error_ptr,
    png_error_ptr error_fn,
    png_error_ptr warn_fn,
    png_voidp mem_ptr,
    png_malloc_ptr malloc_fn,
    png_free_ptr free_fn);
} // PNG_USER_MEM_SUPPORTED

/* Write a PNG chunk - size, type, (optional) data, CRC. */
void png_write_chunk(png_structp png_ptr,
   png_bytep chunk_name,
   png_bytep data,
   png_size_t length);

/* Write the start of a PNG chunk - length and chunk name. */
void png_write_chunk_start(png_structp png_ptr,
   png_bytep chunk_name,
   png_uint_32 length);

/* Write the data of a PNG chunk started with png_write_chunk_start(). */
void png_write_chunk_data(png_structp png_ptr,
      png_bytep data,
      png_size_t length);

/* Finish a chunk started with png_write_chunk_start() (includes CRC). */
void png_write_chunk_end(png_structp png_ptr);

/* Allocate and initialize the info structure */
png_infop png_create_info_struct(png_structp png_ptr);

version(PNG_1_0_X) {
   /* Initialize the info structure (old interface - DEPRECATED) */
   deprecated void png_info_init(png_infop info_ptr) {
      png_info_init_3(&info_ptr, png_sizeof(png_info));
   }
} else version(PNG_1_2_X) {
   /* Initialize the info structure (old interface - DEPRECATED) */
   deprecated void png_info_init(png_infop info_ptr) {
      png_info_init_3(&info_ptr, png_sizeof(png_info));
   }
} // PNG_1_2_X

void png_info_init_3(png_infopp info_ptr, png_size_t png_info_struct_size);

/* Writes all the PNG information before the image. */
void png_write_info_before_PLTE(png_structp png_ptr, png_infop info_ptr);
void png_write_info(png_structp png_ptr, png_infop info_ptr);

version(PNG_SEQUENTIAL_READ_SUPPORTED) {
/* Read the information before the actual image data. */
void png_read_info(png_structp png_ptr, png_infop info_ptr);
} // PNG_SEQUENTIAL_READ_SUPPORTED

version(PNG_TIME_RFC1123_SUPPORTED) {
png_charp png_convert_to_rfc1123(png_structp png_ptr, png_timep ptime);
} // PNG_TIME_RFC1123_SUPPORTED

version(PNG_CONVERT_tIME_SUPPORTED) {
/* Convert from a struct tm to png_time */
void png_convert_from_struct_tm(png_timep ptime, tm * ttime);

/* Convert from time_t to png_time.  Uses gmtime() */
void png_convert_from_time_t(png_timep ptime, time_t ttime);
} // PNG_CONVERT_tIME_SUPPORTED

version(PNG_READ_EXPAND_SUPPORTED) {
/* Expand data to 24-bit RGB, or 8-bit grayscale, with alpha if available. */
void png_set_expand(png_structp png_ptr);
version(PNG_1_0_X) {
} else {
   void png_set_expand_gray_1_2_4_to_8(png_structp png_ptr);
} // !PNG_1_0_X
void png_set_palette_to_rgb(png_structp png_ptr);
void png_set_tRNS_to_alpha(png_structp png_ptr);
version(PNG_1_0_X) {
/* Deprecated */
deprecated void png_set_gray_1_2_4_to_8 (png_structp png_ptr);
} else version(PNG_1_2_X) {
/* Deprecated */
deprecated void png_set_gray_1_2_4_to_8 (png_structp png_ptr);
} // PNG_1_2_X
} // PNG_READ_EXPAND_SUPPORTED

version(PNG_READ_BGR_SUPPORTED) {
/* Use blue, green, red order for pixels. */
void png_set_bgr(png_structp png_ptr);
} else version(PNG_WRITE_BGR_SUPPORTED) {
/* Use blue, green, red order for pixels. */
void png_set_bgr(png_structp png_ptr);
} // PNG_WRITE_BGR_SUPPORTED

version(PNG_READ_GRAY_TO_RGB_SUPPORTED) {
/* Expand the grayscale to 24-bit RGB if necessary. */
void png_set_gray_to_rgb(png_structp png_ptr);
} // PNG_READ_GRAY_TO_RGB_SUPPORTED

version(PNG_READ_RGB_TO_GRAY_SUPPORTED) {
/* Reduce RGB to grayscale. */
version(PNG_FLOATING_POINT_SUPPORTED) {
void png_set_rgb_to_gray(png_structp png_ptr,
      int error_action,
      double red,
      double green);
} // PNG_FLOATING_POINT_SUPPORTED
void png_set_rgb_to_gray_fixed(png_structp png_ptr,
      int error_action,
      png_fixed_point red,
      png_fixed_point green );
png_byte png_get_rgb_to_gray_status(png_structp png_ptr);
} // PNG_READ_RGB_TO_GRAY_SUPPORTED

void png_build_grayscale_palette(int bit_depth, png_colorp palette);

version(PNG_READ_STRIP_ALPHA_SUPPORTED) {
void png_set_strip_alpha(png_structp png_ptr);
} // PNG_READ_STRIP_ALPHA_SUPPORTED

version(PNG_READ_SWAP_ALPHA_SUPPORTED) {
void png_set_swap_alpha(png_structp png_ptr);
} else version(PNG_WRITE_SWAP_ALPHA_SUPPORTED) {
void png_set_swap_alpha(png_structp png_ptr);
} // PNG_WRITE_SWAP_ALPHA_SUPPORTED

version(PNG_READ_INVERT_ALPHA_SUPPORTED) {
void png_set_invert_alpha(png_structp png_ptr);
} else version(PNG_WRITE_INVERT_ALPHA_SUPPORTED) {
void png_set_invert_alpha(png_structp png_ptr);
} // PNG_WRITE_INVERT_ALPHA_SUPPORTED

version(PNG_READ_FILLER_SUPPORTED) {
/* Add a filler byte to 8-bit Gray or 24-bit RGB images. */
void png_set_filler(png_structp png_ptr, png_uint_32 filler, int flags);
/* The values of the PNG_FILLER_ defines should NOT be changed */
enum PNG_FILLER_BEFORE = 0;
enum PNG_FILLER_AFTER = 1;
/* Add an alpha byte to 8-bit Gray or 24-bit RGB images. */
version(PNG_1_0_X) {
} else {
void png_set_add_alpha(png_structp png_ptr, png_uint_32 filler, int flags);
} // !PNG_1_0_X
} else version(PNG_WRITE_FILLER_SUPPORTED) {
/* Add a filler byte to 8-bit Gray or 24-bit RGB images. */
void png_set_filler(png_structp png_ptr, png_uint_32 filler, int flags);
/* The values of the PNG_FILLER_ defines should NOT be changed */
enum PNG_FILLER_BEFORE = 0;
enum PNG_FILLER_AFTER = 1;
/* Add an alpha byte to 8-bit Gray or 24-bit RGB images. */
version(PNG_1_0_X) {
} else {
void png_set_add_alpha(png_structp png_ptr, png_uint_32 filler, int flags);
} // !PNG_1_0_X
} // PNG_WRITE_FILLER_SUPPORTED

version(PNG_READ_SWAP_SUPPORTED) {
/* Swap bytes in 16-bit depth files. */
void png_set_swap(png_structp png_ptr);
} else version(PNG_WRITE_SWAP_SUPPORTED) {
/* Swap bytes in 16-bit depth files. */
void png_set_swap(png_structp png_ptr);
} // PNG_WRITE_SWAP_SUPPORTED

version(PNG_READ_PACK_SUPPORTED) {
/* Use 1 byte per pixel in 1, 2, or 4-bit depth files. */
void png_set_packing(png_structp png_ptr);
} else version(PNG_WRITE_PACK_SUPPORTED) {
/* Use 1 byte per pixel in 1, 2, or 4-bit depth files. */
void png_set_packing(png_structp png_ptr);
} // PNG_WRITE_PACK_SUPPORTED

version(PNG_READ_PACKSWAP_SUPPORTED) {
/* Swap packing order of pixels in bytes. */
void png_set_packswap(png_structp png_ptr);
} else version(PNG_WRITE_PACKSWAP_SUPPORTED) {
/* Swap packing order of pixels in bytes. */
void png_set_packswap(png_structp png_ptr);
} // PNG_WRITE_PACKSWAP_SUPPORTED

version(PNG_READ_SHIFT_SUPPORTED) {
/* Converts files to legal bit depths. */
void png_set_shift(png_structp png_ptr, png_color_8p true_bits);
} else version(PNG_WRITE_SHIFT_SUPPORTED) {
/* Converts files to legal bit depths. */
void png_set_shift(png_structp png_ptr, png_color_8p true_bits);
} // PNG_WRITE_SHIFT_SUPPORTED

version(PNG_READ_INTERLACING_SUPPORTED) {
/* Have the code handle the interlacing.  Returns the number of passes. */
int png_set_interlace_handling(png_structp png_ptr);
} else version(PNG_WRITE_INTERLACING_SUPPORTED) {
/* Have the code handle the interlacing.  Returns the number of passes. */
int png_set_interlace_handling(png_structp png_ptr);
} // PNG_WRITE_INTERLACING_SUPPORTED

version(PNG_READ_INVERT_SUPPORTED) {
/* Invert monochrome files */
void png_set_invert_mono(png_structp png_ptr);
} else version(PNG_WRITE_INVERT_SUPPORTED) {
/* Invert monochrome files */
void png_set_invert_mono(png_structp png_ptr);
} // PNG_WRITE_INVERT_SUPPORTED

version(PNG_READ_BACKGROUND_SUPPORTED) {
/* Handle alpha and tRNS by replacing with a background color. */
version(PNG_FLOATING_POINT_SUPPORTED) {
void png_set_background(png_structp png_ptr,
      png_color_16p background_color,
      int background_gamma_code,
      int need_expand,
      double background_gamma);
} // PNG_FLOATING_POINT_SUPPORTED
enum PNG_BACKGROUND_GAMMA_UNKNOWN = 0;
enum PNG_BACKGROUND_GAMMA_SCREEN =  1;
enum PNG_BACKGROUND_GAMMA_FILE =    2;
enum PNG_BACKGROUND_GAMMA_UNIQUE =  3;
} // PNG_READ_BACKGROUND_SUPPORTED

version(PNG_READ_16_TO_8_SUPPORTED) {
/* Strip the second byte of information from a 16-bit depth file. */
void png_set_strip_16(png_structp png_ptr);
} // PNG_READ_16_TO_8_SUPPORTED

version(PNG_READ_DITHER_SUPPORTED) {
/* Turn on dithering, and reduce the palette to the number of colors available. */
void png_set_dither(png_structp png_ptr,
      png_colorp palette,
      int num_palette,
      int maximum_colors,
      png_uint_16p histogram,
      int full_dither);
} // PNG_READ_DITHER_SUPPORTED

version(PNG_READ_GAMMA_SUPPORTED) {
/* Handle gamma correction. Screen_gamma=(display_exponent) */
version(PNG_FLOATING_POINT_SUPPORTED) {
void png_set_gamma(png_structp png_ptr, double screen_gamma, double default_file_gamma);
} // PNG_FLOATING_POINT_SUPPORTED
} // PNG_READ_GAMMA_SUPPORTED

version(PNG_1_0_X) {
version(PNG_READ_EMPTY_PLTE_SUPPORTED) {
/* Permit or disallow empty PLTE (0: not permitted, 1: permitted) */
/* Deprecated and will be removed.  Use png_permit_mng_features() instead. */
deprecated void png_permit_empty_plte(png_structp png_ptr, int empty_plte_permitted);
} else version(PNG_WRITE_EMPTY_PLTE_SUPPORTED) {
/* Permit or disallow empty PLTE (0: not permitted, 1: permitted) */
/* Deprecated and will be removed.  Use png_permit_mng_features() instead. */
deprecated void png_permit_empty_plte(png_structp png_ptr, int empty_plte_permitted);
} // PNG_WRITE_EMPTY_PLTE_SUPPORTED
} else version(PNG_1_2_X) {
version(PNG_READ_EMPTY_PLTE_SUPPORTED) {
/* Permit or disallow empty PLTE (0: not permitted, 1: permitted) */
/* Deprecated and will be removed.  Use png_permit_mng_features() instead. */
deprecated void png_permit_empty_plte(png_structp png_ptr, int empty_plte_permitted);
} else version(PNG_WRITE_EMPTY_PLTE_SUPPORTED) {
/* Permit or disallow empty PLTE (0: not permitted, 1: permitted) */
/* Deprecated and will be removed.  Use png_permit_mng_features() instead. */
deprecated void png_permit_empty_plte(png_structp png_ptr, int empty_plte_permitted);
} // PNG_WRITE_EMPTY_PLTE_SUPPORTED
} // PNG_1_2_X

version(PNG_WRITE_FLUSH_SUPPORTED) {
/* Set how many lines between output flushes - 0 for no flushing */
void png_set_flush(png_structp png_ptr, int nrows);
/* Flush the current PNG output buffer */
void png_write_flush(png_structp png_ptr);
} // PNG_WRITE_FLUSH_SUPPORTED

/* Optional update palette with requested transformations */
void png_start_read_image(png_structp png_ptr);

/* Optional call to update the users info structure */
void png_read_update_info(png_structp png_ptr, png_infop info_ptr);

version(PNG_NO_SEQUENTIAL_READ_SUPPORTED) {
} else {
/* Read one or more rows of image data. */
void png_read_rows(png_structp png_ptr,
      png_bytepp row,
      png_bytepp display_row,
      png_uint_32 num_rows);
} // !PNG_NO_SEQUENTIAL_READ_SUPPORTED

version(PNG_NO_SEQUENTIAL_READ_SUPPORTED) {
} else {
/* Read a row of data. */
void png_read_row(png_structp png_ptr,
      png_bytep row,
      png_bytep display_row);
} // PNG_NO_SEQUENTIAL_READ_SUPPORTED

version(PNG_NO_SEQUENTIAL_READ_SUPPORTED) {
} else {
/* Read the whole image into memory at once. */
void png_read_image(png_structp png_ptr, png_bytepp image);
} // PNG_NO_SEQUENTIAL_READ_SUPPORTED

/* Write a row of image data */
void png_write_row(png_structp png_ptr, png_bytep row);

/* Write a few rows of image data */
void png_write_rows(png_structp png_ptr, png_bytepp row, png_uint_32 num_rows);

/* Write the image data */
void png_write_image(png_structp png_ptr, png_bytepp image);

/* Writes the end of the PNG file. */
void png_write_end(png_structp png_ptr, png_infop info_ptr);

version(PNG_NO_SEQUENTIAL_READ_SUPPORTED) {
/* Read the end of the PNG file. */
void png_read_end(png_structp png_ptr, png_infop info_ptr);
} // PNG_NO_SEQUENTIAL_READ_SUPPORTED

/* Free any memory associated with the png_info_struct */
void png_destroy_info_struct(png_structp png_ptr, png_infopp info_ptr_ptr);

/* Free any memory associated with the png_struct and the png_info_structs */
void png_destroy_read_struct(png_structpp png_ptr_ptr,
      png_infopp info_ptr_ptr,
      png_infopp end_info_ptr_ptr);

/* Free all memory used by the read (old method - NOT DLL EXPORTED) */
/* Debian note: exporting as it is required by legacy applications */
void png_read_destroy(png_structp png_ptr, png_infop info_ptr, png_infop end_info_ptr);

/* Free any memory associated with the png_struct and the png_info_structs */
void png_destroy_write_struct(png_structpp png_ptr_ptr, png_infopp info_ptr_ptr);

/* Free any memory used in png_ptr struct (old method - NOT DLL EXPORTED) */
/* Debian note: exporting as it is required by legacy applications */
void png_write_destroy(png_structp png_ptr);

/* Set the libpng method of handling chunk CRC errors */
void png_set_crc_action(png_structp png_ptr, int crit_action, int ancil_action);

/* Values for png_set_crc_action() to say how to handle CRC errors in
 * ancillary and critical chunks, and whether to use the data contained
 * therein.  Note that it is impossible to "discard" data in a critical
 * chunk.  For versions prior to 0.90, the action was always error/quit,
 * whereas in version 0.90 and later, the action for CRC errors in ancillary
 * chunks is warn/discard.  These values should NOT be changed.
 *
 *      value                       action:critical     action:ancillary
 */
enum PNG_CRC_DEFAULT =      0;  /* error/quit          warn/discard data */
enum PNG_CRC_ERROR_QUIT =   1;  /* error/quit          error/quit        */
enum PNG_CRC_WARN_DISCARD = 2;  /* (INVALID)           warn/discard data */
enum PNG_CRC_WARN_USE =     3;  /* warn/use data       warn/use data     */
enum PNG_CRC_QUIET_USE =    4;  /* quiet/use data      quiet/use data    */
enum PNG_CRC_NO_CHANGE =    5;  /* use current value   use current value */

/* These functions give the user control over the scan-line filtering in
 * libpng and the compression methods used by zlib.  These functions are
 * mainly useful for testing, as the defaults should work with most users.
 * Those users who are tight on memory or want faster performance at the
 * expense of compression can modify them.  See the compression library
 * header file (zlib.h) for an explination of the compression functions.
 */

/* Set the filtering method(s) used by libpng.  Currently, the only valid
 * value for "method" is 0.
 */
void png_set_filter(png_structp png_ptr, int method, int filters);

/* Flags for png_set_filter() to say which filters to use.  The flags
 * are chosen so that they don't conflict with real filter types
 * below, in case they are supplied instead of the #defined constants.
 * These values should NOT be changed.
 */
enum PNG_NO_FILTERS =   0x00;
enum PNG_FILTER_NONE =  0x08;
enum PNG_FILTER_SUB =   0x10;
enum PNG_FILTER_UP =    0x20;
enum PNG_FILTER_AVG =   0x40;
enum PNG_FILTER_PAETH = 0x80;
enum PNG_ALL_FILTERS = (PNG_FILTER_NONE | PNG_FILTER_SUB | PNG_FILTER_UP |
                        PNG_FILTER_AVG | PNG_FILTER_PAETH);

/* Filter values (not flags) - used in pngwrite.c, pngwutil.c for now.
 * These defines should NOT be changed.
 */
enum PNG_FILTER_VALUE_NONE =  0;
enum PNG_FILTER_VALUE_SUB =   1;
enum PNG_FILTER_VALUE_UP =    2;
enum PNG_FILTER_VALUE_AVG =   3;
enum PNG_FILTER_VALUE_PAETH = 4;
enum PNG_FILTER_VALUE_LAST =  5;

version(PNG_WRITE_WEIGHTED_FILTER_SUPPORTED) { /* EXPERIMENTAL */
/* The "heuristic_method" is given by one of the PNG_FILTER_HEURISTIC_
 * defines, either the default (minimum-sum-of-absolute-differences), or
 * the experimental method (weighted-minimum-sum-of-absolute-differences).
 *
 * Weights are factors >= 1.0, indicating how important it is to keep the
 * filter type consistent between rows.  Larger numbers mean the current
 * filter is that many times as likely to be the same as the "num_weights"
 * previous filters.  This is cumulative for each previous row with a weight.
 * There needs to be "num_weights" values in "filter_weights", or it can be
 * NULL if the weights aren't being specified.  Weights have no influence on
 * the selection of the first row filter.  Well chosen weights can (in theory)
 * improve the compression for a given image.
 *
 * Costs are factors >= 1.0 indicating the relative decoding costs of a
 * filter type.  Higher costs indicate more decoding expense, and are
 * therefore less likely to be selected over a filter with lower computational
 * costs.  There needs to be a value in "filter_costs" for each valid filter
 * type (given by PNG_FILTER_VALUE_LAST), or it can be NULL if you aren't
 * setting the costs.  Costs try to improve the speed of decompression without
 * unduly increasing the compressed image size.
 *
 * A negative weight or cost indicates the default value is to be used, and
 * values in the range [0.0, 1.0) indicate the value is to remain unchanged.
 * The default values for both weights and costs are currently 1.0, but may
 * change if good general weighting/cost heuristics can be found.  If both
 * the weights and costs are set to 1.0, this degenerates the WEIGHTED method
 * to the UNWEIGHTED method, but with added encoding time/computation.
 */
version(PNG_FLOATING_POINT_SUPPORTED) {
void png_set_filter_heuristics(png_structp png_ptr,
      int heuristic_method,
      int num_weights,
      png_doublep filter_weights,
      png_doublep filter_costs);
} // PNG_FLOATING_POINT_SUPPORTED
} // PNG_WRITE_WEIGHTED_FILTER_SUPPORTED

/* Heuristic used for row filter selection.  These defines should NOT be
 * changed.
 */
enum PNG_FILTER_HEURISTIC_DEFAULT =    0;  /* Currently "UNWEIGHTED" */
enum PNG_FILTER_HEURISTIC_UNWEIGHTED = 1;  /* Used by libpng < 0.95 */
enum PNG_FILTER_HEURISTIC_WEIGHTED =   2;  /* Experimental feature */
enum PNG_FILTER_HEURISTIC_LAST =       3;  /* Not a valid value */

/* Set the library compression level.  Currently, valid values range from
 * 0 - 9, corresponding directly to the zlib compression levels 0 - 9
 * (0 - no compression, 9 - "maximal" compression).  Note that tests have
 * shown that zlib compression levels 3-6 usually perform as well as level 9
 * for PNG images, and do considerably fewer caclulations.  In the future,
 * these values may not correspond directly to the zlib compression levels.
 */
void png_set_compression_level(png_structp png_ptr, int level);

void png_set_compression_mem_level(png_structp png_ptr, int mem_level);

void png_set_compression_strategy(png_structp png_ptr, int strategy);

void png_set_compression_window_bits(png_structp png_ptr, int window_bits);

void png_set_compression_method(png_structp png_ptr, int method);

/* These next functions are called for input/output, memory, and error
 * handling.  They are in the file pngrio.c, pngwio.c, and pngerror.c,
 * and call standard C I/O routines such as fread(), fwrite(), and
 * fprintf().  These functions can be made to use other I/O routines
 * at run time for those applications that need to handle I/O in a
 * different manner by calling png_set_???_fn().  See libpng.txt for
 * more information.
 */

version(PNG_STDIO_SUPPORTED) {
/* Initialize the input/output for the PNG file to the default functions. */
void png_init_io(png_structp png_ptr, png_FILE_p fp);
} // PNG_STDIO_SUPPORTED

/* Replace the (error and abort), and warning functions with user
 * supplied functions.  If no messages are to be printed you must still
 * write and use replacement functions. The replacement error_fn should
 * still do a longjmp to the last setjmp location if you are using this
 * method of error handling.  If error_fn or warning_fn is NULL, the
 * default function will be used.
 */

void png_set_error_fn(png_structp png_ptr,
      png_voidp error_ptr,
      png_error_ptr error_fn,
      png_error_ptr warning_fn);

/* Return the user pointer associated with the error functions */
png_voidp png_get_error_ptr(png_structp png_ptr);

/* Replace the default data output functions with a user supplied one(s).
 * If buffered output is not used, then output_flush_fn can be set to NULL.
 * If PNG_WRITE_FLUSH_SUPPORTED is not defined at libpng compile time
 * output_flush_fn will be ignored (and thus can be NULL).
 * It is probably a mistake to use NULL for output_flush_fn if
 * write_data_fn is not also NULL unless you have built libpng with
 * PNG_WRITE_FLUSH_SUPPORTED undefined, because in this case libpng's
 * default flush function, which uses the standard *FILE structure, will
 * be used.
 */
void png_set_write_fn(png_structp png_ptr,
      png_voidp io_ptr,
      png_rw_ptr write_data_fn,
      png_flush_ptr output_flush_fn);

/* Replace the default data input function with a user supplied one. */
void png_set_read_fn(png_structp png_ptr, png_voidp io_ptr, png_rw_ptr read_data_fn);

/* Return the user pointer associated with the I/O functions */
png_voidp png_get_io_ptr(png_structp png_ptr);

void png_set_read_status_fn(png_structp png_ptr, png_read_status_ptr read_row_fn);

void png_set_write_status_fn(png_structp png_ptr, png_write_status_ptr write_row_fn);

version(PNG_USER_MEM_SUPPORTED) {
/* Replace the default memory allocation functions with user supplied one(s). */
void png_set_mem_fn(png_structp png_ptr,
         png_voidp mem_ptr,
         png_malloc_ptr malloc_fn,
         png_free_ptr free_fn);
/* Return the user pointer associated with the memory functions */
png_voidp png_get_mem_ptr(png_structp png_ptr);
} // PNG_USER_MEM_SUPPORTED

version(PNG_READ_USER_TRANSFORM_SUPPORTED) {
void png_set_read_user_transform_fn(png_structp png_ptr,
      png_user_transform_ptr
      read_user_transform_fn);
} else version(PNG_LEGACY_SUPPORTED) {
void png_set_read_user_transform_fn(png_structp png_ptr,
      png_user_transform_ptr
      read_user_transform_fn);
} // PNG_LEGACY_SUPPORTED

version(PNG_WRITE_USER_TRANSFORM_SUPPORTED) {
void png_set_write_user_transform_fn(png_structp png_ptr,
      png_user_transform_ptr write_user_transform_fn);
} else version(PNG_LEGACY_SUPPORTED) {
void png_set_write_user_transform_fn(png_structp png_ptr,
      png_user_transform_ptr write_user_transform_fn);
} // PNG_LEGACY_SUPPORTED

version(PNG_READ_USER_TRANSFORM_SUPPORTED) {
void png_set_user_transform_info(png_structp png_ptr,
      png_voidp user_transform_ptr,
      int user_transform_depth,
      int user_transform_channels);
/* Return the user pointer associated with the user transform functions */
png_voidp png_get_user_transform_ptr(png_structp png_ptr);
} else version(PNG_WRITE_USER_TRANSFORM_SUPPORTED) {
void png_set_user_transform_info(png_structp png_ptr,
      png_voidp user_transform_ptr,
      int user_transform_depth,
      int user_transform_channels);
/* Return the user pointer associated with the user transform functions */
png_voidp png_get_user_transform_ptr(png_structp png_ptr);
} else version(PNG_LEGACY_SUPPORTED) {
void png_set_user_transform_info(png_structp png_ptr,
      png_voidp user_transform_ptr,
      int user_transform_depth,
      int user_transform_channels);
/* Return the user pointer associated with the user transform functions */
png_voidp png_get_user_transform_ptr(png_structp png_ptr);
} // PNG_LEGACY_SUPPORTED

version(PNG_USER_CHUNKS_SUPPORTED) {
void png_set_read_user_chunk_fn(png_structp png_ptr,
         png_voidp user_chunk_ptr,
         png_user_chunk_ptr read_user_chunk_fn);
png_voidp png_get_user_chunk_ptr(png_structp png_ptr);
} // PNG_USER_CHUNKS_SUPPORTED

version(PNG_PROGRESSIVE_READ_SUPPORTED) {
/* Sets the function callbacks for the push reader, and a pointer to a
 * user-defined structure available to the callback functions.
 */
void png_set_progressive_read_fn(png_structp png_ptr,
      png_voidp progressive_ptr,
      png_progressive_info_ptr info_fn,
      png_progressive_row_ptr row_fn,
      png_progressive_end_ptr end_fn);

/* Returns the user pointer associated with the push read functions */
png_voidp png_get_progressive_ptr(png_structp png_ptr);

/* Function to be called when data becomes available */
void png_process_data(png_structp png_ptr,
      png_infop info_ptr,
      png_bytep buffer,
      png_size_t buffer_size);

/* Function that combines rows.  Not very much different than the
 * png_combine_row() call.  Is this even used?????
 */
void png_progressive_combine_row(png_structp png_ptr,
      png_bytep old_row,
      png_bytep new_row);
} // PNG_PROGRESSIVE_READ_SUPPORTED

png_voidp png_malloc(png_structp png_ptr, png_uint_32 size);

version(PNG_1_0_X) {
alias png_malloc_warn = png_malloc;
} else {
/* Added at libpng version 1.2.4 */
png_voidp png_malloc_warn(png_structp png_ptr, png_uint_32 size);
} // !PNG_1_0_X

/* Frees a pointer allocated by png_malloc() */
void png_free(png_structp png_ptr, png_voidp ptr);

version(PNG_1_0_X) {
/* Function to allocate memory for zlib. */
voidpf png_zalloc(voidpf png_ptr, uInt items, uInt size);

/* Function to free memory for zlib */
void png_zfree(voidpf png_ptr, voidpf ptr);
} // PNG_1_0_X

/* Free data that was allocated internally */
void png_free_data (png_structp png_ptr,
      png_infop info_ptr,
      png_uint_32 free_me,
      int num);

version(PNG_FREE_ME_SUPPORTED) {
/* Reassign responsibility for freeing existing data, whether allocated
 * by libpng or by the application
 */
void png_data_freer(png_structp png_ptr,
         png_infop info_ptr,
         int freer,
         png_uint_32 mask);
} // PNG_FREE_ME_SUPPORTED

/* Assignments for png_data_freer */
enum PNG_DESTROY_WILL_FREE_DATA = 1;
enum PNG_SET_WILL_FREE_DATA = 1;

enum PNG_USER_WILL_FREE_DATA = 2;
/* Flags for png_ptr->free_me and info_ptr->free_me */
enum PNG_FREE_HIST = 0x0008;
enum PNG_FREE_ICCP = 0x0010;
enum PNG_FREE_SPLT = 0x0020;
enum PNG_FREE_ROWS = 0x0040;
enum PNG_FREE_PCAL = 0x0080;
enum PNG_FREE_SCAL = 0x0100;
enum PNG_FREE_UNKN = 0x0200;
enum PNG_FREE_LIST = 0x0400;
enum PNG_FREE_PLTE = 0x1000;
enum PNG_FREE_TRNS = 0x2000;
enum PNG_FREE_TEXT = 0x4000;
enum PNG_FREE_ALL = 0x7fff;
enum PNG_FREE_MUL = 0x4220; /* PNG_FREE_SPLT|PNG_FREE_TEXT|PNG_FREE_UNKN */

version(PNG_USER_MEM_SUPPORTED) {
png_voidp png_malloc_default(png_structp png_ptr, png_uint_32 size);
void png_free_default (png_structp png_ptr, png_voidp ptr);
} // PNG_USER_MEM_SUPPORTED

deprecated png_voidp png_memcpy_check(png_structp png_ptr,
      png_voidp s1,
      png_voidp s2,
      png_uint_32 size);

deprecated png_voidp png_memset_check(png_structp png_ptr,
      png_voidp s1,
      int value,
      png_uint_32 size);

version(USE_FAR_KEYWORD) {  /* memory model conversion function */
void *png_far_to_near(png_structp png_ptr, png_voidp ptr, int check);
} /* USE_FAR_KEYWORD */

version(PNG_NO_ERROR_TEXT) {
/* Fatal error in PNG image of libpng - can't continue */
void png_err(png_structp png_ptr);
} else {
/* Fatal error in PNG image of libpng - can't continue */
void png_error(png_structp png_ptr, png_const_charp error_message);

/* The same, but the chunk name is prepended to the error string. */
void png_chunk_error(png_structp png_ptr, png_const_charp error_message);
} // PNG_NO_ERROR_TEXT

version(PNG_NO_WARNINGS) {
/* Non-fatal error in libpng.  Can continue, but may have a problem. */
void png_warning(png_structp png_ptr, png_const_charp warning_message);

version(PNG_READ_SUPPORTED) {
/* Non-fatal error in libpng, chunk name is prepended to message. */
void png_chunk_warning(png_structp png_ptr, png_const_charp warning_message);
} // PNG_READ_SUPPORTED
} // PNG_NO_WARNINGS

/* The png_set_<chunk> functions are for storing values in the png_info_struct.
 * Similarly, the png_get_<chunk> calls are used to read values from the
 * png_info_struct, either storing the parameters in the passed variables, or
 * setting pointers into the png_info_struct where the data is stored.  The
 * png_get_<chunk> functions return a non-zero value if the data was available
 * in info_ptr, or return zero and do not change any of the parameters if the
 * data was not available.
 *
 * These functions should be used instead of directly accessing png_info
 * to avoid problems with future changes in the size and internal layout of
 * png_info_struct.
 */
/* Returns "flag" if chunk data is valid in info_ptr. */
png_uint_32 png_get_valid(png_structp png_ptr, png_infop info_ptr, png_uint_32 flag);

/* Returns number of bytes needed to hold a transformed row. */
png_uint_32 png_get_rowbytes(png_structp png_ptr, png_infop info_ptr);

version(PNG_INFO_IMAGE_SUPPORTED) {
/* Returns row_pointers, which is an array of pointers to scanlines that was
 * returned from png_read_png().
 */
png_bytepp png_get_rows(png_structp png_ptr, png_infop info_ptr);
/* Set row_pointers, which is an array of pointers to scanlines for use
 * by png_write_png().
 */
void png_set_rows(png_structp png_ptr, png_infop info_ptr, png_bytepp row_pointers);
} // PNG_INFO_IMAGE_SUPPORTED

/* Returns number of color channels in image. */
png_byte png_get_channels(png_structp png_ptr, png_infop info_ptr);

version (PNG_EASY_ACCESS_SUPPORTED) {
   /* Returns image width in pixels. */
   png_uint_32 png_get_image_width(png_structp png_ptr, png_infop info_ptr);

   /* Returns image height in pixels. */
   png_uint_32 png_get_image_height(png_structp png_ptr, png_infop info_ptr);

   /* Returns image bit_depth. */
   png_byte png_get_bit_depth(png_structp png_ptr, png_infop info_ptr);

   /* Returns image color_type. */
   png_byte png_get_color_type(png_structp png_ptr, png_infop info_ptr);

   /* Returns image filter_type. */
   png_byte png_get_filter_type(png_structp png_ptr, png_infop info_ptr);

   /* Returns image interlace_type. */
   png_byte png_get_interlace_type(png_structp png_ptr, png_infop info_ptr);

   /* Returns image compression_type. */
   png_byte png_get_compression_type(png_structp png_ptr, png_infop info_ptr);

   /* Returns image resolution in pixels per meter, from pHYs chunk data. */
   png_uint_32 png_get_pixels_per_meter(png_structp png_ptr, png_infop info_ptr);
   png_uint_32 png_get_x_pixels_per_meter(png_structp png_ptr, png_infop info_ptr);
   png_uint_32 png_get_y_pixels_per_meter(png_structp png_ptr, png_infop info_ptr);

   /* Returns pixel aspect ratio, computed from pHYs chunk data.  */
   version (PNG_FLOATING_POINT_SUPPORTED) {
      float png_get_pixel_aspect_ratio(png_structp png_ptr, png_infop info_ptr);
   }

   /* Returns image x, y offset in pixels or microns, from oFFs chunk data. */
   png_int_32 png_get_x_offset_pixels(png_structp png_ptr, png_infop info_ptr);
   png_int_32 png_get_y_offset_pixels(png_structp png_ptr, png_infop info_ptr);
   png_int_32 png_get_x_offset_microns(png_structp png_ptr, png_infop info_ptr);
   png_int_32 png_get_y_offset_microns(png_structp png_ptr, png_infop info_ptr);
} // PNG_EASY_ACCESS_SUPPORTED

/* returns pointer to signature string read from png header */
png_bytep png_get_signature(png_structp png_ptr, png_infop info_ptr);

version (PNG_bKGD_SUPPORTED) {
   png_uint_32 png_get_bKGD(png_structp png_ptr,
         png_infop info_ptr,
         png_color_16p *background);
} // PNG_bKGD_SUPPORTED

version (PNG_bKGD_SUPPORTED) {
   void png_set_bKGD(png_structp png_ptr,
         png_infop info_ptr,
         png_color_16p background);
} // PNG_bKGD_SUPPORTED

version (PNG_cHRM_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      png_uint_32 png_get_cHRM(png_structp png_ptr,
            png_infop info_ptr,
            double *white_x,
            double *white_y,
            double *red_x,
            double *red_y,
            double *green_x,
            double *green_y,
            double *blue_x,
            double *blue_y);
   } // PNG_FLOATING_POINT_SUPPORTED

   version (PNG_FIXED_POINT_SUPPORTED) {
      png_uint_32 png_get_cHRM_fixed(png_structp png_ptr,
            png_infop info_ptr,
            png_fixed_point *int_white_x,
            png_fixed_point *int_white_y,
            png_fixed_point *int_red_x,
            png_fixed_point *int_red_y,
            png_fixed_point *int_green_x,
            png_fixed_point *int_green_y,
            png_fixed_point *int_blue_x,
            png_fixed_point *int_blue_y);
   } // PNG_FIXED_POINT_SUPPORTED
} // PNG_cHRM_SUPPORTED

version (PNG_cHRM_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      void png_set_cHRM(png_structp png_ptr,
            png_infop info_ptr,
            double white_x,
            double white_y,
            double red_x,
            double red_y,
            double green_x,
            double green_y,
            double blue_x,
            double blue_y);
   } // PNG_FLOATING_POINT_SUPPORTED
   version (PNG_FIXED_POINT_SUPPORTED) {
      void png_set_cHRM_fixed(png_structp png_ptr,
            png_infop info_ptr,
            png_fixed_point int_white_x,
            png_fixed_point int_white_y,
            png_fixed_point int_red_x,
            png_fixed_point int_red_y,
            png_fixed_point int_green_x,
            png_fixed_point int_green_y,
            png_fixed_point int_blue_x,
            png_fixed_point int_blue_y);
   } // PNG_FIXED_POINT_SUPPORTED
} // PNG_cHRM_SUPPORTED

version (PNG_gAMA_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      png_uint_32 png_get_gAMA(png_structp png_ptr,
            png_infop info_ptr,
            double *file_gamma);
   } // PNG_FLOATING_POINT_SUPPORTED

   png_uint_32 png_get_gAMA_fixed(png_structp png_ptr,
         png_infop info_ptr,
         png_fixed_point *int_file_gamma);
} // PNG_gAMA_SUPPORTED

version (PNG_gAMA_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      void png_set_gAMA(png_structp png_ptr,
            png_infop info_ptr,
            double file_gamma);
   } // PNG_FLOATING_POINT_SUPPORTED

   void png_set_gAMA_fixed(png_structp png_ptr,
         png_infop info_ptr,
         png_fixed_point int_file_gamma);
} // PNG_gAMA_SUPPORTED

version (PNG_hIST_SUPPORTED) {
   png_uint_32 png_get_hIST(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_16p *hist);
} // PNG_hIST_SUPPORTED

version (PNG_hIST_SUPPORTED) {
   void png_set_hIST(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_16p hist);
} // PNG_hIST_SUPPORTED

png_uint_32 png_get_IHDR(png_structp png_ptr,
      png_infop info_ptr,
      png_uint_32 *width,
      png_uint_32 *height,
      int *bit_depth,
      int *color_type,
      int *interlace_method,
      int *compression_method,
      int *filter_method);

void png_set_IHDR(png_structp png_ptr,
      png_infop info_ptr,
      png_uint_32 width,
      png_uint_32 height,
      int bit_depth,
      int color_type,
      int interlace_method,
      int compression_method,
      int filter_method);

version (PNG_oFFs_SUPPORTED) {
   png_uint_32 png_get_oFFs(png_structp png_ptr,
         png_infop info_ptr,
         png_int_32 *offset_x,
         png_int_32 *offset_y,
         int *unit_type);
} // PNG_oFFs_SUPPORTED

version (PNG_oFFs_SUPPORTED) {
   void png_set_oFFs(png_structp png_ptr,
         png_infop info_ptr,
         png_int_32 offset_x,
         png_int_32 offset_y,
         int unit_type);
} // PNG_oFFs_SUPPORTED

version (PNG_pCAL_SUPPORTED) {
   png_uint_32 png_get_pCAL(png_structp png_ptr,
         png_infop info_ptr,
         png_charp *purpose,
         png_int_32 *X0,
         png_int_32 *X1,
         int *type,
         int *nparams,
         png_charp *units,
         png_charpp *params);
} // PNG_pCAL_SUPPORTED

version (PNG_pCAL_SUPPORTED) {
   void png_set_pCAL(png_structp png_ptr,
         png_infop info_ptr,
         png_charp purpose,
         png_int_32 X0,
         png_int_32 X1,
         int type,
         int nparams,
         png_charp units,
         png_charpp params);
} // PNG_pCAL_SUPPORTED

version (PNG_pHYs_SUPPORTED) {
   png_uint_32 png_get_pHYs(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 *res_x,
         png_uint_32 *res_y,
         int *unit_type);
} // PNG_pHYs_SUPPORTED

version (PNG_pHYs_SUPPORTED) {
   void png_set_pHYs(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 res_x,
         png_uint_32 res_y,
         int unit_type);
} // PNG_pHYs_SUPPORTED

png_uint_32 png_get_PLTE(png_structp png_ptr,
      png_infop info_ptr,
      png_colorp *palette,
      int *num_palette);

void png_set_PLTE(png_structp png_ptr,
      png_infop info_ptr,
      png_colorp palette,
      int num_palette);

version (PNG_sBIT_SUPPORTED) {
   png_uint_32 png_get_sBIT(png_structp png_ptr,
         png_infop info_ptr,
         png_color_8p *sig_bit);
} // PNG_sBIT_SUPPORTED

version (PNG_sBIT_SUPPORTED) {
   void png_set_sBIT(png_structp png_ptr,
         png_infop info_ptr,
         png_color_8p sig_bit);
} // PNG_sBIT_SUPPORTED

version (PNG_sRGB_SUPPORTED) {
   png_uint_32 png_get_sRGB(png_structp png_ptr,
         png_infop info_ptr,
         int *intent);
} // PNG_sRGB_SUPPORTED

version (PNG_sRGB_SUPPORTED) {
   void png_set_sRGB(png_structp png_ptr, png_infop info_ptr, int intent);
   void png_set_sRGB_gAMA_and_cHRM(png_structp png_ptr,
         png_infop info_ptr,
         int intent);
} // PNG_sRGB_SUPPORTED

version (PNG_iCCP_SUPPORTED) {
   png_uint_32 png_get_iCCP(png_structp png_ptr,
         png_infop info_ptr,
         png_charpp name,
         int *compression_type,
         png_charpp profile,
         png_uint_32 *proflen);
   /* Note to maintainer: profile should be png_bytepp */
} // PNG_iCCP_SUPPORTED

version (PNG_iCCP_SUPPORTED) {
   void png_set_iCCP(png_structp png_ptr,
         png_infop info_ptr,
         png_charp name,
         int compression_type,
         png_charp profile,
         png_uint_32 proflen);
   /* Note to maintainer: profile should be png_bytep */
} // PNG_iCCP_SUPPORTED

version (PNG_sPLT_SUPPORTED) {
   png_uint_32 png_get_sPLT(png_structp png_ptr,
         png_infop info_ptr,
         png_sPLT_tpp entries);
} // PNG_sPLT_SUPPORTED

version (PNG_sPLT_SUPPORTED) {
   void png_set_sPLT(png_structp png_ptr,
         png_infop info_ptr,
         png_sPLT_tp entries,
         int nentries);
} // PNG_sPLT_SUPPORTED

version (PNG_TEXT_SUPPORTED) {
/* png_get_text also returns the number of text chunks in *num_text */
   png_uint_32 png_get_text(png_structp png_ptr,
         png_infop info_ptr,
         png_textp *text_ptr,
         int *num_text);
} // PNG_TEXT_SUPPORTED

/*
 *  Note while png_set_text() will accept a structure whose text,
 *  language, and  translated keywords are NULL pointers, the structure
 *  returned by png_get_text will always contain regular
 *  zero-terminated C strings.  They might be empty strings but
 *  they will never be NULL pointers.
 */

version (PNG_TEXT_SUPPORTED) {
   void png_set_text(png_structp png_ptr,
         png_infop info_ptr,
         png_textp text_ptr,
         int num_text);
} // PNG_TEXT_SUPPORTED

version (PNG_tIME_SUPPORTED) {
   png_uint_32 png_get_tIME(png_structp png_ptr,
         png_infop info_ptr,
         png_timep *mod_time);
} // PNG_tIME_SUPPORTED

version (PNG_tIME_SUPPORTED) {
   void png_set_tIME(png_structp png_ptr,
         png_infop info_ptr,
         png_timep mod_time);
} // PNG_tIME_SUPPORTED

version (PNG_tRNS_SUPPORTED) {
   png_uint_32 png_get_tRNS(png_structp png_ptr,
         png_infop info_ptr,
         png_bytep *trans,
         int *num_trans,
         png_color_16p *trans_values);
} // PNG_tRNS_SUPPORTED

version (PNG_tRNS_SUPPORTED) {
   void png_set_tRNS(png_structp png_ptr,
         png_infop info_ptr,
         png_bytep trans,
         int num_trans,
         png_color_16p trans_values);
} // PNG_tRNS_SUPPORTED

version (PNG_tRNS_SUPPORTED) {
}

version (PNG_sCAL_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      png_uint_32 png_get_sCAL(png_structp png_ptr,
            png_infop info_ptr,
            int *unit,
            double *width,
            double *height);
   } else {
      version (PNG_FIXED_POINT_SUPPORTED) {
         png_uint_32 png_get_sCAL_s(png_structp png_ptr,
               png_infop info_ptr,
               int *unit,
               png_charpp swidth,
               png_charpp sheight);
      } // PNG_FIXED_POINT_SUPPORTED
   } // PNG_FLOATING_POINT_SUPPORTED
} // PNG_sCAL_SUPPORTED

version (PNG_sCAL_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      void png_set_sCAL(png_structp png_ptr,
            png_infop info_ptr,
            int unit,
            double width,
            double height);
   } else {
      version (PNG_FIXED_POINT_SUPPORTED) {
         void png_set_sCAL_s(png_structp png_ptr,
               png_infop info_ptr,
               int unit,
               png_charp swidth,
               png_charp sheight);
      } // PNG_FIXED_POINT_SUPPORTED
   } // PNG_FLOATING_POINT_SUPPORTED
} // PNG_sCAL_SUPPORTED

version (PNG_HANDLE_AS_UNKNOWN_SUPPORTED) {
/* Provide a list of chunks and how they are to be handled, if the built-in
   handling or default unknown chunk handling is not desired.  Any chunks not
   listed will be handled in the default manner.  The IHDR and IEND chunks
   must not be listed.
      keep = 0: follow default behaviour
           = 1: do not keep
           = 2: keep only if safe-to-copy
           = 3: keep even if unsafe-to-copy
*/
   void  png_set_keep_unknown_chunks(png_structp png_ptr,
         int keep,
         png_bytep chunk_list,
         int num_chunks);
   int png_handle_as_unknown(png_structp png_ptr, png_bytep chunk_name);
} // PNG_HANDLE_AS_UNKNOWN_SUPPORTED

version (PNG_UNKNOWN_CHUNKS_SUPPORTED) {
   void png_set_unknown_chunks(png_structp png_ptr,
         png_infop info_ptr,
         png_unknown_chunkp unknowns,
         int num_unknowns);
   void png_set_unknown_chunk_location(png_structp png_ptr,
         png_infop info_ptr,
         int chunk,
         int location);
   png_uint_32 png_get_unknown_chunks(png_structp png_ptr,
         png_infop info_ptr,
         png_unknown_chunkpp entries);
} // PNG_UNKNOWN_CHUNKS_SUPPORTED

/* Png_free_data() will turn off the "valid" flag for anything it frees.
 * If you need to turn it off for a chunk that your application has freed,
 * you can use png_set_invalid(png_ptr, info_ptr, PNG_INFO_CHNK);
 */
void  png_set_invalid(png_structp png_ptr, png_infop info_ptr, int mask); 

version (PNG_INFO_IMAGE_SUPPORTED) {
/* The "params" pointer is currently not used and is for future expansion. */
   void png_read_png(png_structp png_ptr,
         png_infop info_ptr,
         int transforms,
         png_voidp params);
   void png_write_png(png_structp png_ptr,
         png_infop info_ptr,
         int transforms,
         png_voidp params);
} // PNG_INFO_IMAGE_SUPPORTED

// /* Define PNG_DEBUG at compile time for debugging information.  Higher
//  * numbers for PNG_DEBUG mean more debugging information.  This has
//  * only been added since version 0.95 so it is not implemented throughout
//  * libpng yet, but more support will be added as needed.
//  */
// #ifdef PNG_DEBUG
// #if (PNG_DEBUG > 0)
// #if !defined(PNG_DEBUG_FILE) && defined(_MSC_VER)
// #include <crtdbg.h>
// #if (PNG_DEBUG > 1)
// #ifndef _DEBUG
// #  define _DEBUG
// #endif
// #ifndef png_debug
// #define png_debug(l,m)  _RPT0(_CRT_WARN,m PNG_STRING_NEWLINE)
// #endif
// #ifndef png_debug1
// #define png_debug1(l,m,p1)  _RPT1(_CRT_WARN,m PNG_STRING_NEWLINE,p1)
// #endif
// #ifndef png_debug2
// #define png_debug2(l,m,p1,p2) _RPT2(_CRT_WARN,m PNG_STRING_NEWLINE,p1,p2)
// #endif
// #endif
// #else /* PNG_DEBUG_FILE || !_MSC_VER */
// #ifndef PNG_DEBUG_FILE
// #define PNG_DEBUG_FILE stderr
// #endif /* PNG_DEBUG_FILE */
//
// #if (PNG_DEBUG > 1)
// /* Note: ["%s"m PNG_STRING_NEWLINE] probably does not work on non-ISO
//  * compilers.
//  */
// #  ifdef __STDC__
// #    ifndef png_debug
// #      define png_debug(l,m) \
//        { \
//        int num_tabs=l; \
//        fprintf(PNG_DEBUG_FILE,"%s"m PNG_STRING_NEWLINE,(num_tabs==1 ? "\t" : \
//          (num_tabs==2 ? "\t\t":(num_tabs>2 ? "\t\t\t":"")))); \
//        }
// #    endif
// #    ifndef png_debug1
// #      define png_debug1(l,m,p1) \
//        { \
//        int num_tabs=l; \
//        fprintf(PNG_DEBUG_FILE,"%s"m PNG_STRING_NEWLINE,(num_tabs==1 ? "\t" : \
//          (num_tabs==2 ? "\t\t":(num_tabs>2 ? "\t\t\t":""))),p1); \
//        }
// #    endif
// #    ifndef png_debug2
// #      define png_debug2(l,m,p1,p2) \
//        { \
//        int num_tabs=l; \
//        fprintf(PNG_DEBUG_FILE,"%s"m PNG_STRING_NEWLINE,(num_tabs==1 ? "\t" : \
//          (num_tabs==2 ? "\t\t":(num_tabs>2 ? "\t\t\t":""))),p1,p2); \
//        }
// #    endif
// #  else /* __STDC __ */
// #    ifndef png_debug
// #      define png_debug(l,m) \
//        { \
//        int num_tabs=l; \
//        char format[256]; \
//        snprintf(format,256,"%s%s%s",(num_tabs==1 ? "\t" : \
//          (num_tabs==2 ? "\t\t":(num_tabs>2 ? "\t\t\t":""))), \
//          m,PNG_STRING_NEWLINE); \
//        fprintf(PNG_DEBUG_FILE,format); \
//        }
// #    endif
// #    ifndef png_debug1
// #      define png_debug1(l,m,p1) \
//        { \
//        int num_tabs=l; \
//        char format[256]; \
//        snprintf(format,256,"%s%s%s",(num_tabs==1 ? "\t" : \
//          (num_tabs==2 ? "\t\t":(num_tabs>2 ? "\t\t\t":""))), \
//          m,PNG_STRING_NEWLINE); \
//        fprintf(PNG_DEBUG_FILE,format,p1); \
//        }
// #    endif
// #    ifndef png_debug2
// #      define png_debug2(l,m,p1,p2) \
//        { \
//        int num_tabs=l; \
//        char format[256]; \
//        snprintf(format,256,"%s%s%s",(num_tabs==1 ? "\t" : \
//          (num_tabs==2 ? "\t\t":(num_tabs>2 ? "\t\t\t":""))), \
//          m,PNG_STRING_NEWLINE); \
//        fprintf(PNG_DEBUG_FILE,format,p1,p2); \
//        }
// #    endif
// #  endif /* __STDC __ */
// #endif /* (PNG_DEBUG > 1) */
//
// #endif /* _MSC_VER */
// #endif /* (PNG_DEBUG > 0) */
// #endif /* PNG_DEBUG */
// #ifndef png_debug
// #define png_debug(l, m)
// #endif
// #ifndef png_debug1
// #define png_debug1(l, m, p1)
// #endif
// #ifndef png_debug2
// #define png_debug2(l, m, p1, p2)
// #endif

png_charp png_get_copyright(png_structp png_ptr);
png_charp png_get_header_ver(png_structp png_ptr);
png_charp png_get_header_version(png_structp png_ptr);
png_charp png_get_libpng_ver(png_structp png_ptr);

version (PNG_MNG_FEATURES_SUPPORTED) {
   png_uint_32 png_permit_mng_features(png_structp png_ptr,
         png_uint_32 mng_features_permitted);
} // PNG_MNG_FEATURES_SUPPORTED

/* For use in png_set_keep_unknown, added to version 1.2.6 */
enum PNG_HANDLE_CHUNK_AS_DEFAULT = 0;
enum PNG_HANDLE_CHUNK_NEVER =      1;
enum PNG_HANDLE_CHUNK_IF_SAFE =    2;
enum PNG_HANDLE_CHUNK_ALWAYS =     3;

/* Added to version 1.2.0 */
version (PNG_ASSEMBLER_CODE_SUPPORTED) {
   version (PNG_MMX_CODE_SUPPORTED) {
      enum PNG_ASM_FLAG_MMX_SUPPORT_COMPILED =  0x01;  /* not user-settable */
      enum PNG_ASM_FLAG_MMX_SUPPORT_IN_CPU =    0x02;  /* not user-settable */
      enum PNG_ASM_FLAG_MMX_READ_COMBINE_ROW =  0x04;
      enum PNG_ASM_FLAG_MMX_READ_INTERLACE =    0x08;
      enum PNG_ASM_FLAG_MMX_READ_FILTER_SUB =   0x10;
      enum PNG_ASM_FLAG_MMX_READ_FILTER_UP =    0x20;
      enum PNG_ASM_FLAG_MMX_READ_FILTER_AVG =   0x40;
      enum PNG_ASM_FLAG_MMX_READ_FILTER_PAETH = 0x80;
      enum PNG_ASM_FLAGS_INITIALIZED =          0x80000000;  /* not user-settable */

      enum PNG_MMX_READ_FLAGS = ( PNG_ASM_FLAG_MMX_READ_COMBINE_ROW
                                | PNG_ASM_FLAG_MMX_READ_INTERLACE
                                | PNG_ASM_FLAG_MMX_READ_FILTER_SUB
                                | PNG_ASM_FLAG_MMX_READ_FILTER_UP
                                | PNG_ASM_FLAG_MMX_READ_FILTER_AVG
                                | PNG_ASM_FLAG_MMX_READ_FILTER_PAETH );

      enum PNG_MMX_WRITE_FLAGS = 0;

      enum PNG_MMX_FLAGS = ( PNG_ASM_FLAG_MMX_SUPPORT_COMPILED
                           | PNG_ASM_FLAG_MMX_SUPPORT_IN_CPU
                           | PNG_MMX_READ_FLAGS
                           | PNG_MMX_WRITE_FLAGS );

      enum PNG_SELECT_READ =  1;
      enum PNG_SELECT_WRITE = 2;
   } // PNG_MMX_CODE_SUPPORTED

   version (PNG_1_0_X) {
      /* pngget.c */
      png_uint_32 png_get_mmx_flagmask(int flag_select, int *compilerID);

      /* pngget.c */
      png_uint_32 png_get_asm_flagmask(int flag_select);

      /* pngget.c */
      png_uint_32 png_get_asm_flags(png_structp png_ptr);

      /* pngget.c */
      png_byte png_get_mmx_bitdepth_threshold(png_structp png_ptr);

      /* pngget.c */
      png_uint_32 png_get_mmx_rowbytes_threshold(png_structp png_ptr);

      /* pngset.c */
      void png_set_asm_flags(png_structp png_ptr, png_uint_32 asm_flags);

      /* pngset.c */
      void png_set_mmx_thresholds(png_structp png_ptr,
            png_byte mmx_bitdepth_threshold,
            png_uint_32 mmx_rowbytes_threshold);

   } // PNG_1_0_X

   version (PNG_1_0_X) {
      /* png.c, pnggccrd.c, or pngvcrd.c */
      int png_mmx_support();
   } // PNG_1_0_X
} // PNG_ASSEMBLER_CODE_SUPPORTED

/* Strip the prepended error numbers ("#nnn ") from error and warning
 * messages before passing them to the error or warning handler.
 */
version (PNG_ERROR_NUMBERS_SUPPORTED) {
   void png_set_strip_error_numbers(png_structp png_ptr, png_uint_32 strip_mode);
} // PNG_ERROR_NUMBERS_SUPPORTED

/* Added at libpng-1.2.6 */
version (PNG_SET_USER_LIMITS_SUPPORTED) {
   void png_set_user_limits(png_structp png_ptr,
         png_uint_32 user_width_max,
         png_uint_32 user_height_max);
   png_uint_32 png_get_user_width_max(png_structp png_ptr);
   png_uint_32 png_get_user_height_max(png_structp png_ptr);
} // PNG_SET_USER_LIMITS_SUPPORTED
/* Maintainer: Put new public prototypes here ^, in libpng.3, and in
 * project defs
 */

version (PNG_READ_COMPOSITE_NODIV_SUPPORTED) {
/* With these routines we avoid an integer divide, which will be slower on
 * most machines.  However, it does take more operations than the corresponding
 * divide method, so it may be slower on a few RISC systems.  There are two
 * shifts (by 8 or 16 bits) and an addition, versus a single integer divide.
 *
 * Note that the rounding factors are NOT supposed to be the same!  128 and
 * 32768 are correct for the NODIV code; 127 and 32767 are correct for the
 * standard method.
 *
 * [Optimized code by Greg Roelofs and Mark Adler...blame us for bugs. :-) ]
 */

 /* fg and bg should be in `gamma 1.0' space; alpha is the opacity          */
   png_byte png_composite(T)(out T composite,
         png_uint_16 fg,
         png_uint_16 alpha,
         png_uint_16 bg)
   {
      png_uint_16 temp = fg * alpha + bg * (255 - alpha) + 128;
      return composite = cast(png_byte)((temp + (temp >> 8)) >> 8);
   }

   png_uint_16 png_composite_16(T)(out T composite,
         png_uint_32 fg,
         png_uint_32 alpha,
         png_uint_32 bg)
   {
      png_uint_32 temp = fg * alpha + bg * (65535 - alpha) + 32768;
      return composite = cast(png_uint_16)((temp + (temp >> 16)) >> 16);
   }
} else {  /* Standard method using integer division */
   png_byte png_composite(T)(out T composite,
         pnt_uint_16 fg,
         png_uint_16 alpha,
         png_uint_16 bg)
   {
      return composite =
         cast(png_byte)((fg * alpha + bg * (255 - alpha) + 127) / 255);
   }

   png_uint_16 png_composite_16(T)(out T composite,
         png_uint_16 fg,
         png_uint_16 alpha,
         png_uint_16 bg)
   {
      return composite =
         cast(png_uint_16)((fg * alpha + bg * (65535 - alpha) + 32767) / 65535);
   }
} // PNG_READ_COMPOSITE_NODIV_SUPPORTED

/* Inline macros to do direct reads of bytes from the input buffer.  These
 * require that you are using an architecture that uses PNG byte ordering
 * (MSB first) and supports unaligned data storage.  I think that PowerPC
 * in big-endian mode and 680x0 are the only ones that will support this.
 * The x86 line of processors definitely do not.  The png_get_int_32()
 * routine also assumes we are using two's complement format for negative
 * values, which is almost certainly true.
 */
version (PNG_READ_BIG_ENDIAN_SUPPORTED) {
   png_uint_32 png_get_uint_32(buf) { return *cast(png_uint_32p)(buf); }
   png_uint_16 png_get_uint_16(buf) { return *cast(png_uint_16p)(buf); }
   png_int_32 png_get_int_32(buf) { return *cast(png_int_32p)(buf); }
} else {
   png_uint_32 png_get_uint_32(png_bytep buf);
   png_uint_16 png_get_uint_16(png_bytep buf);
   png_int_32 png_get_int_32(png_bytep buf);
} // PNG_READ_BIG_ENDIAN_SUPPORTED

png_uint_32 png_get_uint_31(png_structp png_ptr, png_bytep buf);
/* No png_get_int_16 -- may be added if there's a real need for it. */

/* Place a 32-bit number into a buffer in PNG byte order (big-endian).
 */
void png_save_uint_32(png_bytep buf, png_uint_32 i);
void png_save_int_32(png_bytep buf, png_int_32 i);

/* Place a 16-bit number into a buffer in PNG byte order.
 * The parameter is declared unsigned int, not png_uint_16,
 * just to avoid potential problems on pre-ANSI C compilers.
 */
void png_save_uint_16(png_bytep buf, uint i);
/* No png_save_int_16 -- may be added if there's a real need for it. */

/* ************************************************************************* */

/* These next functions are used internally in the code.  They generally
 * shouldn't be used unless you are writing code to add or replace some
 * functionality in libpng.  More information about most functions can
 * be found in the files where the functions are located.
 */


/* Various modes of operation, that are visible to applications because
 * they are used for unknown chunk location.
 */
enum PNG_HAVE_IHDR =             0x01;
enum PNG_HAVE_PLTE =             0x02;
enum PNG_HAVE_IDAT =             0x04;
enum PNG_AFTER_IDAT =            0x08; /* Have complete zlib datastream */
enum PNG_HAVE_IEND =             0x10;

version (PNG_INTERNAL) {

/* More modes of operation.  Note that after an init, mode is set to
 * zero automatically when the structure is created.
 */
enum PNG_HAVE_gAMA =               0x20;
enum PNG_HAVE_cHRM =               0x40;
enum PNG_HAVE_sRGB =               0x80;
enum PNG_HAVE_CHUNK_HEADER =      0x100;
enum PNG_WROTE_tIME =             0x200;
enum PNG_WROTE_INFO_BEFORE_PLTE = 0x400;
enum PNG_BACKGROUND_IS_GRAY =     0x800;
enum PNG_HAVE_PNG_SIGNATURE =    0x1000;
enum PNG_HAVE_CHUNK_AFTER_IDAT = 0x2000; /* Have another chunk after IDAT */

/* Flags for the transformations the PNG library does on the image data */
enum PNG_BGR =                  0x0001;
enum PNG_INTERLACE =            0x0002;
enum PNG_PACK =                 0x0004;
enum PNG_SHIFT =                0x0008;
enum PNG_SWAP_BYTES =           0x0010;
enum PNG_INVERT_MONO =          0x0020;
enum PNG_DITHER =               0x0040;
enum PNG_BACKGROUND =           0x0080;
enum PNG_BACKGROUND_EXPAND =    0x0100;
                             /* 0x0200 unused */
enum PNG_16_TO_8 =              0x0400;
enum PNG_RGBA =                 0x0800;
enum PNG_EXPAND =               0x1000;
enum PNG_GAMMA =                0x2000;
enum PNG_GRAY_TO_RGB =          0x4000;
enum PNG_FILLER =               0x8000;
enum PNG_PACKSWAP =            0x10000;
enum PNG_SWAP_ALPHA =          0x20000;
enum PNG_STRIP_ALPHA =         0x40000;
enum PNG_INVERT_ALPHA =        0x80000;
enum PNG_USER_TRANSFORM =     0x100000;
enum PNG_RGB_TO_GRAY_ERR =    0x200000;
enum PNG_RGB_TO_GRAY_WARN =   0x400000;
enum PNG_RGB_TO_GRAY =        0x600000;  /* two bits, RGB_TO_GRAY_ERR|WARN */
                           /* 0x800000 unused */
enum PNG_ADD_ALPHA =         0x1000000;  /* Added to libpng-1.2.7 */
enum PNG_EXPAND_tRNS =       0x2000000;  /* Added to libpng-1.2.9 */
enum PNG_PREMULTIPLY_ALPHA = 0x4000000;  /* Added to libpng-1.2.41 */
                                            /* by volker */
                            /*  0x8000000 unused */
                            /* 0x10000000 unused */
                            /* 0x20000000 unused */
                            /* 0x40000000 unused */

/* Flags for png_create_struct */
enum PNG_STRUCT_PNG =  0x0001;
enum PNG_STRUCT_INFO = 0x0002;

/* Scaling factor for filter heuristic weighting calculations */
enum PNG_WEIGHT_SHIFT = 8;
enum PNG_WEIGHT_FACTOR = (1<<(PNG_WEIGHT_SHIFT));
enum PNG_COST_SHIFT = 3;
enum PNG_COST_FACTOR = (1<<(PNG_COST_SHIFT));

/* Flags for the png_ptr->flags rather than declaring a byte for each one */
enum PNG_FLAG_ZLIB_CUSTOM_STRATEGY =    0x0001;
enum PNG_FLAG_ZLIB_CUSTOM_LEVEL =       0x0002;
enum PNG_FLAG_ZLIB_CUSTOM_MEM_LEVEL =   0x0004;
enum PNG_FLAG_ZLIB_CUSTOM_WINDOW_BITS = 0x0008;
enum PNG_FLAG_ZLIB_CUSTOM_METHOD =      0x0010;
enum PNG_FLAG_ZLIB_FINISHED =           0x0020;
enum PNG_FLAG_ROW_INIT =                0x0040;
enum PNG_FLAG_FILLER_AFTER =            0x0080;
enum PNG_FLAG_CRC_ANCILLARY_USE =       0x0100;
enum PNG_FLAG_CRC_ANCILLARY_NOWARN =    0x0200;
enum PNG_FLAG_CRC_CRITICAL_USE =        0x0400;
enum PNG_FLAG_CRC_CRITICAL_IGNORE =     0x0800;
enum PNG_FLAG_FREE_PLTE =               0x1000;
enum PNG_FLAG_FREE_TRNS =               0x2000;
enum PNG_FLAG_FREE_HIST =               0x4000;
enum PNG_FLAG_KEEP_UNKNOWN_CHUNKS =     0x8000;
enum PNG_FLAG_KEEP_UNSAFE_CHUNKS =      0x10000;
enum PNG_FLAG_LIBRARY_MISMATCH =        0x20000;
enum PNG_FLAG_STRIP_ERROR_NUMBERS =     0x40000;
enum PNG_FLAG_STRIP_ERROR_TEXT =        0x80000;
enum PNG_FLAG_MALLOC_NULL_MEM_OK =      0x100000;
enum PNG_FLAG_ADD_ALPHA =               0x200000;  /* Added to libpng-1.2.8 */
enum PNG_FLAG_STRIP_ALPHA =             0x400000;  /* Added to libpng-1.2.8 */
                                /*      0x800000  unused */
                                /*     0x1000000  unused */
                                /*     0x2000000  unused */
                                /*     0x4000000  unused */
                                /*     0x8000000  unused */
                                /*    0x10000000  unused */
                                /*    0x20000000  unused */
                                /*    0x40000000  unused */

enum PNG_FLAG_CRC_ANCILLARY_MASK = PNG_FLAG_CRC_ANCILLARY_USE |
                                   PNG_FLAG_CRC_ANCILLARY_NOWARN;

enum PNG_FLAG_CRC_CRITICAL_MASK = PNG_FLAG_CRC_CRITICAL_USE |
                                  PNG_FLAG_CRC_CRITICAL_IGNORE;

enum PNG_FLAG_CRC_MASK = PNG_FLAG_CRC_ANCILLARY_MASK |
                         PNG_FLAG_CRC_CRITICAL_MASK;

// /* Save typing and make code easier to understand */
// 
// #define PNG_COLOR_DIST(c1, c2) (abs((int)((c1).red) - (int)((c2).red)) + \
//    abs((int)((c1).green) - (int)((c2).green)) + \
//    abs((int)((c1).blue) - (int)((c2).blue)))

/* Added to libpng-1.2.6 JB */
auto PNG_ROWBYTES(png_uint_32 pixel_bits, auto width) {
   if (pixel_bits >= 8) {
      return width * (pixel_bits >> 3);
   } else {
      return (width * pixel_bits + 7) >> 3;
   }
}

/* PNG_OUT_OF_RANGE returns true if value is outside the range
 * ideal-delta..ideal+delta.  Each argument is evaluated twice.
 * "ideal" and "delta" should be constants, normally simple
 * integers, "value" a variable. Added to libpng-1.2.6 JB
 */
auto PNG_OUT_OF_RANGE(auto value, auto ideal, auto delta) {
   return value < (ideal - delta) || value > (ideal + delta);
}

/* Variables declared in png.c - only it needs to define PNG_NO_EXTERN */
version (PNG_NO_EXTERN) {
} else version (PNG_ALWAYS_EXTERN) {
   extern const png_byte png_sig[8];
} else {
   extern const png_byte png_sig[8];
}

/* Constant strings for known chunk types.  If you need to add a chunk,
 * define the name here, and add an invocation of the macro in png.c and
 * wherever it's needed.
 */
png_byte[5] PNG_IHDR() { return [ 73,  72,  68,  82, '\0']; }
png_byte[5] PNG_IDAT() { return [ 73,  68,  65,  84, '\0']; }
png_byte[5] PNG_IEND() { return [ 73,  69,  78,  68, '\0']; }
png_byte[5] PNG_PLTE() { return [ 80,  76,  84,  69, '\0']; }
png_byte[5] PNG_bKGD() { return [ 98,  75,  71,  68, '\0']; }
png_byte[5] PNG_cHRM() { return [ 99,  72,  82,  77, '\0']; }
png_byte[5] PNG_gAMA() { return [103,  65,  77,  65, '\0']; }
png_byte[5] PNG_hIST() { return [104,  73,  83,  84, '\0']; }
png_byte[5] PNG_iCCP() { return [105,  67,  67,  80, '\0']; }
png_byte[5] PNG_iTXt() { return [105,  84,  88, 116, '\0']; }
png_byte[5] PNG_oFFs() { return [111,  70,  70, 115, '\0']; }
png_byte[5] PNG_pCAL() { return [112,  67,  65,  76, '\0']; }
png_byte[5] PNG_sCAL() { return [115,  67,  65,  76, '\0']; }
png_byte[5] PNG_pHYs() { return [112,  72,  89, 115, '\0']; }
png_byte[5] PNG_sBIT() { return [115,  66,  73,  84, '\0']; }
png_byte[5] PNG_sPLT() { return [115,  80,  76,  84, '\0']; }
png_byte[5] PNG_sRGB() { return [115,  82,  71,  66, '\0']; }
png_byte[5] PNG_tEXt() { return [116,  69,  88, 116, '\0']; }
png_byte[5] PNG_tIME() { return [116,  73,  77,  69, '\0']; }
png_byte[5] PNG_tRNS() { return [116,  82,  78,  83, '\0']; }
png_byte[5] PNG_zTXt() { return [122,  84,  88, 116, '\0']; }

version (PNG_USE_GLOBAL_ARRAYS) {
   extern png_byte png_ihdr[5];
   extern png_byte png_idat[5];
   extern png_byte png_iend[5];
   extern png_byte png_plte[5];
   extern png_byte png_bkgd[5];
   extern png_byte png_chrm[5];
   extern png_byte png_gama[5];
   extern png_byte png_hist[5];
   extern png_byte png_iccp[5];
   extern png_byte png_itxt[5];
   extern png_byte png_offs[5];
   extern png_byte png_pcal[5];
   extern png_byte png_scal[5];
   extern png_byte png_phys[5];
   extern png_byte png_sbit[5];
   extern png_byte png_splt[5];
   extern png_byte png_srgb[5];
   extern png_byte png_text[5];
   extern png_byte png_time[5];
   extern png_byte png_trns[5];
   extern png_byte png_ztxt[5];
} // png_use_global_arrays

version (PNG_1_0_X) {
   /* Initialize png_ptr struct for reading, and allocate any other memory.
    * (old interface - DEPRECATED - use png_create_read_struct instead).
    */
   void png_read_init(png_structp png_ptr) {
      png_read_init_3(&png_ptr, PNG_LIBPNG_VER_STRING, png_sizeof(png_struct));
   }
} else version (PNG_1_2_X) {
   void png_read_init(png_structp png_ptr) {
      png_read_init_3(&png_ptr, PNG_LIBPNG_VER_STRING, png_sizeof(png_struct));
   }
} // PNG_1_2_X

void png_read_init_3(png_structpp ptr_ptr,
      png_const_charp user_png_ver,
      png_size_t png_struct_size);

version (PNG_1_0_X) {
   void png_read_init_2(png_structp png_ptr,
         png_const_charp user_png_ver,
         png_size_t png_struct_size,
         png_size_t png_info_size);
} else version (PNG_1_2_X) {
   void png_read_init_2(png_structp png_ptr,
         png_const_charp user_png_ver,
         png_size_t png_struct_size,
         png_size_t png_info_size);
} // PNG_1_2_X

version (PNG_1_0_X) {
   /* Initialize png_ptr struct for writing, and allocate any other memory.
    * (old interface - DEPRECATED - use png_create_write_struct instead).
    */
   void png_write_init(png_ptr) {
      png_write_init_3(&png_ptr, PNG_LIBPNG_VER_STRING, png_sizeof(png_struct));
   }
} else version (PNG_1_2_X) {
   void png_write_init(png_ptr) {
      png_write_init_3(&png_ptr, PNG_LIBPNG_VER_STRING, png_sizeof(png_struct));
   }
} // PNG_1_2_X

void png_write_init_3(png_structpp ptr_ptr,
      png_const_charp user_png_ver,
      png_size_t png_struct_size);
void png_write_init_2(png_structp png_ptr,
      png_const_charp user_png_ver,
      png_size_t png_struct_size,
      png_size_t png_info_size);

/* Allocate memory for an internal libpng struct */
deprecated png_voidp png_create_struct(int type);

/* Free memory from internal libpng struct */
deprecated void png_destroy_struct(png_voidp struct_ptr);

deprecated png_voidp png_create_struct_2(int type,
      png_malloc_ptr malloc_fn,
      png_voidp mem_ptr);
deprecated void png_destroy_struct_2(png_voidp struct_ptr,
      png_free_ptr free_fn,
      png_voidp mem_ptr);

/* Free any memory that info_ptr points to and reset struct. */
deprecated void png_info_destroy(png_structp png_ptr, png_infop info_ptr);

version (PNG_1_0_X) {
   version (PNG_PROGRESSIVE_READ_SUPPORTED) {
      deprecated void png_push_fill_buffer(png_structp png_ptr,
            png_bytep buffer,
            png_size_t length);
   } // PNG_PROGRESSIVE_READ_SUPPORTED
} else {
   /* Function to allocate memory for zlib. */
   deprecated voidpf png_zalloc(voidpf png_ptr, uInt items, uInt size);

   /* Function to free memory for zlib */
   deprecated void png_zfree(voidpf png_ptr, voidpf ptr);

   version (PNG_SIZE_T) {
      /* Function to convert a sizeof an item to png_sizeof item */
      deprecated png_size_t png_convert_size(size_t size);
   } // PNG_SIZE_T

   /* Next four functions are used internally as callbacks.  PNGAPI is required
    * but not PNG_EXPORT.  PNGAPI added at libpng version 1.2.3.
    */

   deprecated void png_default_read_data(png_structp png_ptr,
         png_bytep data,
         png_size_t length);

   version (PNG_PROGRESSIVE_READ_SUPPORTED) {
      deprecated void png_push_fill_buffer(png_structp png_ptr,
            png_bytep buffer,
            png_size_t length);
   }

   deprecated void png_default_write_data(png_structp png_ptr,
         png_bytep data,
         png_size_t length);

   version (PNG_WRITE_FLUSH_SUPPORTED) {
      version (PNG_STDIO_SUPPORTED) {
         deprecated void png_default_flush(png_structp png_ptr);
      } // PNG_STDIO_SUPPORTED
   } // PNG_WRITE_FLUSH_SUPPORTED
} // !PNG_1_0_X

/* Reset the CRC variable */
deprecated void png_reset_crc(png_structp png_ptr);

/* Write the "data" buffer to whatever output you are using. */
deprecated void png_write_data(png_structp png_ptr, png_bytep data, png_size_t length);

/* Read data from whatever input you are using into the "data" buffer */
deprecated void png_read_data(png_structp png_ptr, png_bytep data, png_size_t length); 

/* Read bytes into buf, and update png_ptr->crc */
deprecated void png_crc_read(png_structp png_ptr, png_bytep buf, png_size_t length);

/* Decompress data in a chunk that uses compression */
version (PNG_zTXt_SUPPORTED) {
deprecated void png_decompress_chunk(png_structp png_ptr,
      int comp_type,
      png_size_t chunklength,
      png_size_t prefix_length,
      png_size_t *data_length);
} else version (PNG_iTXt_SUPPORTED) {
deprecated void png_decompress_chunk(png_structp png_ptr,
      int comp_type,
      png_size_t chunklength,
      png_size_t prefix_length,
      png_size_t *data_length);
} else version (PNG_iCCP_SUPPORTED) {
deprecated void png_decompress_chunk(png_structp png_ptr,
      int comp_type,
      png_size_t chunklength,
      png_size_t prefix_length,
      png_size_t *data_length);
} else version (PNG_sPLT_SUPPORTED) {
deprecated void png_decompress_chunk(png_structp png_ptr,
      int comp_type,
      png_size_t chunklength,
      png_size_t prefix_length,
      png_size_t *data_length);
} // PNG_sPLT_SUPPORTED

/* Read "skip" bytes, read the file crc, and (optionally) verify png_ptr->crc */
deprecated int png_crc_finish(png_structp png_ptr, png_uint_32 skip);

/* Read the CRC from the file and compare it to the libpng calculated CRC */
deprecated int png_crc_error(png_structp png_ptr);

/* Calculate the CRC over a section of data.  Note that we are only
 * passing a maximum of 64K on systems that have this as a memory limit,
 * since this is the maximum buffer size we can specify.
 */
deprecated void png_calculate_crc(png_structp png_ptr, png_bytep ptr, png_size_t length);

version (PNG_WRITE_FLUSH_SUPPORTED) {
   deprecated void png_flush(png_structp png_ptr);
} // PNG_WRITE_FLUSH_SUPPORTED

/* Simple function to write the signature */
deprecated void png_write_sig(png_structp png_ptr);

/* Write various chunks */

/* Write the IHDR chunk, and update the png_struct with the necessary
 * information.
 */
deprecated void png_write_IHDR(png_structp png_ptr,
      png_uint_32 width,
      png_uint_32 height,
      int bit_depth,
      int color_type,
      int compression_method,
      int filter_method,
      int interlace_method);

deprecated void png_write_PLTE(png_structp png_ptr,
      png_colorp palette,
      png_uint_32 num_pal);

deprecated void png_write_IDAT(png_structp png_ptr,
      png_bytep data,
      png_size_t length);

deprecated void png_write_IEND(png_structp png_ptr);

version (PNG_WRITE_gAMA_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      deprecated void png_write_gAMA(png_structp png_ptr, double file_gamma);
   } // PNG_FLOATING_POINT_SUPPORTED

   version (PNG_FIXED_POINT_SUPPORTED) {
      deprecated void png_write_gAMA_fixed(png_structp png_ptr,
            png_fixed_point file_gamma);
   } // PNG_FIXED_POINT_SUPPORTED
} // PNG_WRITE_gAMA_SUPPORTED

version (PNG_WRITE_sBIT_SUPPORTED) {
   deprecated void png_write_sBIT(png_structp png_ptr,
         png_color_8p sbit,
         int color_type);
} // PNG_WRITE_sBIT_SUPPORTED

version (PNG_WRITE_cHRM_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      deprecated void png_write_cHRM(png_structp png_ptr,
            double white_x,
            double white_y,
            double red_x,
            double red_y,
            double green_x,
            double green_y,
            double blue_x,
            double blue_y);
   } // PNG_FLOATING_POINT_SUPPORTED

   version (PNG_FIXED_POINT_SUPPORTED) {
      deprecated void png_write_cHRM_fixed(png_structp png_ptr,
            png_fixed_point int_white_x,
            png_fixed_point int_white_y,
            png_fixed_point int_red_x,
            png_fixed_point int_red_y,
            png_fixed_point
            int_green_x,
            png_fixed_point int_green_y,
            png_fixed_point int_blue_x,
            png_fixed_point int_blue_y);
   } // PNG_FIXED_POINT_SUPPORTED
} // PNG_WRITE_cHRM_SUPPORTED

version (PNG_WRITE_sRGB_SUPPORTED) {
   deprecated void png_write_sRGB(png_structp png_ptr, int intent);
} // PNG_WRITE_sRGB_SUPPORTED

version (PNG_WRITE_iCCP_SUPPORTED) {
   deprecated void png_write_iCCP(png_structp png_ptr,
         png_charp name,
         int compression_type,
         png_charp profile,
         int proflen);
   /* Note to maintainer: profile should be png_bytep */
} // PNG_WRITE_iCCP_SUPPORTED

version (PNG_WRITE_sPLT_SUPPORTED) {
   deprecated void png_write_sPLT(png_structp png_ptr, png_sPLT_tp palette);
} // PNG_WRITE_sPLT_SUPPORTED

version (PNG_WRITE_tRNS_SUPPORTED) {
   deprecated void png_write_tRNS(png_structp png_ptr,
         png_bytep trans,
         png_color_16p values,
         int number,
         int color_type);
} // PNG_WRITE_tRNS_SUPPORTED

version (PNG_WRITE_bKGD_SUPPORTED) {
   void png_write_bKGD(png_structp png_ptr,
         png_color_16p values,
         int color_type);
} // PNG_WRITE_bKGD_SUPPORTED

version (PNG_WRITE_hIST_SUPPORTED) {
   deprecated void png_write_hIST(png_structp png_ptr, png_uint_16p hist, int num_hist);
} // PNG_WRITE_hIST_SUPPORTED

version (PNG_WRITE_TEXT_SUPPORTED) {
   deprecated png_size_t png_check_keyword(png_structp png_ptr,
         png_charp key,
         png_charpp new_key);
} else version (PNG_WRITE_pCAL_SUPPORTED) {
   deprecated png_size_t png_check_keyword(png_structp png_ptr,
         png_charp key,
         png_charpp new_key);
} else version (PNG_WRITE_iCCP_SUPPORTED) {
   deprecated png_size_t png_check_keyword(png_structp png_ptr,
         png_charp key,
         png_charpp new_key);
} else version (PNG_WRITE_sPLT_SUPPORTED) {
   deprecated png_size_t png_check_keyword(png_structp png_ptr,
         png_charp key,
         png_charpp new_key);
} // PNG_WRITE_sPLT_SUPPORTED

version (PNG_WRITE_tEXt_SUPPORTED) {
   deprecated void png_write_tEXt(png_structp png_ptr,
         png_charp key,
         png_charp text,
         png_size_t text_len);
} // PNG_WRITE_tEXt_SUPPORTED

version (PNG_WRITE_zTXt_SUPPORTED) {
   deprecated void png_write_zTXt(png_structp png_ptr,
         png_charp key,
         png_charp text,
         png_size_t text_len,
         int compression);
} // PNG_WRITE_zTXt_SUPPORTED

version (PNG_WRITE_iTXt_SUPPORTED) {
   deprecated void png_write_iTXt(png_structp png_ptr,
         int compression,
         png_charp key,
         png_charp lang,
         png_charp lang_key,
         png_charp text);
} // PNG_WRITE_iTXt_SUPPORTED

version (PNG_TEXT_SUPPORTED) { /* Added at version 1.0.14 and 1.2.4 */
   deprecated int png_set_text_2(png_structp png_ptr,
         png_infop info_ptr,
         png_textp text_ptr,
         int num_text);
} // PNG_TEXT_SUPPORTED

version (PNG_WRITE_oFFs_SUPPORTED) {
   deprecated void png_write_oFFs(png_structp png_ptr,
         png_int_32 x_offset,
         png_int_32 y_offset,
         int unit_type);
} // PNG_WRITE_oFFs_SUPPORTED

version (PNG_WRITE_pCAL_SUPPORTED) {
   deprecated void png_write_pCAL(png_structp png_ptr,
         png_charp purpose,
         png_int_32 X0,
         png_int_32 X1,
         int type,
         int nparams,
         png_charp units,
         png_charpp params);
} // PNG_WRITE_pCAL_SUPPORTED

version (PNG_WRITE_pHYs_SUPPORTED) {
   deprecated void png_write_pHYs(png_structp png_ptr,
         png_uint_32 x_pixels_per_unit,
         png_uint_32 y_pixels_per_unit,
         int unit_type);
} // PNG_WRITE_pHYs_SUPPORTED

version (PNG_WRITE_tIME_SUPPORTED) {
   deprecated void png_write_tIME(png_structp png_ptr, png_timep mod_time);
} // PNG_WRITE_tIME_SUPPORTED

version (PNG_WRITE_sCAL_SUPPORTED) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      version (PNG_NO_STDIO) {
         version (PNG_FIXED_POINT_SUPPORTED) {
            deprecated void png_write_sCAL_s(png_structp png_ptr,
                  int unit,
                  png_charp width,
                  png_charp height);
         } // PNG_FIXED_POINT_SUPPORTED
      } else {
         deprecated void png_write_sCAL(png_structp png_ptr,
               int unit,
               double width,
               double height);
      } // !PNG_NO_STDIO
   } else {
      version (PNG_FIXED_POINT_SUPPORTED) {
         deprecated void png_write_sCAL_s(png_structp png_ptr,
               int unit,
               png_charp width,
               png_charp height);
      } // PNG_FIXED_POINT_SUPPORTED
   } // !PNG_FLOATING_POINT_SUPPORTED
} // PNG_WRITE_sCAL_SUPPORTED

/* Called when finished processing a row of data */
deprecated void png_write_finish_row(png_structp png_ptr);

/* Internal use only.   Called before first row of data */
deprecated void png_write_start_row(png_structp png_ptr);

version (PNG_READ_GAMMA_SUPPORTED) {
   deprecated void png_build_gamma_table(png_structp png_ptr);
} // PNG_READ_GAMMA_SUPPORTED

/* Combine a row of data, dealing with alpha, etc. if requested */
deprecated void png_combine_row(png_structp png_ptr, png_bytep row, int mask);

version (PNG_READ_INTERLACING_SUPPORTED) {
   /* Expand an interlaced row */
   /* OLD pre-1.0.9 interface:
   PNG_EXTERN void png_do_read_interlace PNGARG((png_row_infop row_info,
      png_bytep row, int pass, png_uint_32 transformations)) PNG_PRIVATE;
    */
   deprecated void png_do_read_interlace(png_structp png_ptr);
} // PNG_READ_INTERLACING_SUPPORTED

/* GRR TO DO (2.0 or whenever):  simplify other internal calling interfaces */

version (PNG_WRITE_INTERLACING_SUPPORTED) {
/* Grab pixels out of a row for an interlaced pass */
   deprecated void png_do_write_interlace(png_row_infop row_info,
         png_bytep row,
         int pass);
} // PNG_WRITE_INTERLACING_SUPPORTED

/* Unfilter a row */
deprecated void png_read_filter_row(png_structp png_ptr,
      png_row_infop row_info,
      png_bytep row,
      png_bytep prev_row,
      int filter);

/* Choose the best filter to use and filter the row data */
deprecated void png_write_find_filter(png_structp png_ptr, png_row_infop row_info);

/* Write out the filtered row. */
deprecated void png_write_filtered_row(png_structp png_ptr, png_bytep filtered_row);

/* Finish a row while reading, dealing with interlacing passes, etc. */
deprecated void png_read_finish_row(png_structp png_ptr);

/* Initialize the row buffers, etc. */
deprecated void png_read_start_row(png_structp png_ptr);

/* Optional call to update the users info structure */
deprecated void png_read_transform_info(png_structp png_ptr, png_infop info_ptr);

/* These are the functions that do the transformations */
version (PNG_READ_FILLER_SUPPORTED) {
   deprecated void png_do_read_filler(png_row_infop row_info,
         png_bytep row,
         png_uint_32 filler,
         png_uint_32 flags);
} // PNG_READ_FILLER_SUPPORTED

version (PNG_READ_SWAP_ALPHA_SUPPORTED) {
   deprecated void png_do_read_swap_alpha(png_row_infop row_info, png_bytep row);
} // PNG_READ_SWAP_ALPHA_SUPPORTED

version (PNG_WRITE_SWAP_ALPHA_SUPPORTED) {
   deprecated void png_do_write_swap_alpha(png_row_infop row_info, png_bytep row);
} // PNG_WRITE_SWAP_ALPHA_SUPPORTED

version (PNG_READ_INVERT_ALPHA_SUPPORTED) {
   deprecated void png_do_read_invert_alpha(png_row_infop row_info, png_bytep row);
} // PNG_READ_INVERT_ALPHA_SUPPORTED

version (PNG_WRITE_INVERT_ALPHA_SUPPORTED) {
   deprecated void png_do_write_invert_alpha(png_row_infop row_info, png_bytep row);
} // PNG_WRITE_INVERT_ALPHA_SUPPORTED

version (PNG_WRITE_FILLER_SUPPORTED) {
   deprecated void png_do_strip_filler(png_row_infop row_info,
         png_bytep row,
         png_uint_32 flags);
} else version (PNG_READ_STRIP_ALPHA_SUPPORTED) {
   deprecated void png_do_strip_filler(png_row_infop row_info,
         png_bytep row,
         png_uint_32 flags);
} // PNG_READ_STRIP_ALPHA_SUPPORTED

version (PNG_READ_SWAP_SUPPORTED) {
   deprecated void png_do_swap(png_row_infop row_info, png_bytep row);
} else version(PNG_WRITE_SWAP_SUPPORTED) {
   deprecated void png_do_swap(png_row_infop row_info, png_bytep row);
} // PNG_WRITE_SWAP_SUPPORTED

version (PNG_READ_PACKSWAP_SUPPORTED) {
   deprecated void png_do_packswap(png_row_infop row_info, png_bytep row);
} else version (PNG_WRITE_PACKSWAP_SUPPORTED) {
   deprecated void png_do_packswap(png_row_infop row_info, png_bytep row);
} // PNG_WRITE_PACKSWAP_SUPPORTED

version (PNG_READ_RGB_TO_GRAY_SUPPORTED) {
   deprecated int png_do_rgb_to_gray(png_structp png_ptr,
         png_row_infop row_info,
         png_bytep row);
} // PNG_READ_RGB_TO_GRAY_SUPPORTED

version (PNG_READ_GRAY_TO_RGB_SUPPORTED) {
   deprecated void png_do_gray_to_rgb(png_row_infop row_info, png_bytep row);
} // PNG_READ_GRAY_TO_RGB_SUPPORTED

version (PNG_READ_PACK_SUPPORTED) {
   deprecated void png_do_unpack(png_row_infop row_info, png_bytep row);
} // PNG_READ_PACK_SUPPORTED

version (PNG_READ_SHIFT_SUPPORTED) {
   deprecated void png_do_unshift(png_row_infop row_info,
         png_bytep row,
         png_color_8p sig_bits);
} // PNG_READ_SHIFT_SUPPORTED

version (PNG_READ_INVERT_SUPPORTED) {
   deprecated void png_do_invert(png_row_infop row_info, png_bytep row);
} else version (PNG_WRITE_INVERT_SUPPORTED) {
   deprecated void png_do_invert(png_row_infop row_info, png_bytep row);
} // PNG_WRITE_INVERT_SUPPORTED

version (PNG_READ_16_TO_8_SUPPORTED) {
   deprecated void png_do_chop(png_row_infop row_info, png_bytep row);
} // PNG_READ_16_TO_8_SUPPORTED

version (PNG_READ_DITHER_SUPPORTED) {
   deprecated void png_do_dither(png_row_infop row_info,
         png_bytep row,
         png_bytep palette_lookup,
         png_bytep dither_lookup);

   version (PNG_CORRECT_PALETTE_SUPPORTED) {
      deprecated void png_correct_palette(png_structp png_ptr,
            png_colorp palette,
            int num_palette);
   } // PNG_CORRECT_PALETTE_SUPPORTED
} // PNG_READ_DITHER_SUPPORTED

version (PNG_READ_BGR_SUPPORTED) {
   deprecated void png_do_bgr(png_row_infop row_info, png_bytep row);
} else version (PNG_WRITE_BGR_SUPPORTED) {
   deprecated void png_do_bgr(png_row_infop row_info, png_bytep row);
} // PNG_WRITE_BGR_SUPPORTED

version (PNG_WRITE_PACK_SUPPORTED) {
   deprecated void png_do_pack(png_row_infop row_info,
         png_bytep row,
         png_uint_32 bit_depth);
} // PNG_WRITE_PACK_SUPPORTED

version (PNG_WRITE_SHIFT_SUPPORTED) {
   deprecated void png_do_shift(png_row_infop row_info,
         png_bytep row,
         png_color_8p bit_depth);
} // PNG_WRITE_SHIFT_SUPPORTED

version (PNG_READ_BACKGROUND_SUPPORTED) {
   version (PNG_READ_GAMMA_SUPPORTED) {
      deprecated void png_do_background(png_row_infop row_info,
            png_bytep row,
            png_color_16p trans_values,
            png_color_16p background,
            png_color_16p background_1,
            png_bytep gamma_table,
            png_bytep gamma_from_1,
            png_bytep gamma_to_1,
            png_uint_16pp gamma_16,
            png_uint_16pp gamma_16_from_1,
            png_uint_16pp gamma_16_to_1,
            int gamma_shift);
   } else {
      deprecated void png_do_background(png_row_infop row_info,
            png_bytep row,
            png_color_16p trans_values,
            png_color_16p background);
   } // PNG_READ_GAMMA_SUPPORTED
} // PNG_READ_BACKGROUND_SUPPORTED

version (PNG_READ_GAMMA_SUPPORTED) {
   deprecated void png_do_gamma(png_row_infop row_info,
         png_bytep row,
         png_bytep gamma_table,
         png_uint_16pp gamma_16_table,
         int gamma_shift);
} // PNG_READ_GAMMA_SUPPORTED

version (PNG_READ_EXPAND_SUPPORTED) {
   deprecated void png_do_expand_palette(png_row_infop row_info,
         png_bytep row,
         png_colorp palette,
         png_bytep trans,
         int num_trans);
   deprecated void png_do_expand(png_row_infop row_info,
         png_bytep row,
         png_color_16p trans_value);
} // PNG_READ_EXPAND_SUPPORTED

/* The following decodes the appropriate chunks, and does error correction,
 * then calls the appropriate callback for the chunk if it is valid.
 */

/* Decode the IHDR chunk */
deprecated void png_handle_IHDR(png_structp png_ptr,
      png_infop info_ptr,
      png_uint_32 length);
deprecated void png_handle_PLTE(png_structp png_ptr,
      png_infop info_ptr,
      png_uint_32 length);
deprecated void png_handle_IEND(png_structp png_ptr,
      png_infop info_ptr,
      png_uint_32 length);

version (PNG_READ_bKGD_SUPPORTED) {
   deprecated void png_handle_bKGD(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_bKGD_SUPPORTED

version (PNG_READ_cHRM_SUPPORTED) {
   deprecated void png_handle_cHRM(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_cHRM_SUPPORTED

version (PNG_READ_gAMA_SUPPORTED) {
   deprecated void png_handle_gAMA(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_gAMA_SUPPORTED

version (PNG_READ_hIST_SUPPORTED) {
   deprecated void png_handle_hIST(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_hIST_SUPPORTED

version (PNG_READ_iCCP_SUPPORTED) {
   void png_handle_iCCP(png_structp png_ptr, png_infop info_ptr, png_uint_32 length);
} // PNG_READ_iCCP_SUPPORTED

version (PNG_READ_iTXt_SUPPORTED) {
   deprecated void png_handle_iTXt(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_iTXt_SUPPORTED

version (PNG_READ_oFFs_SUPPORTED) {
   deprecated void png_handle_oFFs(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_oFFs_SUPPORTED

version (PNG_READ_pCAL_SUPPORTED) {
   deprecated void png_handle_pCAL(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_pCAL_SUPPORTED

version (PNG_READ_pHYs_SUPPORTED) {
   deprecated void png_handle_pHYs(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_pHYs_SUPPORTED

version (PNG_READ_sBIT_SUPPORTED) {
   deprecated void png_handle_sBIT(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_sBIT_SUPPORTED

version (PNG_READ_sCAL_SUPPORTED) {
   deprecated void png_handle_sCAL(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_sCAL_SUPPORTED

version (PNG_READ_sPLT_SUPPORTED) {
   deprecated void png_handle_sPLT(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_sPLT_SUPPORTED

version (PNG_READ_sRGB_SUPPORTED) {
   deprecated void png_handle_sRGB(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_sRGB_SUPPORTED

version (PNG_READ_tEXt_SUPPORTED) {
   deprecated void png_handle_tEXt(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_tEXt_SUPPORTED

version (PNG_READ_tIME_SUPPORTED) {
   deprecated void png_handle_tIME(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_tIME_SUPPORTED

version (PNG_READ_tRNS_SUPPORTED) {
   deprecated void png_handle_tRNS(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_tRNS_SUPPORTED

version (PNG_READ_zTXt_SUPPORTED) {
   deprecated void png_handle_zTXt(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
} // PNG_READ_zTXt_SUPPORTED

deprecated void png_handle_unknown(png_structp png_ptr,
      png_infop info_ptr,
      png_uint_32 length);

deprecated void png_check_chunk_name(png_structp png_ptr, png_bytep chunk_name);

/* Handle the transformations for reading and writing */
deprecated void png_do_read_transformations(png_structp png_ptr);
deprecated void png_do_write_transformations(png_structp png_ptr);

deprecated void png_init_read_transformations(png_structp png_ptr);

version (PNG_PROGRESSIVE_READ_SUPPORTED) {
   deprecated void png_push_read_chunk(png_structp png_ptr, png_infop info_ptr);
   deprecated void png_push_read_sig (png_structp png_ptr, png_infop info_ptr);
   deprecated void png_push_check_crc(png_structp png_ptr);
   deprecated void png_push_crc_skip(png_structp png_ptr, png_uint_32 length);
   deprecated void png_push_crc_finish(png_structp png_ptr);
   deprecated void png_push_save_buffer(png_structp png_ptr);
   deprecated void png_push_restore_buffer(png_structp png_ptr,
         png_bytep buffer,
         png_size_t buffer_length);
   deprecated void png_push_read_IDAT(png_structp png_ptr);
   deprecated void png_process_IDAT_data(png_structp png_ptr,
         png_bytep buffer,
         png_size_t buffer_length);
   deprecated void png_push_process_row(png_structp png_ptr);
   deprecated void png_push_handle_unknown(png_structp png_ptr,
         png_infop info_ptr,
         png_uint_32 length);
   deprecated void png_push_have_info(png_structp png_ptr, png_infop info_ptr);
   deprecated void png_push_have_end(png_structp png_ptr, png_infop info_ptr);
   deprecated void png_push_have_row(png_structp png_ptr, png_bytep row);
   deprecated void png_push_read_end(png_structp png_ptr, png_infop info_ptr);
   deprecated void png_process_some_data(png_structp png_ptr, png_infop info_ptr);
   deprecated void png_read_push_finish_row(png_structp png_ptr);
   version (PNG_READ_tEXt_SUPPORTED) {
      deprecated void png_push_handle_tEXt(png_structp png_ptr,
            png_infop info_ptr,
            png_uint_32 length);
      deprecated void png_push_read_tEXt(png_structp png_ptr,
            png_infop info_ptr);
   } // PNG_READ_tEXt_SUPPORTED
   version (PNG_READ_zTXt_SUPPORTED) {
      deprecated void png_push_handle_zTXt(png_structp png_ptr,
            png_infop info_ptr,
            png_uint_32 length);
      deprecated void png_push_read_zTXt(png_structp png_ptr,
            png_infop info_ptr);
   } // PNG_READ_zTXt_SUPPORTED
   version (PNG_READ_iTXt_SUPPORTED) {
      deprecated void png_push_handle_iTXt(png_structp png_ptr,
            png_infop info_ptr,
            png_uint_32 length);
      deprecated void png_push_read_iTXt(png_structp png_ptr,
            png_infop info_ptr);
   } // PNG_READ_iTXt_SUPPORTED
} // PNG_PROGRESSIVE_READ_SUPPORTED

version (PNG_MNG_FEATURES_SUPPORTED) {
   deprecated void png_do_read_intrapixel(png_row_infop row_info, png_bytep row);
   deprecated void png_do_write_intrapixel(png_row_infop row_info, png_bytep row);
} // PNG_MNG_FEATURES_SUPPORTED

version (PNG_ASSEMBLER_CODE_SUPPORTED) {
   version (PNG_MMX_CODE_SUPPORTED) {
      /* png.c */ /* PRIVATE */
      deprecated void png_init_mmx_flags(png_structp png_ptr);
   } // PNG_MMX_CODE_SUPPORTED
} // PNG_ASSEMBLER_CODE_SUPPORTED

/* The following six functions will be exported in libpng-1.4.0. */
version (PNG_INCH_CONVERSIONS) {
   version (PNG_FLOATING_POINT_SUPPORTED) {
      png_uint_32 png_get_pixels_per_inch(png_structp png_ptr, png_infop info_ptr);
      png_uint_32 png_get_x_pixels_per_inch(png_structp png_ptr, png_infop info_ptr);
      png_uint_32 png_get_y_pixels_per_inch(png_structp png_ptr, png_infop info_ptr);
      float png_get_x_offset_inches(png_structp png_ptr, png_infop info_ptr);
      float png_get_y_offset_inches(png_structp png_ptr, png_infop info_ptr);

      version (PNG_pHYs_SUPPORTED) {
         png_uint_32 png_get_pHYs_dpi(png_structp png_ptr,
               png_infop info_ptr,
               png_uint_32 *res_x,
               png_uint_32 *res_y,
               int *unit_type);
      } // PNG_pHYs_SUPPORTED
   } // PNG_FLOATING_POINT_SUPPORTED
} // PNG_INCH_CONVERSIONS

/* Read the chunk header (length + type name) */
deprecated png_uint_32 png_read_chunk_header(png_structp png_ptr);

/* Added at libpng version 1.2.34 */
version (PNG_cHRM_SUPPORTED) {
   deprecated int png_check_cHRM_fixed(png_structp png_ptr,
         png_fixed_point int_white_x,
         png_fixed_point int_white_y,
         png_fixed_point int_red_x,
         png_fixed_point int_red_y,
         png_fixed_point int_green_x,
         png_fixed_point int_green_y,
         png_fixed_point int_blue_x,
         png_fixed_point int_blue_y);
} // PNG_cHRM_SUPPORTED

version (PNG_cHRM_SUPPORTED) {
   version (PNG_CHECK_cHRM_SUPPORTED) {
      /* Added at libpng version 1.2.34 */
      deprecated void png_64bit_product(long v1,
            long v2,
            ulong *hi_product,
            ulong *lo_product);
   } // PNG_CHECK_cHRM_SUPPORTED
} // PNG_cHRM_SUPPORTED

/* Added at libpng version 1.2.41 */
deprecated void png_check_IHDR(png_structp png_ptr,
      png_uint_32 width,
      png_uint_32 height,
      int bit_depth,
      int color_type,
      int interlace_type,
      int compression_type,
      int filter_type);

/* Added at libpng version 1.2.41 */
png_voidp png_calloc(png_structp png_ptr, png_uint_32 size);

/* Maintainer: Put new private prototypes here ^ and in libpngpf.3 */

} // PNG_INTERNAL;

} // extern (C)
} // !PNG_VERSION_INFO_ONLY
