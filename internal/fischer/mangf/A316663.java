package irvine.oeis.a316;
// manually floor at 2021-08-31 14:40

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A316663 Floor(sqrt((2*n)^(n+1)))
 * @author Georg Fischer
 */
public class A316663 extends FloorSequence {
	
  /** Construct the sequence */
  public A316663() {
    super(0);
  }

  public Z evalCR(final long mN) {
    return mN == 0 ? Z.ZERO : CR.valueOf(2 * mN).pow(CR.valueOf(mN + 1)).sqrt().floor();
  }

}
