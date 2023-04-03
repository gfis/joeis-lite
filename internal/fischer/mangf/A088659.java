package irvine.oeis.a088;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a070.A070777;

/**
 * A088659 a(n) = n*(p-1) where p is the largest prime factor of n.
 * @author Georg Fischer
 */
public class A088659 extends AbstractSequence {

  private int mN = 1;
  private final A070777 mSeq = new A070777();

  /** Construct the sequence. */
  public A088659() {
    super(2);
    mSeq.next();
  }

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN).multiply(mSeq.next());
  }
}
