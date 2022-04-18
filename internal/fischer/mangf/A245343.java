package irvine.oeis.a245;

import irvine.oeis.NestedSequence;
import irvine.oeis.a007.A007953;
import irvine.oeis.a024.A024633;

/**
 * A245343 Sum of digits of n written in fractional base 5/3.
 * @author Georg Fischer
 */
public class A245343 extends NestedSequence {

  /** Construct the sequence. */
  public A245343() {
    super(0, new A007953(), new A024633(), 0, 0);
  }
}
