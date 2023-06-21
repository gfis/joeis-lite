package irvine.oeis.a334;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a003.A003434;

/**
 * A334196 a(1) = 0, then after the first differences of A003434.
 * @author Sean A. Irvine
 */
public class A334196 extends DifferenceSequence {

  /** Construct the sequence. */
  public A334196() {
    super(1, new PrependSequence(new A003434(), 0));
  }
}