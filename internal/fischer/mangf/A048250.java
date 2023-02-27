package irvine.oeis.a048;

import irvine.oeis.MultiplicativeSequence;

/**
 * A048250 Sum of the squarefree divisors of n.
 * @author Georg Fischer
 */
public class A048250 extends MultiplicativeSequence {

  /** Construct the sequence. */
  public A048250() {
    this(1);
  }

  /**
   * Generic constructor with parameters
   * @param expon exponent for the sum
   */
  public A048250(final int expon) {
    super(1, (p, e) -> p.pow(expon).add(1));
  }
}