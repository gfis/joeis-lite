package irvine.oeis;

import irvine.math.z.Z;
import irvine.math.MemoryFunction2;
import irvine.oeis.a000.A000041;

/**
 * Generate the rows of a triangle T(n,k) depending on
 * the left and right border (column), and the terms in the previous row.
 * This generalizes the rules for Pascal's triangle (A007318):
 * T(n,0) = T(n,n) = 1 and T(n,k) = T(n-1,k-1) + T(n-1,k) for 0 &lt; k &lt; n.
 * n and k always start with 0.
 * @author Georg Fischer
 */
public class BorderedTriangleRecurrence extends MemoryFunction2<Integer, Z> implements Sequence {

  private final Sequence mSeqL; // sequence for the left border T(n,0)
  private final Sequence mSeqR; // sequence for the right border T(n,n); this overwrites T(0,0)
  private final Sequence mSeqA; // a(n) of this optional sequence may be used to compute T(n,k) for 0 &lt; k &lt; n.
  private int mN; // current row index n
  private int mK; // current column index k
  private Z mAdd; // term of mSeqA, additive constant per row

  /**
   * Empty constructor.
   * Generates an ordinary Pascal triangle.
   */
  public BorderedTriangleRecurrence() {
    this(new A000041(), new A000041());
  }

  /**
   * Triangle with two sequences for the borders, and no additional term.
   * @param seqL sequence for the left border T(n,0)
   * @param seqR sequence for the right border T(n,n); this overwrites T(0,0)
   */
  public BorderedTriangleRecurrence(final Sequence seqL, final Sequence seqR) {
    this(seqL, seqR, null);
  }

  /**
   * Triangle with sequences for the borders and an additional term (constant for all formulas in one row).
   * @param seqL sequence for the left border T(n,0)
   * @param seqR sequence for the right border T(n,n); this overwrites T(0,0)
   * @param seqA a(n) of this sequence may be used to compute T(n,k) for 0 &lt; k &lt; n.
   */
  public BorderedTriangleRecurrence(final Sequence seqL, final Sequence seqR, final Sequence seqA) {
    mSeqL = seqL;
    mSeqR = seqR;
    mSeqA = seqA;
    mN = -1;
    mK = 0; // start with first element T(0,0)
    mAdd = Z.ZERO;  // for safety
  }

  /**
   * Computes an inner element.
   * This method is typically overwritten.
   * The default implementation here is Pascal's rule.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  @Override
  protected Z compute(final Integer n, final Integer k) {
    Z result = null;
    if (k < 0 || k > n || n < 0) {
      result = Z.ZERO;
    }
    if (k == 0) { // left border
      result = mSeqL.next();
    }
    if (k == n) { // right border (has priority)
      result = mSeqR.next();
    } else if (k > 0) {
      result = get(n - 1, k - 1).add(get(n - 1, k));
      if (mSeqA != null) {
        result = result.add(getA());
      }
    }
    return result;
  }

  /**
   * Return next term, reading the triangle row by row from left to right, starting with T(0,0).
   * @return the next term of the sequence.
   */
  @Override
  public Z next() {
    if (++mK > mN) {
      ++mN;
      mK = 0;
      if (mSeqA != null && mN >= 2) {
        mAdd = mSeqA.next();
      }
    }
    return get(mN, mK);
  }
  /**
   * Gets the additive term from mSeqA for the current row
   * @return mAdd
   */
  protected Z getA() {
    return mAdd;
  }

  /**
   * Method for compatibility with first version.
   * @param k column index
   * @return T(n-1, k)
   */
  protected Z getM1(final int k) {
    return get(mN - 1, k);
  }

  /**
   * Advances the sequence for the leftmost column.
   * @param skip number of elements to skip
   */
  protected void skipLeft(int skip) {
    while (skip > 0) {
      mSeqL.next();
      --skip;
    }
  }

  /**
   * Advances the sequence for the rightmost column.
   * @param skip number of elements to skip
   */
  protected void skipRight(int skip) {
    while (skip > 0) {
      mSeqR.next();
      --skip;
    }
  }

  /**
   * Advances the sequence for the additive term.
   * @param skip number of elements to skip
   */
  protected void skipAdd(int skip) {
    while (skip > 0) {
      mSeqA.next();
      --skip;
    }
  }
}