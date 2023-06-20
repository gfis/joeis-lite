package irvine.oeis.a036;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a029.A029827;

/**
 * A036390 First differences of composite connected numbers (A029827).
 * @author Georg Fischer
 */
public class A036390 extends DifferenceSequence {

  /** Construct the sequence. */
  public A036390() {
    super(1, new A029827());
  }
}
