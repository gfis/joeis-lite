package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a000.A000012;
import irvine.oeis.a143.A143536;
import irvine.oeis.triangle.Product;

/**
 * A143537 Triangle read by rows: T(n,k) = number of primes in the interval [k..n], n &gt;= 1, 1 &lt;= k &lt;= n.
 * @author Georg Fischer
 */
public class A143537 extends Product {

  /** Construct the sequence. */
  public A143537() {
    super(1, new A000012(), new A143536());
  }
}
