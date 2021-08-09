package irvine.oeis.a160;
// Generated by gen_seq4.pl num1dig at 2021-04-26 18:49; manually modified

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence;


/**
 * A160380 Number of 0's in base-4 representation of n.
 * @author Georg Fischer
 */
public class A160380 implements Sequence {

  protected int mN = -1;

  @Override
  public Z next() {
    ++mN;
    return mN == 0 ? Z.ZERO : Z.valueOf(ZUtils.digitCounts(Z.valueOf(mN), 4)[0]);
  }
}