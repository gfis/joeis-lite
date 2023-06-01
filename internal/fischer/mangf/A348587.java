package irvine.oeis.a348;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A348587 Expansion of e.g.f. exp(x) / (2 - cos(x)).
 * E.g.f.: exp(x) / (2 - cos(x))
 * @author Georg Fischer
 */
public class A348587 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A348587() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.exp(RING.x(),mN),RING.subtract(RING.monomial(new Q(2),0),RING.cos(RING.x(),mN)),mN);
  }
}