package irvine.oeis.a082;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a051.A051293;

/**
 * A082550 Number of sets of distinct positive integers whose arithmetic mean is an integer, the largest integer of the set being n.
 * @author Sean A. Irvine
 */
public class A082550 extends DifferenceSequence {

  /** Construct the sequence. */
  public A082550() {
    super(1, new PrependSequence(new A051293(), 0));
  }
}