package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a051.A051731;
import irvine.oeis.a054.A054521;
import irvine.oeis.triangle.Product;

/**
 * A143614 Triangle read by rows, A054521 * A051731, 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A143614 extends Product {

  /** Construct the sequence. */
  public A143614() {
    super(1, new A054521(), new A051731());
  }
}
