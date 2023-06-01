package irvine.oeis.a132;
// Generated by gen_seq4.pl triprod at 2023-05-30 18:09

import irvine.oeis.a001.A001263;
import irvine.oeis.a127.A127773;
import irvine.oeis.triangle.Product;

/**
 * A132818 The matrix product A127773 * A001263 of infinite lower triangular matrices.
 * @author Georg Fischer
 */
public class A132818 extends Product {

  /** Construct the sequence. */
  public A132818() {
    super(1, new A127773(), new A001263());
  }
}