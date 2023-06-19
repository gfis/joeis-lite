package irvine.oeis.a166;
// Generated by gen_seq4.pl triprom/triprod at 2023-06-05 19:25

import irvine.oeis.a047.A047999;
import irvine.oeis.triangle.Product;

/**
 * A166453 Triangle read by rows, square of Sierpinski&apos;s gasket, (A047999)^2
 * @author Georg Fischer
 */
public class A166453 extends Product {

  /** Construct the sequence. */
  public A166453() {
    super(0, new A047999(), new A047999());
  }
}