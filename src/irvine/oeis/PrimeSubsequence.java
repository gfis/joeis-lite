package irvine.oeis;

import irvine.math.z.Z;

/**
 * A {@link Subsequence} consisting of the primes in the underlying sequence.
 * @author Georg Fischer
 */
public class PrimeSubsequence extends Subsequence {

  /**
   * Creates a sequence of the primes in another sequence.
   * @param seq underlying sequence
   */
  public PrimeSubsequence(final Sequence seq) {
    super(seq);
  }

  @Override
  public boolean isOk(Z term) {
    return term.isProbablePrime();
  }
}
