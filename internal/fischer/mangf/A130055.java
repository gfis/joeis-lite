package irvine.oeis.a130;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a127.A127093;
import irvine.oeis.a129.A129691;
import irvine.oeis.triangle.Product;

/**
 * A130055 A129691 * A127093.
 * @author Georg Fischer
 */
public class A130055 extends Product {

  /** Construct the sequence. */
  public A130055() {
    super(1, new A129691(), new A127093());
  }
}
