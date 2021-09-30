package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.a000.A000041; // all ones
import irvine.oeis.a000.A000004; // all zeroes

/**
 * Generate a triangle with the rules of the Pascal triangle, 
 * but with modified left and right borders (instead of 1), 
 * and an optional additive constant for each row.
 * @author Georg Fischer
 */
public class GeneralizedPascalTriangle implements Sequence {

  // protected static String mDebug = System.getProperty("debug", "0");
  protected Sequence mSeqL; // sequence for left border
  protected Sequence mSeqR; // sequence for right border
  protected Sequence mSeqA; // terms of this sequence are added to each row
  protected Z[] mOldRow; // previous row
  protected Z[] mNewRow; // current row
  protected Z mAdd; // additive term
  protected int mN; // current row index
  protected int mK; // current column index

  /**
   * Empty constructor.
   * Generates an ordinary Pascal triangle.
   */
  public GeneralizedPascalTriangle() {
    this(new A000041(), new A000041());
  }

  /**
   * Triangle with additive constant zero for the rows.
   * @param seqL terms for the left border
   * @param seqR terms for the right border
   */
  public GeneralizedPascalTriangle(final Sequence seqL, final Sequence seqR) {
    this(seqL, seqR, null); // add 0
  }

  /**
   * Triangle with some additive constant for the rows.
   * @param seqL terms for the left border
   * @param seqR terms for the right border
   * @param seqA terms to be added to each row
   */
  public GeneralizedPascalTriangle(final Sequence seqL, final Sequence seqR, final Sequence seqA) {
    mSeqL = seqL;
    mSeqR = seqR;
    mSeqA = seqA;
    mN = -1;
    mK = -1; // start with first element T(0,0)
    mNewRow = new Z[0];
    mAdd = Z.ZERO;
  }

  /**
   * Return next term, reading the triangle row by row from left to right, starting with T(0,0).
   * @return the next term of the sequence.
   */
  @Override
  public Z next() {
    ++mK;
    if (mK > mN) {
      ++mN;
      mK = 0;
      mOldRow = mNewRow;
      mNewRow = new Z[mN + 1];
      if (mSeqA != null) {
          mAdd = mSeqA.next();
      }
    }
    Z result = null;
    if (mK == 0) {
      result = mSeqL.next();
    } 
    if (mK == mN) {
      result = mSeqR.next();
    } 
    if (mK > 0 && mK < mN) {
      result = mSeqA != null ? mAdd.add(mOldRow[mK - 1]).add(mOldRow[mK]) : mOldRow[mK - 1].add(mOldRow[mK]);
    }
    mNewRow[mK] = result;
    return result;
  }

}
