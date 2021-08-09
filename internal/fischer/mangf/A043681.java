package irvine.oeis.a043;
// manually 2021-03-04

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence;

/**
 * A043681 When cubed gives number composed just of the digits 0, 1, 2, 3.
 * @author Georg Fischer
 */
public class A043681 implements Sequence {
    
  private Z nz;

  /** Construct the sequence */
  public A043681() {
    nz = Z.NEG_ONE;
  }

  @Override
  public Z next() {
    while (true) {
      nz = nz.add(Z.ONE);
      final int [] dc = ZUtils.digitCounts(nz.multiply(nz).multiply(nz));
      if (dc[4] + dc[5] + dc[6] + dc[7] + dc[8] + dc[9] == 0) {
        return nz;
      }
    }
  }
}
