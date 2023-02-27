package irvine.oeis.a083;
// Generated by gen_seq4.pl A083064/arronk

import irvine.math.z.Z;

/**
 * A083070 First super-diagonal of number array A083064.
 * @author Georg Fischer
 */
public class A083070 extends A083064 {

  private int mN = -1;

  @Override
  public int getOffset() {
    return 1;
  }

  @Override
  public Z next() {
    ++mN;
    return super.matrixElement(mN + 1, mN);
  }
}
