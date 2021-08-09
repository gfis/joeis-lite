package irvine.oeis.a058;
// manually for CC=etproot 2020-11-14

import irvine.math.z.Z;
import irvine.oeis.EulerTransform;
import irvine.oeis.PeriodicSequence;
import irvine.oeis.Sequence;

/**
 * A058559 McKay-Thompson series of class 20d for Monster.
 * Uses Somos <code>T20d=rootn(T10B,2); T10B=4+e10B=A058098;</code> with 
 * <code>e10B=ecalc([1,1;5,1;2,-1;10,-1],[1,4])=A132040</code>
 * C.f. A034318.
 *  
 * @author Georg Fischer
 */
public class A058599 implements Sequence {

  protected EulerTransform mET1; // the first sequenc
  protected EulerTransform mET2; // the second sequence
  protected int mSqueeze0; // number of zeroes to be removed from the resulting sequence
  protected Z mFactor; // multiply the second sequence by this factor before addition
  protected Z mAdd0; // add this constant to the first resulting term
  protected int mN; // current index/offset
  protected int mOffset; // index of first term of the sequence
  protected int mState; // for zero squeezing
  protected int mCount; // for zero squeezing
  
  /** Construct the sequence. */
  public A058599() {
    this(-1,0,1,4,    -2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,0);
  }

  /** 
   * Constructor with parameters. 
   * @param offset index of first term of the sequence
   * @param squeeze0 number of zeroes to be removed from the resulting sequence
   * @param factor multiply the sequence by this factor (not used)
   * @param add0 constant to be added to a(0)
   * @param per1 the terms of the PeriodicSequence to be transformed
   */
  public A058599(final int offset, final int squeeze0, final long factor, final long add0, final long ... per1) {
    mET1 = new EulerTransform(new PeriodicSequence(per1), 1);
    mSqueeze0 = squeeze0;
    mFactor = Z.valueOf(factor);
    mAdd0 = Z.valueOf(add0);
    mOffset = offset;
    mN = offset - 1;
    mCount = mSqueeze0; // start with output
    mState = 1;
  }
  
  @Override
  public Z next() {
    while (true) {
      switch (mState) {
        case 0:
          if (mCount <= 0) {
            mCount = mSqueeze0;
            mState = 1;
          } else {
            --mCount;
            advance();
          }
          break;
        case 1:
          if (mCount <= 0 && mSqueeze0 > 0) {
            mCount = mSqueeze0; // now skip mSqueeze0 zeroes
            mState = 0;
          } else {
            --mCount;
            return advance();
          }
          break;
        default:
          break;
      } // switch
    } // while
  }
  
  private Z advance() {
    ++mN; // starts with offset (= -1)
    Z result = mET1.next();
    if (mN == 0) {
      result = result.add(mAdd0);
    }
    return result;
  }
  
}
