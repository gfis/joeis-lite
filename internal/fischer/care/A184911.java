package irvine.oeis.a184;
// manually floor at 2021-09-13

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;
/**
 * A184911 n+floor(nr/t)+floor(ns/t), where r=2^(1/4), s=2^(1/2), t=2^(3/4).
 * @author Georg Fischer
 */
public class A184911 extends FloorSequence {

  private final CR mS = CR.SQRT2;
  private final CR mR = mS.sqrt();
  private final CR mT = CR.TWO.pow(CR.THREE.divide(CR.FOUR));

  /** Construct the sequence. */
  public A184911() {
    super(1);
  }

  protected Z evalCR(final long n) {
    return Z.valueOf(n).add(CR.valueOf(n).multiply(mR).divide(mT).floor()).add(CR.valueOf(n).multiply(mS).divide(mT).floor());
  }

}
