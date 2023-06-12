package irvine.oeis.a133;
// Generated by gen_seq4.pl triprom/triprov at 2023-06-05 19:25

import irvine.oeis.a007.A007318;
import irvine.oeis.a052.A052474;
import irvine.oeis.triangle.VectorProduct;

/**
 * A133544 A007318 * A052474.
 * @author Georg Fischer
 */
public class A133544 extends VectorProduct {

  /** Construct the sequence. */
  public A133544() {
    super(1, new A007318(), new A052474());
  }
}
