package irvine.oeis.a167;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a007.A007504;

/**
 * A167214 a(n) = (sum of first n primes) * n.
 * @author Georg Fischer
 */
public class A167214 extends AbstractSequence {

  private int mN = 0;
  private final A007504 mSeq = new A007504();

  /** Construct the sequence. */
  public A167214() {
    super(1);
    mSeq.next();
  }

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN).multiply(mSeq.next());
  }
}
