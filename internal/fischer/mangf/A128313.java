package irvine.oeis.a128;
// Generated by gen_seq4.pl triprom/triprod at 2023-06-05 19:25

import irvine.oeis.a054.A054525;
import irvine.oeis.a130.A130595;
import irvine.oeis.triangle.Product;

/**
 * A128313 Moebius transform of A007318 (signed).
 * @author Georg Fischer
 */
public class A128313 extends Product {

  /** Construct the sequence. */
  public A128313() {
    super(1, new A054525(), new A130595());
  }
}
