package irvine.oeis.a180;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A180498 a(n) = n^2 - 5*floor(n/sqrt(5))^2.
 * @author Georg Fischer
 */
public class A180498 extends FloorSequence {
  /** Construct the sequence */
  public A180498() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return Z.valueOf(mN).square()
        .subtract(Z.FIVE.multiply(CR.valueOf(mN).divide(CR.FIVE.sqrt()).floor().square()));
  }

}
