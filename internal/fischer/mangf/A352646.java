package irvine.oeis.a352;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A352646 Expansion of e.g.f. 1/(1 - 2 * x * cos(x)).
 * E.g.f.: 1/(1 - 2 * x * cos(x))
 * @author Georg Fischer
 */
public class A352646 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A352646() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.one(),RING.multiply(RING.monomial(new Q(2),1),RING.cos(RING.x(),mN),mN)),mN);
  }
}
