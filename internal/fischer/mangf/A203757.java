package irvine.oeis.a203;

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;
import irvine.oeis.a203.A203755;

/**
 * A203757 Square root of v(2n)/v(2n-1), where v=A203755.
 * @author Georg Fischer
 */
public class A203757 implements Sequence {

  private int mN = 0;
  private MemorySequence mSeq = MemorySequence.cachedSequence(new A203755());
  
  @Override
  public Z next() {
    ++mN;
    return mSeq.a(2*mN - 1).divide(mSeq.a(2*mN - 2)).sqrt();
  }
}
