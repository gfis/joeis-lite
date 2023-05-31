package irvine.oeis.a361;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A361816 Expansion of 1/sqrt(1 - 4*x*(1-x)^3).
 * @author Georg Fischer
 */
public class A361816 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A361816() {
    super(0, "[[0],[8,-4],[-18,12],[12,-12],[-2,4],[0,-1]]", "1,2,0,-10,-22,12,174,344,-354,-3304", 0);
  }
}
