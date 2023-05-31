package irvine.oeis.a352;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A352643 Expansion of e.g.f. exp(3 * x * cos(x)).
 * E.g.f.: exp(3 * x * cos(x))
 * @author Georg Fischer
 */
public class A352643 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A352643() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.multiply(RING.monomial(new Q(3),1),RING.cos(RING.x(),mN),mN),mN);
  }
}
