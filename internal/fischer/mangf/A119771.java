package irvine.oeis.a119;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A119771 Product of n^2 and n-th tetrahedral number: n^3*(n+1)*(n+2)/6.
 * @author Georg Fischer
 */
public class A119771 implements Sequence {

  private int mN = -1;

  public Z next() {
    ++mN;
    return Z.valueOf(mN + 1).multiply(mN * mN).multiply(mN).multiply(mN + 2).divide(6);
  }
}
