package irvine.oeis.a123;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-07 21:43

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A123097 Triangle read by rows: T(n,k) = binomial(n-2, k-1) + n*binomial(n-1, k-1), 1 &lt;= k &lt;= n, starting with T(1, 1) = 1.
 * @author Georg Fischer
 */
public class A123097 extends BaseTriangle {

  /** Construct the sequence. */
  public A123097() {
    super(1, 1, 1);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return (n == 1 && k == 1) ? Z.ONE : Binomial.binomial(n-2,k-1).add(Binomial.binomial(n-1,k-1).multiply(n));
  }
}