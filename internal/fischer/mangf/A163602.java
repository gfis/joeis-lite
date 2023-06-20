package irvine.oeis.a163;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a062.A062312;

/**
 * A163602 First differences of A161753.
 * @author Sean A. Irvine
 */
public class A163602 extends DifferenceSequence {

  /** Construct the sequence. */
  public A163602() {
    super(1, new PrependSequence(new A062312(), 0));
  }
}
