package irvine.oeis.a288;

import irvine.math.z.Z;
import irvine.math.z.BellNumbers;
import irvine.math.z.Binomial;
import irvine.math.z.Integers;
import irvine.oeis.SequenceWithOffset;

/**
 * A288785 Number of blocks of size &gt;= three in all set partitions of n.
 * a(n) = Sum_{j=0..n- 3} binomial(n,j) * Bell(j).
 * @author Georg Fischer
 */
public class A288785 implements SequenceWithOffset {

  private int mN;
  private int mOffset;
  private int mParm;

  /** Construct the sequence. */
  public A288785() {
    this(3, 3);
  }

  /**
   * Generic constructor with parameters
   * @param offset 
   * @param parm 
   */
  public A288785(final int offset, final int parm) {
    mOffset = offset;
    mN = offset - 1;
    mParm = parm;
  }

  @Override
  public int getOffset() {
    return mOffset;
  }

  @Override
  public Z next() {
    ++mN;
    return Integers.SINGLETON.sum(0, mN - mParm, j -> Binomial.binomial(mN, j).multiply(BellNumbers.bell(j)));
  }
}
