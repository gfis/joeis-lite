package irvine.oeis.a332;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a156.A156242;

/**
 * A332875 Sizes of maximal weakly increasing subsequences of A000002.
 * @author Sean A. Irvine
 */
public class A332875 extends DifferenceSequence {

  /** Construct the sequence. */
  public A332875() {
    super(1, new PrependSequence(new A156242(), 0));
  }
}
