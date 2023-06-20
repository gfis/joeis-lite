package irvine.oeis.a230;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a095.A095116;

/**
 * A230846 1 + A075526(n).
 * @author Sean A. Irvine
 */
public class A230846 extends DifferenceSequence {

  /** Construct the sequence. */
  public A230846() {
    super(1, new PrependSequence(new A095116(), 0));
  }
}
