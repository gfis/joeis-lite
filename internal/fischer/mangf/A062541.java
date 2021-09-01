package irvine.oeis.a062;
// manually floor at 2021-08-30 14:32

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A062541 a(n) = floor(Pi^n * e^n).
 * @author Georg Fischer
 */
public class A062541 extends FloorSequence {
  /** Construct the sequence */
  public A062541() {
    super(0);
  }

  public Z evalCR(final long mN) {
    return CR.PI.multiply(CR.E).pow(mN).floor();
  }

}
