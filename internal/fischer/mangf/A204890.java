package irvine.oeis.a204;

import irvine.math.z.Z;
import irvine.oeis.a000.A000040;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;
import irvine.oeis.triangle.Triangle;

/**
 * A204890 Ordered differences of primes.
 * @author Georg Fischer
 */
public class A204890 extends Triangle {

  private int mDist;
  private MemorySequence mSeq;

  /** Construct the sequence. */
  public A204890() {
    this(new A000040(), 1);
    hasRAM(true);
  }

  /**
   * Generic constructor with parameters
   * @param seq underlying sequence
   * @param dist number of zeros to be prepended to the underlying sequence
   */
  public A204890(final Sequence seq, final int dist) {
    mSeq = MemorySequence.cachedSequence(seq);
    mDist = dist;
    hasRAM(true);
  }

  @Override
  public Z compute(int n, int k) {
    n += 2;
    ++k;
    // System.out.println("n=" + n + ", k=" + k + ", a(n)=" + mSeq.a(n - mDist) + ", a(k)=" + mSeq.a(k - mDist));
    return mSeq.a(n - mDist).subtract(mSeq.a(k - mDist));
  }
}