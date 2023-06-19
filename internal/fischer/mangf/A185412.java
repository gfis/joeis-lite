package irvine.oeis.a185;
// Generated by gen_seq4.pl triprod at 2023-06-05 17:58

import irvine.oeis.a130.A130595;
import irvine.oeis.a156.A156919;
import irvine.oeis.triangle.Product;

/**
 * A185412 Triangle T(n,m) read by rows: the matrix product A130595 * A156919.
 * @author Georg Fischer
 */
public class A185412 extends Product {

  /** Construct the sequence. */
  public A185412() {
    super(0, new A130595(), new A156919());
  }
}