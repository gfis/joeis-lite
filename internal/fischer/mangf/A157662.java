package irvine.oeis.a157;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a002.A002808;

/**
 * A157662 Composite numbers such that the last digit is equal to the sum of all the previous digits.
 * @author Georg Fischer
 */
public class A157662 extends A002808 {

  /** Construct the sequence. */
  public A157662() {
    Z cn = super.next();
    while (!cn.equals(Z.valueOf(99))) {
      cn = super.next();
    }
  }

  @Override
  public Z next() {
    while (true) {
      final Z cn = super.next();
      if (cn.mod(Z.TEN).equals(Z.valueOf(ZUtils.digitSum(cn.divide(Z.TEN))))) {
        return cn;
      }
    }
  }
}
