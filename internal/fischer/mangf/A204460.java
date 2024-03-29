package irvine.oeis.a204;
// manually A204459/arronk

import irvine.math.z.Z;
import irvine.oeis.a204.A204459;

/**
 * A204460 Number of 2*n-element subsets that can be chosen from {1,2,...,8*n} having element sum n*(8*n+1).
 * @author Georg Fischer
 */
public class A204460 extends A204459 {

  private int mN =-1;
  
  @Override
  public Z next() {
    ++mN;
    return super.matrixElement(4, mN++);
  }
}

