package irvine.oeis.a035;
// Generated by gen_seq4.pl eulerper at 2020-03-06 22:01

import irvine.oeis.recur.PeriodicSequence;
import irvine.oeis.transform.EulerTransform;

/**
 * A035985 Number of partitions of n into parts not a multiple of 7. Also number of partitions with at most 6 parts of size 1 and differences between parts at distance 9 are greater than 1.
 * @author Georg Fischer
 */
public class A035985 extends EulerTransform {

  /** Construct the sequence. */
  public A035985() {
    super(0, new PeriodicSequence(1, 1, 1, 1, 1, 1, 0), 1);
  }
}