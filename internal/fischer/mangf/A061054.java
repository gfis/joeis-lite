package irvine.oeis.a061;
// manually floor at 2021-08-30 09:14

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A061054 Floor(n+n^(3/4)).
 * @author Georg Fischer
 */

public class A061054 extends FloorSequence {
  /** Construct the sequence */
  public A061054() {
    super(0);
  }

  public Z evalCR(final long mN) {
    return CR.valueOf(mN).pow(3).sqrt().sqrt().add(CR.valueOf(mN)).floor(3 * Long.bitCount(mN) + 1024);
  }

}
