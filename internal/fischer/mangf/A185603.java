package irvine.oeis.a185;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A185548 a(n) = floor(floor(n^(5/2))^(1/2))
 * @author Georg Fischer
 */
public class A185603 extends FloorSequence {
  /** Construct the sequence */
  public A185603() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.valueOf(CR.valueOf(mN).pow(5).sqrt().floor()).sqrt().floor();
  }

}
