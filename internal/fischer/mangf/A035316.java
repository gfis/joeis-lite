package irvine.oeis.a035;

import irvine.oeis.MultiplicativeSequence;

/**
 * A035316 Sum of the square divisors of n.
 * @author Georg Fischer
 */
public class A035316 extends MultiplicativeSequence {

  /** Construct the sequence. */
  public A035316() {
    this(1);
  }

  /**
   * Generic constructor with parameters
   * @param expon exponent for the sum
   */
  public A035316(final int expon) {
    super(1, (p, e) -> p.pow(2 * expon * (1 + e / 2)).subtract(1).divide(p.pow(2 * expon).subtract(1)));
  }
}
