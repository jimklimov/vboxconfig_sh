This repository contains the `vboxconfig.sh` script fixed to properly detect
non-"Oracle Solaris 11" platforms during VirtualBox installations.

From: Jim Klimov
To: vbox-dev@virtualbox.org
Date: 9 Mar 16:09 2015 
Subj: Patch to support installation on non-Sun/Oracle Solaris hosts

Hello all,

I submit a patch which should simplify installation of modern VirtualBox on some
non-Oracle derivate distributions of Solaris which are known to host VirtualBox 
just fine. Most of the patch deals with "proper" detection of major and minor OS
version numbers on those distributions. Also there is now a touchable filename
to enforce installation of USB filters and corresponding UNIX group accounts,
as a workaround for further distros not detected as supported by even new code.

I submit this patch under the terms of MIT license.

This was last tested with VirtualBox 4.3.24 and OpenIndiana Hipster and OmniOS
Bloody, all updated today to the most current states available.

Note this was not yet tested in practice with SXCE although snippets were developed
that should work there. I don't expect there are many of those installations left beside my 
closet, but those are all pleased with old VBox versions for now... ain't broke, you know ;)


Hope this helps,
// Jim Klimov
