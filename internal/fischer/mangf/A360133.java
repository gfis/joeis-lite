package irvine.oeis.a360;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360133 Expansion of 1/sqrt(1 - 4*x/(1+x)^3).
 * @author Georg Fischer
 */
public class A360133 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360133() {
    super(0, "[[0],[4,-1],[12,-4],[0,-2],[2],[0,-1]]", "1,2,0,-4,-4,6,18,4,-48,-70", 0);
  }
}