package irvine.oeis.a356;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A356820 Expansion of e.g.f. exp(-x * exp(3*x)).
 * E.g.f.: exp(-x * exp(3*x))
 * @author Georg Fischer
 */
public class A356820 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A356820() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.subtract(RING.zero(),RING.multiply(RING.x(),RING.exp(RING.monomial(new Q(3),1),mN),mN)),mN);
  }
}