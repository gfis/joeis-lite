package irvine.oeis.recur;

import java.util.ArrayList;
import java.util.function.BiFunction;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;

/**
 * A recurrence with constant order (depth), specified by a single formula,
 * depending on <code>a(n+k)</code>.
 * This is the successor of <em>ConstantOrderSequence</em>.
 * @author Georg Fischer
 */
public class LambdaRecurrence extends AbstractSequence {

  /**
   * A circular buffer for the recurrence elements, and the terms of additional sequences.
   * The size of the buffer must be a power of 2, plus the space for the additional terms.
   * Any initial values are stored at the proper indexes. 
   * The rest of the buffer is prefilled with zeros.
   */
  public class RingBuffer {

    private int mBufLen; // size of the buffer (must be a power of 2)
    private int mMask; // bit mask for accessing elements of {@link #mBuffer}, <code>= mBufLen - 1</code>
    private final ArrayList<Z> mCache = new ArrayList<>();
    
    /** Construct the buffer. */
    public RingBuffer(final int len) {
      mBufLen = len;
      mMask = mBufLen - 1;
      for (int i = 0; i < mBufLen; ++i) {
        mCache.add(Z.ZERO);
      }
    }

    /**
     * Get an element.
     * @param i index of the element, 0 based, the circular access is achieved by a bit mask.
     * Indexes &gt;= 0 access the recurrence elements, while negative indexes access the terms of
     * additional sequences.
     * @return buffer element
     */
    public Z get(final int i) {
      return i >= 0 ? mCache.get(i & mMask) : mCache.get(mBufLen - i); // get(mBufLen) is null
    }

    /**
     * Set an element.
     * @param i index of the element, 0 based, the circular access is achieved by a bit mask.
     * Indexes &gt;= 0 access the recurrence elements, while negative indexes access the terms of
     * additional sequences.
     * The buffer is automatically expanded for the additional elements.
     * @return buffer element
     */
     public void set(final int i, final Z value) {
      if (i >= 0) {
        mCache.set(i & mMask, value);
      } else {
        final int iseq = mBufLen - i; // get(mBufLen) is null
        while (mCache.size() < iseq) {
          mCache.add(Z.ZERO);
        }
        mCache.set(iseq, value);
      }
    }
  }

  private BiFunction<RingBuffer, Integer, Z> mLambda; // the lambda expression for the recurrence
  private int mInitLen; // number of initial terms
  private int mIn; // index for counting initial terms
  private int mShift; // d &gt;= 0 such that <code>a(n+d)</code> is the highest and next element to be computed (0 &lt;= d &lt;= k).
  private int mN; // index of the next sequence element to be computed
  private int mOrder; // order k-1 of the recurrence, number of previous sequence elements used to compute <code>a(n+shift)</code>
  private final RingBuffer mBuffer; // the ring buffer

  /**
   * Construct a general recurrence sequence.
   * @param offset first valid term has this index
   * @param initTerms initial values of <code>a(offset..order+offset-1)</code>
   */
  public LambdaRecurrence(final int offset, BiFunction<RingBuffer, Integer, Z> lambda, final String initTerms) {
    this(offset, 16, 0, lambda, ZUtils.toZ(initTerms));
  }

  /**
   * Construct a general recurrence sequence.
   * @param offset first valid term has this index
   * @param order order (depth) of the recurrence, index distance between <code>a(n+kmin)</code> and <code>a(n+kmax)</code>
   * @param initTerms initial values of <code>a(offset..order+offset-1)</code>
   */
  public LambdaRecurrence(final int offset, final int order, BiFunction<RingBuffer, Integer, Z> lambda, final String initTerms) {
    this(offset, order, 0, lambda, ZUtils.toZ(initTerms));
  }

  /**
   * Construct a general recurrence sequence.
   * @param offset first valid term has this index
   * @param order order (depth) of the recurrence, index distance between <code>a(n+kmin)</code> and <code>a(n+kmax)</code>
   * @param shift compute next element <code>a(n+shift)</code> instead of <code>a(n)</code>
   * @param initTerms initial values of <code>a(offset..order+offset-1)</code>
   */
  public LambdaRecurrence(final int offset, final int order, final int shift, BiFunction<RingBuffer, Integer, Z> lambda, final String initTerms) {
    this(offset, order, shift, lambda, ZUtils.toZ(initTerms));
  }

  /**
   * Construct a general recurrence sequence.
   * @param offset first valid term has this index
   * @param order order (depth) of the recurrence, index distance between <code>a(n+kmin)</code> and <code>a(n+kmax)</code>
   * @param shift compute next element <code>a(n+shift)</code> instead of <code>a(n)</code>
   * @param initTerms initial values of <code>a(offset..order+offset-1)</code>
   */
  public LambdaRecurrence(final int offset, final int order, final int shift, BiFunction<RingBuffer, Integer, Z> lambda, final long... initTerms) {
    this(offset, order, shift, lambda, ZUtils.toZ(initTerms));
  }

  /**
   * Construct a general recurrence sequence.
   * @param offset first valid term has this index
   * @param order order (depth) of the recurrence, index distance between <code>a(n+kmin)</code> and <code>a(n+kmax)</code>
   * @param shift compute next element <code>a(n+shift)</code> instead of <code>a(n)</code>
   * @param initTerms initial values of <code>a(offset..order+offset-1)</code>
   */
  public LambdaRecurrence(final int offset, final int order, final int shift, BiFunction<RingBuffer, Integer, Z> lambda, final Z... initTerms) {
    super(offset);
    mLambda = lambda;
    mOrder = order;
    mShift = shift;
    mIn = 0;
    mN = offset - 1; //  + mBufLen) & mMask;
    mInitLen = initTerms.length;
    int bufLen = Integer.highestOneBit(mOrder + 1) << 1;
    if (bufLen < mInitLen) {
      bufLen = Integer.highestOneBit(mInitLen + 1) << 1; // does not matter if too high
    }
    mBuffer = new RingBuffer(bufLen);
    for (int i = 0; i < mInitLen; ++i) {
      mBuffer.set(i + offset, initTerms[i]);
    }
  }

  /**
   * Gets the index distance between the highest recurrence element and <code>a[n]: 0..k-1</code>.
   * @return a non-negative number
   */
  public int getDistance() {
    return mShift;
  }

  /**
   * Gets the order of <code>this</code> recurrence
   * @return number of sequence elements in the recurrence equation, minus one.
   * The vector for the equation has an additional element for the constant,
   * and another for the new sequence element to be computed.
   */
  public int getOrder() {
    return mOrder;
  }

  @Override
  public Z next() {
    ++mN;
    if (++mIn <= mInitLen) {
      return mBuffer.get(mN);
    }
    final Z result = mLambda.apply(mBuffer, mN - mShift);
    mBuffer.set(mN, result);
    return result;
  }

}
