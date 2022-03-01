package irvine.oeis.a227;
// manually 2022-02-28

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a007.A007623;

/**
 * A227154 Product of digits+1 of n in factorial base.
 * @author Georg Fischer
 */
public class A227154 extends A007623 {

  @Override
  public Z next() {
    return ZUtils.digitProduct(super.next(), 10).add(1);
  }
}
