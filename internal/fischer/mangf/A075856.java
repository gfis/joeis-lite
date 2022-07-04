package irvine.oeis.a075;
// manually trecpas

import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A075856 Triangle formed from coefficients of the polynomials p(1)=x, p(n+1) = (n + x*(n+1))*p(n) + x*x*(d/dx)p(n).
 * @author Georg Fischer
 */
public class A075856 extends Triangle {

  /** Construct the sequence. */
  public A075856 () {
    hasRAM(false);
  }

  @Override
  protected Z compute(final int n, final int k) {
    return n == 0 ? Z.ONE : get(n - 1, k - 1).multiply(n + k + 1).add(get(n - 1, k).multiply(n));
  }
}
