package irvine.oeis.a276;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a001.A001952;

/**
 * A276864 First differences of the Beatty sequence A001952 for 2 + sqrt(2).
 * @author Sean A. Irvine
 */
public class A276864 extends DifferenceSequence {

  /** Construct the sequence. */
  public A276864() {
    super(1, new PrependSequence(new A001952(), 0));
  }
}
