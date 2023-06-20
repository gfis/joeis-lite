package irvine.oeis.a124;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a066.A066885;

/**
 * A124434 LCM (least common multiple) of A001043 (sum of consecutive primes) and A001223 (difference of consecutive primes).
 * @author Sean A. Irvine
 */
public class A124434 extends DifferenceSequence {

  /** Construct the sequence. */
  public A124434() {
    super(1, new PrependSequence(new A066885(), 0));
  }
}
