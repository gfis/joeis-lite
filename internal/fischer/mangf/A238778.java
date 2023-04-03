package irvine.oeis.a238;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a035.A035026;

/**
 * A238778 Sum of all primes p such that 2n - p is also a prime.
 * @author Georg Fischer
 */
public class A238778 extends AbstractSequence {

  private int mN = 1;
  private final A035026 mSeq = new A035026();

  /** Construct the sequence. */
  public A238778() {
    super(2);
    mSeq.next();
  }

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN).multiply(mSeq.next());
  }
}
