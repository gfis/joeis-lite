package irvine.oeis.a073;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a002.A002808;

/**
 * A073445 Second differences of A002808, the sequence of composites.
 * @author Georg Fischer
 */
public class A073445 extends DifferenceSequence {

  /** Construct the sequence. */
  public A073445() {
    super(1, new DifferenceSequence(new A002808()));
  }
}