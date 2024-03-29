package irvine.oeis.a133;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a007.A007318;
import irvine.oeis.a133.A133566;
import irvine.oeis.triangle.Product;

/**
 * A133569 A133566 * A007318 as infinite lower triangular matrices.
 * @author Georg Fischer
 */
public class A133569 extends Product {

  /** Construct the sequence. */
  public A133569() {
    super(1, new A133566(), new A007318());
  }
}
