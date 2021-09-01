package irvine.oeis.a074;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A074704 a(n) = floor(n^(3/2)) - n*floor(n^(1/2)).
 * @author Georg Fischer
 */
public class A074704 extends FloorSequence {

  /** Construct the sequence */
  public A074704() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    final CR n2 = CR.valueOf(mN).sqrt();
    return n2.pow(3).floor().subtract(Z.valueOf(mN).multiply(n2.floor()));
  }

}
