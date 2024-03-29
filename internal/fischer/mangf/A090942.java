package irvine.oeis.a090;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a033.A033286;

/**
 * A090942 n-th arithmetic mean = prime(n).
 * @author Sean A. Irvine
 */
public class A090942 extends DifferenceSequence {

  /** Construct the sequence. */
  public A090942() {
    super(1, new PrependSequence(new A033286(), 0));
  }
}
