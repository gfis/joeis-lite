package irvine.oeis.a361;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A361732 a(n) = [x^n] (x^5 + 5*x^4 + 4*x^3 - 3*x + 1)/(x^2 + 2*x - 1)^2.
 * @author Georg Fischer
 */
public class A361732 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A361732() {
    super(0, "[[0],[0,-1,1],[0,-4,2],[-2,3,-1]]", "1,1,2,6,20,60,174,490", 0);
  }
}