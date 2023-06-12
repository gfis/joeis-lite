package irvine.oeis.a363;
// Generated by gen_seq4.pl egfu at 2023-06-02 20:31

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A363008 Expansion of e.g.f. 1/(2 - exp(exp(exp(exp(x) - 1) - 1) - 1)).
 * E.g.f.: 1/(2 - exp(exp(exp(exp(x) - 1) - 1) - 1))
 * @author Georg Fischer
 */
public class A363008 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A363008() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.monomial(new Q(2),0),RING.exp(RING.subtract(RING.exp(RING.subtract(RING.exp(RING.subtract(RING.exp(RING.x(),mN),RING.one()),mN),RING.one()),mN),RING.one()),mN)),mN);
  }
}
