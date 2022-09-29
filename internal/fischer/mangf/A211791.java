package irvine.oeis.a211;
// manually 2022-09-10

import irvine.math.LongUtils;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.SequenceWithOffset;

/**
 * A211791 Number of ordered triples (w,x,y) such that x and y are in {1,...,n} and w^2&lt;=x^2+y^2.
 * @author Georg Fischer
 */
public class A211791 implements SequenceWithOffset {

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
        sum = sum.add(LongUtils.sqrt(x*x + y*y));
      }
    }
    return sum;
  }
}
