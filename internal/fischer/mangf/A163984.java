package irvine.oeis.a163;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a056.A056737;

/**
 * A163984 First differences of A056737.
 * @author Georg Fischer
 */
public class A163984 extends DifferenceSequence {

  /** Construct the sequence. */
  public A163984() {
    super(1, new A056737());
  }
}
