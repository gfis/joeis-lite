package irvine.oeis.a058;
// manually for CC=etproot 2020-11-16

import irvine.math.z.Z;
import irvine.oeis.EulerTransform;
import irvine.oeis.EulerInvTransform;
import irvine.oeis.Sequence;
import irvine.oeis.a058.A058637;

/**
 * A058741 McKay-Thompson series of class 66a for Monster.
 * Uses Somos <code>T66a=rootn(1+symm(e33A,3),2); T33B=1+symm(e33A,3)=A058637</code>
 * <code>A058741=EULER0(EULER0i(Vec(T33B))/2)</code> 
 * @author Georg Fischer
 */
public class A058741 implements Sequence {

  protected EulerInvTransform mEiT1; // the first sequenc
  protected EulerTransform mET2; // the second sequence
  protected Z mFactor; // multiply the second sequence by this factor before addition
  protected Z mAdd0; // add this constant to the first resulting term
  protected int mN; // current index/offset
  
  /** Construct the sequence. */
  public A058741() {
    this(new A058637(), 2, 0);
  }

  /** 
   * Constructor with parameters. 
   * @param seq take the root of this formal power series
   * @param factor denominator of the fractional exponent
   * @param add0 constant to be added to a(0)
   */
  public A058741(Sequence seq, final int factor, final long add0) {
    mEiT1 = new EulerInvTransform(seq, 0);
    mEiT1.setExponent(1, factor);
    mET2 = new EulerTransform(mEiT1, 1);
    mN = -2; // always start with -1
    mAdd0 = Z.valueOf(add0);
  }
  
  @Override
  public Z next() {
    ++mN;
    Z result = mET2.next();
    if (mN == 0) {
      result = result.add(mAdd0);
    }
    return result;
  }
  
}
