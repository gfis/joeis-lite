package irvine.oeis.a306;
// Generated by gen_seq4.pl trafo

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a001.A001006;
import irvine.oeis.transform.BoustrophedonTransformSequence;

/**
 * A306836 Expansion of e.g.f. (sec(x) + tan(x))*exp(x)*BesselI(1,2*x)/x.
 * @author Georg Fischer
 */
public class A306836 extends AbstractSequence {

  private final BoustrophedonTransformSequence mSeq1 = new BoustrophedonTransformSequence(new A001006());

  /** Construct the sequence. */
  public A306836() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next();
  }
}
