package irvine.oeis.a128;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a000.A000012;
import irvine.oeis.a126.A126988;
import irvine.oeis.triangle.Product;

/**
 * A128489 A000012 * A126988.
 * @author Georg Fischer
 */
public class A128489 extends Product {

  /** Construct the sequence. */
  public A128489() {
    super(1, new A000012(), new A126988());
  }
}
