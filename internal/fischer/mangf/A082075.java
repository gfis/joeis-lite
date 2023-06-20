package irvine.oeis.a082;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a002.A002145;

/**
 * A082075 First differences of primes of the form 4*k+3 (A002145).
 * @author Georg Fischer
 */
public class A082075 extends DifferenceSequence {

  /** Construct the sequence. */
  public A082075() {
    super(1, new A002145());
  }
}
