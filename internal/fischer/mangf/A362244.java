package irvine.oeis.a362;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A362244 Expansion of e.g.f. 1/(1 - x * exp(-x * (exp(-x) - 1))).
 * E.g.f.: 1/(1 - x * exp(-x * (exp(-x) - 1)))
 * @author Georg Fischer
 */
public class A362244 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A362244() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.one(),RING.multiply(RING.x(),RING.exp(RING.subtract(RING.zero(),RING.multiply(RING.x(),RING.subtract(RING.exp(RING.subtract(RING.zero(),RING.x()),mN),RING.one()),mN)),mN),mN)),mN);
  }
}