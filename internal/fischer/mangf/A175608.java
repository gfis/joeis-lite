package irvine.oeis.a175;
// manually deris/charfun at 2022-07-01 23:08

import irvine.math.LongUtils;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A175608 Characteristic function of squarefree triangular integers: 1 if n(n+1)/2 is squarefree else 0.
 * @author Georg Fischer
 */
public class A175608 implements Sequence {

  private long mN = 0;

  @Override
  public Z next() {
    ++mN;
    return LongUtils.isSquareFree(mN * (mN + 1) / 2) ? Z.ONE : Z.ZERO;
  }
}
