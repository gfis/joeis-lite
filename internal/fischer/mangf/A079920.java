package irvine.oeis.a079;

import irvine.math.z.Z;
import irvine.oeis.a079.A079922;

/**
 * A079920 Solution to the Dancing School Problem with 15 girls and n+15 boys: f(15,n).
 * @author Georg Fischer
 */
public class A079920 extends A079922 {

  /** Construct the sequence */
  public A079920() {
    super(15);
  }
  
  /**
   * Generic constructor with parameter
   * @param p 2nd parameter of function f
   */
  public A079920(int p) {
    mP = p;
    mN = -1;
  }
  
  @Override
  public Z next() {
    return super.compute(mP, ++mN).abs();
  }

}
