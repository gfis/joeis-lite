package irvine.oeis.a187;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A187950 [nr+kr] - [nr] - [kr], where r = (1+sqrt(5))/2, k = 4, [.]=floor.
 * @author Georg Fischer
 */
public class A187950 extends FloorSequence {
  /** Construct the sequence */
  public A187950() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.PHI.multiply(CR.valueOf(mN)).add(CR.PHI.multiply(CR.FOUR)).floor()
        .subtract(CR.PHI.multiply(CR.valueOf(mN)).floor())
        .subtract(CR.PHI.multiply(CR.FOUR).floor());
  }

}
