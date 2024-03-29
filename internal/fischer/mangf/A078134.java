package irvine.oeis.a078;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a001.A001156;

/**
 * A078134 Number of ways to write n as sum of squares &gt; 1.
 * @author Georg Fischer
 */
public class A078134 extends DifferenceSequence {

  /** Construct the sequence. */
  public A078134() {
    super(1, new A001156());
  }
}
