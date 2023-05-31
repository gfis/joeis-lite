package irvine.oeis.a095;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a002.A002260;
import irvine.oeis.triangle.Product;

/**
 * A095729 A002260 squared, as an infinite lower triangular matrix, read by rows.
 * @author Georg Fischer
 */
public class A095729 extends Product {

  /** Construct the sequence. */
  public A095729() {
    super(1, new A002260(), new A002260());
  }
}
