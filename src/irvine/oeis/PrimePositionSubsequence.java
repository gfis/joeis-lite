package irvine.oeis;

import irvine.math.z.Z;

/**
 * A {@link Subsequence} consisting of the indices (positions) of the primes in the underlying sequence.
 * @author Georg Fischer
 */
public class PrimePositionSubsequence extends PositionSubsequence {

  /**
   * Creates a sequence of the positions of primes in another sequence.
   * @param seq underlying sequence
   * @param offset index of first term of the underlying sequence.
   */
  public PrimePositionSubsequence(final Sequence seq, final int offset) {
    super(seq, offset);
  }

  @Override
  public boolean isOk(Z term) {
  	return term.isProbablePrime();
  }
}
