package irvine.oeis.a134;
// Generated by gen_seq4.pl floorr at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.cr.ComputableReals;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A134894 Ceiling(n*exp(tan n)).
 * @author Georg Fischer
 */
public class A134894 extends FloorSequence {

  private static final ComputableReals REALS = ComputableReals.SINGLETON;
  /** Construct the sequence */
  public A134894() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.valueOf(mN).multiply(REALS.tan(CR.valueOf(mN)).exp()).ceil();
  }

}
