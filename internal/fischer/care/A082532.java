package irvine.oeis.a082;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A082532 a(n) = n^2 - 2*floor(n/sqrt(2))^2.
 * @author Georg Fischer
 */
public class A082532 extends FloorSequence {

  /** Construct the sequence */
  public A082532() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return Z.valueOf(mN).square()
        .subtract(Z.TWO.multiply(CR.valueOf(mN).divide(CR.SQRT2).floor().square()));
  }

}
