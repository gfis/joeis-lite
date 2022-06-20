#!perl

# Move producer sources from ../../src/irvine/oeis/a*/A*.java to ../../prog/ subdirectories
# @(#) $Id$
# 2022-06-16, Georg Fischer
#
#:# usage:
#:#     find ../../src/irvine/oeis -iname "a???" -type d \
#:#     | perl moveprog.pl [-q] > output
#:#         -q quiet (only a count is printed)
#-------------------------
use strict;
use integer;
use warnings;

my $debug    = 0; # 0 (none), 1 (some), 2 (more)
my $timeout  = 4; # in seconds
my $dwindow  = 4; # window of differing terms to be shown
my $quiet    = 0; # show all mv results
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{q}) {  # 
        $quiet     = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %dirs;
my $tarroot = "./prog/gp";
my $count = 0;
while (<>) {
    s/\s+\Z//; # chompr
    my $pathspec = $_;
    #                    1       1  2    2
    if ($pathspec =~ m{\/(a\d\d\d)\Z}) {
        my ($adir) = ($1);
        if (0) {
            my $tarpath = "$tarroot/$adir";
            if (! defined($dirs{$tarpath}) or ! -d "$tarpath") { # tarpath not yet readable
                $dirs{$tarpath} = 1;
                mkdir($tarpath);
            }
            my $filename = "$tarpath/$aseqno.gp";
        }
        my $cmd = "mv -v $pathspec $tarroot";
        # print "$cmd\n";
        my $result = `$cmd`;
        if ($quiet == 0) {
            print "$result";
        }
        $count ++;
    } # pathspec ok
} # while <>
print "$count directories moved to $tarroot\n";
__DATA__
../../src/irvine/oeis
../../src/irvine/oeis/a007
../../src/irvine/oeis/a007/A007117.java
../../src/irvine/oeis/a007/A007324.java
../../src/irvine/oeis/a023
../../src/irvine/oeis/a023/A023199.java
../../src/irvine/oeis/a031
../../src/irvine/oeis/a031/A031508.java
../../src/irvine/oeis/a057
../../src/irvine/oeis/a057/A057623.java
../../src/irvine/oeis/a057/A057625.java
