package irvine.oeis.a127;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a127.A127093;
import irvine.oeis.a127.A127094;
import irvine.oeis.triangle.Product;

/**
 * A127098 Triangle T(n,m) read by rows: product A127093 * A127094.
 * @author Georg Fischer
 */
public class A127098 extends Product {

  /** Construct the sequence. */
  public A127098() {
    super(1, new A127093(), new A127094());
  }
}
