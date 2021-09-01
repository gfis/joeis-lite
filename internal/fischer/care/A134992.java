package irvine.oeis.a134;
// manually floor at 2021-09-01 20:47

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A134992 a(n) = round(3*n/2*log(n)).
 * @author Georg Fischer
 */
public class A134992 extends FloorSequence {
  /** Construct the sequence */
  public A134992() {
    super(2);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.valueOf(3 * mN).divide(CR.TWO).multiply(CR.valueOf(mN).log()).round(1000);
  }

}
