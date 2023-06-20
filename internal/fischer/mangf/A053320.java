package irvine.oeis.a053;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a023.A023200;

/**
 * A053320 Distance between pairs of primes differing by 4.
 * @author Georg Fischer
 */
public class A053320 extends DifferenceSequence {

  /** Construct the sequence. */
  public A053320() {
    super(1, new A023200());
  }
}
