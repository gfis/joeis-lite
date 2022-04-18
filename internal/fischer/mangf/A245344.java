package irvine.oeis.a245;

import irvine.oeis.NestedSequence;
import irvine.oeis.a007.A007953;
import irvine.oeis.a024.A024640;

/**
 * A245344 Sum of digits of n written in fractional base 7/3.
 * @author Georg Fischer
 */
public class A245344 extends NestedSequence {

  /** Construct the sequence. */
  public A245344() {
    super(0, new A007953(), new A024640(), 0, 0);
  }
}
