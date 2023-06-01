package irvine.oeis.a134;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a000.A000012;
import irvine.oeis.a127.A127093;
import irvine.oeis.triangle.Product;

/**
 * A134559 A127093 * A000012.
 * @author Georg Fischer
 */
public class A134559 extends Product {

  /** Construct the sequence. */
  public A134559() {
    super(1, new A127093(), new A000012());
  }
}