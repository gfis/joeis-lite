package irvine.oeis.a201;

import irvine.math.z.Z;
import irvine.oeis.SequenceWithOffset;
import irvine.oeis.triangle.Triangle;

/**
 * A201641 Triangle read by rows, T(n,k) for 0&lt;=k&lt;=n, generalizes the colored Motzkin paths of A129400.
 * Recurrence: T(0,0)=1, T(0,k)=0 for k>0 and for n>=1 T(n,k) = T(n-1,k-1) + 2*T(n-1,k) + 4*T(n-1,k+1).
 * @author Georg Fischer
 */
public class A201641 extends Triangle implements SequenceWithOffset {

  @Override
  public int getOffset() {
    return 0;
  }
  
  @Override
  protected Z compute(final int n, final int k) {
    return n == 0 || n == k ? Z.ONE : get(n - 1, k - 1).add(get(n - 1, k).multiply2()).add(get(n - 1, k + 1).multiply(4));
  }
}
