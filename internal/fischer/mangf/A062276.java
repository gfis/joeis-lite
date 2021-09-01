package irvine.oeis.a062;
// manually floor at 2021-08-30 14:32

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;
/**
 * A062276 a(n) = floor(n^(n+1) / (n+1)^n).
 * @author Georg Fischer
 */
public class A062276 extends FloorSequence {
  /** Construct the sequence */
  public A062276() {
    super(0);
  }

  public Z evalCR(final long mN) {
    return CR.valueOf(Z.valueOf(mN).pow(mN + 1)).divide(CR.valueOf(Z.valueOf(mN + 1).pow(mN))).floor();
  }

}
