package irvine.oeis.a057;

import irvine.math.LongUtils;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A057889 Bit-reverse of n, including as many leading as trailing zeros.
 * @author Georg Fischer
 */
public class A057889 implements Sequence {

  private long mN;

  /** Construct the sequence. */
  public A057889() {
    mN = -1;
  }

  @Override
  public Z next() {
    if (++mN == 0) {
      return Z.ZERO;
    }
    final int head0 = Long.numberOfLeadingZeros(mN);
    final int tail0 = Long.numberOfTrailingZeros(mN);
    final long nOrg = mN >> tail0;
    final long nRev = ((Long.reverse(nOrg) >> head0) & ((1 << (64 - head0)) - 1)) >> tail0;
    return Z.valueOf(nOrg != nRev ? (nRev << tail0) : mN);
  }
}
