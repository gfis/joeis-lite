package irvine.oeis.a348;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A348580 Expansion of e.g.f. exp(x) / (1 - sin(x)).
 * E.g.f.: exp(x) / (1 - sin(x))
 * @author Georg Fischer
 */
public class A348580 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A348580() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.exp(RING.x(),mN),RING.subtract(RING.one(),RING.sin(RING.x(),mN)),mN);
  }
}
