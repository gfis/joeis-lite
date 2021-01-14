package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.HolonomicRecurrence;

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

  /**
   * Creates a sequence of the primes in the sequence defined by a holonomic recurrence.
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be specified accordingly.
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   * The offset is always 1 since such sequences are lists.
   */
  public PrimeSubsequence(final String matrix, final String initTerms) {
    this(new HolonomicRecurrence(1, matrix, initTerms, 0));
  } // Constructor

  @Override
  public boolean isOk(Z term) {
    return term.isProbablePrime();
  }
}
