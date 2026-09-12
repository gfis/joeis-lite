package irvine.oeis.recur;

import java.util.ArrayList;
import java.util.TreeSet;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;

/**
 * A sequence comprising the transform of zero, one or more other sequences.
 * This program is similar to {@link SimpleTransformSequence}, but the terms
 * of the target sequence and of several underlying sequences can be used
 * in the lambda expression.
 * <p />
 * Any initial terms are prepended first. If there is a recurrence, or
 * if a source sequence has a higher offset than the target sequence,
 * a sufficient number of initial terms must be specified.
 * The offsets are handled automatically, that means the indexes n of all involved
 * sequences are aligned.
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

  private final MexFunction<MexSequence, Long, Z> mLambda; // maps (self, n) to next term
  private final ArrayList<Z> mA; // the existing target sequence elements: a(n-1), a(n-k) etc.
  private final TreeSet<Z> mSparse; // the existing target sequence elements that are not members of the contiguous block
  private final Z[] mInits; // initial terms
  private final int mInitNo; // number of initial terms: mInits.length
  private int mIn; // index for mInits
  private long mN; // current index of target sequence a(n)
  private Z mMex; // the first non-existing element = mBlock + 1

  /**
   * Creates a target sequence from an expression of source sequences.
   * @param offset offset of the new sequence
   * @param lambda function mapping (self, n) to the terms of the target sequence
   * @param initTerms initial terms for a(n)
   * A typical pattern for the call is:
   * <code>super(1, (self, n) -> f(n, self.s(0), self.s(1), self.s(2)), "1", new A999990(), new A999991(), new A999992())</code>
   * If there are some initial terms for a(n), they are exhausted first, resulting in a target offset n.
   * <p />
   * Existing target terms can be accessed with <code>self.a(n-1), self.a(n-2), self.a(n-k)</code> and so on,
   * thus allowing recurrences and memorized terms.
   */
  public MexSequence(final int offset, final MexFunction<MexSequence, Long, Z> lambda, final String initTerms) {
    super(offset);
    mA = new ArrayList<>();
    mSparse = new TreeSet<>();
    mN = -1;
    while (mN < offset - 1) {
      ++mN;
      mA.add(Z.ZERO); // adjust a(n)
    }
    // now mN = mOffset - 1
    mMex = Z.valueOf(mN + 1);
    mLambda = lambda;
    mInits = (initTerms.isEmpty() || "[]".equals(initTerms)) ? new Z[0] : ZUtils.toZ(initTerms);
    mInitNo = mInits.length;
    for (int ix = 0; ix < mInitNo; ++ix) {
      add(mInits[ix]);
    }
    mIn = 0;
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
    if (cmp > 0) {
      mSparse.add(x);
    } else if (cmp == 0) {
      mMex = mMex.add(1);
      while (mSparse.size() > 0 && mSparse.first().equals(mMex)) {
        mMex = mMex.add(1);
        mSparse.pollFirst();
      }
    } // else x < mMex: ignore
  }

  /**
   * Retrieve the minimal excluded element.
   * @return the minimal element that does not yet exist in the sequence
   */
  public Z mex() {
    return mMex;
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
    final Z result = mIn < mInitNo ? mInits[mIn++] : mLambda.apply(this, ++mN);
    add(result); // memorize and maintain mMex, mSparse
    return result;
  }
}
