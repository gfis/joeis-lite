package irvine.oeis.a335;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A335531 Expansion of e.g.f. 1/(1-3*log(1+x)).
 * E.g.f.: 1/(1-3*log(1+x))
 * @author Georg Fischer
 */
public class A335531 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A335531() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.one(),RING.multiply(RING.monomial(new Q(3),0),RING.log(RING.onePlusXToTheN(1),mN),mN)),mN);
  }
}
