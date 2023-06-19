package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a051.A051731;
import irvine.oeis.a127.A127368;
import irvine.oeis.triangle.Product;

/**
 * A143613 Triangle read by rows, A051731 * A127368, 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A143613 extends Product {

  /** Construct the sequence. */
  public A143613() {
    super(1, new A051731(), new A127368());
  }
}