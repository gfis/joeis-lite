package irvine.oeis.a134;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a128.A128174;
import irvine.oeis.a134.A134309;
import irvine.oeis.triangle.Product;

/**
 * A134317 A128174 * A134309.
 * @author Georg Fischer
 */
public class A134317 extends Product {

  /** Construct the sequence. */
  public A134317() {
    super(1, new A128174(), new A134309());
  }
}
