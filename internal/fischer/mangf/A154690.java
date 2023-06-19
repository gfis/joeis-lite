package irvine.oeis.a154;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A154690 Triangle read by rows: T(n,m) = (2^(n-m) + 2^m)*binomial(n,m), 0 &lt;= m &lt;= n.
 * @author Georg Fischer
 */
public class A154690 extends BaseTriangle {

  /** Construct the sequence. */
  public A154690() {
    super(0, 0, 0);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Z.ONE.shiftLeft(n - k).add(Z.ONE.shiftLeft(k)).multiply(Binomial.binomial(n,k));
  }
}