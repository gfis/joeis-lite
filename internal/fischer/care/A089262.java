package irvine.oeis.a089;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A089262 a(n) = 2^floor(log_2(n)) - 2^floor(log_2(n*2/3)).
 * @author Georg Fischer
 */
public class A089262 extends FloorSequence {

  /** Construct the sequence */
  public A089262() {
    super(0);
  }

  @Override
  public Z evalCR(final long mN) {
    final CR log2 = CR.TWO.log();
    final Z f1 = CR.valueOf(mN).log().divide(log2).floor();
    final Z f2 = CR.valueOf(mN * 2).divide(CR.THREE).log().divide(log2).floor();
    return Z.TWO.pow(f1).subtract(Z.TWO.pow(f2));
  }

}
