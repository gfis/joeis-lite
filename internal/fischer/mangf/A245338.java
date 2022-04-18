package irvine.oeis.a245;

import irvine.oeis.NestedSequence;
import irvine.oeis.a007.A007953;
import irvine.oeis.a024.A024656;

/**
 * A245338 Sum of digits of n written in fractional base 9/8.
 * @author Georg Fischer
 */
public class A245338 extends NestedSequence {

  /** Construct the sequence. */
  public A245338() {
    super(0, new A007953(), new A024656(), 0, 0);
  }
}
