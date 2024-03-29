package irvine.oeis.a104;
// Generated by gen_seq4.pl triprom/triprod at 2023-05-31 21:46

import irvine.oeis.a000.A000012;
import irvine.oeis.a094.A094727;
import irvine.oeis.triangle.Product;

/**
 * A104587 Triangle read by rows, given by the matrix product A * B where A (A094727) = [1; 2, 3; 3, 4, 5; 4, 5, 6, 7; ...] and B = [1; 1, 1; 1, 1, 1; ...] (both are infinite lower triangular matrices with the other terms zero).
 * @author Georg Fischer
 */
public class A104587 extends Product {

  /** Construct the sequence. */
  public A104587() {
    super(0, new A094727(), new A000012());
  }
}
