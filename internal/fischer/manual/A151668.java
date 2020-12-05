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

  protected int mA;
  protected int mB;
  
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
    mHp1 = 1;
  }

  @Override
  protected Z advanceF(final int k) {
    return Z.NEG_ONE;
  }

  @Override
  protected Z advanceG(final int k) {
    return Z.valueOf(- mA);
  }


  @Override
  protected int advanceH(final int k) {
    mHp1 *= mB;
    return mHp1;
  }

}
