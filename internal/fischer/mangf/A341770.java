package irvine.oeis.a341;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A341770 Largest number m on the square spiral board such that it takes n steps to reach square 1 from square m along the shortest path without stepping on any prime number.
 * a(n) = 4*n^2 - 9*n + 5 for n &gt;= 7.
 * @author Georg Fischer
 */
public class A341770 implements Sequence {

  private int mN = -1;
  private int[] mInits = new int[] { 1, 8, 23, 34, 61, 62, 97 };

  @Override
  public Z next() {
    ++mN;
    if (mN < 7) {
      return Z.valueOf(mInits[mN]);
    }
    return Z.valueOf(4*mN - 9).multiply(mN).add(5);
  }
}
