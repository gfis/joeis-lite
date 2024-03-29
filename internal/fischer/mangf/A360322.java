package irvine.oeis.a360;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360322 a(n) = Sum_{k=0..n} (-5)^(n-k) * binomial(n-1,n-k) * binomial(2*k,k).
 * @author Georg Fischer
 */
public class A360322 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360322() {
    super(0, "[[0],[10,-5],[8,-6],[0,-1]]", "1,2,-4,10,-30,102,-376,1462", 0);
  }
}
