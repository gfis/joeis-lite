package irvine.oeis.a257;

import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A257606 Triangle read by rows: T(n,k) = t(n-k, k); t(n,m) = f(m)*t(n-1,m) + f(n)*t(n,m-1), where f(x) = x + 4.
 * @author Georg Fischer
 */
public class A257606 extends Triangle {

  /**
   * Function for the multiplicands of the two previous triangle elements.
   * Usually overwritten by sublcasses.
   * @param x function parameter: <code>n-k</code> or <code>k</code>
   */
  protected long function(final long x) {
    return x + 4;
  }

  @Override
  public Z compute(final int n, final int k) {
    return n == 0 ? Z.ONE : get(n - 1, k - 1).multiply(function(n - k))
        .add(get(n - 1, k).multiply(function(k)));
  }
}
