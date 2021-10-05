package irvine.oeis.a127;
// manually 2021-09-29

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A127103 Numbers n such that n^2 divides 3^n-1. 
 * @author Georg Fischer
 */
public class A127103 implements Sequence {

  protected int mN;
  protected int mParm1;
  protected int mParm2;
  protected int mParm3;
  protected Z mPow;

  /** Construct the sequence. */
  public A127103() {
    this(2, 3, -1);
  }

  /**
   * Generic constructor with parameters: k^parm1 divides parm2^k+parm3
   * @param parm1 power of k
   * @param parm2 base
   * @param parm3 additive term
   */
  public A127103(final int parm1, final int parm2, final int parm3) {
    mN = 0;
    mParm1 = parm1;
    mParm2 = parm2;
    mParm3 = parm3;
    mPow = Z.ONE;
  }

  @Override
  public Z next() {
    while (true) {
      ++mN;
      mPow = mPow.multiply(mParm2);
      if (mPow.add(mParm3).mod(Z.valueOf(mN).pow(mParm1)).isZero()) {
        return Z.valueOf(mN);
      }
    }
  }
}
