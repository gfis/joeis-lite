package irvine.oeis.a053;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a031.A031934;

/**
 * A053326 First differences of A031934.
 * @author Georg Fischer
 */
public class A053326 extends DifferenceSequence {

  /** Construct the sequence. */
  public A053326() {
    super(1, new A031934());
  }
}
