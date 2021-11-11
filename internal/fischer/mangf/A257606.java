package irvine.oeis.a257;

import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A257606 Triangle read by rows: T(n,k) = t(n-k, k); t(n,m) = f(m)*t(n-1,m) + f(n)*t(n,m-1), where f(x) = x + 4.
 * @author Georg Fischer
 */
public class A257606 extends Triangle {

  protected Function mFunction;

  protected static class Function {
    protected long value(final long x) {
      return x + 4;
    }
  }

  /** Construct the sequence. */
  public A257606() {
    this(new Function());
  }

  /**
   * Generic constructor with parameters
   * @param function
   */
  public A257606(final Function fun) {
    mFunction = fun;
  }

  @Override
  public Z compute(final int n, final int k) {
    return n == 0 ? Z.ONE : get(n - 1, k - 1).multiply(mFunction.value(n - k))
        .add(get(n - 1, k).multiply(mFunction.value(k)));
  }
}
