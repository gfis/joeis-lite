package irvine.oeis.a079;
// manually

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence;

/**
 * A079908 Solution to the Dancing School Problem with 3 girls and n+3 boys: f(3,n).
 * @author Georg Fischer
 */
public class A079908 implements Sequence {

  protected Z[] mCoeffs; // of polynomial for next()
  protected Z mN; // ccurrent index
  
  /** Construct the sequence */
  public A079908() {
    this("[0,3,0,1]");
  }
  
  /**
   * Generic constructor with parameter
   * @param coeffs coefficients for polynomial
   */
  public A079908(final String coeffs) {
    mCoeffs = ZUtils.toZ(coeffs);
    mN = Z.NEG_ONE;
  }
  
  @Override
  public Z next() {
    mN = mN.add(Z.ONE);
    int i = mCoeffs.length - 1;
    Z result = mCoeffs[i--];
    while (i >= 0) {
      result = result.multiply(mN).add(mCoeffs[i--]);
    }
    return result;
  }
}