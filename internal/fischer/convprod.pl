#!perl

# Extract parameters for convolution products of 2 series
# @(#) $Id$
# 2023-02-24, Georg Fischer: copied from eisenprod.pl; 1 Jahr Ukraine-Krieg
#
#:# Usage:
#:#     perl covprod.pl [-d mode] input > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 and scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}

while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options

my $line;
my $name;
my $aseqno;
my $callcode = "convprod";
my $skip;   # asemble skip instructions here
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $line =~ s{ }{\t}; # first space only
    my $nok = "";
    ($aseqno, $name) = split(/\t/, $line);
    my $alist = "";
    if (0) {
    } elsif ($name =~ m{\{+(A\d+)\}+ +(and|with) +\{+(A\d+)\}+}) {
        $alist = "new $1(), new $3()";
    } else {
        $nok = "nok0";
    }
    if ($nok eq "") {
        $name = substr($name, 0, 128);
        print        join("\t", $aseqno, $callcode, 0, "1,1", $alist, "", "", "", "", "", "", $name) . "\n";
        #                                              parm1  2       3   4   5   6   7   8
    } else {
        print STDERR join("\t", $aseqno, $callcode, 0, $name) . "\n";
    }
} # while <>
#----------------
__DATA__
A281490 Convolution of sequences {{A010054}} and {{A281814}}.
A281541 Convolution of {{A001156}} and {{A046951}}.
A281572 Convolution of {{A034444}} and {{A073576}}.
A281617 Convolution of {{A086971}} and A101048.
A281688 Convolution of {{A001511}} and {{A018819}}.
A281689 Convolution of {{A003107}} and {{A005086}}.
A281722 Convolution of the sequences {{A004016}} and {{A005928}}.
