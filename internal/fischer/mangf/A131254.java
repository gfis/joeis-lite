package irvine.oeis.a131;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a000.A000012;
import irvine.oeis.a004.A004070;
import irvine.oeis.triangle.Product;

/**
 * A131254 A004070 * A000012.
 * @author Georg Fischer
 */
public class A131254 extends Product {

  /** Construct the sequence. */
  public A131254() {
    super(0, new A004070(), new A000012());
  }
}