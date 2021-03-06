#!/bin/ksh -p
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source.  A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#

#
# Copyright (c) 2015 by Delphix. All rights reserved.
#

. $STF_SUITE/include/libtest.shlib

#
# DESCRIPTION:
# Verify that zfs mount should fail with a non-empty directory
#
# STRATEGY:
# 1. Unmount the dataset
# 2. Create a new empty directory
# 3. Set the dataset's mountpoint
# 4. Attempt to mount the dataset
# 5. Verify the mount succeeds
# 6. Unmount the dataset
# 7. Create a file in the directory created in step 2
# 8. Attempt to mount the dataset
# 9. Verify the mount fails
#

verify_runnable "both"

log_assert "zfs mount fails with non-empty directory"

fs=$TESTPOOL/$TESTFS

log_must $ZFS umount $fs
log_must mkdir -p $TESTDIR
log_must $ZFS set mountpoint=$TESTDIR $fs
log_must $ZFS mount $fs
log_must $ZFS umount $fs
log_must touch $TESTDIR/testfile.$$
log_mustnot $ZFS mount $fs
log_must rm -rf $TESTDIR

log_pass "zfs mount fails non-empty directory as expected."
