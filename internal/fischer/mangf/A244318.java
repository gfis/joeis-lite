package irvine.oeis.a244;
// manually A067067/parm3 at 2022-02-28 19:48

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a014.A014418;

/**
 * A244318 Product of digits+1 of n in Greedy Catalan Base (A014418).
 * @author Georg Fischer
 */
public class A244318 extends A014418 {

  @Override
  public Z next() {
    return ZUtils.digitProduct(super.next(), 10).add(1);
  }
}