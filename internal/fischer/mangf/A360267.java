package irvine.oeis.a360;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360267 a(n) = Sum_{k=0..floor(n/3)} binomial(n-3*k,k) * binomial(2*(n-3*k),n-3*k).
 * @author Georg Fischer
 */
public class A360267 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360267() {
    super(0, "[[0],[-8,4],[0],[0],[-2,4],[0,-1]]", "1,2,6,20,72,264,984,3712,14136,54224", 0);
  }
}
