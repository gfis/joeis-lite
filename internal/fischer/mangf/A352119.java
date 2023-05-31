package irvine.oeis.a352;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A352119 Expansion of e.g.f. 1/(2 - exp(4*x))^(1/4).
 * E.g.f.: 1/(2 - exp(4*x))^(1/4)
 * @author Georg Fischer
 */
public class A352119 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A352119() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.exp(RING.multiply(RING.log(RING.subtract(RING.monomial(new Q(2),0),RING.exp(RING.monomial(new Q(4),1),mN)),mN),RING.series(RING.one(),RING.monomial(new Q(4),0),mN),mN),mN),mN);
  }
}
