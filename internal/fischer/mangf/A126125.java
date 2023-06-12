package irvine.oeis.a126;
// Generated by gen_seq4.pl triprom/triprod at 2023-06-05 19:25

import irvine.oeis.a061.A061554;
import irvine.oeis.triangle.Product;

/**
 * A126125 Triangle equal to the matrix square of the triangle binomial(n,floor((n+1-(-1)^(n+k)*(k+1))/2)).
 * @author Georg Fischer
 */
public class A126125 extends Product {

  /** Construct the sequence. */
  public A126125() {
    super(0, new A061554(), new A061554());
  }
}
