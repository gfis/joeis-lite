package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a054.A054525;
import irvine.oeis.a143.A143311;
import irvine.oeis.triangle.Product;

/**
 * A143312 Triangle read by rows, A054525 * A143311, 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A143312 extends Product {

  /** Construct the sequence. */
  public A143312() {
    super(1, new A054525(), new A143311());
  }
}