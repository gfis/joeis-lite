package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a054.A054523;
import irvine.oeis.a054.A054525;
import irvine.oeis.triangle.Product;

/**
 * A143276 Triangle read by rows, A054525 * A054523, 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A143276 extends Product {

  /** Construct the sequence. */
  public A143276() {
    super(1, new A054525(), new A054523());
  }
}
