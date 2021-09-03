package irvine.oeis.a076;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A076878 a(n) = ceiling(n^(1/n))^n - n.
 * @author Georg Fischer
 */
public class A076878 extends FloorSequence {
  /** Construct the sequence */
  public A076878() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.valueOf(mN).pow(CR.valueOf(mN).inverse()).ceil().pow(mN).subtract(Z.valueOf(mN));
  }

}
