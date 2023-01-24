#!perl

# Extract parameters for GramMatrixThetaSeries
# @(#) $Id$
# 2023-01-24, output of epsigs for EtaProductSequence
# 2020-10-28, Georg Fischer: copied from partcond.pl
#
#:# Usage:
#:#     grep -E "Number of integer solutions " $(COMMON)/cat25.txt | cut -b4- \
#:#     | perl nisolut.pl [-d debug] [-e] > nisolut.gen
#:#         -d  debugging level (0=none (default), 1=some, 2=more)
#:#         -e  whether to output eta product signatures as comments
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $cc = "nisolut";
my $with_epsig = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-e}  ) {
        $with_epsig = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $line;
my @parms; # records in joeis_names.txt
my $matrix;
my $offset = 0;
my $callcode;

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $callcode = $cc;
    $line =~ m{\A(A\d+) +([^\.]*)};
    my ($aseqno, $name) = ($1, $2);
    @parms = ();
    if (0) {

    # A033715 Number of integer solutions (x, y) to the equation x^2 + 2y^2 = n.
    # A320124 Number of integer solutions to a^2 + b^2 + 2*c^2 + 3*d^2 = n.	nonn,	0..10000
    # A320125 Number of integer solutions to a^2 + b^2 + 2*c^2 + 4*d^2 = n.	nonn,	0..10000
    # A320126 Number of integer solutions to a^2 + b^2 + 2*c^2 + 5*d^2 = n.	nonn,	0..10000
    # A320147 Number of integer solutions to a^2 + b^2 + 3*c^2 + 5*d^2 = n.
    } elsif ($name =~ m{umber of (integer )?solutions ([\(\[][abcdefvwxyz\, \)\]]+)?to (the equation )?(.*)}) {
        my $equat = $4;
        if (($equat =~ s{\s*\=\s*n\Z}{}) > 0) {
            my @expons = ();
            foreach my $term (split(/\s*\+\s*/, $equat)) {
                if ($term =~ m{\A(\d*) *\*? *[a-z]\^2\Z}) {
                    push(@expons, $1 || 1);
                } else {
                    $callcode = "#1 $term ";
                }
            } # foreach
            if ($callcode !~ m{\A\#}) {
                my @rows = ();
                for (my $i = 0; $i < scalar(@expons); $i ++) {
                    my @cols = ();
                    for (my $j = 0; $j < scalar(@expons); $j ++) {
                        push(@cols, ($i == $j) ? $expons[$i] : 0);
                    } # for $j
                    push(@rows, "{" . join(",", @cols) . "}");
                } # for $i
                $matrix = "{" . join(", ", @rows) . "}";
            } # ne ""
            push(@parms, $matrix);
            if (0 && $with_epsig) { # not working if there are non-diagonal elements
                print "# " . join("\t", $aseqno, "epsig", $offset, join(",", @expons), $name) . "\n";
            }
        } else {
            $callcode = "#2";
        } # no "="

    # %N A028960 Numbers represented by quadratic form with Gram matrix [ 3, 1; 1, 8 ].
    # %N A028961 Theta series of quadratic form (or lattice) with Gram matrix [ 3, 1; 1, 8 ].        # A028953 Sequence Theta series of quadratic form (or lattice) with Gram matrix [ 3, 1; 1, 4 ].    nonn,   0..10000
    } elsif ($name =~ m{\ANumbers represented }) {
        $callcode = "#3"; # ignore this record
    } elsif ($name =~ m{Gram matrix *\[([ \d\,\;\-]+)\]}) {
        $matrix = $1;
        $matrix =~ s/\s//g;
        $matrix =~ s/\;/\}, \{/g;
        push(@parms, "{{" . $matrix . "}}");
    } else {
        $callcode = "#4"; # ignore this record
    }
 
    if ($callcode !~ m{\A\#}) {
        print        join("\t", $aseqno, $callcode, $offset, @parms, "1", "", $name) . "\n";
    } else {
        print STDERR join("\t", $aseqno, $callcode, $offset, $name) . "\n";;
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

