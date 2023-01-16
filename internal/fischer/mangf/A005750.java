package irvine.oeis.a005;

import irvine.oeis.transform.EulerTransform;
import irvine.oeis.a000.A000151;

/**
 * A005750 Number of planted matched trees with n nodes.
 * @author Sean A. Irvine
 */
public class A005750 extends EulerTransform {

  /** Construct the sequence. */
  public A005750() {
    super(1, new A000151(), 1);
  }
}
