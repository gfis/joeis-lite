package irvine.oeis.a245;

import irvine.oeis.NestedSequence;
import irvine.oeis.a007.A007953;
import irvine.oeis.a024.A024645;

/**
 * A245347 Sum of digits of n written in fractional base 8/3.
 * @author Georg Fischer
 */
public class A245347 extends NestedSequence {

  /** Construct the sequence. */
  public A245347() {
    super(0, new A007953(), new A024645(), 0, 0);
  }
}
