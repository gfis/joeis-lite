package irvine.oeis.a203;

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;
import irvine.oeis.a203.A203773;

/**
 * A203775 Square root of v(2*n+1) / (2*v(2*n)), where v=A203773.
 * @author Georg Fischer
 */
public class A203775 implements Sequence {

  private int mN = 0;
  private MemorySequence mSeq = MemorySequence.cachedSequence(new A203773());
  
  @Override
  public Z next() {
    ++mN;
    return mSeq.a(2*mN).divide(mSeq.a(2*mN - 1).multiply2()).sqrt();
  }
}
