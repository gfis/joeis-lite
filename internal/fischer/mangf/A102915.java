package irvine.oeis.a102;
// Generated by gen_seq4.pl suchprk0 at 2021-01-04 15:21
// DO NOT EDIT here!

import irvine.math.z.Z;
import irvine.oeis.Sequence;


/**
 * A102915 Numbers n such that n3 is prime and n is a multiple of 10.
 * @author Georg Fischer
 */
public class A102915 implements Sequence {
  protected long mK; // number k to be returned
  protected Z mConst1; // constant behind k
  protected Z mPow10; // 10^m always > k

  /** Empty constructor */
  public A102915() {
    this("03", "100");
  }
  
  /** 
   * Constructor for subclasses, with parameters
   * @param const1 constant behind k
   * @param pow10 least power of 10 &gt; const1
   */
  protected A102915(final String const1, final String pow10) {
    mConst1 = new Z(const1);
    mK = -1;
    mPow10 = new Z(pow10);
  }

  @Override
  public Z next() {
    boolean busy = true;
    while (busy) {
      ++mK;
      if (mConst1.add(mPow10.multiply(mK)).isProbablePrime()) {
        busy = false;
      }
    }
    return Z.valueOf(mK * 10);
  }
}
