package irvine.oeis.a206;
// manually, 2020-12-04

import irvine.math.z.Z;
import irvine.oeis.GeneralizedEulerTransform;
import irvine.oeis.Sequence;
import irvine.oeis.a002.A002275;

/**
 * A206244 Number of partitions of n into repunits (A002275).
 * Prototype for "Number of partitions of n into ... (Annnnn)".
 * G.f.: Product_{k>=1} 1/(1 - x^((10^k-1)/9)).
 * @author Georg Fischer
 */
public class A206244 extends GeneralizedEulerTransform {

  protected Sequence mSeq;
  protected long mA;
  protected long mB;
  protected Z mStone; // next milestone with a non-zero x^n
  
  /** Construct the sequence. */
  public A206244() {
    this(new A002275());
  }
 
  /** 
   * Constructor with parameters. 
   * @param a factor before x
   * @param b base of n-th power 
   */
  public A206244(final Sequence seq) {
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
