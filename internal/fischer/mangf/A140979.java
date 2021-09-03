package irvine.oeis.a140;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A140979 Floor(2*phi*floor(n*phi)) where phi = A001622.
 * @author Georg Fischer
 */
public class A140979 extends FloorSequence {

  /** Construct the sequence */
  public A140979() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.TWO.multiply(CR.PHI).multiply(CR.valueOf(CR.PHI.multiply(CR.valueOf(mN)).floor())).floor();
  }

}
