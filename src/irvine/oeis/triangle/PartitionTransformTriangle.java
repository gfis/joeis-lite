package irvine.oeis.triangle;

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;

/**
 * Triangle resulting from the application of Peter Luschny&apos;s Partition Transform to another sequence.
 * @author Georg Fischer
 */
public class PartitionTransformTriangle extends BaseTriangle {

  private boolean mAccu;
  private boolean mInverse;
  private int mN = -1;
  private int mOffset;
  private final MemorySequence mSeq;

  /**
   * Constructor with sequence only.
   * @param seq underlying sequence
   */
  public PartitionTransformTriangle(final Sequence seq) {
    this(0, seq, false, false);
  }

  /**
   * Constructor with offset and sequence only.
   * @param offset first index
   * @param seq underlying sequence
   */
  public PartitionTransformTriangle(final int offset, final Sequence seq) {
    this(offset, seq, false, false);
  }

  /**
   * Constructor with all parameters.
   * @param offset first index, must be &gt;= 0.
   * @param seq underlying sequence
   * @param inverse whether to compute the inverse transform
   * @param accu whether the input terms should by multiplicatively accumulated
   */
  public PartitionTransformTriangle(final int offset, final Sequence seq, final boolean inverse, final boolean accu) {
    super(offset, 0, 0); // no row or column shift
    mSeq = MemorySequence.cachedSequence(seq);
    mInverse = inverse;
    mAccu = accu;
  }

  /**
   * Gets an element of the triangle.
   * @param n row number
   * @param k column number
   * @return T(n,k), or 0 for k &lt; 0 or k &gt; n.
   */
  protected Z get(final int n, final int k) {
    if (k > n || k < 0) {
      return Z.ZERO;
    } else if (n == 0) {
      mLastRow = new Z[] { Z.ONE };
      return mLastRow[0];
    } else if (n == mRow && k <= mCol) {
      return mLastRow[k];
    } 
    // else if (n < mRow) {
    return get(n)[k];
  }

  /**
   * Increase the row index, add a new, empty row and reset the column index.
   * The row length is <code>mRow + 1</code>.
   */
  protected void addRow() {
    ++mRow;
    mRowLen = mSizeFct.apply(mRow);
    add(new Z[mRowLen]);
    mLastRow = get(mRow);
    int k = mRowLen - 1;
    final int m = mRow;
    Z sum = Z.ZERO;
    if (mInverse) {
      mLastRow[k] = get(m - 1, m - 1).divide(mSeq.a(0));
      while (k >= 0) {
        for (int i = 0; i <= m - k + 1; ++i) {
          sum = sum.add(mSeq.a(i).multiply(mLastRow[k + i]));
        }
        mLastRow[k] = get(m - 1, k - 1).subtract(sum).divide(mSeq.a(0));
        --k;
      }
    } else { // not inverse
      mLastRow[k] = get(m - 1, m - 1).multiply(mSeq.a(0));
      while (k >= 0) {
        for (int i = 0; i <= m - k + 1; ++i) {
          sum = sum.add(mSeq.a(i).multiply(get(m - i - 1, k - 1)));
        }
        mLastRow[k] = sum;
        --k;
      }
    }
    mCol = 0;
  }

  /**
   * Compute an element of the BaseTriangle with shifted indexes.
   * In contrast to {@link #get} and {@link #compute}, the indexes are shifted by {@link #mRowShift}, {@link #mColShift}.
   * @param n shifted row index
   * @param k shifted column index
   * @return T(n, k)
   */
  public Z triangleElement(final int n, final int k) {
    return get(n, k);
  }
}
