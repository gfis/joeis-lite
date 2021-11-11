package irvine.oeis.a166;

import irvine.math.factorial.MemoryFactorial;
import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A166350 Table T(n,m) = m! read by rows.
 * @author Georg Fischer
 */
public class A166350 extends Triangle {

  private static final MemoryFactorial FACTORIAL = new MemoryFactorial();

  @Override
  public Z compute(final int n, final int k) {
    return FACTORIAL.factorial(k + 1);
  }
}
