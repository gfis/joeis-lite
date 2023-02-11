package irvine.oeis.a077;
// generated by patch_offset.pl at 2023-02-08 12:41

import irvine.oeis.a006.A006786;
import irvine.oeis.transform.InverseEulerTransform;

/**
 * A077269 Number of connected squarefree graphs on n nodes.
 * @author Georg Fischer
 */
public class A077269 extends InverseEulerTransform {

  /** Construct the sequence. */
  public A077269() {
    super(1, new A006786());
  }
}
