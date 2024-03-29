package irvine.oeis.a003;

import irvine.oeis.SkipSequence;
import irvine.oeis.transform.EulerTransform;
import irvine.oeis.a001.A001190;

/**
 * A003214 Number of binary forests with n nodes.
 * @author Sean A. Irvine
 */
public class A003214 extends EulerTransform {

  /** Construct the sequence. */
  public A003214() {
    super(0, new SkipSequence(new A001190(), 1), 1);
  }
}
