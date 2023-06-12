package irvine.oeis.a129;
// Generated by gen_seq4.pl triprod at 2023-06-10 09:55

import irvine.oeis.a097.A097806;
import irvine.oeis.a129.A129372;
import irvine.oeis.triangle.Product;

/**
 * A129572 A129372 * A097806.
 * @author Georg Fischer
 */
public class A129572 extends Product {

  /** Construct the sequence. */
  public A129572() {
    super(1, new A129372(), new A097806());
  }
}
