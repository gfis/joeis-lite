#!perl

# Read rows from database table 'seq4' and generate corresponding Java sources for jOEIS
# @(#) $Id$
# 2024-03-12: V7.4: failure tolerance: ignore unknown patterns and wrong bracketing
# 2024-02-26: V7.3: GaussianINtegers, GP, GD, GU, Zi; cannot read pattern with output of $aseqno
# 2023-10-16: V7.2: .10 -> Z.TEN
# 2023-10-16: V7.1: FactorUtils; skip records with "€" in parm[i]
# 2023-10-16: V7.0: FI, FL, SJ, BI, S1, S2, .* .+ .- replacements; %zhash
# 2023-09-26: V6.5: GroupFactory
# 2023-09-23: V6.4: IntegerPartition
# 2023-09-21: V6.3: finally keep the spaces in comma-separated parameter terms
# 2023-09-18: V6.2: Shield/unshield String parameters, do not extract Java classnames from them
# 2023-09-12: V6.1: Puma
# 2023-09-07: V6.0: *.jpat now in pattern/; optional Java parameter names
# 2023-08-14: V5.2: HolonomicRecurrence; *CK=67
# 2023-07-27: V5.1: HolonomicRecurrence
# 2022-04-04: V5.0: IntegerUtils, LongUtils
# 2022-12-19: V4.9: BellNumbers, Mobius
# 2022-12-19: V4.8: do not import if it is imported with subpackage
# 2022-09-25: V4.7: recur.{Period|Padding}Sequence
# 2022-05-05: V4.6: ZString
# 2022-05-05: V4.5: IntegerUtils
# 2022-06-17: V4.4, generate for prog/gp
# 2022-06-14: V4.3, Rationals
# 2022-06-10: V4.2, suppress auto-import generation for uppercase in PARI scripts (Strings)
# 2022-05-31: V4.1, last parm was not generated
# 2022-05-31: V4.0, suppress "\.(multiply|divide)\(1\)|\.(add|subtract)\(0\)"
# 2022-05-20: V3.9, Cheetah -> Jaguar
# 2022-05-18: V3.8: mN = 0 - 1; again
# 2022-05-15: V3.7: 0 - 1 -> -1
# 2022-05-05: V3.6: LongUtils
# 2022-04-08: V3.5: Stirling, Fibonacci
# 2022-04-08: V3.4: z.Euler.phi(n)
# 2022-04-03: V3.3: FACTORIAL.factorial 
# 2022-03-26: V3.2: import Z, Integers, Cheetah.factor if necessary
# 2022-02-02: V3.1: no #import Long|Boolean
# 2022-01-14: V3.0: skip over empty callcodes
# 2021-11-26: V2.9: but only "Binomial("
# 2021-11-26: V2.8: import Binomial
# 2021-11-11: V2.7: no import for "Function"
# 2021-11-09: V2.6: Transpose, AbsoluteSequence
# 2021-10-29, V2.5: -cc concatenated with callcode in infile
# 2021-10-28, V2.4: -cc overwrites callcodes in infile
# 2021-10-10, V2.3: for subpackages irvine.oeis.cons|triangle
# 2020-09-02, V2.2: do not import @OVerride 
# 2020-06-21, V2.1: imports not from comments
# 2020-06-16, V2.0: hash for imports automatically compiled
# 2020-06-09, V1.8: leading "~~;  private final CR ~~parm2~~parm2~~...
# 2020-05-19, V1.7: replace ~~ in $(PARMi) -> newline + 8 spaces
# 2019-12-06, V1.6: no spaces in vectors
# 2019-07-04, V1.5: -m: only those not already in $maindir
# 2019-06-23: up to 8 $(PARMi) in seq4
# 2019-06-13, Georg Fischer: derived from gen_pattern.pl
#
#:# Usage:
#:#   perl gen_seq4.pl [-d debug] [-a author] [-cc callcode] [-l maxlen]
#:#          [-x {java|gp|gap...}] [-t targetdir] [-nc] infile > logfile
#:#   -a  author     Sean or Georg
#:#   -cc callcode   overwrites the callcode in the infile
#:#   -t  targetdir  generate into targetdir/*.ext (default ../../src/irvine/oeis)
#:#   -x  ext        extension (default ".java")
#:#   -nc            do not overwrite if already present in $maindir
#:#
#:#   infile lines have the format: ASEQNO CALLCODE OFFSET PARM1 PARM2 PARM3 PARM4 ... PARM8 NAME
#:#   The pattern file(s) may contain all of these
#:#   and $(AUTHOR), $(DATE), $(GEN), $(IMPORT), $(PACK), $(PROG).
#--------------------------------------------------------
use strict;
use integer;
use warnings;
use English; # PREMATCH

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
# $timestamp = sprintf ("%04d-%02d-%02d ", $year + 1900, $mon + 1, $mday);
my $version_id  = "gen_seq4.pl V7.4";
my $max_term = 16;
my $max_size = 16;
my $max_line_len = 120;
my $indent   = 6;
my $debug   = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $author    = "Georg Fischer";
my $patprefix = "./pattern/";
my $patext    = ".jpat";
my $cc        = "";
my $callcode  = "cfsnum";
my $lang      = "java";
my $ext       = ".java";
my %patterncache  = (); # empty at the beginning
my $basedir   = "../../../OEIS-mat/common";
my $targetdir = "../../src/irvine/oeis";
my %dirs      = (); # hash for the directories to be created
my $maindir   = "../../../joeis/src/irvine/oeis";
my $clobber   = 1; # overwrite even if already present in $maindir
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{a}) {
        $author    =  shift(@ARGV);
    } elsif ($opt  =~ m{cc}) {
        $cc        =  shift(@ARGV);
    } elsif ($opt  =~ m{d}) {
        $debug     =  shift(@ARGV);
    } elsif ($opt  =~ m{l}) {
        $lang      = shift(@ARGV);
    } elsif ($opt  =~ m{nc}) {
        $clobber   = 0;
    } elsif ($opt  =~ m{p}) {
        $patprefix =  shift(@ARGV);
    } elsif ($opt  =~ m{t}) {
        $targetdir =  shift(@ARGV);
    } elsif ($opt  =~ m{x}) {
        $ext       =  shift(@ARGV);
        $ext = ".$ext" if ($ext !~ m{\A\.});
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $TYPE_PERM = 1; # import is permanent (from the pattern)
my $TYPE_TEMP = 2; # import is temporary (from the parameters)
my %imports = (); # hash for classes to be imported; key=1 - always, key=2 - for this specific class (deleted at the end)
my $pattern;
my $offset = "0";
my $aseqno;
my $package;
my $name;
my @parms;
my $old_package = "";
my $gen_count = 0;
my %zhash = qw(0 ZERO 1 ONE 2 TWO 3 THREE 4 FOUR 5 FIVE 6 SIX 7 SEVEN 8 EIGHT 9 NINE 10 TEN); $zhash{"-1"} = "NEG_ONE";
my $do_generate = 1;

mkdir $targetdir;
my $old_callcode = "";
while (<>) { # read inputfile
    s{\A\#.*}{}; # remove comments
    next if m{\A\s*\Z}; # skip empty lines
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    # $line .= "\t"; # why ??? (last parm problem)
    if ($debug >= 1) {
        print "$line\n";
    }
    @parms    = split(/\t/, "$line\t\t", -1); # this is a row from db table 'seq4'
    $aseqno   = shift(@parms);
    next if scalar(@parms) == 0; # only aseqno => came from CC=man
    $callcode = shift(@parms);
    next if length($callcode) == 0; # skip over empty callcodes
    next if $callcode =~ m{\#}; # skip over commented callcodes
    next if $callcode =~ m{\A(nyi|\-\d)};  # skip over callcodes starting with "nyi" or "-2"
    # my $im = 0; print STDERR "# " . join("; ", map { "[" . ($im ++) ."]=$_" } @parms) . "\n";
    my $iparm = 0;
    $offset   = $parms[$iparm ++]; # PARM1, PARM2, ... PARM8, NAME follow
    $name = $parms[9]; # by convention, in target makefile.select3
    $name =~ s{\&}{\&amp\;}g;
    $name =~ s{\'}{\&apos\;}g;
    $name =~ s{\"}{\&quot\;}g;
    $name =~ s{\<}{\&lt\;}g;
    $name =~ s{\>}{\&gt\;}g;
    $pattern  = $patterncache{$callcode};
    if ($old_callcode ne $callcode) { # pattern changes - read again because of imports
        $old_callcode = $callcode;
        $pattern = &read_pattern("$patprefix$callcode$patext");
        $patterncache{$callcode} = $pattern;
        if ($debug >= 1) {
            print STDERR "read $patprefix$callcode$patext\n";
        }
    } # new pattern
    $package = lc(substr($aseqno, 0, 4)); # Java package name
    my $copy = $pattern;
    #          1           12     2 3        3
    $copy =~ s{(\$\(PARM\d+)(\=\w+)?([^\)]*\))}{$1$3}g; # remove Java parameter names $2, e.g. $(PARM1=start.L) -> $(PARM1.L)
    $do_generate = 1;
    if ($debug >= 2) {
        print "# scalar(parms)=" . scalar(@parms) . "\n";
    }
    my $contains_nyi = 0; # assume that there is no "€"
    while ($iparm < scalar(@parms) - 1) { # for all $(PARMi)
        my $max_term_len = 0;
        my @terms;
        if ($iparm <= 8 && ($parms[$iparm] =~ m{€}) && $contains_nyi == 0) { # does not work: dbat destroys "€"
            $contains_nyi = $iparm;
        }
        if ($parms[$iparm] eq "\"null\"") {
            $parms[$iparm] =    "null";
        }
        # normalizations:
        $parms[$iparm] =~ s{\) +}{\) }g; # multiple spaces after ")"
        $parms[$iparm] =~ s{\( +}{\(}g;  # spaces after  "("
        $parms[$iparm] =~ s{ +\)}{\)}g;  # spaces before ")"
        $parms[$iparm] =~ s{\. +}{\.}g;  # spaces after  "."
        $parms[$iparm] =~ s{ +\.}{\.}g;  # spaces before "."
        $parms[$iparm] =~ s{ *\, *}{\, }g;  # spaces around ","
        if ($parms[$iparm] =~ m{\-\>}) { # with lambda expression: replace shortcuts and check bracketing
            my $parm = $parms[$iparm];
        #   if ($parm =~ s{(BI|FA|FD|FI|MU|PR|SU|S1|S2|ZV|Z\_1|n_1|Z2|\.[\+\-\*\/])([^\(])} {$1\<--HERE$2}g) {
        #       print STDERR "# $aseqno, unknown shortcut: $aseqno $parm\n";
        #   }
            my $test = $parm;
            #                       12      21
            my $nopen = ($parm =~ s{([\(\[\{])}  {$1}g);
            my $nclos = ($parm =~ s{([\)\]\}])}  {$1}g);
            if ($nopen != $nclos) {
                print STDERR "#?? wrong bracketing in $aseqno $parm, open=$nopen, close=$nclos\n"; 
                $do_generate = 0;
            }
            $parm =~ s{ZV\(}           {Z.valueOf\(}g;
            $parm =~ s{Z\.valueOf\((\-1|[0-9]|10)\)}{"Z." . $zhash{$1}}eg;
            $parm =~ s{BI\(}           {Binomial.binomial\(}g;
            $parm =~ s{BS}             {BernoulliSequence}g;
            $parm =~ s{CV\(}           {CR.valueOf\(}g;
            $parm =~ s{FA\(}           {MemoryFactorial.SINGLETON.factorial\(}g;
            $parm =~ s{FD\(}           {MemoryFactorial.SINGLETON.doubleFactorial\(}g;
            $parm =~ s{FM\(}           {MemoryFactorial.SINGLETON.multiFactorial\(}g;
            $parm =~ s{FI\(}           {Fibonacci.fibonacci\(}g;
            $parm =~ s{GD\(}           {GaussianIntegers.SINGLETON.sumdiv\(}g;
            $parm =~ s{GP\(}           {GaussianIntegers.SINGLETON.product\(}g;
            $parm =~ s{GU\(}           {GaussianIntegers.SINGLETON.sum\(}g;
            $parm =~ s{LU\(}           {Fibonacci.lucas\(}g;
            $parm =~ s{KS\(}           {LongUtils.kronecker(}g;
            $parm =~ s{IU\.}           {IntegerUtils\.}g;
            $parm =~ s{JF\(}           {Jaguar.factor(}g;
            $parm =~ s{MU\(}           {Mobius.mobius\(}g;
            $parm =~ s{PM\(}           {Puma.primeZ\(}g;
            $parm =~ s{IPP\(}          {isProbablePrime\(}g;
            $parm =~ s{PA\(}           {new Pair<Integer, Integer>(\(}g;
            $parm =~ s{PR\(}           {Integers.SINGLETON.product\(}g;
            $parm =~ s{PT\(}           {IntegerPartition.partitions\(}g;
            $parm =~ s{RD\(}           {Rationals.SINGLETON.sumdiv\(}g;
            $parm =~ s{RP\(}           {Rationals.SINGLETON.sopf\(}g;
            $parm =~ s{RQ\(}           {Rationals.SINGLETON.product\(}g;
            $parm =~ s{RR\(}           {ZUtils.reverse\(}g;
            $parm =~ s{RU\(}           {Rationals.SINGLETON.sum\(}g;
            $parm =~ s{SD\(}           {Integers.SINGLETON.sumdiv\(}g;
            $parm =~ s{SDA\(}          {ZUtils.sortDigitsAscending\(}g;
            $parm =~ s{SDD\(}          {ZUtils.sortDigitsDescending\(}g;
            $parm =~ s{SP\(}           {Integers.SINGLETON.sopf\(}g;
            $parm =~ s{SU\(}           {Integers.SINGLETON.sum\(}g;
            $parm =~ s{S1\(}           {Stirling.firstKind\(}g;
            $parm =~ s{SA\(([^\)]+)\)} {Stirling.firstKind\($1\)\.abs\(\)}g;
            $parm =~ s{S2\(}           {Stirling.secondKind\(}g;
            $parm =~ s{ZE\(}           {Zeta.zeta\(}g;
            $parm =~ s{ZH\(}           {Zeta.zetaHurwitz\(}g;
            #               1      1    2      2  3    3  with "))" 
            $parm =~ s{ZNO\(([^\,]+)\, *([^\)]+)\)([\)])}   {new IntegersModMul\($2\)\)\.order\($1\)}g; # PARI's znorder(Mod(b,s)) -> new IntegersModMul(s).order(b)
            #               1      1    2      2  3     3 with ")."
            $parm =~ s{ZNO\(([^\,]+)\, *([^\)]+)\)([^\)])}  {new IntegersModMul\($2\)\.order\($1\)$3}g; # PARI's znorder(Mod(b,s)) -> new IntegersModMul(s).order(b)
            $parm =~ s{Z\_1\(}         {Z.NEG_ONE.pow\(}g;
            $parm =~ s{n\_1\(}         {(((n & 1) == 0) ? 1 : -1)}g;
            $parm =~ s{Z2\(}           {Z.TWO.pow\(}g;
            $parm =~ s{\.\*\(}         {.multiply\(}g;
            $parm =~ s{\.\/\(}         {.divide\(}g;
            $parm =~ s{\.\+\(}         {.add\(}g;
            $parm =~ s{\.\-\(}         {.subtract\(}g;
            $parm =~ s{\.\^\(}         {.pow\(}g;
            $parm =~ s{\.(\d|10)\b}    {"Z.$zhash{$1}"}eg;
        #   bad for lambdaQ expressions:
        #   $parm =~ s{\.multiply\(2\)}{.multiply2\(\)}g;
        #   $parm =~ s{\.divide\(2\)}  {.divide2\(\)}g;
            $parm =~ s{\.pow\(2\)}     {.square\(\)}g;
            $parm =~ s{\.pow\(1\)}     {}g;
            $parms[$iparm] = $parm;
            #                      1            1
            $parms[$iparm] =~ s{\(\) *\-\> *}{}; # remove dummy lambda prefix
        }
        if ($parms[$iparm] !~ m{\~\~}) { # with statement separator
            @terms = map {
                if (length > $max_term_len) {
                    $max_term_len = length;
                }
                $_
        #   } split(/\,\s*/, $parms[$iparm]); # removes the spaces
            } split(/\,/, $parms[$iparm]);
        } else {
            @terms = ($parms[$iparm]);
        }
        if ($debug >= 2) {
            print "# start iparm=$iparm, terms=" . join(",", @terms) . "\n";
        }
        $copy =~ m{\$\(PARM$iparm(\.\w+)?\)}i;
        my $line_len = length($PREMATCH) || 0;
        my $type = $1 || "";
        my $term;
        my $len;
        my @typed_terms = ();
        foreach my $term (@terms) {
            if ($term =~ m{\/\*\*\/}) {
                $term = "";
            }
            if ($debug >= 2) {
                print "# before: type(PARM$iparm) = \"$type\", term=\"$term\"\n";
            }
            if (0) {
            } elsif (length($type) == 0) { # leave it, but replace "~~" -> newlines
                if ($term =~ m{\A\~\~([^\~]*)}) { # leading ~~ - special separator
                    my $separator = $1;
                    $separator =~ m{\A(\S*)(\s+.*)}; # separator has the form: head spaces tail
                    my $head = $1;
                    my $tail = $2;
                    $tail = $separator; # new logic
                    $head = "";
                    $term =~ s{\A\~\~([^\~]*)(\~\~)?}{}; # remove the separator
                    my $statements = "";
                    foreach my $part (split(/\~\~/, $term)) {
                        $statements .= "$tail$part$head\n";
                    }
                    $statements =~ s{\n\Z}{};
                    $term = $statements;
                } else { # infix ~~
                    $term =~ s{\~\~}{\"\n        , \"}g; # 8 spaces and comma
                }
            } elsif ($type =~ m{I}i)     { # normal int
                # term is unchanged
            } elsif ($type =~ m{L}i)     { # make 'long' constant
                if (length($term) > 16) {
                    print "# $aseqno length($term) > 16\n";
                    $do_generate = 0;
                }
                $term .= "L";
            } elsif ($type =~ m{Z}i)     { # construct new Z(String)
                $term = "new Z(\"$term\")";
            }
            $len = length($term);
            $line_len += $len + 1; # 1 for ",";
            if ($debug >= 2) {
                print "# after : type(PARM$iparm) = \"$type\", term=\"$term\"\n";
            }
            push(@typed_terms, $term)
        } # foreach $term
        my $parm = join(",", @typed_terms);
        if ($parms[$iparm] =~ m{(\, ?)\Z}) { 
            $parm .= $1;
        }
        if ($parm eq "") { # remove empty line
            $copy =~ s{\n\s*\$\(PARM$iparm(\.\w+)?\)\s*\n}{\n}g;
        }
        $copy =~ s{\$\(PARM$iparm(\.\w+)?\)}{$parm}g;
        $iparm ++;
    } # while $iparm

    $copy =~ s{(\, *)+\)}{\)}; # remove trailing commas from parameter lists
    if (0) {
    } elsif ($contains_nyi > 0) {
        print "# $aseqno " . join(" ", $callcode, splice(@parms, 0, $contains_nyi)) . " ... skipped\n";
    } elsif ($copy =~ m{\$\((PARM\d)}) {
        print "# $aseqno $1 not replaced - skipped\n";
        if ($debug >= 1) {
            print "$copy\n================================\n";
        }
    } elsif ($do_generate > 0) {
        &write_output($copy, $aseqno);
    } else {
        print "# $aseqno has too big parameter values - skipped\n";
    }
    &clean_imports();
} # while <>
print STDERR "# $gen_count sequences generated\n";
#-----------------
sub write_output {
    my ($copy, $aseqno) = @_; # global $old_package, $gen_count, $debug
    my $call1 = ($cc eq $callcode) ? $cc : "$cc/$callcode"; 
    map {
        my $line = $_;
        if ($line !~ m{\A\s*\*\s+}) {
            &extract_imports($line, $TYPE_TEMP);
        }
        $line
        } split(/\n/, $copy);
    # print STDERR "# name $aseqno: $name\n";
    $copy =~ s{\$\(ASEQNO\)}         {$aseqno}g;
    $copy =~ s{\$\(AUTHOR\)}         {$author}g;
    $copy =~ s{\$\(CALLCODE\)}       {$call1}g;
    $copy =~ s{\$\(DATE\)}           {$timestamp}g;
    $copy =~ s{\$\(GEN\)}            {$0}g;
    $copy =~ s{\$\(IMPORT\)}         {&get_imports($aseqno)}eg;
    $copy =~ s{\$\(PROG\)}           {$version_id}g;
    $copy =~ s{\$\(NAME\)}           {$name}g;
    $copy =~ s{\$\(OFFSET\) *\- *1}  {$offset - 1}eg;
    $copy =~ s{mN\s*\=\s*(\d+)\s*\-\s*1\s*\;}{"mN = " . ($1 - 1) . ";"}e;
    $copy =~ s{\$\(OFFSET\)}         {$offset}g;
    $copy =~ s{\$\(PACK\)}           {$package}g;
    $copy =~ s{\.(multiply|divide)\(1\)|\.(add|subtract)\(0\)}{}g;
    my $package = lc(substr($aseqno, 0, 4));
    # print STDERR "==> $maindir/$package/$aseqno.java ?\n";
    if ($clobber == 1 or (! -r "$maindir/$package/$aseqno.$ext")) { # overwrite or does not yet exist
        my $packdir = "$targetdir/$package";
        if (! defined($dirs{$packdir}) or ! -d "$packdir") { # tarpath not yet readable
            $dirs{$packdir} = 1;
            mkdir($packdir);
            print STDERR "mkdir $packdir\n";
        }
        my $filename = "$packdir/$aseqno$ext";
        open(OUT, ">", $filename) || die "cannot write \"$filename\"\n";
        print OUT $copy;
        close(OUT);
        if ($debug >= 1) {
            print "--------------------------------\n";
            print $copy;
        } # debug
        $gen_count ++;
    } # overwrite
} # write_output
#--------------------------------
sub read_pattern { # read the pattern and return it
    my ($patfile) = @_;
    %imports = (); # start with no imports
    my $state = "init";
    my $result = "";
    if (open(PAT, "<", "$patfile") != 0) {
        while (<PAT>) {
            my $patline = $_; # no chompr!
            if ($debug >= 2) {
              print "# patline=$patline";
            }
            if ($state eq "init" and ($patline =~ m{\A\s*\Z})) {
                $state =  "next";
                $result .= "\n\$(IMPORT)\n";
                $patline = "";
            }
            if ($patline =~ m{\A\s*import +([\w\.]+)\;}) {
                my $class = $1;
                $imports{$class} = $TYPE_PERM; # permanent for this pattern
                $patline = "";
            } else {
                &extract_imports($patline, $TYPE_PERM);
            }
            $result .= $patline;
        } # while <PAT>
        close(PAT);
        if ($debug >= 1) {
            print "# pattern: \n$result";
        }
    } else {
        print STDERR "#* cannot read \"$patfile\" for $aseqno\n";
        $do_generate = 0;
    }
    return $result;
} # read_pattern
#--------------------------------
sub clean_imports { # remove all temporary imports, keep the ones from the pattern only
    my @permkeys = grep { $imports{$_} == $TYPE_PERM } keys(%imports);
    %imports = ();
    foreach my $key (@permkeys) {
        $imports{$key} = $TYPE_PERM;
    } # foreach
} # clean_imports
#--------------------------------
sub extract_imports { # look for Annnnnnn, ZUtils. StringUtils. CR. etc.
    my ($line, $itype) = @_; # 1 = permanent for this pattern, 2 = temporary
    my @aseqnos = ($line =~ m{(A\d{6})}g);
    foreach my $aseqno (@aseqnos) {
        $imports{"irvine.oeis." . lc(substr($aseqno, 0, 4)) . ".$aseqno"}                               = $itype;
    } # foreach                                                                                     
    if ($line =~ m{\WAbsoluteSequence}             ) { $imports{"irvine.oeis.AbsoluteSequence"  }                = $itype; }
    if ($line =~ m{\WBellNumbers\.}                ) { $imports{"irvine.math.z.BellNumbers"     }                = $itype; }
    if ($line =~ m{\WBernoulliSequence}            ) { $imports{"irvine.math.q.BernoulliSequence" }              = $itype; }
    if ($line =~ m{\WBinomial\.}                   ) { $imports{"irvine.math.z.Binomial"}                        = $itype; }
    if ($line =~ m{\WCarmichael}                   ) { $imports{"irvine.math.z.Carmichael"                     } = $itype; }
    if ($line =~ m{\WCC\W}                         ) { $imports{"irvine.math.cc.CC"}                             = $itype; }
    if ($line =~ m{\WComputableComplexField}       ) { $imports{"irvine.math.cr.ComputableComplexField"}         = $itype; }
    if ($line =~ m{\WCR\W}                         ) { $imports{"irvine.math.cr.CR"}                             = $itype; }
    if ($line =~ m{\WComputableReals}              ) { $imports{"irvine.math.cr.ComputableReals"}                = $itype; }
    if ($line =~ m{\WConvolutionProduct}           ) { $imports{"irvine.oeis.transform.ConvolutionProduct"}      = $itype; }
    if ($line =~ m{\WCyclotomic}                   ) { $imports{"irvine.nt.cyclotomic.Cyclotomic"}               = $itype; }
    if ($line =~ m{\WDecimalExpansionSequence}     ) { $imports{"irvine.oeis.cons.DecimalExpansionSequence"    } = $itype; }
    if ($line =~ m{\WDifferenceSequence}           ) { $imports{"irvine.oeis.DifferenceSequence"               } = $itype; }
    if ($line =~ m{\WDirectSequence}               ) { $imports{"irvine.oeis.DirectSequence"                   } = $itype; }
    if ($line =~ m{\WEuler\.}                      ) { $imports{"irvine.math.z.Euler"           }                = $itype; }
    if ($line =~ m{\WFACTORIAL\.}                  ) { $imports{"irvine.math.factorial.MemoryFactorial"}         = $itype; }
    if ($line =~ m{\WFactorSequence}               ) { $imports{"irvine.factor.util.FactorSequence"}             = $itype; }
    if ($line =~ m{\WFactorUtils}                  ) { $imports{"irvine.factor.util.FactorUtils"               } = $itype; }
    if ($line =~ m{\WFibonacci\.}                  ) { $imports{"irvine.math.z.Fibonacci"}                       = $itype; }
    if ($line =~ m{\WFilterPositionSequence}       ) { $imports{"irvine.oeis.FilterPositionSequence"           } = $itype; }
    if ($line =~ m{\WFilterSequence}               ) { $imports{"irvine.oeis.FilterSequence"                   } = $itype; }
    if ($line =~ m{\WGaussianIntegers\.}           ) { $imports{"irvine.math.group.GaussianIntegers"}            = $itype; }
    if ($line =~ m{\WGeneratingFunctionSequence}   ) { $imports{"irvine.oeis.recur.GeneratingFunctionSequence" } = $itype; }
    if ($line =~ m{\WHankelTransformSequence}      ) { $imports{"irvine.oeis.transform.HankelTransformSequence"} = $itype; }
    if ($line =~ m{\WHolonomicRecurrence}          ) { $imports{"irvine.oeis.recur.HolonomicRecurrence"}         = $itype; }
    if ($line =~ m{\WIntegerPartition}             ) { $imports{"irvine.math.partitions.IntegerPartition"}       = $itype; }
    if ($line =~ m{\WIntegerUtils\.}               ) { $imports{"irvine.math.IntegerUtils"}                      = $itype; }
    if ($line =~ m{\WIntegers\.}                   ) { $imports{"irvine.math.z.Integers"}                        = $itype; }
    if ($line =~ m{\WIntegersMod\(}                ) { $imports{"irvine.math.group.IntegersMod"                } = $itype; }
    if ($line =~ m{\WIntegersModMul\(}             ) { $imports{"irvine.math.group.IntegersModMul"             } = $itype; }
    if ($line =~ m{\WInverse\b}                    ) { $imports{"irvine.oeis.triangle.Inverse"  }                = $itype; }
    if ($line =~ m{\WJaguar\.}                     ) { $imports{"irvine.factor.factor.Jaguar"   }                = $itype; }
    if ($line =~ m{\WLinearRecurrence}             ) { $imports{"irvine.oeis.recur.LinearRecurrence"}            = $itype; }
    if ($line =~ m{\WLongUtils\.}                  ) { $imports{"irvine.math.LongUtils"}                         = $itype; }
    if ($line =~ m{\WMemoryFactorial}              ) { $imports{"irvine.math.factorial.MemoryFactorial"}         = $itype; }
    if ($line =~ m{\WMultiplicativeSequence}       ) { $imports{"irvine.oeis.MultiplicativeSequence"           } = $itype; }
    if ($line =~ m{\WMobius}                       ) { $imports{"irvine.math.Mobius"}                            = $itype; }
    if ($line =~ m{\WPaddingSequence}              ) { $imports{"irvine.oeis.recur.PaddingSequence" }            = $itype; }
    if ($line =~ m{\WPair}                         ) { $imports{"irvine.util.Pair" }                             = $itype; }
    if ($line =~ m{\WPeriodicSequence}             ) { $imports{"irvine.oeis.recur.PeriodicSequence"}            = $itype; }
    if ($line =~ m{\WPolynomialUtils}              ) { $imports{"irvine.math.polynomial.Polynomial"}             = $itype; }
    if ($line =~ m{\WPolynomial}                   ) { $imports{"irvine.math.polynomial.Polynomial"}             = $itype; }
    if ($line =~ m{\WPrependSequence}              ) { $imports{"irvine.oeis.PrependSequence"   }                = $itype; }
    if ($line =~ m{\WProduct}                      ) { $imports{"irvine.oeis.triangle.Product"  }                = $itype; }
    if ($line =~ m{\WPuma}                         ) { $imports{"irvine.factor.prime.Puma"      }                = $itype; }
    if ($line =~ m{\WQ\W}                          ) { $imports{"irvine.math.q.Q"}                               = $itype; }
    if ($line =~ m{\WRationals\.}                  ) { $imports{"irvine.math.q.Rationals"}                       = $itype; }
    if ($line =~ m{\WRecordPositionSequence}       ) { $imports{"irvine.oeis.RecordPositionSequence"}            = $itype; }
    if ($line =~ m{\WSequence(\d|\$\(OFFSET\))}    ) { $imports{"irvine.oeis.Sequence$1" }                       = $itype; }
    if ($line =~ m{\WSimpleTransformSequence}      ) { $imports{"irvine.oeis.transform.SimpleTransformSequence"} = $itype; }
    if ($line =~ m{\WSkipSequence}                 ) { $imports{"irvine.oeis.SkipSequence"      }                = $itype; }
    if ($line =~ m{\WStirling\.}                   ) { $imports{"irvine.math.z.Stirling"}                        = $itype; }
    if ($line =~ m{\WStringUtils\.}                ) { $imports{"irvine.util.string.StringUtils"}                = $itype; }
    if ($line =~ m{\WTranspose}                    ) { $imports{"irvine.oeis.triangle.Transpose"}                = $itype; }
    if ($line =~ m{\WUnaryCRFunction}              ) { $imports{"irvine.math.cr.UnaryCRFunction"}                = $itype; }
    if ($line =~ m{\WZUtils\.}                     ) { $imports{"irvine.math.z.ZUtils"}                          = $itype; }
    if ($line =~ m{\WZi\W}                         ) { $imports{"irvine.math.zi.Zi"}                             = $itype; }
    if ($line =~ m{\WZ\W}                          ) { $imports{"irvine.math.z.Z"}                               = $itype; }
    if ($line =~ m{\WZeta\.}                       ) { $imports{"irvine.math.cr.Zeta"}                           = $itype; }
    delete($imports{"irvine.oeis.Sequence"});
    if ($line !~ m{\A\s*(\/\/|\/\*|\*)}) { # no comment line
        my @shields = ();
        my $ish = 0;
        #                   1      1
        while ($line =~ s{\"([^\"]*)\"}{\#$ish}) { # shield strings
        	push(@shields, $1);
        	$ish ++;
        }
        while (($line =~ s{[^\(\.\@\w]([A-Z][\.\w\_]+)}{}) > 0)  { # non-name followed by Java classname starting with uppercase
            my $class_name = $1; 
            # look it up in the imports accumulated so far
            $class_name =~ m{\.(\w+)\Z};
            my $last_name = $1;
            my $found = 0;
            foreach my $key (keys(%imports)) {
                if (($key =~ m{\.$last_name\Z}) || ($key =~ m{cheat\.bridge})) {
                    $found = 1;
                }
            } # foreach $key
            if ($found) { # already there - do nothing
            } elsif ( $class_name =~ m{Transform}) {          # .transform.xxx
                $imports{"irvine.oeis.transform.$class_name"} = $itype;
            } elsif (($class_name !~ m{\AA\d+})               # A-number
                &&   ($class_name !~ m{\.})                   # contains dot
                &&   ($class_name !~ m{\A[A-Z\_]+\d?\Z})      # only uppercase = constant; POWER2
                &&   ($class_name !~ m{\A(String|Integer|Long|Boolean|StringBuilder)\Z}) # common Java types
                &&   ($class_name !~ m{\AComputableReals\Z})
                &&   ($class_name !~ m{\AUnaryCRFunction\Z})
                &&   ($class_name !~ m{\AFunction\Z})
               ) {
                $imports{"irvine.oeis.$class_name"} = $itype; 
            }
        } # Java classname
        $ish = 0;
        #                   1   1
        while ($line =~ s{\#(\d+)}{\"$shields[$ish]\"}) { # unshield strings
        	$ish ++;
        }
    } # no comment
    if ($debug >= 2) {
        print "# imports: " . join(",", map { "$_\($imports{$_}\)" } sort(keys(%imports))) . "\n";
    } # debug
    delete($imports{"irvine.oeis.CR"});
} # extract_imports
#--------------------------------
sub get_imports {
    my ($aseqno) = @_;
    my $result = "";
    foreach my $key (sort(keys(%imports))) {
        if ($key !~ m{\.$aseqno}) { # do not self-import the sequence to be generated
            $result .= "\nimport $key;";
        }
    } # foreach
    return length($result) > 0 ? substr($result, 1) : $result; # ignore leading "\n"
} # get_imports
#--------------------------------
__DATA__
package irvine.oeis.$(PACK);
// Generated by gen_pattern.pl - do NOT edit here!

import irvine.math.z.Z;
import irvine.oeis.PeriodicSequence;
import irvine.oeis.PrependSequence;

/**
 * $(ASEQNO) $(NAME)
 * @author $(AUTHOR)
 */
public class $(ASEQNO) extends PrependSequence {

  /** Construct the sequence. */
  public $(ASEQNO)() {
    super(new PeriodicSequence($(PARM3)), Z.valueOf($(PARM2)));
  }
}
#------------------------------
package irvine.oeis.a010;

import irvine.math.z.Z;
import irvine.oeis.PeriodicSequence;
import irvine.oeis.PrependSequence;

/**
 * A010237 Continued fraction for sqrt(199).
 * @author Sean A. Irvine
 */
public class A010237 extends PrependSequence {

  /** Construct the sequence. */
  public A010237() {
    super(new PeriodicSequence(9, 2, 1, 2, 2, 5, 4, 1, 1, 13, 1, 1, 4, 5, 2, 2, 1, 2, 9, 28), Z.valueOf(14));
  }
}
