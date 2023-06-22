package irvine.oeis.a085;
// Generated by gen_seq4.pl deris at 2021-10-28 23:42

import irvine.oeis.PartialSumSequence;
import irvine.oeis.a051.A051935;

/**
 * A085626 Partial sums of A051935.
 * @author Georg Fischer
 */
public class A085626 extends PartialSumSequence {

  /** Construct the sequence. */
  public A085626() {
    super(1, new A051935());
  }
}
