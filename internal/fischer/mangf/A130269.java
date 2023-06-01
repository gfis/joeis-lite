package irvine.oeis.a130;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a002.A002260;
import irvine.oeis.a051.A051340;
import irvine.oeis.triangle.Product;

/**
 * A130269 A002260 * A051340.
 * @author Georg Fischer
 */
public class A130269 extends Product {

  /** Construct the sequence. */
  public A130269() {
    super(1, new A002260(), new A051340());
  }
}