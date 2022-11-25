package irvine.oeis.a154;

import irvine.math.factorial.MemoryFactorial;
import irvine.math.z.Z;
import irvine.oeis.Sequence0;

/**
 * A154030 Sequence defined by a(2*n) = 2*(n^2 + 2*n) and a(2*n-1) = (2*n)!/n!.
 * @author Georg Fischer
 */
public class A154030 extends Sequence0 {

  private int mN = -1;

  @Override
  public Z next() {
    ++mN;
    final int n = mN / 2;
    return ((mN & 1) == 0) ? Z.valueOf(n * n).add(mN).multiply2() : MemoryFactorial.SINGLETON.factorial(mN + 1).divide(MemoryFactorial.SINGLETON.factorial((mN + 1) / 2));
  }
}
