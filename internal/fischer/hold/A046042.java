package irvine.oeis.a046;
// manually, 2020-12-05

import irvine.math.z.Z;
import irvine.oeis.GeneralizedEulerTransform;
import irvine.oeis.Sequence;
import irvine.oeis.a000.A000583; // fourth powers

/**
 * A046042 Number of partitions of n into fourth powers.
 * G.f.: -1 + 1/product(1-x^(k^4), k > 0).
 * @author Georg Fischer
 */
public class A046042 extends GeneralizedEulerTransform {

  protected Sequence mSeq;
  protected long mA;
  protected long mB;
  protected Z mStone; // next milestone with a non-zero x^n
  
  /** Construct the sequence. */
  public A046042() {
    this(new A000583());
  }
 
  /** 
   * Constructor with parameters. 
   * @param a factor before x
   * @param b base of n-th power 
   */
  public A046042(final Sequence seq) {
    super(1);
    mA = 1;
    mB = 1;
    mSeq = seq;
    mSeq.next();
    mStone = mSeq.next();
  }

  @Override
  protected Z advanceF(final long n) {
    return Z.ONE;
  }
  
  @Override
  protected Z advanceG(final long n) {
    Z result = Z.ZERO;
    if (mStone.equals(Z.valueOf(n))) {
      result = Z.valueOf(mA);
      mStone = mSeq.next();
    } // else 0
    return result;
  }
  

}
