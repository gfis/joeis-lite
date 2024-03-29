package irvine.oeis.a333;
// generated by patch_offset.pl at 2023-01-14 12:23

import irvine.oeis.transform.EulerTransform;
import irvine.oeis.PrependSequence;
import irvine.oeis.a006.A006824;

/**
 * A333730 Number of simple 4-regular bipartite graphs with 2n nodes.
 * @author Georg Fischer
 */
public class A333730 extends EulerTransform {

  /** Construct the sequence. */
  public A333730() {
    super(1, new PrependSequence(new A006824(), 0, 0, 0));
  }
}
