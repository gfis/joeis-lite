package irvine.oeis.a127;
// Generated by gen_seq4.pl triprom/triprod at 2023-05-31 21:46

import irvine.oeis.a054.A054522;
import irvine.oeis.triangle.Product;

/**
 * A127474 Triangle, square of A054522.
 * @author Georg Fischer
 */
public class A127474 extends Product {

  /** Construct the sequence. */
  public A127474() {
    super(1, new A054522(), new A054522());
  }
}
