package irvine.oeis.a132;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a001.A001263;
import irvine.oeis.a127.A127773;
import irvine.oeis.triangle.Product;

/**
 * A132819 A001263 * A127773.
 * @author Georg Fischer
 */
public class A132819 extends Product {

  /** Construct the sequence. */
  public A132819() {
    super(1, new A001263(), new A127773());
  }
}
