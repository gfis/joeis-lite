package irvine.oeis.a099;
// manually floor at 2021-08-31 14:40

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A099396 a(n) = floor(log_2(2/3*n)) for n >= 2, a(1) = 0.
 * @author Georg Fischer
 */
public class A099396 extends FloorSequence {
	
  /** Construct the sequence */
  public A099396() {
    super(1);
  }

  public Z evalCR(final long mN) {
    return mN == 1 ? Z.ZERO : CR.valueOf(2 * mN).divide(CR.THREE).log().divide(CR.TWO.log()).floor();
  }

}
