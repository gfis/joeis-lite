#!perl

# Extract parameters for complementary equations
# 2020-09-26, Georg Fischer
#
#:# Usage:
#:# grep -iE "complementary eq" $(COMMON)/joeis_names.txt \
#:# | grep -vE "self\-complementary|musical|Golay" \
#:# | perl compleq.pl [-d debug] > compleq.gen 2> compleq.rest.tmp
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $callcode = "compleq";
my ($aseqno, $superclass, $name, @rest);
my $heres; # which sequence gives the OEIS terms (a, b, c ...)
my $receq; # recurrence equation
my $where; # raw condition
my %inits; # for initial values
my $letters = "abcdefgh";
my $is_ok;
my @summands; # in the right side of the recurrence equation
my $base_aseqno = "";
my $line;

while (<>) {
    $line = $_;
    $is_ok = 1;
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    $name =~ s{\s*[\;\.]\s*see comment.*}{}i;
    $callcode = "compleq";
    if (0) {
    #                              1           2                         3                               4       5   6            7
    } elsif ($name =~ m{\ASolution (sequence )?([abcdefghn\(\) ]*)of the (near\-)?complementary equation ([^\,]+)(\, (with|where) ([^\.]+))?}) {
        $heres = $2 || 'a';
        $receq = $4;
        $where = $7 || "";
        #--
        $heres =~ s{[\(\)n ]}{}g; # keep 1 letter a-h only
        $heres = ord($heres) - ord('a');
        $where =~ s{ }{}g; # remove spaces
        $where =~ s{\,\,+}{\,}g; # single comma
        $where =~ s{(\,and|\;see).*}{}; # remove further text
        %inits = ();
        foreach my $init (split(/[\,\;]/, $where)) {
            my ($var, $value) = split(/\=/, $init);
            if (! defined($var)) {
                print STDERR "# undefined var, init=\"$init\", line=$line";
                $var = 'a';
            }
            $inits{$var} = $value;
        } # foreach $init
        #--
        $receq =~ s{ }{}g; # remove spaces
        $receq =~ s{(\d+)([a-z])}{$1\*$2}g; # insert missing "*"s
        $is_ok = eval_summands($receq);
    } else {
        $is_ok = 0;
    }
    if ($is_ok) {
        &output();
    } else {
        print STDERR $line;
    }
} # while <>
#----
sub eval_summands {
    my ($receq) = @_;
    my $is_ok = 1;
    my ($left, $right) = split(/\=/, $receq);
    if ($left eq "a(n)") {
        if (0) {
        } elsif ($right =~ m{a\(0\)\*b\(n\-1\)\+a\(1\)\*b\(n\-2\)\+\.\.\.\+a\(n\-1\)\*b\(0\)}) {
            $callcode = "compl_p"; # "product"
            $right =~ s{\+\.\.\.}{}; # treat it in jpat or manually
        } elsif ($right =~ m{\.\.\.}) {
            $callcode = "compl_s"; # "sum"
            $right =~ s{\+\.\.\.}{}; # treat it in jpat or manually
        }
        $right =~ s{\)([\+\-])}{\);$1}g;  # )+   -> );+
        $right =~ s{([\+\-])n}{${1}n\;}g; # +n-1 -> +n;-1
        $right =~ s{n\;\*([abcdefgh])\(}{n\*$1\(}g; # but not for +n*b(
        @summands = split(/\;/, $right);
    } else {
        $is_ok = 0;
    }
    return $is_ok;
} # eval_summands
#----
sub output {
    my $iterms = "";
    if ($debug >= 2) {
        print "# inits: ";
        foreach my $key (sort(keys(%inits))) {
            print "$key=$inits{$key} ";
        }
        print "\n";
    }
    my @matrix = ();
    my $max_letter = "a";
    foreach my $key (sort(keys(%inits))) { # store the initial assignments in a matrix
        if ($key !~ m{\A$max_letter}) {
            $max_letter = substr($key, 0, 1); # first letter
        }
        my $ix = ord($max_letter) - ord('a');
        $key =~ m{(\d+)}; # may even be 2 digits with this complicated code
        my $iy = $1;
        $matrix[$ix][$iy] = $inits{$key};
    } # foreach $key

    my $nix = ord($max_letter) - ord('a') + 1;
    if ($debug >= 2) {
        print "# nix=$nix\n";
    }
    my $ix = 0;
    my @iterms = ();
    while ($ix < $nix) { # flatten the matrix
        my $list = "\"[";
        my $iy = 0;
        while (defined($matrix[$ix][$iy])) {
            if ($iy > 0) {
                $list .= ",";
            }
            $list .= $matrix[$ix][$iy];
            $iy ++;
        } # while $iy
        $list .= "]\"";
        $iterms[$ix ++] = $list;
    } # while $ix

    my $adjunct = "";
    my @afactors = ();
    my @constant = ();
    my $isd = 0;
    my $maxdist = 0;
    my $maxexp  = 0;
    my $with_dots = 0;
    while ($isd < scalar(@summands)) {
        my $sumd = $summands[$isd ++];
        $sumd =~ s{\A([^\+\-])}{\+$1}; # prefix with "+" if no sign
        if ($debug >= 1) {
            print "# sumd=\"$sumd\"\n";
        }
        if (0) {
        } elsif ($sumd =~ m{\A([\+\-])?((\d+)\*?)?a\(n\-(\d+)\)\Z}) { # main sequence, +2*a(n-1)
            my $sign   = $1 || "+";
            my $factor = $3 || 1;
            my $dist   = $4 || 0;
            $afactors[$dist] = "$sign$factor";
            if ($dist > $maxdist) {
                $maxdist = $dist;
            }
        } elsif ($sumd =~ m{\A([\+\-])?((\d+)\*?)?n(\^(\d+))?\Z}) { # polynomial in n, +2*n^m
            my $sign   = $1 || "+";
            my $factor = $3 || 1;
            my $expon  = $5 || 1;
            $constant[$expon] = "$sign$factor";
            if ($expon  > $maxexp ) {
                $maxexp  = $expon ;
            }
        } elsif ($sumd =~ m{\A([\+\-])?(\d+)\Z}) { # single constant, +1
            my $sign   = $1 || "+";
            my $factor = $2 || 1;
            $constant[0] = "$sign$factor";
        } elsif ($sumd =~ m{\A([\+\-])?floor(.*)}) { # ignore "floor( )"
            $adjunct  .= "$1$2";
        } else { # everything else, a,b,c ... mixed
            if ($sumd =~ m{([\+\-])?(.+)\^2\Z}) { # expand ^2, squared
                $sumd = "$1$2\*$2";
            }
            $adjunct .= $sumd;
            #            1        23         4
            $sumd =~ m{([b-h])};
            my $letter = $1;
            if (! defined($letter)) {
                print STDERR "# undef letter, sumd=\"$sumd\", line=$line";
            } else {
                my $compl_seqno = ord($letter) - ord('a');
                if ($compl_seqno >= scalar(@iterms)) {
                    push(@iterms, "\"[]\""); # had no initial settings
                }
            }
        }
    } # while $isd
    $name =~ s{Solution of the complementary equation }{};
    my $recurrence .= "[";
    my $sep = "[";
    for (my $iexp = 0; $iexp <= $maxexp; $iexp ++) {
        $recurrence .= $sep . ($constant[$iexp] || 0);
        $sep = ",";
    }
    $recurrence .= "]";
    for (my $dist = $maxdist; $dist > 0; $dist --) { # build the holonomic matrix
        $recurrence .= ",[" . ($afactors[$dist] || 0) . "]";
    }
    $recurrence .= ",[-1]]"; # for annihilator: ... -a(n) == 0
    $recurrence  =~ s{([\[\,])\+}{$1}g;
    $adjunct     =~ s{\A\+}{}; # remove leading +
    if (0) {
    } elsif ($callcode eq "compl_p") {
        $adjunct = "prod";
    } elsif ($callcode eq "compleq") {
        $ix = 0; # sequence a
        my $iy = 0;
        while (defined($matrix[$ix][$iy])) {
            $adjunct =~ s{a\($iy\)}{$matrix[$ix][$iy]}g; # replace a(0), a(1) ... in $adjunct
            $iy ++;
        } # while a($iy)
    } elsif ($callcode eq "compl_s") {
        $adjunct = ($adjunct =~ m{b\(0\)}) ? 0 : 1;
    }
    print join("\t", $aseqno, $callcode, 0, $base_aseqno, $heres, "\"$recurrence\""
        , join(",", @iterms), $adjunct, "", "", "", $name) . "\n";
} #
#================================
__DATA__
A022424 Sequence    Solution a( ) of the complementary equation a(n) = b(n-1) + b(n-2), where a(0) = 1, a(1) = 2; see Comments. nonn,changed,   0..10000
A022425 A022424 Solution a( ) of the complementary equation a(n) = b(n-1) + b(n-2), where a(0) = 1, a(1) = 4; see Comments. nonn,   0..10000
A022426 A022424 Solution a( ) of the complementary equation a(n) = b(n-1) + b(n-2), where a(0) = 2, a(1) = 3; see Comments. nonn,   0..10000
A136495 null    Solution of the complementary equation b(n)=a(a(n))+n.  nonn,   1..10000
A136496 null    Solution of the complementary equation b(n)=a(a(n))+n; this is sequence b; sequence a is A136495.   nonn,synth  1..60
A136497 null    Solution of the complementary equation b(n)=a(a(n))+a(n).   nonn,synth  1..71
A136498 null    Solution of the complementary equation b(n)=a(a(n))+a(n); this is the sequence b. Sequence a is A136497.    nonn,synth  1..59
A136499 null    Solution of the complementary equation b(n)=a(a(n))+a(n)+1; this is the sequence a. Sequence b is A136500.  nonn,synth  1..72
A136500 null    Solution of the complementary equation b(n)=a(a(n))+a(n)+1; this is the sequence b. Sequence a is A136499.  nonn,synth  1..58
A138253 null    Beatty discrepancy of the complementary equation b(n) = a(a(n)) + n.    nonn,synth  1..105
A293057 null    Solution of the complementary equation a(n) = a(n-1) + a(n-2) + b(n-2) + 2, where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.   nonn,easy,synth 0..36
A293058 null    Solution of the complementary equation a(n) = a(n-1) + a(n-2) + b(n-2) + 3, where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.   nonn,easy,synth 0..35
A293076 null    Solution of the complementary equation a(n) = a(n-1) + a(n-2) + b(n-2), where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.   nonn,easy,changed,synth 0..36
A293316 null    Solution of the complementary equation a(n) = a(n-1) + a(n-2) + b(n-2) + 1, where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.   nonn,easy,synth 0..36
A294381 null    Solution of the complementary equation a(n) = a(n-1)*b(n-2), where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.  nonn,easy,  0..49
A294382 null    Solution of the complementary equation a(n) = a(n-1)*b(n-2) - 1, where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.  nonn,more,synth 0..12
A294383 null    Solution of the complementary equation a(n) = a(n-1)*b(n-2) + 1, where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.  nonn,more,synth 0..12
A294384 null    Solution of the complementary equation a(n) = a(n-1)*b(n-2) - n, where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.  nonn,more,synth 0..13
A294385 null    Solution of the complementary equation a(n) = a(n-1)*b(n-2) + n, where a(0) = 1, a(1) = 3, b(0) = 2, b(1) = 4.  nonn,more,synth 0..12
A297468 null    Solution (b(n)) of the system of 2 complementary equations in Comments. nonn,easy,  0..1000
A297469 null    Solution (bb(n)) of the system of 3 complementary equations in Comments.    nonn,easy,changed,  0..10000
A297826 null    Solution (a(n)) of the near-complementary equation a(n) = a(1)*b(n-1) - a(0)*b(n-2) + n, where a(0) = 1, a(1) = 2, b(0) = 3, b(1) = 4, and (b(n)) is the increasing sequence of positive integers not in (a(n)).  See Comments. nonn,easy,  0..10000
A297830 null    Solution of the complementary equation a(n) = a(1)*b(n-1) - a(0)*b(n-2) + 2*n, where a(0) = 1, a(1) = 2, b(0) = 3, b(1) = 4, and (b(n)) is the increasing sequence of positive integers not in (a(n)).  See Comments.   nonn,easy,  0..10000
A297831 null    Solution of the complementary equation a(n) = a(1)*b(n-1) - a(0)*b(n-2) + 2*n - 1, where a(0) = 1, a(1) = 2, b(0) = 3, b(1) = 4, and (b(n)) is the increasing sequence of positive integers not in (a(n)).  See Comments.   nonn,easy,  0..10000


