package irvine.oeis.a260;
// Generated by gen_seq4.pl m1pow/m1mul at 2023-06-04 18:45

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a053.A053258;

/**
 * A260971 Expansion of phi_0(-q) in powers of q where phi_0() is a 5th-order mock theta function.
 * @author Georg Fischer
 */
public class A260971 extends AbstractSequence {

  private int mN = -1;
  private final A053258 mSeq = new A053258();

  /** Construct the sequence. */
  public A260971() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return mSeq.next().multiply(((mN & 1) == 0) ? 1 : -1);
  }
}
