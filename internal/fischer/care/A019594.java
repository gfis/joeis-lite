package irvine.oeis.a019;
// manually 2021-08-03

import irvine.math.z.Z;
import irvine.oeis.Sequence;
import irvine.oeis.a005.A005206;
import irvine.oeis.a019.A019588;

/**
 * A019594 Conway&apos;s &quot;para-budding&quot; sequence.
 * From sequencedb: A005206(n)+A019588(n)
 * @author Georg Fischer
 */
public class A019594 extends A005206 {

  protected Sequence mSeq;

  /** Construct the sequence. */
  public A019594() {
    mSeq = new A019588();
  }

  @Override
  public Z next() {
    return super.next().add(mSeq.next());
  }
}
