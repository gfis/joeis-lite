package irvine.oeis.a137;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a000.A000012;
import irvine.oeis.a008.A008277;
import irvine.oeis.triangle.Product;

/**
 * A137649 Triangle read by rows, A000012 * A008277.
 * @author Georg Fischer
 */
public class A137649 extends Product {

  /** Construct the sequence. */
  public A137649() {
    super(1, new A000012(), new A008277());
  }
}
