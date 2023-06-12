package irvine.oeis.a157;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A157423 Triangle read by rows, T(n,k) = 0 if (n-k+1) is prime, else 1.
 * @author Georg Fischer
 */
public class A157423 extends BaseTriangle {

  /** Construct the sequence. */
  public A157423() {
    super(1, 1, 1);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Z.valueOf(n - k + 1).isPrime() ? Z.ZERO : Z.ONE;
  }
}
