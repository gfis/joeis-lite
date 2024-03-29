package irvine.oeis.a245;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a038.A038580;

/**
 * A245175 Second differences of A038580.
 *
 * @author Georg Fischer
 */
public class A245175 extends DifferenceSequence {

  /** Construct the sequence. */
  public A245175() {
    super(1, new DifferenceSequence(new A038580()));
  }
}
