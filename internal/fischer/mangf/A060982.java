package irvine.oeis.a060;

import irvine.math.z.Z;
import irvine.oeis.a061.A061870;

/**
 * A060982 Smallest nontrivial number m such that |first digit - second digit + third digit - fourth digit ...| = n.
 * @author Georg Fischer
 */
public class A060982 extends A061870 {

  private long mN = -1;

  @Override
  public Z next() {
    ++mN;
    long k = 9;
    while (true) {
      ++k;
      if (Math.abs(alternatingDigitSum(String.valueOf(k))) == mN) {
        return Z.valueOf(k);
      }
    }
  }
}
