package irvine.oeis.a361;
// Generated by gen_seq4.pl binomin/holos at 2023-05-08 14:44

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A361031 a(n) = (3^3)*(1*2*4*5*7*8*10*11)*(3*n)!/(n!*(n+4)!^2).
 * @author Georg Fischer
 */
public class A361031 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A361031() {
    super(0, "[[0],[-6,27,-27],[16,8,1]]", "[11550,2772]", 0);
  }
}
