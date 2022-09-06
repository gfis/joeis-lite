package irvine.oeis.a092;
// generated by patch_offset.pl at 2022-08-27 22:44

import irvine.oeis.a012.A012245;
import irvine.oeis.cons.BinaryToDecimalExpansionSequence;

/**
 * A092874 Decimal expansion of the "binary" Liouville number.
 * @author Georg Fischer
 */
public class A092874 extends BinaryToDecimalExpansionSequence {

  /** Construct the sequence. */
  public A092874() {
    super(0, new A012245());
  }
}