package irvine.oeis.a134;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a051.A051731;
import irvine.oeis.a127.A127733;
import irvine.oeis.triangle.Product;

/**
 * A134576 A127733 * A051731.
 * @author Georg Fischer
 */
public class A134576 extends Product {

  /** Construct the sequence. */
  public A134576() {
    super(1, new A127733(), new A051731());
  }
}
