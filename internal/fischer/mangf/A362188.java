package irvine.oeis.a362;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A362188 Expansion of e.g.f. exp(x/(1-3*x)^(2/3)).
 * E.g.f.: exp(x/(1-3*x)^(2/3))
 * @author Georg Fischer
 */
public class A362188 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A362188() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.series(RING.x(),RING.exp(RING.multiply(RING.log(RING.subtract(RING.one(),RING.monomial(new Q(3),1)),mN),RING.series(RING.monomial(new Q(2),0),RING.monomial(new Q(3),0),mN),mN),mN),mN),mN);
  }
}
