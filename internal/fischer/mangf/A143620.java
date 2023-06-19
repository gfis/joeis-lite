package irvine.oeis.a143;
// Generated by gen_seq4.pl triprom/triprod at 2023-06-05 19:25

import irvine.oeis.a054.A054521;
import irvine.oeis.triangle.Product;

/**
 * A143620 Triangle read by rows, square of A054521, 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A143620 extends Product {

  /** Construct the sequence. */
  public A143620() {
    super(1, new A054521(), new A054521());
  }
}