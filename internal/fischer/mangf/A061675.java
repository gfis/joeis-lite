package irvine.oeis.a061;
// manually floor at 2021-08-30 14:32

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A061675 a(n) = floor(Pi^n + e^n).
 * @author Georg Fischer
 */
public class A061675 extends FloorSequence {

  /** Construct the sequence */
  public A061675() {
    super(0);
  }

  public Z evalCR(final long mN) {
    return CR.PI.pow(mN).add(CR.E.pow(mN)).floor();
  }

}
