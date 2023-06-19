package irvine.oeis.a143;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.factorial.MemoryFactorial;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A143122 Triangle read by rows, T(n,k) = Sum_{j=k..n} j!, 0 &lt;= k &lt;= n.
 * @author Georg Fischer
 */
public class A143122 extends BaseTriangle {

  /** Construct the sequence. */
  public A143122() {
    super(0, 0, 0);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Integers.SINGLETON.sum(k,n,j -> MemoryFactorial.SINGLETON.factorial(j));
  }
}