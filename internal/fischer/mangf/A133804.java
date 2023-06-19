package irvine.oeis.a133;
// Generated by gen_seq4.pl triprod/tripro3 at 2023-06-09 15:51

import irvine.oeis.a007.A007318;
import irvine.oeis.a133.A133080;
import irvine.oeis.a133.A133566;
import irvine.oeis.triangle.Product;

/**
 * A133804 A007318 * A133080 * A133566.
 * @author Georg Fischer
 */
public class A133804 extends Product {

  /** Construct the sequence. */
  public A133804() {
    super(1, new Product(0, new A007318(), new A133080()), new A133566());
  }
}