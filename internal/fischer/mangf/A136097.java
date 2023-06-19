package irvine.oeis.a136;
// Generated by gen_seq4.pl m1pow/m1mul at 2023-06-04 18:45

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a015.A015030;

/**
 * A136097 a(n) = A135951(n) /[(2^(n+1)-1) * 2^(n*(n-1)/2)].
 * @author Georg Fischer
 */
public class A136097 extends AbstractSequence {

  private int mN = -1;
  private final A015030 mSeq = new A015030();

  /** Construct the sequence. */
  public A136097() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    return mSeq.next().multiply(((mN & 1) == 0) ? 1 : -1);
  }
}