package irvine.oeis.a053;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a031.A031926;

/**
 * A053322 First differences of A031926.
 * @author Georg Fischer
 */
public class A053322 extends DifferenceSequence {

  /** Construct the sequence. */
  public A053322() {
    super(1, new A031926());
  }
}
