package irvine.oeis.a255;
// Generated by gen_seq4.pl A255961/arronk

import irvine.math.z.Z;
import irvine.oeis.a255.A255961;

/**
 * A255672 Coefficient of x^n in Product_{k&gt;=1} 1/(1-x^k)^(k*n).
 * @author Georg Fischer
 */
public class A255672 extends A255961 {

  private int mN = -1;
  
  @Override
  public int getOffset() {
    return 0;
  }

  @Override
  public Z next() {
    ++mN;
    return super.matrixElement(mN, mN);
  }
}
