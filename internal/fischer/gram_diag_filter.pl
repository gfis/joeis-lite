#!perl

# Filter output of nisolut.pl and extract those with aöö non-diagonal elements = 0.
# @(#) $Id$
# 2023-01-24, Georg Fischer: copied from nisolut.pl; DvH=81
#
#:# Usage:
#:#     ... | perl nisolut.pl \
#:#     | perl gram_diag_filter.pl [-d mode] > output.seq4
#:#         -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $cc = "gramdiag";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $line;
my  ($aseqno, $callcode, $offset, $matrix, $dummy1, $dummy2, $name);
my @diags;

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    next if $line !~ m{\A(A\d+)};
    ($aseqno, $callcode, $offset, $matrix, $dummy1, $dummy2, $name) = split(/\t/, $line);
    $callcode = $cc;
    $matrix =~ s{\s}{}g; # remove whitespace
    @diags = ();
    my @rows = map {
        s/[\{\}]//g; $_ # remove { }
        } split(/\}\,\{/, $matrix);
    my $is_diagonal = 1; # assume succes
    for (my $irow = 0; $irow < scalar(@rows); $irow ++) {
        my @cols = split(/\,/, $rows[$irow]);
        for (my $icol = 0; $icol < scalar(@cols); $icol ++) {
            if ($irow != $icol) {
                if ($cols[$icol] != 0) {
                    $is_diagonal = 0;
                }
            } else { # =
                $diags[$icol] = $cols[$icol];
            }
        }
    } # foreach row
 
    if ($is_diagonal) {
        print        join("\t", $aseqno, $callcode, $offset, join(",", @diags), "", "", "", $name) . "\n";
    } else {
        print STDERR join("\t", $aseqno, "non-diagonal", $offset, $name) . "\n";;
    }
} # while <>
#----------------
__DATA__
A029682	nisolut	0	{{2,1,0}, {1,2,1}, {0,1,4}}	1		Theta series of quadratic form with Gram matrix [ 2, 1, 0; 1, 2, 1; 0, 1, 4 ]
A033701	nisolut	0	{{4,0,2,-2,0,-1}, {0,4,-2,0,-2,1}, {2,-2,4,-1,1,-2}, {-2,0,-1,4,0,2}, {0,-2,1,0,4,-2}, {-1,1,-2,2,-2,4}}	1		Gram matrix [4, 0, 2, -2, 0, -1; 0, 4, -2, 0, -2, 1; 2, -2, 4, -1, 1, -2; -2, 0, -1, 4, 0, 2; 0, -2, 1, 0, 4, -2; -1, 1, -2, 2, -2, 4]
A033715	nisolut	0	{{1,0}, {0,2}}	1		Number of integer solutions (x, y) to the equation x^2 + 2y^2 = n
A033716	nisolut	0	{{1,0}, {0,3}}	1		Number of integer solutions to the equation x^2 + 3y^2 = n
A033717	nisolut	0	{{1,0,0}, {0,2,0}, {0,0,4}}	1		Number of integer solutions to the equation x^2 + 2*y^2 + 4*z^2 = n
A033719	nisolut	0	{{1,0}, {0,7}}	1		Number of integer solutions to the equation x^2 + 7*y^2 = n

