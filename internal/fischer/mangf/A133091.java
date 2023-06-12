package irvine.oeis.a133;
// Generated by gen_seq4.pl triprod at 2023-06-09 15:51

import irvine.oeis.a002.A002260;
import irvine.oeis.a133.A133080;
import irvine.oeis.triangle.Product;

/**
 * A133091 A133080 * A002260.
 * @author Georg Fischer
 */
public class A133091 extends Product {

  /** Construct the sequence. */
  public A133091() {
    super(1, new A133080(), new A002260());
  }
}
