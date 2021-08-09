package irvine.oeis.a015;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A015889 Numbers n such that n | 4^n + 4.
 * @author Georg Fischer
 */
public class A015889 implements Sequence {

  protected Z mK; // Number k such that ...
  protected Z[] mList; // list of constants to be exponentiated
  protected Z[] mPows; // list[i]^mN
  protected Z mConst; // starting value of the sum
  protected int mLen; // length of mPows, mList
  
  /** Construct the sequence */
  public A015889() {
    this(4, 5);
  }
  
  /** 
   * Constructor with parameters
   * @param exp exponent
   */
  public A015889(final int ... list) {
    mConst = Z.valueOf(list[0]);
    mLen = list.length - 1;
    mList = new Z[mLen];
    mPows = new Z[mLen];
    for (int i = 1; i < mLen; ++i) {
        mList[i - 1] = list[i];
        mPows[i - 1] = Z.ONE;
    }
    mK = Z.ZERO;
  }

  @Override
  public Z next() {
    while (true) {
      mK = mK.add(1);
      Z sum = mConst;
      for (int i = 0; i < mLen; ++i) {
        mPows[i] = mPows[i].multiply(mList[i]);
        sum = sum.add(mPows[i]);
      } 
      if (sum.mod(mK).isZero()) {
        return mK;
      }
    }
  }
}
