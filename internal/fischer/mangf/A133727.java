package irvine.oeis.a133;
// Generated by gen_seq4.pl triprom/triprov at 2023-05-31 21:46

import irvine.oeis.a007.A007438;
import irvine.oeis.a051.A051731;
import irvine.oeis.triangle.VectorProduct;

/**
 * A133727 A051731 * A007438 as a diagonalized matrix.
 * @author Georg Fischer
 */
public class A133727 extends VectorProduct {

  /** Construct the sequence. */
  public A133727() {
    super(1, new A051731(), new A007438());
  }
}
