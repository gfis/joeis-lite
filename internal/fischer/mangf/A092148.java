package irvine.oeis.a092;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A092148 Expansion of e.g.f. 1/(exp(x)-x*exp(2*x)).
 * E.g.f.: 1/(exp(x)-x*exp(2*x))
 * @author Georg Fischer
 */
public class A092148 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A092148() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.exp(RING.x(),mN),RING.multiply(RING.x(),RING.exp(RING.monomial(new Q(2),1),mN),mN)),mN);
  }
}
