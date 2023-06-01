package irvine.oeis.a134;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a000.A000012;
import irvine.oeis.a084.A084938;
import irvine.oeis.triangle.Product;

/**
 * A134379 A084938 * A000012.
 * @author Georg Fischer
 */
public class A134379 extends Product {

  /** Construct the sequence. */
  public A134379() {
    super(0, new A084938(), new A000012());
  }
}