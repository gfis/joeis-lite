package irvine.oeis.a362;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A362204 Expansion of e.g.f. exp(x/sqrt(1-2*x)).
 * E.g.f.: exp(x/sqrt(1-2*x))
 * @author Georg Fischer
 */
public class A362204 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A362204() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.series(RING.x(),RING.pow(RING.subtract(RING.one(),RING.monomial(new Q(2),1)),Q.HALF,mN),mN),mN);
  }
}