package irvine.oeis.a257;

import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A257615 Triangle read by rows: T(n,k) = t(n-k, k); t(n,m) = f(m)*t(n-1,m) + f(n)*t(n,m-1), where f(x) = 2*x + 5.
 * @author Georg Fischer
 */
public class A257615 extends Triangle {

  public A257615() {
  }

/*
f(x) = 2*x + 5;
T(n, k) = t(n-k, k);
t(n, m) = if (!n && !m, 1, if (n < 0 || m < 0, 0, f(m)*t(n-1, m) + f(n)*t(n, m-1)));
tabl(nn) = for (n=0, nn, for (k=0, n, print1(t(n, k), ", "); ); print(); );
*/

  @Override
  public Z compute(final int n, final int k) {
    return n < 1 ? Z.ONE : get(n - 1, k - 1).multiply(2*(n - k) + 5).add(get(n - 1, k).multiply(2*k + 5));
  }
}
