#!/usr/bin/perl

# Change files in place
# @(#) $Id$
# 2022-07-13, Georg Fischer copied from dbat/etc/util/unhead.pl
#
# Usage:
#   perl change.pl file...
#------------------------------------------------------------------
use strict;
    my $rmcount = -1; # default: remove nothing

    while (scalar(@ARGV) > 0 && ($ARGV[0] =~ m{\A\-})) {
        my $opt = shift(@ARGV);
        if (0) {
        } elsif ($opt =~ m{\A\-n}) {
            $rmcount = shift(@ARGV);
        } else {
            print STDERR "unknown option $opt\n";
        }
    } # while $opt

    while (scalar(@ARGV) > 0) {
        my $inname = shift(@ARGV);
        open (SRC, "<", $inname) || die "cannot read \"$inname\"\n";
        my $buffer = "";
        my $count = 0;
        while (<SRC>) {
            s/\boffset\b/offset1/g; # <---- this is the change
            $count ++;
            if ($count > $rmcount) {
                $buffer .= $_;
            } else {
                # skip first lines
            }
        } # while <SRC>
        close(SRC);
        open (TAR, ">", $inname) || die "cannot write \"$inname\"\n";
        print TAR $buffer;
        close(TAR);
    } # while ARGS
