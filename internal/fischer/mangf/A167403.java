package irvine.oeis.a167;
// Generated by gen_seq4.pl build/arronk

import irvine.math.z.Z;
import irvine.oeis.a305.A305161;

/**
 * A167403 Number of decimal numbers having n or fewer digits and having the sum of their digits equal to n.
 * @author Georg Fischer
 */
public class A167403 extends A305161 {

  private int mN = 0;

  @Override
  public int getOffset() {
    return 1;
  }

  @Override
  public Z next() {
    ++mN;
    return super.matrixElement(mN, 9);
  }
}
