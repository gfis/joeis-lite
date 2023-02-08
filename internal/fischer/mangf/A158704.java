package irvine.oeis.a158;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence1;

/**
 * A158704 Nonnegative integers with an even number of even powers of 2 in their base-2 representation.
 * @author Georg Fischer
 */
public class A158704 extends Sequence1 {

  private Z mN = Z.NEG_ONE;
  
  @Override
  public Z next() {
    while (true) {
      mN = mN.add(1);
      final int[] counts = ZUtils.digitCounts(mN, 4);
      if (((counts[1] + counts[3]) & 1) == 0) {
        return mN;
      }
    }
  }
}
