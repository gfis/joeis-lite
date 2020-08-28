java -Doeis.big-factor-limit=1000000000 -Xmx4g -cp "../../../joeis-lite/dist/joeis-lite.jar;../../../joeis/build.tmp/joeis.jar" irvine.test.SequenceTest A143123


m=22; CoefficientList[Series[(1+x*Sum[x^k/Product[1-p*x, {p,0,k}], {k,0,m}])/(1-x^2)]], {x, 0,m}],x]