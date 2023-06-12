package irvine.oeis.a128;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a000.A000012;
import irvine.oeis.a128.A128621;
import irvine.oeis.triangle.Product;

/**
 * A128623 A128621 * A000012.
 * @author Georg Fischer
 */
public class A128623 extends Product {

  /** Construct the sequence. */
  public A128623() {
    super(1, new A128621(), new A000012());
  }
}
