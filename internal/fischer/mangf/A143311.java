package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a126.A126988;
import irvine.oeis.a127.A127648;
import irvine.oeis.triangle.Product;

/**
 * A143311 Triangle read by rows, A127648 * A126988; 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A143311 extends Product {

  /** Construct the sequence. */
  public A143311() {
    super(1, new A127648(), new A126988());
  }
}
