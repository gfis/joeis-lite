package irvine.oeis.a056;

import irvine.math.Mobius;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;
import irvine.oeis.a000.A000920;

/**
 * A056271 A056271 Number of primitive (aperiodic) words of length n which contain exactly six different symbols.
 * Sum mu(d)*A000920(n/d) where d|n.
 * @author Georg Fischer
 */
public class A056271 implements Sequence {

  protected int mN;
  protected MemorySequence mSeq;

  /** Construct the sequence. */
  public A056271() {
    this(new A000920());
  }

  /**
   * Generic constructor with parameters.
   * @param seq underlying sequence
   */
  public A056271(final Sequence seq) {
    mN = 0;
    mSeq = MemorySequence.cachedSequence(seq);
    mSeq.add(Z.ZERO);
  }

  @Override
  public Z next() {
    ++mN;
    return Integers.SINGLETON.sumdiv(mN, d -> mSeq.a(mN / d).multiply(Mobius.mobius(d)));
  }
}
