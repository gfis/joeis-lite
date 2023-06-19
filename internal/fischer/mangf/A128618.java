package irvine.oeis.a128;
// Generated by gen_seq4.pl triprod at 2023-06-09 15:51

import irvine.oeis.a127.A127647;
import irvine.oeis.a128.A128174;
import irvine.oeis.triangle.Product;

/**
 * A128618 Triangle read by rows: A128174 * A127647 as infinite lower triangular matrices.
 * @author Georg Fischer
 */
public class A128618 extends Product {

  /** Construct the sequence. */
  public A128618() {
    super(1, new A128174(), new A127647());
  }
}