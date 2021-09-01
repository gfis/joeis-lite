package irvine.oeis.a076;
// manually floor at 2021-09-01 20:47

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A076521 Floor( (n/2)*log_2(2*n/3) ).
 * @author Georg Fischer
 */
public class A076521 extends FloorSequence {
  /** Construct the sequence */
  public A076521() {
    super(2);
  }

  @Override
  public Z evalCR(final long mN) {
    final CR log2 = CR.valueOf(mN).divide(CR.THREE).log().divide(CR.TWO.log());
    return CR.valueOf(mN).divide(CR.TWO).multiply(log2).floor();
  }

}
