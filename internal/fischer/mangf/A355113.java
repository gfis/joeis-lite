package irvine.oeis.a355;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A355113 Expansion of e.g.f. 5 / (6 - 5*x - exp(5*x)).
 * E.g.f.: 5 / (6 - 5*x - exp(5*x))
 * @author Georg Fischer
 */
public class A355113 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A355113() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.monomial(new Q(5),0),RING.subtract(RING.subtract(RING.monomial(new Q(6),0),RING.monomial(new Q(5),1)),RING.exp(RING.monomial(new Q(5),1),mN)),mN);
  }
}
