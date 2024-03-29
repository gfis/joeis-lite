package irvine.oeis.a355;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A355379 Expansion of e.g.f. exp(exp(3*x) + exp(x) - 2).
 * E.g.f.: exp(exp(3*x) + exp(x) - 2)
 * @author Georg Fischer
 */
public class A355379 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A355379() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.subtract(RING.add(RING.exp(RING.monomial(new Q(3),1),mN),RING.exp(RING.x(),mN)),RING.monomial(new Q(2),0)),mN);
  }
}
