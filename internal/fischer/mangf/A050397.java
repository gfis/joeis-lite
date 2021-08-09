package irvine.oeis.a050;
// manually; serrevas at 2021-05-02 19:02

import irvine.math.z.Z;
import irvine.oeis.RevertTransformSequence;
import irvine.oeis.a000.A000085;


/**
 * A050397 Reversion of sequence of involutions (A000085).
 * @author Georg Fischer
 */
public class A050397 extends RevertTransformSequence {

  protected int mN; // current index
  
  /** Construct the sequence. */
  public A050397() {
    super(new A000085());
    mSeq.next();
    mSeq.next();
    mN = 0;
  }

  @Override
  public Z next() {
    return ++mN <= 2 ? Z.ONE : super.next();
  }
}
