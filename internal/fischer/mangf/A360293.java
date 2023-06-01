package irvine.oeis.a360;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360293 a(n) = Sum_{k=0..floor(n/2)} (-1)^k * binomial(n-1-k,k) * binomial(2*n-4*k,n-2*k).
 * @author Georg Fischer
 */
public class A360293 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360293() {
    super(0, "[[0],[4,-1],[-14,4],[4,-2],[-2,4],[0,-1]]", "1,2,6,18,58,194,662,2290,8002,28178", 0);
  }
}