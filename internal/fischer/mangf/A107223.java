package irvine.oeis.a107;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A107223 Floor(Pi*Floor(n*Pi)).
 * @author Georg Fischer
 */
public class A107223 extends FloorSequence {

  /** Construct the sequence */
  public A107223() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.valueOf(CR.PI.multiply(CR.valueOf(mN)).floor()).multiply(CR.PI).floor();
  }

}
