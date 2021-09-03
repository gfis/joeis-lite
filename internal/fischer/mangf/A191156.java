package irvine.oeis.a191;
// manually floor at 2021-09-01 13:41

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A191156 a(n) = [6*n*Pi] - 2*[3*n*Pi], where [ ]=floor.
 * @author Georg Fischer
 */
public class A191156 extends FloorSequence {
  /** Construct the sequence */
  public A191156() {
    super(1);
  }

  public Z evalCR(final long mN) {
    return CR.PI.multiply(CR.valueOf(6*mN)).floor().subtract(CR.PI.multiply(CR.valueOf(3*mN)).floor().multiply(Z.TWO));
  }

}
