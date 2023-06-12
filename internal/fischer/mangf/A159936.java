package irvine.oeis.a159;
// Generated by gen_seq4.pl tripro3 at 2023-06-05 18:41

import irvine.oeis.a000.A000012;
import irvine.oeis.a051.A051731;
import irvine.oeis.a054.A054533;
import irvine.oeis.triangle.Product;

/**
 * A159936 Triangle read by rows, A051731 * A054533 * transpose(A101688), provided A101688 is read as a square array.
 * @author Georg Fischer
 */
public class A159936 extends Product {

  /** Construct the sequence. */
  public A159936() {
    super(1, new Product(0, new A051731(), new A054533()), new A000012());
  }
}
