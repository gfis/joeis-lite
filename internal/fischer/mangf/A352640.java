package irvine.oeis.a352;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A352640 Expansion of e.g.f. exp(3*sin(x)).
 * E.g.f.: exp(3*sin(x))
 * @author Georg Fischer
 */
public class A352640 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A352640() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.multiply(RING.monomial(new Q(3),0),RING.sin(RING.x(),mN),mN),mN);
  }
}