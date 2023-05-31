package irvine.oeis.a355;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A355233 E.g.f. A(x) satisfies A&apos;(x) = 1 + 2 * (exp(x) - 1) * A(x).
 * E.g.f.: 3*exp(2*exp(x) - 2*x - 2)/4 - 1/(exp(2*x)*4) - 1/(2*exp(x))
 * @author Georg Fischer
 */
public class A355233 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A355233() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.subtract(RING.subtract(RING.series(RING.multiply(RING.monomial(new Q(3),0),RING.exp(RING.subtract(RING.subtract(RING.multiply(RING.monomial(new Q(2),0),RING.exp(RING.x(),mN),mN),RING.monomial(new Q(2),1)),RING.monomial(new Q(2),0)),mN),mN),RING.monomial(new Q(4),0),mN),RING.series(RING.one(),RING.multiply(RING.exp(RING.monomial(new Q(2),1),mN),RING.monomial(new Q(4),0),mN),mN)),RING.series(RING.one(),RING.multiply(RING.monomial(new Q(2),0),RING.exp(RING.x(),mN),mN),mN));
  }
}
