package irvine.oeis.a095;
// manually floor at 2021-09-01 16:25

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A095395 a(n) = Floor[n^((n+1)/(n))]-Floor[n^((n)/(n+1))].
 * @author Georg Fischer
 */
public class A095395 extends FloorSequence {
  /** Construct the sequence */
  public A095395() {
    super(1);
  }

  @Override
  public Z evalCR(final long mN) {
    CR n1 = CR.valueOf(mN + 1).divide(CR.valueOf(mN));
    CR n2 = CR.valueOf(mN).divide(CR.valueOf(mN + 1));
    return        CR.valueOf(mN).pow(n1).floor()
        .subtract(CR.valueOf(mN).pow(n2).floor());
  }

}
