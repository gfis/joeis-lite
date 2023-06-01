package irvine.oeis.a082;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a007.A007318;
import irvine.oeis.a134.A134309;
import irvine.oeis.triangle.Product;

/**
 * A082137 Square array of transforms of binomial coefficients, read by antidiagonals.
 * @author Georg Fischer
 */
public class A082137 extends Product {

  /** Construct the sequence. */
  public A082137() {
    super(0, new A007318(), new A134309());
  }
}