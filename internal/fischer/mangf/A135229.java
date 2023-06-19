package irvine.oeis.a135;
// Generated by gen_seq4.pl tripro3 at 2023-06-05 18:41

import irvine.oeis.a007.A007318;
import irvine.oeis.a097.A097807;
import irvine.oeis.a103.A103451;
import irvine.oeis.triangle.Product;

/**
 * A135229 Triangle A000012(signed) * A103451 * A007318, read by rows.
 * @author Georg Fischer
 */
public class A135229 extends Product {

  /** Construct the sequence. */
  public A135229() {
    super(0, new Product(0, new A097807(), new A103451()), new A007318());
  }
}