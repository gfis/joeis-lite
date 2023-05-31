package irvine.oeis.a156;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a007.A007318;
import irvine.oeis.a154.A154325;
import irvine.oeis.triangle.Product;

/**
 * A156708 Triangle read by rows, binomial transform of A154325
 * @author Georg Fischer
 */
public class A156708 extends Product {

  /** Construct the sequence. */
  public A156708() {
    super(0, new A007318(), new A154325());
  }
}
