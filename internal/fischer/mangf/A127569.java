package irvine.oeis.a127;
// Generated by gen_seq4.pl triprom/triprov at 2023-05-31 21:46

import irvine.oeis.a000.A000203;
import irvine.oeis.a054.A054525;
import irvine.oeis.triangle.VectorProduct;

/**
 * A127569 Triangle read by rows: product of the Mobius matrix A054525 by the diagonal matrix diag(A000203(n)).
 * @author Georg Fischer
 */
public class A127569 extends VectorProduct {

  /** Construct the sequence. */
  public A127569() {
    super(1, new A054525(), new A000203());
  }
}
