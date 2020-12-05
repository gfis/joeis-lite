package irvine.oeis.a266;
// manually 2020-12-05

import irvine.math.z.Z;
import irvine.oeis.GeneralizedEulerTransform;

/**
 * A266964 Expansion of Product_{k&gt;=1} (1 - k*x^k)^k.
 * @author Georg Fischer
 */
public class A266964 extends GeneralizedEulerTransform {

  /** Construct the sequence */
  public A266964() {
    super(1);
  }

  @Override
  protected Z advanceF(final int k) {
    return Z.valueOf(- k);
  }

  @Override
  protected Z advanceG(final int k) {
    return Z.valueOf(k);
  }


}
