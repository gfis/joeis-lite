package irvine.oeis.a362;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A362274 Expansion of e.g.f. 1/(1-x*exp(x*exp(x))).
 * E.g.f.: 1/(1-x*exp(x*exp(x)))
 * @author Georg Fischer
 */
public class A362274 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A362274() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.one(),RING.multiply(RING.x(),RING.exp(RING.multiply(RING.x(),RING.exp(RING.x(),mN),mN),mN),mN)),mN);
  }
}
