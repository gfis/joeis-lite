package irvine.oeis.a153;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a007.A007318;
import irvine.oeis.a153.A153198;
import irvine.oeis.triangle.Product;

/**
 * A153199 Triangle read by rows, A007318 * A153198.
 * @author Georg Fischer
 */
public class A153199 extends Product {

  /** Construct the sequence. */
  public A153199() {
    super(0, new A007318(), new A153198());
  }
}