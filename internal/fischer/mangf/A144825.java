package irvine.oeis.a144;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a000.A000012;
import irvine.oeis.a144.A144824;
import irvine.oeis.triangle.Product;

/**
 * A144825 Triangle read by rows, A144824 * A000012
 * @author Georg Fischer
 */
public class A144825 extends Product {

  /** Construct the sequence. */
  public A144825() {
    super(1, new A144824(), new A000012());
  }
}
