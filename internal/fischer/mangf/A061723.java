package irvine.oeis.a061;
// manually floor at 2021-08-30 14:32

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;
/**
 * A061723 Floor of arithmetic-geometric mean of n and 2*n - 1.
 * @author Georg Fischer
 */
public class A061723 extends FloorSequence {
  /** Construct the sequence */
  public A061723() {
    super(0);
  }

  public Z evalCR(final long mN) {
    return mN == 0 ? Z.ZERO : CR.valueOf(mN).agm(CR.valueOf(mN + mN - 1)).floor();
  }

}
