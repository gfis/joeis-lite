package irvine.oeis.a185;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A185601 a(n) = floor(n^(3/2))-floor(n^(1/2))-n; complement of A185602.
 * @author Georg Fischer
 */
public class A185601 extends FloorSequence {
	
  /** Construct the sequence */
  public A185601() {
    super(3);
  }

  @Override
  public Z evalCR(final long mN) {
    final CR n32 = CR.valueOf(mN).pow(3).sqrt();
    final CR n12 = CR.valueOf(mN).sqrt();
    return n32.floor().subtract(n12.floor()).subtract(mN);
  }

}
