package irvine.oeis.a252;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A252729 Start with 1, add 1, subtract 2, multiply by 3, add 4, subtract 5, multiply by 6, add 7, etc.
 * @author Georg Fischer
 */
public class A252729 implements Sequence {

  private int mN = 0;
  private Z mA = Z.ONE;

  @Override
  public Z next() {
    ++mN;
    final Z result = mA;
    switch (mN % 3) {
      default:
      case 1:
        mA = mA.add(mN);
        break;
      case 2:
        mA = mA.subtract(mN);
        break;
      case 0:
        mA = mA.multiply(mN);
        break;
    }
    return result;
  }
}
