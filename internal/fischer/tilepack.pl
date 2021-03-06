#!perl

# Copy Java sources and replcae the package names
# 2020-05-29: switch "start test code"
# 2020-05-19, Georg Fischer
#
#:# Usage:
#:#   perl tilepack.pl [-p package] [-t] srcfile tarfile
#:#       -p package name (default org.teherba.tile)
#:#       -t enclose test code by comment brackets
#
# The sources may contain comment brackets of the following form:
#   // start test code //
#     Java for debugging purposes only
#   // end   test code */
#
# The first "//" is replaced by "/*" for these brackets.
#--------------------------------------------------------
use strict;
use integer;
use warnings;

# my $srcdir = "../../../OEIS-mat/coors";
# my $tardir = "../../src";
my $pack = "org.teherba.tile";
my $remtest = 0; # default: keep test code
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $pack   = shift(@ARGV);
    } elsif ($opt  =~ m{t}) {
        $remtest   = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
my $srcfile = shift(@ARGV);
my $tarfile = shift(@ARGV);
open(SRC, "<", $srcfile) || die "cannot read  \"$srcfile\"\n";
open(TAR, ">", $tarfile) || die "cannot write \"$tarfile\"\n";
while (<SRC>) {
    my $line = $_;
    if ($line =~m{\$\(PACK\)(\.\w+)?}) {
        my $class = $1 || "";
        $line =~ s{\A\/\/\s*}{}; # remove Java comment
        if (0) {
        } elsif($class eq ".Sequence") {
            $line =~ s{\$\(PACK\)}{irvine.oeis};
        } elsif($class eq ".Z") {
            $line =~ s{\$\(PACK\)}{irvine.math.z};
        } else {
            $line =~ s{\$\(PACK\)}{$pack};
        }
        # with $(PACK)
    } elsif ($remtest == 1 and ($line =~ m{\/\/ start test code})) {
        $line =~   s{\/\/ start test code}{\/\* start test code};
    }
    print TAR $line;
} # while <>
print STDERR "$srcfile -> $tarfile\n";
close(SRC);
close(TAR);
__DATA__
/* Properties and methods for a uniform tiling and its coordination sequences
 * @(#) $Id$
 * Copyright (c) 2020 Dr. Georg Fischer
 * 2020-05-15, Georg Fischer: extracted from Tiler.java
 */
// package $(PACK);
// import $(PACK).Position;
// import $(PACK).PositionMap;
// import $(PACK).Vertex;
// import $(PACK).VertexList;
// import $(PACK).VertexType;
// import $(PACK).VertexTypeArray;
// import $(PACK).Z;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;

