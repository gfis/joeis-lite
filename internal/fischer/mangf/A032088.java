package irvine.oeis.a032;
// Generated by gen_pattern.pl - DO NOT EDIT here!

import irvine.oeis.recur.GeneratingFunctionSequence;

/**
 * A032088 Number of reversible strings with n beads of 5 colors. If more than 1 bead, not palindromic.
 * @author Georg Fischer
 */
public class A032088 extends GeneratingFunctionSequence {


  /** Construct the sequence. */
  public A032088() {
    super(1, new long[] {0, 5, -15, -25, 125},
      new long[] {1, -5, -5, 25});
  }
}
