package irvine.oeis.a180;
// manually partsum at 2023-03-13

import irvine.oeis.PartialSumSequence;
import irvine.oeis.a100.A100706;

/**
 * A180027 Partial sums of sigma_A100706(n).
 * @author Sean A. Irvine
 */
public class A180027 extends PartialSumSequence {

  /** Construct the sequence. */
  public A180027() {
    super(0, new A100706());
  }
}
