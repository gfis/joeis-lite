package irvine.oeis.a129;
// Generated by gen_seq4.pl triprod/trinv at 2023-05-30 18:09

import irvine.oeis.a054.A054523;
import irvine.oeis.triangle.Inverse;

/**
 * A129691 Inverse of A054523.
 * @author Georg Fischer
 */
public class A129691 extends Inverse {

  /** Construct the sequence. */
  public A129691() {
    super(1, new A054523());
  }
}