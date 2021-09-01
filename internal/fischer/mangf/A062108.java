package irvine.oeis.a062;
// manually floor at 2021-08-30 14:32

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;
/**
 * A062108 a(n) = floor(n^(3/4)).
 * @author Georg Fischer
 */
public class A062108 extends FloorSequence {
  /** Construct the sequence */
  public A062108() {
    super(0);
  }

  public Z evalCR(final long mN) {
    return mN == 0 ? Z.ZERO : CR.valueOf(mN).pow(CR.THREE.divide(CR.FOUR)).floor();
  }

}
