package irvine.oeis.a296;
// manually sumdiv at 2023-04-04 09:23

import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A296955 Sum of the smaller parts of the partitions of n into two distinct parts such that the smaller part divides the larger.
 * @author Georg Fischer
 */
public class A296955 extends AbstractSequence {

  private int mN = 0;

  /** Construct the sequence. */
  public A296955() {
    super(1);
  }

  @Override
  public Z next() {
    ++mN;
    return Integers.SINGLETON.sumdiv(mN, d -> ((d < mN / 2) ? Z.valueOf(d) : Z.ZERO));
  }
}
