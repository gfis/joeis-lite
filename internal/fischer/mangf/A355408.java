package irvine.oeis.a355;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A355408 Expansion of e.g.f. 1/(1 + exp(x) - exp(3*x)).
 * E.g.f.: 1/(1 + exp(x) - exp(3*x))
 * @author Georg Fischer
 */
public class A355408 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A355408() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.add(RING.one(),RING.exp(RING.x(),mN)),RING.exp(RING.monomial(new Q(3),1),mN)),mN);
  }
}
