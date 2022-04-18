package irvine.oeis.a245;

import irvine.oeis.NestedSequence;
import irvine.oeis.a007.A007953;
import irvine.oeis.a024.A024638;

/**
 * A245321 Sum of digits of n written in fractional base 6/5.
 * @author Georg Fischer
 */
public class A245321 extends NestedSequence {

  /** Construct the sequence. */
  public A245321() {
    super(0, new A007953(), new A024638(), 0, 0);
  }
}
