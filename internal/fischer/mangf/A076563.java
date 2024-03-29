package irvine.oeis.a076;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a006.A006530;

/**
 * A076563 a(n) = n - greatest prime divisor of n, for n&gt;1.
 * @author Georg Fischer
 */
public class A076563 extends AbstractSequence {

  private int mN = 1;
  private final A006530 mSeq = new A006530();

  /** Construct the sequence. */
  public A076563() {
    super(2);
    mSeq.next();
  }

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN).subtract(mSeq.next());
  }
}
