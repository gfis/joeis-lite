package irvine.oeis.a344;
// manually floor at 2021-08-31 14:40

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A344348 a(n) = floor(frac(e * n) * n).
 * @author Georg Fischer
 */
public class A344348 extends FloorSequence {
	
  /** Construct the sequence */
  public A344348() {
    super(0);
  }

  public Z evalCR(final long mN) {
    return mN <= 3 ? Z.ZERO : CR.E.multiply(CR.valueOf(mN)).frac().multiply(CR.valueOf(mN)).floor();
  }

}
