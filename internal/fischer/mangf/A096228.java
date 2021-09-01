package irvine.oeis.a096;
// manually floor at 2021-08-31 14:40

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A096228 a(n) = floor(n^2*((n-1)/n)^(n-1/2))
 * @author Georg Fischer
 */
public class A096228 extends FloorSequence {

  /** Construct the sequence */
  public A096228() {
    super(1);
  }

  public Z evalCR(final long mN) {
    return mN <= 1 ? Z.ZERO : CR.valueOf(mN).pow(2).multiply(CR.valueOf(mN - 1).divide(CR.valueOf(mN)).pow(CR.valueOf(mN).subtract(CR.HALF))).floor();
  }

}
