package irvine.oeis.a127;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a054.A054521;
import irvine.oeis.a127.A127648;
import irvine.oeis.triangle.Product;

/**
 * A127368 Relative prime triangle, read by rows.
 * @author Georg Fischer
 */
public class A127368 extends Product {

  /** Construct the sequence. */
  public A127368() {
    super(1, new A054521(), new A127648());
  }
}
