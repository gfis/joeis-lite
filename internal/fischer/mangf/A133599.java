package irvine.oeis.a133;
// Generated by gen_seq4.pl triprod/tripro3 at 2023-06-09 15:51

import irvine.oeis.a007.A007318;
import irvine.oeis.a097.A097806;
import irvine.oeis.a133.A133080;
import irvine.oeis.triangle.Product;

/**
 * A133599 A097806 * A133080 * A007318.
 * @author Georg Fischer
 */
public class A133599 extends Product {

  /** Construct the sequence. */
  public A133599() {
    super(1, new Product(0, new A097806(), new A133080()), new A007318());
  }
}