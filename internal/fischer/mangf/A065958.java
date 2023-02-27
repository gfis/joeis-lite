package irvine.oeis.a065;

import irvine.oeis.MultiplicativeSequence;

/**
 * A065958 a(n) = n^2*Product_{distinct primes p dividing n} (1+1/p^2).
 * @author Georg Fischer
 */
public class A065958 extends MultiplicativeSequence {

  private long mN;
  private int mExpon;

  /** Construct the sequence. */
  public A065958() {
    this(2);
  }

  /**
   * Generic constructor with parameters
   * @param expon exponent for the sum
   */
  public A065958(final int expon) {
    super(1, (p, e) -> p.pow(expon * e).add(p.pow(expon * e - expon)));
  }
}
