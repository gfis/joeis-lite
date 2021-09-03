package irvine.oeis.a191;
// manually floor at 2021-09-01 13:31

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A191152 [4n*e]-2[2n*e], where [ ]=floor.
 * @author Georg Fischer
 */
public class A191152 extends FloorSequence {
  /** Construct the sequence */
  public A191152() {
    super(1);
  }

  public Z evalCR(final long mN) {
    return CR.E.multiply(CR.valueOf(4*mN)).floor().subtract(CR.E.multiply(CR.valueOf(2*mN)).floor().multiply(Z.TWO));
  }

}
