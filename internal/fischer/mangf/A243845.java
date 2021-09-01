package irvine.oeis.a243;
// manually 2021-08-15

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A243845 Numbers generated by recursive procedure a(n) = nozero(a(n-1) * 3), in which the function nozero(x) removes all zeros from x, starting with a(1) = 1. 
 * @author Georg Fischer
 */
public class A243845 implements Sequence {

  protected int mN;
  protected Z mA_1;

  /** Construct the sequence. */
  public A243845() {
    mN = 0;
    mA_1 = Z.ONE;
  }

  @Override
  public Z next() {
    ++mN;
    if (mN == 1) {
      return mA_1;
    } else {
      mA_1 = new Z(mA_1.multiply(3).toString().replaceAll("0", ""));
      return mA_1;
    }
  }
}
