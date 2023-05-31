package irvine.oeis.a354;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A354313 Expansion of e.g.f. 1/(1 - x/2 * (exp(2 * x) - 1)).
 * E.g.f.: 1/(1 - x/2 * (exp(2 * x) - 1))
 * @author Georg Fischer
 */
public class A354313 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A354313() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.one(),RING.multiply(RING.series(RING.x(),RING.monomial(new Q(2),0),mN),RING.subtract(RING.exp(RING.monomial(new Q(2),1),mN),RING.one()),mN)),mN);
  }
}
