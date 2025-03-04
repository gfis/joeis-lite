#!perl

# Read joeis/src/irvine/oeis/PolynomialFieldSequence.java and extract known operations
# @(#) $Id$
# 2025-02-28, Georg Fischer: TF für BP in B
#
#:# Usage:
#:#   perl read_pfs.pl [-d debug] ../../../src/irvine/oeis/PolynomialFieldSequence.java > outfile.gen
#:#
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $pwd = `pwd`;
$pwd =~ m{(\/joeis\-lite\/internal\/fischer\S*)};  
$pwd = $1;
my $mode = "u";
my $debug = 0;
my $callcode = "functions";
my $offset = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $mode      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %hoper = ();
my $oper;
my $state = 1;
my $ix = 0;
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    if ($debug >= 1 && $state != 4) {
        print "state=$state: ";
    }
    if (0) {
    } elsif ($state == 1) { # before switch
        if ($line =~ m{\A\s*switch[^\{]+\{\s*\/\/\!}) {
            $ix = 0;
            $state = 2;
        }
        print "$line\n";
    } elsif ($state == 2) { # in switch - collect the indexes
        if (0) {
        #                     1          12  2
        } elsif ($line =~ m{\A(\s*case\s*)(.*)}) {
            my $start = $1;
            my $rest  = $2;
            my ($string, $comment);
            if (0) {
            #                     1   1     2            3      3  4  42
            } elsif ($rest =~ s{\A(\d+)\s*\:(\s*\/\/\s*\"([^\"]+)\"(.*))?}{$ix$2}) { # already case on number
                $comment = $2 || "";
                $string  = $3;
                $rest = "$ix\: $2";
                $line = "$start$rest";
            #                       1      1       2  2
            } elsif ($rest =~ m{\A\"([^\"]+)\"\s*\:(.*)}) { # still case on string
                $string  = $1;
                $comment = $2;
                $comment =~ s{\A\s*\/\/}{};
                $rest = "$ix\: // \"$string\" $comment";
                $line = "$start$rest";
            }
            $hoper{$string} = $ix;
            $ix ++;
        } elsif ($line =~ m{\A\s*\}\s*\/\/\!\s*switch}) {
            $state = 3;
        }
        print "$line\n";
    } elsif ($state == 3) { # before fillMap
        print "$line\n";
        if (0) {
        } elsif ($line =~ m{\A\s*private\s+void\s+fillMap\(\)\s+\{\s*\/\/\!}) {
            print "    // Updated by gits$pwd/$0 at $timestamp\n";
            $state = 4;
        }
    } elsif ($state == 4) { # in fillMap
        if (0) {
        } elsif ($line =~ m{\A\s*\}\s*\/\/\!\s*fillMap}) {
            foreach my $key (sort(keys(%hoper))) {
                print "    sPostMap.put(\"$key\", $hoper{$key});\n";
            }
            $state = 5;
            print "$line\n";
        } else { # ignore old fillMap lines
        }
    } elsif ($state == 5) { # before fillMap
        print "$line\n";
    } else {
    }
} # while <>
__DATA__

print <<'GFis';
  private final Stack<Polynomial<Q>> mStackPol = new Stack<>();
  private static final HashMap<String, Integer> sFunctions = new HashMap<String, Integer>(64);
  private static final ArrayList<BiFunction<Stack<Polynomial<Q>>, Integer, Polynomial<Q>>> sLambda = new ArrayList<>(64);
  private static void setPost1(final int ipost, final String key, final BiFunction<Stack<Polynomial<Q>>, Integer, Polynomial<Q>> lambda) {
    sLambda.set(ipost, lambda);
    sFunctions.put(key, ipost);
  }

  {
    int ix = 0;
    setPost1(++ix, "A"     , (stack, m) -> null; // 1
    setPost1(++ix, "sub"   , (stack, m) -> null; // 2
    setPost1(++ix, "p"     , (stack, m) -> null; // 3
    setPost1(++ix, "<"     , (stack, m) -> null; // 4
    setPost1(++ix, "^"     , (stack, m) -> { Polynomial<Q> op2 = stack.pop(); return RING.pow(stack.pop(), Long.parseLong(op2.toString()), m); });
    setPost1(++ix, "x"     , (stack, m) -> RING.x());   // 4
    setPost1(++ix, "+"     , (stack, m) -> { Polynomial<Q> op2 = stack.pop(); return RING.add(stack.pop(), op2); });
    setPost1(++ix, "-"     , (stack, m) -> { Polynomial<Q> op2 = stack.pop(); return RING.subtract(stack.pop(), op2); });
    setPost1(++ix, "*"     , (stack, m) -> { Polynomial<Q> op2 = stack.pop(); return RING.multiply(stack.pop(), op2, m + 1); });
    setPost1(++ix, "/"     , (stack, m) -> { Polynomial<Q> op2 = stack.pop(); return RING.series(stack.pop(), op2, m); });

GFis
my $ihop = 16; # leave the lower elements for complicated formulas to be set manually
for my $key (sort(keys(%hoper))) {
    print "    setPost1($ihop, " . sprintf("%-10s", "\"$key\"") . ", $hoper{$key});\n";
    $ihop ++;
} # for $key
print "  }\n\n";
exit(0);
#----
# append some additional ones
while(<DATA>) {
    if (m{^A\d+}) {
        print;
    }
} # while DATA
#   public static final Function2D DIGIT_SUM =  new DigitSum(); // =A001370(10, = A000120(2, -> A007953(10,
__DATA__
          case "lambertW": // current definition of LambertW works
            mStack.set(top, RING.lambertW(mStack.get(top), m));
            break;
          case "lambNegW": // workaround if only the "negated" version works - normally this should be identical with <code>lambertW</code>
            mStack.set(top, RING.negate(RING.lambertW(mStack.get(top), m)));
            break;

          case "<": // "<(\d+)" = shift x -> x^$1 (may be negative)
            mStack.set(top, RING.shift(mStack.get(top), (pfix.length() <= 1) ? 1 : Integer.parseInt(pfix.substring(1))));
            break;
