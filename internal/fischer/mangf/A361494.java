package irvine.oeis.a361;
// Generated by gen_seq4.pl egfu at 2023-06-02 20:31

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A361494 Expansion of e.g.f. 1/(1 - log(2 - exp(x))).
 * E.g.f.: 1/(1 - log(2 - exp(x)))
 * @author Georg Fischer
 */
public class A361494 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A361494() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.one(),RING.log(RING.subtract(RING.monomial(new Q(2),0),RING.exp(RING.x(),mN)),mN)),mN);
  }
}
