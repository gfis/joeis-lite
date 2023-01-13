package irvine.oeis.a083;

import irvine.math.z.Z;
import irvine.oeis.Sequence0;

/**
 * A083062 a(n) = (n+1)^n/(n+2) - (-1)^n/(n+2).
 * @author Georg Fischer
 */
public class A083062 extends Sequence0 {

  private int mN = -1;

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN + 1).pow(mN).subtract(((mN & 1) == 0) ? 1 : -1).divide(mN + 2);
  }
}
