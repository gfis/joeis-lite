package irvine.oeis.a158;
// Generated by gen_seq4.pl triprod at 2023-06-10 09:55

import irvine.oeis.a051.A051731;
import irvine.oeis.a158.A158821;
import irvine.oeis.triangle.Product;

/**
 * A158906 Triangle read by rows: the matrix product A158821 * A051731.
 * @author Georg Fischer
 */
public class A158906 extends Product {

  /** Construct the sequence. */
  public A158906() {
    super(1, new A158821(), new A051731());
  }
}