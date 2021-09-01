package irvine.oeis.a184;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A184910 n+floor(nr/s)+floor(nr/t), where r=2^(1/4), s=2^(1/2), t=2^(3/4).
 * @author Georg Fischer
 */
public class A184910 extends FloorSequence {

  private final CR mR = CR.TWO.pow(CR.FOUR.inverse());
  private final CR mS = CR.SQRT2;
  private final CR mT = CR.TWO.pow(CR.THREE.divide(CR.FOUR));

  /** Construct the sequence */
  public A184910() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    final CR n = CR.valueOf(mN);
    return Z.valueOf(mN).add(mR.multiply(n).divide(mS).floor()).add(mR.multiply(n).divide(mT).floor());
  }

}
