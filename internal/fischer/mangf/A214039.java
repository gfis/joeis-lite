package irvine.oeis.a214;
// manually arsimple/prev3 at 2021-11-18 12:14

import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A214039 a(n) = a(n-1) - floor((a(n-2) + a(n-3))/2), with a(n)=n for n &lt; 3.
 * @author Georg Fischer
 */
public class A214039 implements Sequence {

  private int mN = -1; 
  private Z mAn_3 = Z.ZERO;
  private Z mAn_2 = Z.ONE;
  private Z mAn_1 = Z.TWO;
  
  @Override
  public Z next() {
    ++mN;
    final Z n = Z.valueOf(mN);
    if (mN == 0) {
      return mAn_3;
    } else if (mN == 1) {
      return mAn_2;
    } else if (mN == 2) {
      return mAn_1;
    } else {
      Z result = mAn_1.subtract(new Q(mAn_2.add(mAn_3), Z.TWO).floor());
      mAn_3 = mAn_2;
      mAn_2 = mAn_1;
      mAn_1 = result;
      return mAn_1;
    }
  }
}
