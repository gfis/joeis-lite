package irvine.oeis.a143;
// Generated by gen_seq4.pl triprod at 2023-06-09 15:51

import irvine.oeis.a000.A000012;
import irvine.oeis.a143.A143317;
import irvine.oeis.triangle.Product;

/**
 * A143318 Triangle read by rows: A143317 * A000012.
 * @author Georg Fischer
 */
public class A143318 extends Product {

  /** Construct the sequence. */
  public A143318() {
    super(1, new A143317(), new A000012());
  }
}
