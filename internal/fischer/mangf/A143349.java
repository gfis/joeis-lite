package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a000.A000012;
import irvine.oeis.a054.A054524;
import irvine.oeis.triangle.Product;

/**
 * A143349 Triangle read by rows, A000012 * A054524 = A000012 * A051731 * A128407; 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A143349 extends Product {

  /** Construct the sequence. */
  public A143349() {
    super(1, new A000012(), new A054524());
  }
}