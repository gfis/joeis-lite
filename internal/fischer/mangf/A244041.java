package irvine.oeis.a244;

import irvine.oeis.NestedSequence;
import irvine.oeis.a007.A007953;
import irvine.oeis.a024.A024631;

/**
 * A244041 Sum of digits of n written in fractional base 4/3.
 * @author Georg Fischer
 */
public class A244041 extends NestedSequence {

  /** Construct the sequence. */
  public A244041() {
    super(0, new A007953(), new A024631(), 0, 0);
  }
}
