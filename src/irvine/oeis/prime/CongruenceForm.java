package irvine.oeis.prime;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A sequence of primes that is defined by a list of remainders with respect to some modulus (divisor).
 * The algorithm tests one of the modulus conditions after the other for primeness,
 * and then steps by the modulus.
 * @author Georg Fischer
 */
public class CongruenceForm implements Sequence {

  protected long mModulus; // current number with some property
  protected int[] mRemains; // remainders
  protected int mRemIndex; // current index in mRemains
  protected int mRemStart; // first index of remainders, number of initial terms
  protected int mRemSize; // mRemains.length
  protected Z mCandBase; // lowest candidate

  /**
   * Construct an instance with a list of initial primes.
   * @param start number of of initial terms, index of first remainder
   * @param modulus divisor
   * @param remains list of initial terms followed by the remainders
   */
  protected CongruenceForm(final long modulus, final int start, final int... remains) {
    mModulus = modulus;
    mRemStart = start;
    mRemains = remains;
    mRemIndex = -1; // begin with the initial terms
    mCandBase = Z.ZERO;
    mRemSize = mRemains.length;
  }

  @Override
  public Z next() {
    while (true) {
      ++mRemIndex;
      if (mRemIndex >= mRemSize) {
        mCandBase = mCandBase.add(mModulus);
        mRemIndex = mRemStart; // continue behind the initial terms
      }
      final Z candidate = mCandBase.add(mRemains[mRemIndex]);
      // System.out.println("mCandidate=" + mCandidate + ", mCandBase=" + mCandBase + ", mRemIndex=" + mRemIndex);
      if (candidate.isProbablePrime()) {
        return candidate;
      }
    }
  }
}
