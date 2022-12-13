java -cp ../../dist/joeis-lite.jar irvine.oeis.ContinuedFractionOfSqrtSequence %1 %2 %3 %4 %5 %6 | tee cfs.tmp
diff cfs.tmp cfp.tmp
