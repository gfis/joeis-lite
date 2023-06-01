package irvine.oeis.a351;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A351778 Expansion of e.g.f. 1/(1 + 3*x*exp(x)).
 * E.g.f.: 1/(1 + 3*x*exp(x))
 * @author Georg Fischer
 */
public class A351778 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A351778() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.add(RING.one(),RING.multiply(RING.monomial(new Q(3),1),RING.exp(RING.x(),mN),mN)),mN);
  }
}