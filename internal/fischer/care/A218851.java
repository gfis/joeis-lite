package irvine.oeis.a218;
// manually floor at 2021-09-01 13:58

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A218851 a(n) = 2*floor((n + sin(n)/(2*sin(1/2))) * log(n)) + 1.
 * @author Georg Fischer
 */
public class A218851 extends FloorSequence {
  /** Construct the sequence */
  public A218851() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    final CR n = CR.valueOf(mN);
    return Z.TWO.multiply(n.sin().add(n).multiply(n.log().divide(CR.HALF.sin()).divide(CR.TWO))
        .floor(1000)).add(Z.ONE);
  }

}
