package irvine.oeis.a128;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a051.A051731;
import irvine.oeis.a128.A128407;
import irvine.oeis.triangle.Product;

/**
 * A128408 A128407 * A051731.
 * @author Georg Fischer
 */
public class A128408 extends Product {

  /** Construct the sequence. */
  public A128408() {
    super(1, new A128407(), new A051731());
  }
}