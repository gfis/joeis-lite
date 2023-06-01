package irvine.oeis.a128;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a051.A051731;
import irvine.oeis.a097.A097806;
import irvine.oeis.triangle.Product;

/**
 * A128185 A097806 * A051731.
 * @author Georg Fischer
 */
public class A128185 extends Product {

  /** Construct the sequence. */
  public A128185() {
    super(1, new A097806(), new A051731());
  }
}