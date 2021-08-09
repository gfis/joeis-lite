package irvine.oeis.a117;
// manually 2021-01-20

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a000.A000931;

/**
 * A117601 Padovan numbers which are divisible by the sum of their digits.
 * @author Georg Fischer
 */
public class A117601 extends A000931 {

  @Override
  public Z next() {
    Z result = super.next();
    while (! result.remainder(Z.valueOf(ZUtils.digitSum(result))).equals(Z.ZERO)) {
      result = super.next();
    }
    return result;
  }
}
