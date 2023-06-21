package irvine.oeis.a281;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a005.A005590;

/**
 * A281048 Expansion of x*(1 - x)*Product_{k&gt;=0} (1 + x^(2^k) - x^(2^(k+1))).
 * @author Georg Fischer
 */
public class A281048 extends DifferenceSequence {

  /** Construct the sequence. */
  public A281048() {
    super(1, new A005590());
  }
}