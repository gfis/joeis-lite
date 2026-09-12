package irvine.oeis.recur;

import java.util.ArrayList;
import java.util.TreeSet;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;

/**
 * A sequence where the next elements depends on the existence of values in the previous elements of the sequence.
 * <p />
 * Any initial terms are prepended first.
 * @author Georg Fischer
 */
public class MexSequence extends AbstractSequence {

  @FunctionalInterface
  public interface MexFunction<MexSequence, Long, Z> {
    /**
     * Apply the function.
     * @param self reference to enclosing class
     * @param n current index
     * @return value of <code>a(n)</code>
     */
    Z apply(MexSequence self, Long n);
  }

  @FunctionalInterface
  public interface MexPredicate<MexSequence, Long, Boolean> {
    /**
     * Apply the function.
     * @param self reference to enclosing class
     * @param n current index
     * @return value of <code>a(n)</code>
     */
    Boolean apply(MexSequence self, Long n);
  }

  private final MexFunction<MexSequence, Long, Z> mLambda; // maps (self, n) to next term
  private final MexPredicate<MexSequence, Long, Boolean> mPredicate; // maps (self, n) to next term
  private final ArrayList<Z> mA; // the existing target sequence elements: a(n-1), a(n-k) etc.
  private Z mMex; // the first non-existing element
  private final TreeSet<Z> mSparse; // the existing target sequence elements that are not members of the contiguous block
  private final Z[] mInits; // initial terms
  private final int mInitNo; // number of initial terms: mInits.length
  private int mIn; // index for mInits
  private long mN; // current index of target sequence a(n)

  /**
   * Creates the sequence from a condition for the new, smallest element not yet in the sequence.
   * @param offset offset of the new sequence
   * @param lambda function mapping (self, n) to the terms of the target sequence
   * @param initTerms initial terms for a(n)
   * If there are some initial terms for a(n), they are exhausted first, resulting in a target offset n.
   * Existing target terms can be accessed with <code>self.a(n-1), self.a(n-2), self.a(n-k)</code> and so on.
   */
  public MexSequence(final int offset, final MexFunction<MexSequence, Long, Z> lambda, final MexPredicate<MexSequence, Long, Boolean> predicate, final String initTerms) {
    super(offset);
    mLambda = lambda; 
    mPredicate = predicate;
    mInits = (initTerms.isEmpty() || "[]".equals(initTerms)) ? new Z[0] : ZUtils.toZ(initTerms);
    mA = new ArrayList<>();
    mSparse = new TreeSet<>();
    mN = offset - 1;
    while (mN < offset - 1) {
      ++mN;
      mA.add(Z.ZERO); // adjust a(n)
    }
    // now mN = mOffset - 1
    mMex = Z.valueOf(mN + 1);
    mInitNo = mInits.length;
    for (int ix = 0; ix < mInitNo; ++ix) {
      add(mInits[ix]);
    }
    mIn = 0;
  }

  /**
   * Creates the sequence from explicit expressions for <code>a(n)</code>.
   * @param offset offset of the new sequence
   * @param lambda function mapping (self, n) to the terms of the target sequence
   * @param initTerms initial terms for a(n)
   * If there are some initial terms for a(n), they are exhausted first, resulting in a target offset n.
   * Existing target terms can be accessed with <code>self.a(n-1), self.a(n-2), self.a(n-k)</code> and so on.
   */
  public MexSequence(final int offset, final MexFunction<MexSequence, Long, Z> lambda, final String initTerms) {
    this(offset, lambda, (self, n) -> true, initTerms);
  }

  /**
   * Add an element to the target sequence.
   * The minimal element in <code>mSparse> is always greater than <code>mBlock + 1</code>,
   * therefore <code>mex() = mBlock + 1</code>.
   * @param x element to be added
   */
  private void add(final Z x) {
    mA.add(x);
    final int cmp = x.compareTo(mMex);
    if (cmp > 0) { // in the sparse range, no need to adjust mMex
      mSparse.add(x);
    } else if (cmp == 0) { // x === mMex
      mMex = mMex.add(1);
      while (!mSparse.isEmpty() && mSparse.first().equals(mMex)) { // try to increase mMex by elements from the head of mSparse
        mMex = mMex.add(1);
        mSparse.pollFirst();
      }
    } // else x < mMex: ignore
    // System.out.println("# add: mN=" + mN + ", result=" + result + ", mMex=" + mMex + ", first=" + (mSparse.isEmpty() == 0 ? "{}" : mSparse.first().toString()));
  }

  /**
   * Retrieve the minimal excluded element.
   * @return the minimal element that does not yet exist in the sequence
   */
  public Z mex() {
    return mMex;
  }

  /**
   * Test whether an element is already in the sequence.
   * @return true if the element is <code>&lt; mMex</code> or in <code>mSparse</code>
   */
  public boolean contains(final Z x) {
    return x.compareTo(mMex) < 0 || mSparse.contains(x);
  }

  /**
   * Retrieve an existing target sequence element.
   * @param n index of target sequence
   * @return a(n)
   */
  public Z a(final long n) {
    return mA.get((int) n);
  }

  @Override
  public Z next() {
    ++mN;
    final Z result;
    if (mIn < mInitNo) {
      result =  mInits[mIn++];
      add(result);
      return result;
    } 
    if (mPredicate == null) {
      result = mLambda.apply(this, mN);
      add(result); // memorize and maintain mMex, mSparse
      return result;
    }
    // iterate through the non-existing elements: mMex and the gaps in mSparse
      result = mLambda.apply(this, mN);
      add(result); // memorize and maintain mMex, mSparse
      return result;
  }
}
