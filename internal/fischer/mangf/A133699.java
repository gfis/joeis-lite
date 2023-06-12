package irvine.oeis.a133;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a051.A051731;
import irvine.oeis.a133.A133698;
import irvine.oeis.triangle.Product;

/**
 * A133699 A051731 * A133698.
 * @author Georg Fischer
 */
public class A133699 extends Product {

  /** Construct the sequence. */
  public A133699() {
    super(1, new A051731(), new A133698());
  }
}
