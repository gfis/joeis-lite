package irvine.oeis.a134;
// Generated by gen_seq4.pl triprod at 2023-06-09 15:51

import irvine.oeis.a000.A000012;
import irvine.oeis.a134.A134673;
import irvine.oeis.triangle.Product;

/**
 * A134674 A134673 * A000012.
 * @author Georg Fischer
 */
public class A134674 extends Product {

  /** Construct the sequence. */
  public A134674() {
    super(1, new A134673(), new A000012());
  }
}
