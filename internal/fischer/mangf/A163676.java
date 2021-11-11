package irvine.oeis.a163;

import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A163676 Triangle T(n,m) = 4mn + 2m + 2n - 1 read by rows.
 * @author Georg Fischer
 */
public class A163676 extends Triangle {

  @Override
  public Z compute(final int n, final int k) {
    return Z.valueOf((4*n + 6)*k + 6*n + 7);
  }
}
