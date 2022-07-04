package irvine.oeis.a210;

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A210062 Number of digits in 7^n.
 * @author Georg Fischer
 */
public class A210062 implements Sequence {

  private static CR LOG;
  private long mN = -1;

  /** Construct the sequence. */
  public A210062() {
    this(7);
  }

  /**
   * Generic constructor with parameters
   * @param num 
   */
  public A210062(final int num) {
    mN = -1;
    LOG = CR.valueOf(num).log().divide(CR.TEN.log());
  }

  @Override
  public Z next() {
    return LOG.multiply(++mN).floor().add(1);
  }
}
