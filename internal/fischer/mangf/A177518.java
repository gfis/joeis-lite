package irvine.oeis.a177;
// Generated by gen_seq4.pl tricol/arrcol

import irvine.math.z.Z;
import irvine.oeis.a242.A242784;

/**
 * A177518 Number of permutations of 1..n avoiding adjacent step pattern up, down, down, down.
 * @author Georg Fischer
 */
public class A177518 extends A242784 {

  private int mN = 0;

  @Override
  public int getOffset() {
    return 1;
  }

  @Override
  public Z next() {
    return super.matrixElement(++mN, 14);
  }
}

