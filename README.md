# About

This repository contains the `vboxconfig.sh` script fixed to properly detect
non-"Oracle Solaris 11" platforms during VirtualBox installations.

This script estimates the OS environment on the VirtualBox host and chooses
which drivers to install and register, for Solaris ("SunOS" distro) in
particular. In case of the extended Solaris family (based on the open-sourced
illumos core) the original Sun/Oracle Solaris logic does not work well, so
to cater for these systems some fixes were needed.

## Branches

The "downloaded" branch shall contain occasional snapshots of the script
provided by the upstream VirtualBox downloadable distributions.

The "illumos-fix" is my work in progress as I develop and test the script,
as well as rebase it to newer upstream versions over time.

The "master" branch is a sort of release variant of the "illumos-fix" -
whatever seems stable enough to publish and use for everybody daring enough ;)

## License

Common license for the script is GPLv2 as in VirtualBox OSE.
My changes were initially released under MIT License which is even less
prohibitive; follow-up work here is licensed as GPLv2 to avoid the mess.

In any case, I hope these changes would be found useful and might wind up
in pre-packaged distributions, be it the original Oracle VirtualBox, or
any of the OSE builds in illumos distributions.

Jim Klimov

----------------

## Original announcement

 From: Jim Klimov
 To: vbox-dev@virtualbox.org
 Date: 9 Mar 16:09 2015 
 Subj: Patch to support installation on non-Sun/Oracle Solaris hosts

Hello all,

I submit a patch which should simplify installation of modern VirtualBox
on some non-Oracle derivate distributions of Solaris which are known to
host VirtualBox just fine. Most of the patch deals with "proper" detection 
of major and minor OS version numbers on those distributions. Also there
is now a touchable filename to enforce installation of USB filters and
corresponding UNIX group accounts, as a workaround for further distros
not detected as supported by even new code.

I submit this patch under the terms of MIT license.

This was last tested with VirtualBox 4.3.24 and OpenIndiana Hipster and
OmniOS Bloody, all updated today to the most current states available.

Note this was not yet tested in practice with OpenSolaris SXCE (yes, I do
have some running), although snippets were developed that should work there.
I don't expect there are many of those installations left beside my closet,
but those are all pleased with old VBox versions for now... ain't broke,
you know ;)

 Hope this helps,
 // Jim Klimov
