package irvine.oeis.a230;
// Generated by gen_seq4.pl trafo

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a065.A065091;
import irvine.oeis.transform.BoustrophedonTransformSequence;

/**
 * A230953 Boustrophedon transform of odd primes, cf. A065091.
 * @author Georg Fischer
 */
public class A230953 extends AbstractSequence {

  private final BoustrophedonTransformSequence mSeq1 = new BoustrophedonTransformSequence(new A065091());

  /** Construct the sequence. */
  public A230953() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next();
  }
}