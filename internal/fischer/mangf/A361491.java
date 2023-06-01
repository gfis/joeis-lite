package irvine.oeis.a361;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A361491 Expansion of x*(1+38*x+x^2)/((1-x)*(x^2-34*x+1)).
 * @author Georg Fischer
 */
public class A361491 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A361491() {
    super(1, "[[0],[1],[-35],[35],[-1]]", "1,73,2521,85681,2910673,98877241,3358915561,114104251873,3876185648161", 0);
  }
}