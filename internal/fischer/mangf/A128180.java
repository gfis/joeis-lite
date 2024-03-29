package irvine.oeis.a128;
// Generated by gen_seq4.pl triprod at 2023-06-06 10:40

import irvine.oeis.a002.A002260;
import irvine.oeis.a097.A097807;
import irvine.oeis.triangle.Product;

/**
 * A128180 A002260 * A097807.
 * @author Georg Fischer
 */
public class A128180 extends Product {

  /** Construct the sequence. */
  public A128180() {
    super(1, new A002260(), new A097807());
  }
}
