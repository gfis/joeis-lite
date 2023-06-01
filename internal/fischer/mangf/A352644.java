package irvine.oeis.a352;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A352644 Expansion of e.g.f. exp(2 * x * cosh(x)).
 * E.g.f.: exp(2 * x * cosh(x))
 * @author Georg Fischer
 */
public class A352644 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A352644() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.multiply(RING.monomial(new Q(2),1),RING.cosh(RING.x(),mN),mN),mN);
  }
}