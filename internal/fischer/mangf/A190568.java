package irvine.oeis.a190;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a017.A017910;

/**
 * A190568 Number of squares between powers of 2, floor(sqrt(2^(n+1))) - floor(sqrt(2^n)).
 * @author Sean A. Irvine
 */
public class A190568 extends DifferenceSequence {

  /** Construct the sequence. */
  public A190568() {
    super(-1, new PrependSequence(new A017910(), 0));
  }
}
