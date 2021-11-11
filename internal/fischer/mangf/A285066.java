package irvine.oeis.a285;

import irvine.math.z.Z;
import irvine.math.factorial.MemoryFactorial;
import irvine.oeis.a285.A285061;

/**
 * A285066 Triangle read by rows: T(n, m) = A285061(n, m)*m!, 0 &lt;= m &lt;= n.
 * @author Georg Fischer
 */
public class A285066 extends A285061 {

  private static final MemoryFactorial FACTORIAL = new MemoryFactorial();

  @Override
  public Z next() {
    return super.next().multiply(FACTORIAL.factorial(mCol));
  }
}
