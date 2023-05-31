package irvine.oeis.a127;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a002.A002260;
import irvine.oeis.a127.A127773;
import irvine.oeis.triangle.Product;

/**
 * A127778 Triangle T(n,k) = A002411(k) read by rows.
 * @author Georg Fischer
 */
public class A127778 extends Product {

  /** Construct the sequence. */
  public A127778() {
    super(1, new A002260(), new A127773());
  }
}
