package irvine.oeis.a095;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a007.A007318;
import irvine.oeis.a011.A011971;
import irvine.oeis.triangle.Product;

/**
 * A095674 Triangle read by rows, formed from product of Pascal&apos;s triangle (A007318) and Aitken&apos;s (or Bell&apos;s) triangle (A011971).
 * @author Georg Fischer
 */
public class A095674 extends Product {

  /** Construct the sequence. */
  public A095674() {
    super(0, new A007318(), new A011971());
  }
}
