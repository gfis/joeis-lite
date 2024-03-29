package irvine.oeis.a127;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a054.A054521;
import irvine.oeis.a054.A054522;
import irvine.oeis.triangle.Product;

/**
 * A127479 Triangle read by rows: A054522 * A054521 as infinite lower triangular matrices.
 * @author Georg Fischer
 */
public class A127479 extends Product {

  /** Construct the sequence. */
  public A127479() {
    super(1, new A054522(), new A054521());
  }
}
