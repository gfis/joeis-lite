package irvine.oeis.a355;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A355112 Expansion of e.g.f. 4 / (5 - 4*x - exp(4*x)).
 * E.g.f.: 4 / (5 - 4*x - exp(4*x))
 * @author Georg Fischer
 */
public class A355112 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A355112() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.monomial(new Q(4),0),RING.subtract(RING.subtract(RING.monomial(new Q(5),0),RING.monomial(new Q(4),1)),RING.exp(RING.monomial(new Q(4),1),mN)),mN);
  }
}
