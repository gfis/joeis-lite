package irvine.oeis.a246;
// Generated by gen_seq4.pl m1pow at 2023-06-04 18:45

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a055.A055941;

/**
 * A246016 a(n) = (-1)^A055941(n).
 * @author Georg Fischer
 */
public class A246016 extends AbstractSequence {

  private final A055941 mSeq = new A055941();

  /** Construct the sequence. */
  public A246016() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq.next().testBit(0) ? Z.NEG_ONE : Z.ONE;
  }
}
