package irvine.oeis.a081;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a290.A290707;

/**
 * A081494 Start with Pascal's triangle; form a triangle by sliding down n steps from top on both sides and including the horizontal row, deleting the inner numbers; a(n) = sum of entries on perimeter of triangle.
 * @author Sean A. Irvine
 */
public class A081494 extends DifferenceSequence {

  /** Construct the sequence. */
  public A081494() {
    super(1, new PrependSequence(new A290707(), 0));
  }
}
