package irvine.oeis.a191;
// manually floor at 2021-09-01 13:41

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A191153 a(n) = floor(2*n*Pi) - 2*floor(n*Pi).
 * @author Georg Fischer
 */
public class A191153 extends FloorSequence {
  /** Construct the sequence */
  public A191153() {
    super(1);
  }

  public Z evalCR(final long mN) {
    return CR.PI.multiply(CR.valueOf(2*mN)).floor().subtract(CR.PI.multiply(CR.valueOf(mN)).floor().multiply(Z.TWO));
  }

}
