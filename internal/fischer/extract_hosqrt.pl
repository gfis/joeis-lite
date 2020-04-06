#!perl

# Grep generating functions with sqrt() for JoeisPreparer 
# @(#) $Id$
# 2020-01-05: $factor
# 2020-04-06, Georg Fischer: copied from holrec/gfsqrt_grep.pl
#
#:# Usage:
#:#   perl extract_hosqrt.pl $(COMMON)/cat25.txt > gfsqrt1.tmp
#:#   $(RAMATH).sequence.JoeisPreparer -f          gfsqrt1.tmp
#--------------------------------------------------------------
use strict;
use integer;
use warnings;

my $line;
my $aseqno;
my $expr;
my $factor; # $factor/sqrt()
my $gftype; # "e" if e.g.f, "o" otherwise
my $callcode;

while(<>) {
    # s{\s+\Z}{}; # chompr
    $line   = $_;
    $gftype = "o";
    $callcode = "hosqrt";
    if ($line =~ m{onject}) { # ignore
    #                              1        2                 3                          4                    5           
    } elsif ($line =~ m{\A\%[NF]\s+(A\d+)\s+(Expansion of\s*)?([EO]\.)?[Gg]\.f\.\s*\:?\s*(A\([t-z]\)\s*\=\s*)?([^\.\,\;\=]+)}i) { 
        $aseqno  = $1;
        $gftype  = lc($3 || "o");
        $expr    = lc($5);
        if ($expr =~ m{sqrt[\(\[]|\^\(\-?\d+\/\d+\)}) {
            $expr =~ s{\s}{}g;
            # $expr =  lc($expr);
            $expr =~ s{(where|\-\_).*}{};
            my $ok = 1;
            foreach my $word ($expr =~ m{([a-z]\w+)}g) {
                if ($word ne 'sqrt') {
                    $ok = 0;
                }
            } # foreach $word
            if ($ok == 0) { # bad
            } elsif ($expr =~ m{[\~a-p]}) {
            } else {
            	$expr =~ tr{\[\]}{\(\)};
            	$expr =~ s{sqrt}{\%}g;
            	my %letters = ();
            	foreach my $letter ($expr =~ m{([q-z])}g) {
            		$letters{$letter} = 1;
            	}
            	my $word = join("", sort(keys(%letters)));
            	if (length($word) == 1) {
            		$expr =~ s{$word}{x}g;
            		$expr =~ s{\%}{sqrt}g;
                	print join("\t", $aseqno, $callcode, 0, $expr, $gftype) . "\n";
                }
            }
        }
    }
} # while <>
__DATA__
