package irvine.oeis.a361;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A361557 Expansion of e.g.f. exp((exp(x) - 1)/(1-x)).
 * E.g.f.: exp((exp(x) - 1)/(1-x))
 * @author Georg Fischer
 */
public class A361557 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A361557() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.series(RING.subtract(RING.exp(RING.x(),mN),RING.one()),RING.oneMinusXToTheN(1),mN),mN);
  }
}
