package irvine.oeis.a201;

import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A201639 Triangle read by rows, T(n,k) for 0&lt;=k&lt;=n, generalizes the Motzkin lattice paths with weights of A003645.
 * Recurrence: <code>T(0,0)=1, T(0,k)=0 for k&gt;0 and for n&gt;=1 T(n,k) = T(n-1,k-1)+4*T(n-1,k)+4*T(n-1,k+1)</code>.
 * @author Georg Fischer
 */
public class A201639 extends Triangle  {

  /** Construct the sequence. */
  public A201639() {
    setOffset(0);
  }

  @Override
  protected Z compute(final int n, final int k) {
    return n == 0 || n == k ? Z.ONE : get(n - 1, k - 1).add(get(n - 1, k).multiply(4)).add(get(n - 1, k + 1).multiply(4));
  }
}
