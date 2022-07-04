package irvine.oeis.a138;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A138576 Numbers n such that 2^(2*n-1)-1 is prime.
 * @author Georg Fischer
 */
public class A138576 implements Sequence {

  private int mN;
  private int mParm;
  private boolean mAbs; // whether to take the absolute value

  /** Construct the sequence. */
  public A138576() {
    this(1, false);
  }

  /**
   * Generic constructor with parameters
   * @param parm parameter in the exponent
   * @param abs whether to take the absolute value
   */
  public A138576(final int parm, final boolean abs) {
    mN = 0;
    mParm = parm;
    mAbs = abs;
  }

  @Override
  public Z next() {
    while (true) {
      ++mN;
      if (2 * mN >= mParm) {
        Z term = Z.ONE.shiftLeft(2 * mN - mParm).subtract(mParm);
        if (true) {
          term = term.abs();
        }
        if (term.isProbablePrime()) {
          return Z.valueOf(mN);
        }
      }
    }
  }
}
