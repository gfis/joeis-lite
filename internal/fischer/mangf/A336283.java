package irvine.oeis.a336;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a156.A156017;

/**
 * A336283 Row sums of A192933.
 * @author Sean A. Irvine
 */
public class A336283 extends DifferenceSequence {

  /** Construct the sequence. */
  public A336283() {
    super(1, new PrependSequence(new A156017(), 0));
  }
}
