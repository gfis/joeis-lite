package irvine.oeis.a361;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A361791 Expansion of 1/sqrt(1 - 4*x/(1+x)^5).
 * @author Georg Fischer
 */
public class A361791 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A361791() {
    super(0, "[[0],[6,-1],[30,-6],[60,-15],[60,-20],[14,-11],[4,-2],[0,-1]]", "1,2,-4,-10,30,72,-238,-580,1970,4910,-16734,-42750", 0);
  }
}