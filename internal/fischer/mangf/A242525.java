package irvine.oeis.a242;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a185.A185265;

/**
 * A242525 Number of cyclic arrangements of S={1,2,...,n} such that the difference between any two neighbors is at most 3.
 * @author Sean A. Irvine
 */
public class A242525 extends DifferenceSequence {

  /** Construct the sequence. */
  public A242525() {
    super(1, new PrependSequence(new A185265(), 0));
  }
}
