package irvine.oeis.a360;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360132 Expansion of 1/sqrt(1 - 4*x/(1-x)^6).
 * @author Georg Fischer
 */
public class A360132 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360132() {
    super(0, "[[0],[-7,1],[42,-7],[-105,21],[140,-35],[-105,35],[60,-25],[-9,11],[0,-1]]", "1,2,18,134,1010,7788,60978,482708,3853338,30964238,250150176,2029781310,16530857930", 0);
  }
}
