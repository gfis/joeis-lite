package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a051.A051731;
import irvine.oeis.a054.A054524;
import irvine.oeis.triangle.Product;

/**
 * A143352 Triangle read by rows, A051731 * A054524 = (A051731)^2 * A128407; 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A143352 extends Product {

  /** Construct the sequence. */
  public A143352() {
    super(1, new A051731(), new A054524());
  }
}
