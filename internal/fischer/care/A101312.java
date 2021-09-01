package irvine.oeis.a101;
// manually 2021-08-15

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A101312 Number of &quot;Friday the 13ths&quot; in year n (starting at 1901). 
 * (PARI) a(n)=[1, 2, 2, 2, 2, 1, 1, 2, 2, 1, 3, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 3, 1, 1, 3, 2, 1, 3][(n+(n\100-n\400-15)*12)%28+1]
 * @author Georg Fischer
 */
public class A101312 implements Sequence {

  protected int mN;
  protected int[] mParm;

  /** Construct the sequence. */
  public A101312() {
    mN = 1900;
    mParm = new int[] { 1, 2, 2, 2, 2, 1, 1, 2, 2, 1, 3, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 3, 1, 1, 3, 2, 1, 3 };
  }

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mParm[(mN + (mN / 100 - mN / 400 - 15) * 12) % 28]);
  }
}
