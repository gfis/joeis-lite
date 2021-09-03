package irvine.oeis.a063;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A063438 Floor((n+1)*Pi)-Floor(n*Pi).
 * @author Georg Fischer
 */
public class A063438 extends FloorSequence {

  /** Construct the sequence */
  public A063438() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.valueOf(mN + 1).multiply(CR.PI).floor()
        .subtract(CR.valueOf(mN).multiply(CR.PI).floor());
  }

}
