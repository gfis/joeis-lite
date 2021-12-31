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
  protected int mInitial; // some initial prime not covered by the modulus condition, or 1 if not present.
  protected int mRemIndex;
  protected int mRemSize;
  protected Z mCandBase;

  /**
   * Construct an instance without initial.
   * @param modulus divisor
   * @param remains list of remainders
   */
  protected CongruenceForm(final long modulus, final int... remains) {
    this (1, modulus, remains);
  }

  /**
   * Construct an instance with an initial prime.
   * @param initial initial prime not covered by the modulus condition, or 0 if not present.
   * @param modulus divisor
   * @param remains list of remainders
   */
  protected CongruenceForm(final int initial, final long modulus, final int... remains) {
    mInitial = initial;
    mModulus = modulus;
    mRemains = remains;
    mRemIndex = -1;
    mCandBase = Z.ZERO;
    mRemSize = mRemains.length;
  }

  @Override
  public Z next() {
    while (true) {
      ++mRemIndex;
      if (mRemIndex >= mRemSize) {
        mCandBase = mCandBase.add(mModulus);
        mRemIndex = 0;
      }
      final Z candidate = mCandBase.add(mRemains[mRemIndex]);
      // System.out.println("mCandidate=" + mCandidate + ", mCandBase=" + mCandBase + ", mRemIndex=" + mRemIndex);
      if (candidate.isProbablePrime()) {
        return candidate;
      }
    }
  }
}
