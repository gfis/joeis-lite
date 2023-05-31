package irvine.oeis.a134;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a002.A002260;
import irvine.oeis.a103.A103451;
import irvine.oeis.triangle.Product;

/**
 * A134868 A103451 * A002260.
 * @author Georg Fischer
 */
public class A134868 extends Product {

  /** Construct the sequence. */
  public A134868() {
    super(1, new A103451(), new A002260());
  }
}
