package irvine.oeis.a007;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence;

/**
 * A007953 Digital sum (i.e., sum of digits) of n; also called digsum(n).
 * @author Sean A. Irvine
 * @author Georg Fischer
 */
public class A007953 implements Sequence {

  protected long mN;
  protected long mBase;
  
  /** Construct this sequence */
  public A007953() {
    this(10);
  }
  
  /**
   * Generic constructor with parameter
   * @param base sum the digits of n written in this base
   */
  public A007953(final long base) {
    mN = -1;
    mBase = base;
  }

  @Override
  public Z next() {
    return Z.valueOf(ZUtils.digitSum(++mN, mBase));
  }
}