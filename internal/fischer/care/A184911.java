package irvine.oeis.a184;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A184911 n+floor(nr/t)+floor(ns/t), where r=2^(1/4), s=2^(1/2), t=2^(3/4).
 * @author Georg Fischer
 */
public class A184911 extends FloorSequence {

  private final CR mR = CR.TWO.pow(CR.ONE.divide(CR.FOUR));
  private final CR mS = CR.SQRT2;
  private final CR mT = CR.TWO.pow(CR.THREE.divide(CR.FOUR));

  /** Construct the sequence */
  public A184911() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return Z.valueOf(mN).add(mR.multiply(CR.valueOf(mN)).divide(mT).floor()).add(mS.multiply(CR.valueOf(mN)).divide(mT).floor());
  }

}
