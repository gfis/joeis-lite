package irvine.oeis.a128;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a002.A002260;
import irvine.oeis.a097.A097806;
import irvine.oeis.triangle.Product;

/**
 * A128151 A002260 * A097806.
 * @author Georg Fischer
 */
public class A128151 extends Product {

  /** Construct the sequence. */
  public A128151() {
    super(1, new A002260(), new A097806());
  }
}
