package irvine.oeis.a134;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a000.A000012;
import irvine.oeis.a077.A077028;
import irvine.oeis.triangle.Product;

/**
 * A134392 A077028 * A000012, that is Rascal&apos;s triangle (as matrix) multiplied by a lower triangular matrix of ones (main diagonal of ones included).
 * @author Georg Fischer
 */
public class A134392 extends Product {

  /** Construct the sequence. */
  public A134392() {
    super(1, new A077028(), new A000012());
  }
}