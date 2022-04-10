package irvine.oeis.a060;

import irvine.math.Mobius;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;
import irvine.oeis.a005.A005809;

/**
 * A060170 Number of orbits of length n under the map whose periodic points are counted by A005809.
 * a(n) = (1/n)* Sum_{d|n} mu(n/d)*A005809(d).
 * @author Georg Fischer
 */
public class A060170 implements Sequence {

  protected int mN;
  protected MemorySequence mSeq;

  /** Construct the sequence. */
  public A060170() {
    this(new A005809());
  }

  /**
   * Generic constructor with parameters.
   * @param seq underlying sequence
   */
  public A060170(final Sequence seq) {
    mN = 0;
    mSeq = MemorySequence.cachedSequence(seq);
  }

  @Override
  public Z next() {
    ++mN;
    return Integers.SINGLETON.sumdiv(mN, d -> mSeq.a(d).multiply(Mobius.mobius(mN / d))).divide(mN);
  }
}
