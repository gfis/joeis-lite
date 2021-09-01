package irvine.oeis.a174;
// manually floor at 2021-09-01 20:47

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A174576 a(n) = Floor[(alpha^n-beta^n)(alpha-beta)], with alpha = (1 + Sqrt(a0))/2; beta = (1 - Sqrt(a0))/2; a0=(1 + Sqrt(5))/2.
 * @author Georg Fischer
 */
public class A174576 extends FloorSequence {

  private final CR mB = CR.ONE.subtract(CR.PHI.sqrt()).divide(CR.TWO);
  private final CR mC = CR.ONE.add(CR.PHI.sqrt()).divide(CR.TWO);

  /** Construct the sequence */
  public A174576() {
    super(0);
  }

  @Override
  public Z evalCR(final long mN) {
    return mC.pow(mN).subtract(mB.pow(mN)).multiply(mC.subtract(mB)).floor();
  }

}
