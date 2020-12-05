package irvine.oeis.a151;
// manually, 2020-12-04

import irvine.math.z.Z;
import irvine.oeis.GeneralizedEulerTransform;

/**
 * A151668 G.f.: Prod_{k >= 0} (1+2*x^(3^k)).
 * Prototype for Prod_{k >= 0} (1+a*x^(b^k)).
 * @author Georg Fischer
 */
public class A151668 extends GeneralizedEulerTransform {

  protected long mA;
  protected long mB;
  protected Z mStone; // next milestone with a non-zero x^n
  
  /** Construct the sequence. */
  public A151668() {
    this(2, 3);
  }
 
  /** 
   * Constructor with parameters. 
   * @param a factor before x
   * @param b base of n-th power 
   */
  public A151668(final int a, final int b) {
    super(1);
    mA = a;
    mB = b;
    mStone = Z.ONE;
  }

  @Override
  protected Z advanceF(final long n) {
    return Z.NEG_ONE;
  }
  
  @Override
  protected Z advanceG(final long n) {
    Z result = Z.ZERO;
    if (mStone.equals(Z.valueOf(n))) {
      result = Z.valueOf(- mA);
      mStone = mStone.multiply(mB);
    } // else 0
    return result;
  }
  

}
