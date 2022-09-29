package irvine.oeis.a211;
// manually 2022-09-10

import irvine.math.LongUtils;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.SequenceWithOffset;

/**
 * A211792 Number of ordered triples (w,x,y) such that x and y are in {1,...,n} and w^3&lt;=x^3+y^3.
 * @author Georg Fischer
 */
public class A211792 implements SequenceWithOffset {


  private int mN = 0;

  @Override
  public int getOffset() {
    return 1;
  }

  @Override
  public Z next() {
    ++mN;
    Z sum = Z.ZERO;
    for (int x = 1; x <= mN; ++x) {
      for (int y = 1; y <= mN; ++y) {
        sum = sum.add(Z.valueOf(x).pow(3).add(Z.valueOf(y).pow(3)).root(3));
      }
    }
    return sum;
  }
}
