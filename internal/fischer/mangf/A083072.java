package irvine.oeis.a083;
// Generated by gen_seq4.pl A083064/arronk

import irvine.math.z.Z;
import irvine.oeis.a083.A083064;

/**
 * A083072 A subdiagonal of number array A083064.
 * @author Georg Fischer
 */
public class A083072 extends A083064 {

  private int mN = -1;
  
  @Override
  public int getOffset() {
    return 0;
  }

  @Override
  public Z next() {
    ++mN;
    return super.matrixElement(mN, mN+2);
  }
}

