package irvine.oeis.a164;

import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A164915 Inverse of binomial matrix (10^n,1) A164899. (See A164899 for companion sequence.)
 * @author Georg Fischer
 */
public class A164915 extends BaseTriangle {

  /** Construct the sequence. */
  public A164915() {
    super(1, 1, 1);
    hasRAM(false);
  }

  @Override
  public Z triangleElement(final int n, final int k) {
    if (k == 1) {
      return Z.ONE;
    }
    if (n == k) {
      return Z.TEN.pow(k - 1);
    }
    // T(n, k) = T(n-1, k) - T(n-2, k-1), with T(n, 1) = 1 and T(n, n) = 10^(n-1)
    return get(n - 1, k).subtract(get(n - 2, k - 1));
  }
}
