package irvine.oeis.a168;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a051.A051731;
import irvine.oeis.a101.A101688;
import irvine.oeis.triangle.Product;

/**
 * A168509 Triangle read by rows, A051731 * A101688
 * @author Georg Fischer
 */
public class A168509 extends Product {

  /** Construct the sequence. */
  public A168509() {
    super(1, new A051731(), new A101688());
  }
}