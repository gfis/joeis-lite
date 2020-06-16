#!perl

# Convert postfix back to infix using a table of patterns
# for the operands, operators and functions
# @(#) $Id$
# 2020-06-16, Georg Fischer: copied from cr_infix.pl
#
#:# Usage:
#:#   perl post_infix.pl [-d debug] [-p patternfile] > outfile
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
my $postsep   = ";";  # separator for postfix strings
my $PATSEP    = "\t"; # separator for pattern file
my $formsep   = "~~"; # separator for formulae in $parm1
my $patprefix = "./";
my $patext    = ".cpat";
my $numescape = "01234567";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $patprefix = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %patterns  = (); # empty at the beginning
&read_patterns();

my $line;
while (<>) {
    $line = $_;
    $line =~ s{\s+\Z}{}; # chompr
    if ($line =~ m{\AA\d+\t}) { # starts with aseqno
        my ($aseqno, $callcode, $offset, $formlist, @rest) = split(/\t/, $line);
        $formsep = substr($formlist, 0, 1); # start with 1st char
        $formlist =~ m{\A($formsep+)}; 
        $formsep = $1; # maybe several of them
        my @formulae = split(/$formsep/, $formlist);
        shift(@formulae); # remove empty 1st element
        my $result = ""; # append resulting target formulae here
        foreach my $postfix (@formulae) {
            my $postsep = substr($postfix, 0, 1); # first character is separator (";")
            $postfix = substr($postfix, 1);
            my @postlist = split(/$postsep/, $postfix);
            my @elems;
            my @stack = ();
            my ($op1, $op2);
            my $ielem = 0;
            my $ipost = 0;
            my $error = 0;
            while ($ipost < scalar(@postlist) and $error == 0) { 
                my $post = $postlist[$ipost];
                my ($srctype, $nsrc, $target, $ntar) = split(/$PATSEP/, $patterns{$post});
                #--------
                if (! defined($srctype))                  { # unknown name, number or function
                    if (0) { # caution, order of "elsif"s matters
                    } elsif ($post =~ m{\A\d})            { # unknown number 
                        if (length($post) >= 10) {
                            $post .= "L"; # make long
                        }
                        ($srctype, $nsrc, $target, $ntar) = split(/$PATSEP/, $patterns{$numescape});
                        $target =~ s{$numescape}{$post}g;
                        push(@stack, $target);
                    } elsif ($post =~ m{\A\w+\(\Z})       { # any function start - ignore
                    } elsif ($post =~ m{\A(A\d+_?\d*)\)}) { # A-number function end 
                        # leave it for the moment
                        $$post = $1;
                        $elems[0] = pop(@stack);
                        push(@stack, "$post($elems[0])");
                    } elsif ($post =~ m{\A\w+\)\Z})       { # unknown function end - assume 1 parameter
                        $post =~ s{\)}{};
                        $elems[0] = pop(@stack);
                        push(@stack, "$post($elems[0])");
                    } elsif ($post =~ m{\A[a-zA-Z]})      { # unknown name
                        push(@stack, $target);
                    } else                                { # total garbage
                        push(@stack, "<?post=$post?>");
                    }
                    # unknown name, number or function
                #--------
                } elsif ($srctype =~ m{fun|op}) {
                    my $open = "(";
                    $ielem = $nsrc - 1;
                    while ($ielem >= 0) { # elem0 elem1 +
                        $elems[$ielem] = pop(@stack);
                        $ielem --;
                    } # while 
                    if (0) {
                    } elsif ($ntar == 0) { # e.g. unary minus -> elem0.negate()
                        push(@stack, "$target$open)");
                    } elsif ($ntar == 1) {
                        push(@stack, "$elems[0]$target$open$elems[1])"); # elem0.add(elem1)
                    } elsif ($ntar == 2) {
                        push(@stack, "$target$open$elems[0],$elems[1])"); # .mod(elem0,elem1)
                    }
                    # srctype fun|op
                #--------
                } elsif ($srctype eq "name") {
                    push(@stack, $target);
                #--------
                } elsif ($srctype eq "num" ) {
                    push(@stack, $target);
                #--------
                } else {
                    print STDERR "undefined srctype=\"$srctype\"\n";
                }
                #--------
                $ipost ++;
            } # while $ipost

            if (scalar(@stack) == 1 and $error == 0) {
                $result .= $formsep . pop(@stack);
            } else {
            	$result .= $formsep . "<?stack=" . join($postsep, @stack) . "?>";
            }
        } # foreach $postfix
        print join("\t", $aseqno, $callcode, $offset, $result, @rest) . "\n";
    } # if aseqno
} # while <>

#--------------------------------
# Read the patterns for operands, operators and functions 
# and store them in a hash.
# The tab-separated pattern lines have the following fields:
# source: key 
# type:   of source,
#         num = a number (without sign), 
#         name =  variable name, 
#         op = operator symbol, 
#         fun = function start (e.g. "abs(")) in the postfix string
# nsrc:   number of operands for source
# target: the representation of the postfix element in the target language
# ntar:   number of operands for target, for example for mod(a,b) = 2, a.mod(b) = 1
sub read_patterns { 
    my $patfile = "$patprefix";
    if ($patfile !~ m{$patext\Z}) {
        $patfile .=   $patext;
    }
#   open(PAT, "<", $patfile) or die "cannot read \"$patfile\"\n";
#   while (<PAT>) {
    while (<DATA>) {
        next if m{\A\#}; # skip comment lines
        s{\s+\Z}{}; # chompr
        my $line = $_;
        if ($debug >= 1) {
          print "# $line";
        }
        my @parts = split(/$PATSEP/, $line);
        my $key = shift(@parts); # first field is key
        $patterns{$key} = join($PATSEP, @parts);
    } # while <PAT>
#   close(PAT);
} # read_patterns
#--------------------------------
__DATA__
# Patterns for irvine.math.z.Z infix expression generation
# 2020-06-16, Georg Fischer
#
0	num	0	Z.ZERO	0
1	num	0	Z.ONE	0
2	num	0	Z.TWO	0
3	num	0	Z.THREE	0
4	num	0	Z.FOUR	0
5	num	0	Z.FIVE	0
6	num	0	Z.SIX	0
7	num	0	Z.SEVEN	0
8	num	0	Z.EIGHT	0
9	num	0	Z.NINE	0
10	num	0	Z.TEN	0
01234567	num	0	Z.valueOf(01234567)
n	name	0	Z.valueOf(mN)	0
+	op	2	add	1
-	op	2	subtract	1
*	op	2	multiply	1
/	op	2	divide	1
-.	op	1	negate	1
%	op	2	mod	1
^	op	2	pow	1
floor)	fun	1	floor	0
ceil)	fun	1	ceil	0
round)	fun	1	round	0
sqrt)	fun	1	sqrt	0

