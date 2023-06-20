package irvine.oeis.a053;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a001.A001597;

/**
 * A053289 First differences of consecutive perfect powers (A001597).
 * @author Georg Fischer
 */
public class A053289 extends DifferenceSequence {

  /** Construct the sequence. */
  public A053289() {
    super(1, new A001597());
  }
}
