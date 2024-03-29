package irvine.oeis.a360;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360318 a(n) = Sum_{k=0..n} 3^(n-k) * binomial(n-1,n-k) * binomial(2*k,k).
 * @author Georg Fischer
 */
public class A360318 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360318() {
    super(0, "[[0],[42,-21],[-8,10],[0,-1]]", "1,2,12,74,466,2982,19320,126390", 0);
  }
}
