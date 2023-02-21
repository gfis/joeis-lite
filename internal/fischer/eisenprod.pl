#!perl

# Extract parameters for products of Eisenstein series
# @(#) $Id$
# 2023-02-21, Georg Fischer: copied from anopan.pl; *JA=66
#
#:# Usage:
#:#     grep -Pi "a\(n\) *\= *A\d+\([^\)]+\) *([\+\-\*\/\^]|and|or|xor|xand|mod) *A\d+\([^\)]+\) *\." $(COMMON)/jcat25.txt \
#:#     | grep -E "^\%" \
#:#     | cut -b 4- | sed -e "s/ /\t/" \
#:#     | perl anopan.pl [-d debug] [-f ofter_file] > $@.tmp 2> $@.rest.tmp
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
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

my %eisenmap = qw (
    E_2    A006352
    E_4    A004009
    E_6    A013973
    E_8    A008410
    E_10   A013974
    E_12   A029828
    E_14   A058550
    E_16   A029829
    E_20   A029830
    E_24   A029831
    E_99   A000594
    );

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
    $line = substr($line, 3);
    $line =~ s{ }{\t};
    my $nok = "";
    ($aseqno, $name) = split(/\t/, $line);
    $name =~ s{\bDelta\b}{E_99}g;
    $name =~ s{\([qx]\)}{}g;
    my $expr;
    if (0) {
    } elsif ($name =~ m{expansion of ([E\d\_\^\*\/\(\) ]+)[\,\.w]}i) {
        $expr = $1;
        $expr =~ s{ }{}g;
    } elsif ($name =~ m{whose (\d+)\w\w power equals ([E\d\_\^\*\/\(\) ]+)[\,\.w]}i) {
        my $root = $1; 
        $expr = $2;
        $expr =~ s{ }{}g;
        $expr = "($expr)^(1/$root)";
    } else {
        $nok = "nok";
    }
    if ($nok eq "") {
        print join("\t", $aseqno, $callcode, 0, $expr) . "\n";
    }
} # while <>
#----------------
__DATA__
%N A289981 Coefficients in expansion of 236364091*E_24/Delta^2 where Delta is the generating function of Ramanujan's tau function (A000594).
%N A290009 Coefficients in expansion of 691*E_4*E_8*E_12.
%F A290009 G.f.: 691*E_4^3*E_12.
%N A290010 Coefficients in expansion of 691*E_6^2*E_12.
%N A290048 Coefficients in expansion of E_6*Delta^2 where Delta is the generating function of Ramanujan's tau function (A000594).
%N A341873 Coefficients of the series whose 24th power equals E_2(x)^5/E_10(x), where E_2(x) and E_10(x) are the Eisenstein series A006352 and A013974.
