package irvine.oeis.a323;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a060.A060691;

/**
 * A323385 Expansion of AGM(1,1-16*x) (where AGM denotes the arithmetic-geometric mean).
 * @author Georg Fischer
 */
public class A323385 extends AbstractSequence {

  private int mN = -1;
  private final A060691 mSeq = new A060691();

  /** Construct the sequence. */
  public A323385() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return Z.ONE.shiftLeft(mN).multiply(mSeq.next());
  }
}
