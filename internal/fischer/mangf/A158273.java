package irvine.oeis.a158;
// manually 2021-07-05

import irvine.math.z.Z;
import irvine.oeis.a061.A061049;

/**
 * A158273 Indices of single-digit numbers in A061049.
 * @author Georg Fischer
 */
public class A158273 extends A061049 {

  private int mN;
  
  /** Construct the sequence. */
  public A158273() {
    mN = 7;
  }

  @Override
  public Z next() {
    while (true) {
      ++mN;
      if (super.next().compareTo(Z.TEN) < 0) {
        return Z.valueOf(mN);
      };
    }
  }

}
