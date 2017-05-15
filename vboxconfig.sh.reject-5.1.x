As of 2017-05-15 the vboxconfig.sh.patch does not apply to the
script from Oracle VirtualBox 5.1.x due to substantial upstream
changes.

To facilitate future investigation, here is a mis-merge diff,
thanks to "nikolam" for producing it.

/var/tmp/vbox$ diff -u vboxconfig-original.sh  vboxconfig-patched.sh  
--- vboxconfig-original.sh      2017-05-15 14:15:20.424709680 +0200
+++ vboxconfig-patched.sh       2017-05-15 14:10:26.672142724 +0200
@@ -1,7 +1,7 @@
 #!/bin/sh
 # $Id: vboxconfig.sh 109027 2016-07-22 18:04:30Z bird $
 ## @file
-# VirtualBox Configuration Script, Solaris host.
+# VirtualBox Configuration Script, Solaris (10, 11, 12, SXCE, illumos) host.
 #
 
 #
@@ -239,6 +239,9 @@
 # get_sysinfo()
 # cannot fail
 get_sysinfo()
+            # OI 151a8      "pkg://openindiana.org/system/kernel@0.5.11,5.11-0.151.1.8:20130721T133142Z"
+            # OI Hipster'15 "pkg://openindiana.org/system/kernel@0.5.11-2015.0.1.15135:20150621T130732Z"
+            # OmniOS Bloody "pkg://omnios/system/kernel@0.5.11,5.11-0.151015:20150519T142340Z"
 {
     # First check 'uname -v' and weed out the recognized, unofficial distros of Solaris
     STR_OSVER=`uname -v`
@@ -268,7 +271,7 @@
             #            or "pkg://solaris/system/kernel@0.5.11,5.11-0.175.0.0.0.1.0:20111012T032837Z"
             #            or "pkg://solaris/system/kernel@5.12-5.12.0.0.0.9.1.3.0:20121012T032837Z" [1]
             # [1]: The sed below doesn't handle this. It's instead parsed below in the PSARC/2012/240 case.
-            STR_KERN_MAJOR=`echo "$PKGFMRI" | sed 's/^.*\@//;s/\,.*//'`
+            STR_KERN_MAJOR=`echo "$PKGFMRI" | sed 's/^.*\@//;s/\,.*//;s/\-.*//'`
             if test ! -z "$STR_KERN_MAJOR"; then
                 # The format is "0.5.11" or "5.12"
                 # Let us just hardcode these for now, instead of trying to do things more generically. It's not
@@ -308,6 +311,16 @@
                         HOST_OS_MINORVERSION=`echo "$STR_KERN_MINOR" | cut -f2 -d'-' | cut -f6 -d'.'`
                     elif test "$HOST_OS_MAJORVERSION" -eq 11; then
                         HOST_OS_MINORVERSION=`echo "$STR_KERN_MINOR" | cut -f2 -d'-' | cut -f2 -d'.'`
+                        case "`uname -v`" in
+                            Generic_*) ;; # Sun/Oracle Solaris GA release
+                            snv_*) # OpenSolaris
+                                HOST_OS_MINORVERSION="`uname -v | sed 's/^snv_//'`" || \
+                                HOST_OS_MINORVERSION=0 ;;
+                            oi*|omnios*|illumos*) # More distros welcome
+                                infoprint "Detected an opensource Solaris descendant, assuming snv_151 compatibility"
+                                HOST_OS_MINORVERSION=151
+                                ;;
+                        esac
                     else
                         errorprint "Solaris kernel major version $HOST_OS_MAJORVERSION not supported."
                         exit 1
@@ -1407,5 +1420,124 @@
     exit 1
 esac
 
+<<<<<<<
 exit "$?"
 
+=======
+            #            or "pkg://solaris/system/kernel@5.12,5.11-5.12.0.0.0.4.1:20120908T030246Z"
+            #            or "pkg://solaris/system/kernel@0.5.11,5.11-0.175.0.0.0.1.0:20111012T032837Z"
+            # OI 151a8      "pkg://openindiana.org/system/kernel@0.5.11,5.11-0.151.1.8:20130721T133142Z"
+            # OI Hipster'15 "pkg://openindiana.org/system/kernel@0.5.11-2015.0.1.15135:20150621T130732Z"
+            # OmniOS Bloody "pkg://omnios/system/kernel@0.5.11,5.11-0.151015:20150519T142340Z"
+>>>>>>>
+<<<<<<<
+=======
+            STR_KERN_MAJOR=`echo "$PKGFMRI" | sed 's/^.*\@//;s/\,.*//;s/\-.*//'`
+            if test ! -z "$STR_KERN_MAJOR"; then
+                # The format is "0.5.11" or "5.12"
+                # Let us just hardcode these for now, instead of trying to do things more generically. It's not
+>>>>>>>
+<<<<<<<
+=======
+                        HOST_OS_MINORVERSION=`echo "$STR_KERN_MINOR" | cut -f2 -d'-' | cut -f6 -d'.'`
+                    elif test "$HOST_OS_MAJORVERSION" -eq 11; then
+                        HOST_OS_MINORVERSION=`echo "$STR_KERN_MINOR" | cut -f2 -d'-' | cut -f2 -d'.'`
+                        case "`uname -v`" in
+                            Generic_*) ;; # Sun/Oracle Solaris GA release
+                            snv_*) # OpenSolaris
+                                HOST_OS_MINORVERSION="`uname -v | sed 's/^snv_//'`" || \
+                                HOST_OS_MINORVERSION=0 ;;
+                            oi*|omnios*|illumos*) # More distros welcome
+                                infoprint "Detected an opensource Solaris descendant, assuming snv_151 compatibility"
+                                HOST_OS_MINORVERSION=151
+                                ;;
+                        esac
+                    else
+                        errorprint "Solaris kernel major version $HOST_OS_MAJORVERSION not supported."
+                        exit 1
+>>>>>>>
+<<<<<<<
+=======
+    else
+        HOST_OS_MAJORVERSION=`uname -r`
+        if test -z "$HOST_OS_MAJORVERSION" || test "$HOST_OS_MAJORVERSION" != "5.10";  then
+            case "`uname -v`" in
+                snv*) if grep "Solaris Express Community Edition snv_" $PKG_INSTALL_ROOT/etc/release 2>/dev/null; then
+                        infoprint "WARNING: Solaris SXCE detected... you really should upgrade!"
+                        infoprint "         Assuming that Solaris 10 methods are applicable."
+                        HOST_OS_MAJORVERSION=SXCE
+                      fi ;;
+            esac
+            if test "$HOST_OS_MAJORVERSION" != "SXCE"; then
+                # S11 without 'pkg'?? Something's wrong... bail.
+                errorprint "Solaris $HOST_OS_MAJORVERSION detected without executable $BIN_PKG !? I am confused."
+                exit 1
+            fi
+            HOST_OS_MAJORVERSION="11"
+            HOST_OS_MINORVERSION="`uname -v | sed 's/^snv_//'`" || \
+                HOST_OS_MINORVERSION=0
+        else
+            HOST_OS_MAJORVERSION="10"
+        fi
+
+        if test "$REMOTEINST" -eq 0; then
+            if test "$HOST_OS_MAJORVERSION" != 11 ; then
+                # Use uname to verify it's S10.
+                # Major version is S10, Minor version is no longer relevant (or used), use uname -v so it gets something
+                # like "Generic_blah" for purely cosmetic purposes
+                HOST_OS_MINORVERSION=`uname -v`
+            fi
+        else
+            # Remote installs from S10 local.
+            BIN_PKGCHK=`which pkgchk 2> /dev/null`
+>>>>>>>
+<<<<<<<
+=======
+
+            REMOTE_S10=`$BIN_PKGCHK -l -p /kernel/amd64/genunix $BASEDIR_PKGOPT 2> /dev/null | grep SUNWckr | tr -d ' \t'`
+            if test ! -z "$REMOTE_S10" && test "$REMOTE_S10" = "SUNWckr"; then
+                if test "$HOST_OS_MAJORVERSION" != 11 ; then
+                    HOST_OS_MAJORVERSION="10"
+                    HOST_OS_MINORVERSION=""
+                fi
+            else
+                errorprint "Remote target $PKG_INSTALL_ROOT is not Solaris 10 nor SXCE."
+                errorprint "Will not attempt to install to an unidentified remote target."
+                exit 1
+            fi
+>>>>>>>
+<<<<<<<
+=======
+    fi
+
+    # Load VBoxUSBMon, VBoxUSB
+    try_vboxusb=no
+    if test -f "$PKG_INSTALL_ROOT/etc/vboxinst_vboxusb"; then
+        subprint "Detected: Force-load file $PKG_INSTALL_ROOT/etc/vboxinst_vboxusb."
+        try_vboxusb=yes
+    else
+        if test -f "$DIR_CONF/vboxusbmon.conf" && test "$HOST_OS_MAJORVERSION" != "10"; then
+            # For VirtualBox 3.1 the new USB code requires Nevada > 123 i.e. S12+ or S11 b124+
+            if test "$HOST_OS_MAJORVERSION" -gt 11 || \
+              (test "$HOST_OS_MAJORVERSION" -eq 11 && test "$HOST_OS_MINORVERSION" -gt 123); then
+                try_vboxusb=yes
+            else
+                warnprint "Solaris 11 build 124 or higher required for USB support. Skipped installing USB support."
+            fi
+        fi
+    fi
+
+    if test "$try_vboxusb" = yes ; then
+            # Add a group "vboxuser" (8-character limit) for USB access.
+            # All users which need host USB-passthrough support will have to be added to this group.
+            groupadd vboxuser >/dev/null 2>&1
+>>>>>>>
+<<<<<<<
+=======
+                add_driver "$MOD_VBOXUSB" "$DESC_VBOXUSB" "$FATALOP" "$NULLOP"
+                load_module "drv/$MOD_VBOXUSB" "$DESC_VBOXUSB" "$FATALOP"
+            fi
+    fi
+
+    return $?
+>>>>>>>


