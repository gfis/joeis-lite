package irvine.oeis.a257;
// manually floor at 2021-09-01 13:58

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A257855 a(n) = 2*n^5 - floor(2^(1/5)*n)^5.
 * @author Georg Fischer
 */
public class A257855 extends FloorSequence {
  /** Construct the sequence */
  public A257855() {
    super(0);
  }

  @Override
  public Z evalCR(final long mN) {
    return Z.valueOf(mN).pow(5).multiply2().subtract(CR.TWO.pow(CR.FIVE.inverse()).multiply(CR.valueOf(mN)).floor(1000)).pow(5);
  }

}
