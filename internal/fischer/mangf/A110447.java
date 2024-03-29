package irvine.oeis.a110;

import irvine.math.z.Z;
import irvine.oeis.SequenceWithOffset;
import irvine.oeis.a030.A030266;

/**
 * A110447 Permutations containing 3241 patterns only as part of 35241 patterns.
 * @author Georg Fischer
 */
public class A110447 extends A030266 implements SequenceWithOffset {

  /** Construct the sequence. */
  public A110447() {
    super.next();
  }

  @Override
  public int getOffset() {
    return 0;
  }
}
