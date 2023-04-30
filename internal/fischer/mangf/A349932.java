package irvine.oeis.a349;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a035.A035327;

/**
 * A349932 Product of n and its binary ones&apos; complement.
 * @author Georg Fischer
 */
public class A349932 extends AbstractSequence {

  private int mN = 0;
  private final A035327 mSeq = new A035327();

  /** Construct the sequence. */
  public A349932() {
    super(1);
    mSeq.next();
  }

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN).multiply(mSeq.next());
  }
}