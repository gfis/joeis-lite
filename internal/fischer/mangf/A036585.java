package irvine.oeis.a036;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a001.A001969;

/**
 * A036585 Ternary Thue-Morse sequence: closed under a-&gt;abc, b-&gt;ac, c-&gt;b.
 * @author Georg Fischer
 */
public class A036585 extends DifferenceSequence {

  /** Construct the sequence. */
  public A036585() {
    super(1, new A001969());
  }
}
