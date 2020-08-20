package irvine.oeis;

import irvine.math.z.Z;

/**
 * A sequence generated verbatim from a list, with the last element repeated indefinitely.
 * See also {@link PeriodicSequence}.
 * @author Georg Fischer
 */
public class PaddingSequence implements Sequence {

  private final Z[] mLList; // start with this list
  private final Z[] mRList; // superimpose this list when mLList is exhausted
  private final int mLLen; // length of mLList
  private final int mRLen; // length of mRList
  private int mN = -1; // first element will be mLList[0]

  /**
   * Construct the sequence.
   * @param leftList the left list
   * @param rightList the right list
   */
  public PaddingSequence(final long[] leftList, final long[] rightList) {
    mLLen = leftList.length;
    mLList = new Z[leftList.length];
    for (int k = 0; k < mLLen; ++k) {
      mLList[k] = Z.valueOf(leftList[k]);
    }
    mRLen = rightList.length;
    mRList = new Z[rightList.length];
    for (int k = 0; k < mRLen; ++k) {
      mRList[k] = Z.valueOf(rightList[k]);
    }
  }

  @Override
  public Z next() {
    ++mN;
    return mN < mLLen ? mLList[mN] : (mRLen == 1 ? mRList[0] : mRList[mN % mRLen]);
  }
}
