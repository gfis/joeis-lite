package irvine.oeis.a128;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a054.A054521;
import irvine.oeis.a128.A128407;
import irvine.oeis.triangle.Product;

/**
 * A128431 Triangle read by rows: A054521 * A128407.
 * @author Georg Fischer
 */
public class A128431 extends Product {

  /** Construct the sequence. */
  public A128431() {
    super(1, new A054521(), new A128407());
  }
}
