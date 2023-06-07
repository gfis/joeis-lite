package irvine.oeis.a131;

import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A131431 3n + 1 preceded by n zeros.
 * @author Georg Fischer
 */
public class A131431 extends BaseTriangle {

  /** Construct the sequence. */
  public A131431() {
    super(0, 0, 0);
    hasRAM(true);
  }

  @Override
  public Z triangleElement(final int n, final int k) {
    return (k == n) ? Z.valueOf(3 * n + 1) : Z.ZERO;
  }
}
