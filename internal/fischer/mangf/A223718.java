package irvine.oeis.a223;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a257.A257890;

/**
 * A223718 Number of nX1 0..2 arrays with rows, antidiagonals and columns unimodal.
 * @author Sean A. Irvine
 */
public class A223718 extends DifferenceSequence {

  /** Construct the sequence. */
  public A223718() {
    super(1, new PrependSequence(new A257890(), 0));
  }
}
