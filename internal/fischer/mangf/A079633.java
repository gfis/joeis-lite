package irvine.oeis.a079;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A079633 a(n) = floor(n/floor(n^(1/3))) - floor(n^(2/3)).
 * @author Georg Fischer
 */
public class A079633 extends FloorSequence {

  /** Construct the sequence */
  public A079633() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    final CR n3 = CR.valueOf(mN).pow(CR.ONE_THIRD);
    return Z.valueOf(mN).divide(n3.floor())
        .subtract(n3.pow(2).floor());
  }

}
