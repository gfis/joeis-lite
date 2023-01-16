package irvine.oeis.a036;
// Generated by gen_seq4.pl eulerper at 2020-03-06 22:01

import irvine.oeis.recur.PeriodicSequence;
import irvine.oeis.transform.EulerTransform;

/**
 * A036026 Number of partitions of n into parts not of forms 4*k+2, 20*k, 20*k+5 or 20*k+15.
 * @author Georg Fischer
 */
public class A036026 extends EulerTransform {

  /** Construct the sequence. */
  public A036026() {
    super(0, new PeriodicSequence(1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0), 1);
  }
}
