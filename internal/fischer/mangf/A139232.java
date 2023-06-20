package irvine.oeis.a139;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a000.A000668;

/**
 * A139232 Second differences of Mersenne primes A000668.
 * @author Georg Fischer
 */
public class A139232 extends DifferenceSequence {

  /** Construct the sequence. */
  public A139232() {
    super(1, new DifferenceSequence(new A000668()));
  }
}
