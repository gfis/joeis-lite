package irvine.oeis.a245;

import irvine.oeis.NestedSequence;
import irvine.oeis.a007.A007953;
import irvine.oeis.a024.A024649;

/**
 * A245336 Sum of digits of n written in fractional base 8/7.
 * @author Georg Fischer
 */
public class A245336 extends NestedSequence {

  /** Construct the sequence. */
  public A245336() {
    super(0, new A007953(), new A024649(), 0, 0);
  }

}
