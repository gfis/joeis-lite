#!perl

# Extract parameters for PrimeSubsequence from names like "Numbers such that ... is prime"
# 2021-01-12, Georg Fischer: copied from suchprim.pl
#
#:# Usage:
#:#   grep ... $(COMMON)/joeis_names.txt \
#:#   | perl prisub.pl [-d debug] [-f ofter_file] > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, @rest, $name);
my $debug   = 0;
my $offset = 0;
my $rseqno = "";
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
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
my $terms;
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";
#----------------

my @parms;
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    $line =~ s{\, where .*}{};
    $line =~ s{ is (a )?prime}{\; is prime};
    $callcode = "prisub";
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    if (defined($ofters{$aseqno})) {
        print STDERR "# $aseqno $superclass - ignore since already implemented\n";
    } elsif ($name =~ m{\.\#\.\.}) { # never
        print STDERR "$line\n";
    } elsif ($name =~ m{ers ([a-z]) such that (the string |the concatenation )?([^\;]+)\; is prime(\Z|\.)}) {
        my $letter = $1;
        my $expr   = $3;
        $expr =~ s{ }{}g;
        $expr =~ s{$letter}{k}g;
        $expr =~ s{R_k}{\(10^k\-1\)\/9}g;         # R_k   -> (10^k-1)/9
        $expr =~ s{(\A|[\+\-])k}{${1}1\*k}g;      # +k    -> +1*k
        $expr =~ s{(\d)k}{${1}\*k}g;              # 1234k -> 1234*k
        $expr =~ s{(\d+)\^(\d+)}{$1**$2}eg;       # 2^10  -> 1024
        $expr =~ s{k(\!+)(\D)}{"k\!" . length($1) . $2}eg; # k!!!  -> k!3
        $expr =~ s{k!\[(\d+)\]}{k\!$1}g;          # k![3] -> k!3
        my $parms = &parse($expr);
        if (length($parms) > 0) {
            print join("\t", $aseqno, $callcode, $parms) . "\n";
        } else {
            print STDERR join("\t", $aseqno, $expr, $name) . "\n";
        }
    } else {
        print STDERR "$line\n";
    } # if proper name
} # while <>
#----
sub parse {
    my ($expr) = @_;
    my $result = "";
    my ($p1, $p2, $p3, $p4, $p5);
    my $ex = "";
    if ($expr =~ m{[a-z][a-z]}) { 
        # ignore if there is a word
    } elsif ($expr =~ m{\A$ex(\d+)\*k([\+\-])(\d+)\Z}) { # 7*k~7
        (                    $p1,    $p2,    $p3     ) = ($1, $2, $3);
        $result  = join("\t", 1, "[[$p1],[1],[-1]]"                                , "[$p2$p3]",                  0, "", "", $expr);
    } elsif ($expr =~ m{\A$ex(\d+)\^k([\+\-])(\d+)\Z}) { # 7^k~7
        (                    $p1,    $p2,    $p3) = ($1, $2, $3);
        $result  = join("\t", 1, "[[" . eval("-($p2$p3)*($p1-1)") . "],[$p1],[-1]]", "[" . eval("1$p2$p3") . "]", 0, "", "", $expr);
    } elsif ($expr =~ m{\A$ex(\d+)\*k\^(\d+)([\+\-])(\d+)\Z}) { # 7*k^7~7; a(n) = 23*k^2 + 5 -> "[[5,0,23],[-1]]","[23+5]"
        (                    $p1,      $p2, $p3,    $p4) = ($1, $2, $3, $4);
      if ($p2 <= 6) {
        $result  = join("\t", 1, "[[$p3$p4" . (",0" x ($p2 - 1)) . ",$p1],[-1]]",    "[" . eval("$p3$p4") . "]",  0, "", "", $expr);
      } else {
        $result = "";
      }
    } elsif ($expr =~ m{\A$ex(\d+)([\+\-]\d+)\*k(([\+\-](\.\.\.[\+\-])?\d+\*k\^\d+)+)\Z}) { # 7~7*k~7*k^7~7*k^7
        (                    $p1, $p2,          $p3                                 ) = ($1, $2, $3, $4);
        # 32 pass, very good
        $result  = join("\t", 1, "[[$p1,$p2");
        my $iexp = 1;
        my @pairs = ($p3 =~ m{([\+\-](\.\.\.[\+\-])?\d+\*k\^\d+)}g);
        my ($oldfactor, $oldexp) = (1,1);
        foreach my $pair (@pairs) {
            if ($pair =~ m{([\+\-]\d+)\*k\^(\d+)}) {
                my ($factor, $exp) = ($1, $2);
                if ($pair =~ m{\.\.\.}) { # with ellipsis
                    while ($iexp + 1 < $exp) {
                        $result .= "," . (($iexp + 1) & 1);
                        $iexp ++;
                    } # while $iexp
                    $result .= ",1";
                    # with ellipsis
                } else {
                    while ($iexp + 1 < $exp) {
                        $result .= ",0";
                        $iexp ++;
                    } # while $iexp
                    $result .= ",$factor";
                }
                # print "# pair=$pair, factor=$factor, exp=$exp\n";
                $iexp ++;
                ($oldfactor, $oldexp) = ($factor, $exp);
            }
        } # foreach
        $result .=  join("\t", "],[-1]]", "[$p1]",  0, "", "", $expr);
    } elsif ($expr =~ m{\A1$ex\*k\!(\d+)([\+\-]\d+)\Z}) { # k!7~7;
        (                    $p1, $p2) = ($1, $2);
        # k!6-1 -> "[[-1],[0,1],[0],[0],[0],[0],[0],[-1]]", [1,1,2,3,4,5]-1 ; GU=8, very good
        $p2 =~ s{\+}{};
        # print "# p1=$p1, p2=$p2, expr=$expr, name=$name\n";
        my @inits = (1);
        for (my $ind = 1; $ind < $p1; $ind ++) {
            push(@inits, $ind);
        } # for
        $callcode = "prisubf";
        $result  = join("\t", 1, "[[0],[0,1]" . (",[0]" x ($p1 - 1)) . ",[-1]]", join(",", @inits), 0, $p2, "", $expr);
    } elsif ($expr =~ m{\A(\d+(\*k(\^\d+)?)?)([\+\-](\d+(\*k(\^\d+)?)?))+\Z}) { 
        my @pairs = split(/([\+\-])/, $expr);
        foreach my $pair (@pairs) {
        } # foreach
        $callcode = "prisubp";
        $result .= join("\t", "],[-1]]", "[1]",  0, "", "", $expr);
    }
    $result =~ s{([\[\,])\+}{$1}g; # [+7 -> [7
    return $result;
} # parse
#================
__DATA__
