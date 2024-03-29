package irvine.oeis.a131;
// Generated by gen_seq4.pl triprom/triprod at 2023-06-05 19:25

import irvine.oeis.a046.A046854;
import irvine.oeis.triangle.Product;

/**
 * A131245 A046854^2 as an infinite lower triangular matrix.
 * @author Georg Fischer
 */
public class A131245 extends Product {

  /** Construct the sequence. */
  public A131245() {
    super(0, new A046854(), new A046854());
  }
}
