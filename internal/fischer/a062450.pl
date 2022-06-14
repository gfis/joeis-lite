#!perl
# 2022-06-14, Georg Fischer
use strict;
use integer;
use warnings;

my $unshield  = shift(@ARGV) || "";
my $precision = shift(@ARGV) || "";
while (<DATA>) {
    s/\s+\Z//; # chompr
    my ($aseqno, $callcode, $expr, $name) = map {
        s/\s+\Z//;
        s/\A\s+//;
        $_
    } split(/\t/);
    # shielding
    $expr =~ s{n\!}                         {cv[fact\[n\]\]}g;
    $expr =~ s{\(1\/n\^n\)}                 {cv[new Q[Z.ONE,zv[n].pow[n]]]}g;
    $expr =~ s{n\^n}                        {cv\[zv\[n\].pow\[n\]\]}g;
    $expr =~ s{\^\(n\-1\)}                  {.pow[n\-1\]}g;
    $expr =~ s{\^sqrt\(n\)}                 {.pow[cv\[n\].sqrt\[\]\]}g;
    $expr =~ s{\(1\+log\(n\)\/n\)}          {\[CR\.ONE\.add\[cv\[n\]\.log\[\].divide\[cv\[n\]\]\]\]}g;
    $expr =~ s{1\+log\(n\)}                 {CR\.ONE\.add\[cv\[n\]\.log\[\]\]}g;
    $expr =~ s{sqrt\(n\)}                   {cv\[n\].sqrt\[\]}g;
    $expr =~ s{log\(i\)}                    {cv\[i\].log\[\]}g;
    $expr =~ s{\^log\(n\)}                  {.pow\[cv\[n\].log\[\]\]}g;
    $expr =~ s{log\(n\)}                    {cv\[n\].log\[\]}g;
    $expr =~ s{log\(1\+i\)}                 {cv\[1\+i\].log\[\]}g;
    $expr =~ s{log\(1\+n\)}                 {cv\[1\+n\].log\[\]}g;
    $expr =~ s{\^\(\(1\-1\/n\)\^\(1\/n\)\)} {.pow\[CR.ONE.subtract\[cv\[new Q\[1,n\]\]\].pow\[cv\[new Q\[1\,n\]\]\]\]}g;
    $expr =~ s{\^\(1\-1\/n\)}               {.pow\[CR.ONE.subtract\[cv\[new Q\[1,n\]\]\]\]}g;
    $expr =~ s{\^\(\-1\/n\)}                {.pow\[cv\[new Q\[-1,n\]\]\]}g;
    $expr =~ s{\^\(1\/n\)}                  {.pow\[cv\[new Q\[1,n\]\]\]}g;
    while ($expr =~ m{\(1\+log(.*)\)\Z}) {
        $expr    =~ s{\(1\+log(.*)\)\Z}{CR\.ONE\.add[log$1\]};
    }
    while ($expr =~ m{log\(([^\)]+)\)}) {
        my $arg = $1;
        if ($arg =~ m{\An(.*)}) {
            $arg = "cv[n]$1";
        }
        $expr    =~ s{log\(([^\)]+)\)}     {$arg\.log\[\]};
    }
    if ($expr =~ m{\^(.*)}) {
        my $rest = $1;
        if ($rest !~ m{\^}) {
            $rest =~ s{\A\(n\.pow}{\(cv\[n\]\.pow};
            if ($rest =~ m{\A\(.*\)\Z}) {
                $rest =~ s{\A\(}{\[};
                $rest =~ s{\)\Z}{\]};
            }
            if ($rest !~ m{\A\[.*\]\Z}) {
                $rest = "[$rest]";
            }
            $expr =~ s{\^(.*)}{\.pow$rest}g;
        }
    }
    $expr =~      s{add\[1\+cv\[1\+n\]\.log\[\]\.log\[\]\]\]}
        {add\[CR\.ONE\.add\[cv\[1\+n\]\.log\[\]\.log\[\]\]\]\]};
    if ($unshield eq "-u") { # unshielding
        $expr =~ s{\bn\b}{mN}g;
        $expr =~ s{cv\[}         {CR.valueOf\[}g;
        $expr =~ s{zv\[}         {Z.valueOf\[}g;
        $expr =~ s{fact\[}       {MemoryFactorial\.SINGLETON\.factorial\[}g;
        $expr =~ s{prod\(}       {ComputableReals\.SINGLETON\.product\[}g;
        $expr =~ tr{\[\]}
                   {\(\)};
        if (0) {
        } elsif ($callcode eq "round") {
            $expr .= ".round($precision)";
        } elsif ($callcode eq "floor") {
            $expr .= ".floor($precision)";
        }
        if ($name =~ m{\Alog}) {
            $expr = "mN == 0 ? Z.ONE : $expr";
        }
    }
    # print join("\t", $aseqno, "simpler", 1, $expr, "", $name) . "\n";
    if ($expr =~ m{[\(\)\+\-\*\/]}) {
        print join("\t", $aseqno, "simple", 1, $expr, "", $name) . "\n";
    }
} # while DATA
__DATA__
A062458	round	cv[n+1].pow[n+1].divide[cv[n].pow[n]]       	(n+1)^(n+1)/n^n
A062413	floor	log(n!)^(1-1/n)                             	log(n!)^(1-1/n)
A062414	round	log(n!)^(1-1/n)                             	log(n!)^(1-1/n)
A062415	floor	log(n)^(n-1)                                	log(n)^(n-1)
A062416	round	log(n)^(n-1)                                	log(n)^(n-1)
A062417	floor	log(n!)^((1-1/n)^(1/n))                     	log(n!)^((1-1/n)^1/n)
A062418	round	log(n!)^((1-1/n)^(1/n))                     	log(n!)^((1-1/n)^1/n)
A062419	floor	log(n)^log(n)                               	log(n)^log(n)
A062420	round	log(n)^log(n)                               	log(n)^log(n)
A062421	floor	log(n!)^log(n)                              	log(n!)^log(n)
A062422	round	log(n!)^log(n)                              	log(n!)^log(n)
A062423	floor	log(n)^(sqrt(n).multiply[log(n)])           	log(n)^(sqrt(n)*log(n))
A062424	round	log(n)^(sqrt(n).multiply[log(n)])           	log(n)^(sqrt(n)*log(n))
A062425	floor	log(n!)^log(1+log(n))                       	log(n!)^log(1+log(n))
A062426	round	log(n!)^log(1+log(n))                       	log(n!)^log(1+log(n))
A062427	floor	log(n^n)^(1-1/n)                            	log(n^n)^(1-1/n)
A062428	round	log(n^n)^(1-1/n)                            	log(n^n)^(1-1/n)
A062429	floor	log(n^n)^((1-1/n)^(1/n))                    	log(n^n)^((1-1/n)^(1/n))
A062430	round	log(n^n)^((1-1/n)^(1/n))                    	log(n^n)^((1-1/n)^(1/n))
A062431	floor	log(n^n)^log(n)                             	log(n^n)^log(n)
A062432	round	log(n^n)^log(n)                             	log(n^n)^log(n)
A062433	floor	log(n^n)^log(1+log(n))                      	log(n^n)^log(1+log(n))
A062434	round	log(n^n)^log(1+log(n))                      	log(n^n)^log(1+log(n))
A062435	floor	log(n!)^log(log(1+n))                       	log(n!)^log(log(1+n))
A062436	round	log(n!)^log(log(1+n))                       	log(n!)^log(log(1+n))
A062437	floor	log(n^n)^log(log(1+n))                      	log(n^n)^log(log(1+n))
A062438	round	log(n^n)^log(log(1+n))                      	log(n^n)^log(log(1+n))
A062441	floor	log(n)^(1+log(n))                           	log(n)^(1+log(n))
A062442	round	log(n)^(1+log(n))                           	log(n)^(1+log(n))
A062443	floor	log(n!)^(1+log(1+log(n)))                   	log(n!)^(1+log(1+log(n)))
A062444	round	log(n!)^(1+log(1+log(n)))                   	log(n!)^(1+log(1+log(n)))
A062445	floor	log(n!)^(1+log(1+log(1+n)))                 	log(n!)^(1+log(1+log(1+n)))
A062446	round	log(n!)^(1+log(1+log(1+n)))                 	log(n!)^(1+log(1+log(1+n)))
A062449	floor	log(n^n)^(1+log(1+log(n)))                  	log(n^n)^(1+log(1+log(n)))
A062450	round	log(n^n)^(1+log(1+log(n)))                  	log(n^n)^(1+log(1+log(n)))
A062451	floor	log(n^n)^(1+log(1+log(1+n)))                	log(n^n)^(1+log(1+log(1+n)))
A062452	round	log(n^n)^(1+log(1+log(1+n)))                	log(n^n)^(1+log(1+log(1+n)))
A062453	floor	log(n!)^sqrt(n)                             	log(n!)^sqrt(n)
A062454	round	log(n!)^sqrt(n)                             	log(n!)^sqrt(n)
A062455	floor	log(n^n)^sqrt(n)                            	log(n^n)^sqrt(n)
A062456	round	log(n^n)^sqrt(n)                            	log(n^n)^sqrt(n)
A062460	round	log(n)^n                                    	log(n)^n
A062461	floor	log(n!)^(n^(-1/n))                          	log(n!)^(n^(-1/n))
A062462	round	log(n!)^(n^(-1/n))                          	log(n!)^(n^(-1/n))
A062463	floor	log(n)^sqrt(n)                              	log(n)^sqrt(n)
A062464	round	log(n)^sqrt(n)                              	log(n)^sqrt(n)
A062465	floor	log(n)^(n^(1-1/n))                          	log(n)^(n^(1-1/n))
A062466	round	log(n)^(n^(1-1/n))                          	log(n)^(n^(1-1/n))
A062467	floor	log(n!)^(1+log(n)/n)                        	log(n!)^(1+log(n)/n)
A062468	round	log(n!)^(1+log(n)/n)                        	log(n!)^(1+log(n)/n)
A062469	floor	log(n^n)^(1/n^n)                            	log(n^n)^(1/n^n)
A062470	round	log(n^n)^(1/n^n)                            	log(n^n)^(1/n^n)
A062471	floor	log(n^n)^(1+log(n)/n)                       	log(n^n)^(1+log(n)/n)
A062472	round	log(n^n)^(1+log(n)/n)                       	log(n^n)^(1+log(n)/n)
A062473	floor	log(n!)^(1+log(n))                          	log(n!)^(1+log(n))
A062474	round	log(n!)^(1+log(n))                          	log(n!)^(1+log(n))
A062475	floor	log(n!)^(1+log(log(1+n)))                   	log(n!)^(1+log(log(1+n)))
A062476	round	log(n!)^(1+log(log(1+n)))                   	log(n!)^(1+log(log(1+n)))
A062477	floor	log(n^n)^(1+log(n))                         	log(n^n)^(1+log(n))
A062478	round	log(n^n)^(1+log(n))                         	log(n^n)^(1+log(n))
A062479	floor	log(n^n)^(1+log(log(1+n)))                  	log(n^n)^(1+log(log(1+n)))
A062480	round	log(n^n)^(1+log(log(1+n)))                  	log(n^n)^(1+log(log(1+n)))
A062482	floor	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[CR.ONE.add[cv[i].log[]].divide[cv[i*i]]])      	Product(n^((1+log(i))/i^2))
A062483	round	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[CR.ONE.add[cv[i].log[]].divide[cv[i*i]]])      	Product(n^((1+log(i))/i^2))
A062488	floor	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[CR.ONE.add[cv[i].log[]].divide[cv[1+i*i]]])    	Product(n^((1+log(i))/(1+i^2)))
A062489	round	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[CR.ONE.add[cv[i].log[]].divide[cv[1+i*i]]])    	Product(n^((1+log(i))/(1+i^2)))
A062486	floor	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[CR.ONE.add[cv[1+i].log[]].divide[cv[i*i]]])    	Product(n^((1+log(1+i))/i^2))
A062487	round	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[CR.ONE.add[cv[1+i].log[]].divide[cv[i*i]]])    	Product(n^((1+log(1+i))/i^2))
A062492	floor	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[CR.ONE.add[cv[1+i].log[]].divide[cv[1+i*i]]])  	Product(n^((1+log(1+i))/(1+i^2)))
A062493	round	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[CR.ONE.add[cv[1+i].log[]].divide[cv[1+i*i]]])  	Product(n^((1+log(1+i))/(1+i^2)))
A062484	floor	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[cv[1+i].log[].divide[cv[i*i]]])                	Product(n^(log(1+i)/i^2))
A062485	round	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[cv[1+i].log[].divide[cv[i*i]]])                	Product(n^(log(1+i)/i^2))
A062490	floor	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[cv[1+i].log[].divide[cv[1+i*i]]])             	Product(n^(log(1+i)/(1+i^2)))
A062491	round	mN == 0 ? Z.ONE : prod(1,n  , i -> cv[n].pow[cv[1+i].log[].divide[cv[1+i*i]]])             	Product(n^(log(1+i)/(1+i^2)))
A062494	floor	mN == 0 ? Z.ONE : prod(1,n-1, i -> cv[n-i].pow[cv[i].log[]])                               	Product((n-i)^log(i))
A062495	round	mN == 0 ? Z.ONE : prod(1,n-1, i -> cv[n-i].pow[cv[i].log[]])                               	Product((n-i)^log(i))
A062496	floor	mN == 0 ? Z.ONE : prod(1,n-1, i -> cv[n-i].pow[CR.ONE.add[cv[1+i].log[]]])                  	Product((n-i)^(1+log(1+i)))
A062497	round	mN == 0 ? Z.ONE : prod(1,n-1, i -> cv[n-i].pow[CR.ONE.add[cv[1+i].log[]]])                  	Product((n-i)^(1+log(1+i)))
A062498	floor	mN == 0 ? Z.ONE : prod(1,n-1, i -> cv[n-i].pow[CR.ONE.add[cv[i].log[]]])                    	Product((n-i)^(1+log(i)))
A062499	round	mN == 0 ? Z.ONE : prod(1,n-1, i -> cv[n-i].pow[CR.ONE.add[cv[i].log[]]])                    	Product((n-i)^(1+log(i)))
