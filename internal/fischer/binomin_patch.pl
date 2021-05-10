#!perl

# Patch the initial terms for CC=binomin
# 2021-05-08, Georg Fischer: copied from binomin.pl
#
#:# Usage:
#:#   perl binomin_patch.pl [-d debug] binomin2.tmp > binomin3.tmp
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $callcode, $offset, @parms);
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) { # seq4 format
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, @parms) = split(/\t/, $line);
    $offset = $parms[0];
    my @terms = split(/\,/, $parms[4]);
    my $ind = scalar(@terms) - 2; # normally -1, but last may have been truncated
    while ($ind >= 0 && ($terms[$ind] ne "0")) {
        $ind --;
    } # while
    # now $ind == -1 or $terms[$ind] eq "0"
    $ind ++; # include this one
    $parms[4] = "";
    $parms[2] = "[" . join(",", splice(@terms, 0, $ind + 2)) . "]";
    print join("\t", $aseqno, $callcode, @parms) . "\n"; 
} # while <>
__DATA__
