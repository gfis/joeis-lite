package irvine.oeis.a118;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a031.A031921;

/**
 * A118509 First differences of A031921.
 * @author Georg Fischer
 */
public class A118509 extends DifferenceSequence {

  /** Construct the sequence. */
  public A118509() {
    super(1, new A031921());
  }
}