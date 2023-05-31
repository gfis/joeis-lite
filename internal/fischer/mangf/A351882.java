package irvine.oeis.a351;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A351882 Expansion of e.g.f. 1 / (1 - x)^sec(x).
 * E.g.f.: 1 / (1 - x)^sec(x)
 * @author Georg Fischer
 */
public class A351882 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A351882() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.exp(RING.multiply(RING.log(RING.oneMinusXToTheN(1),mN),RING.sec(RING.x(),mN),mN),mN),mN);
  }
}
