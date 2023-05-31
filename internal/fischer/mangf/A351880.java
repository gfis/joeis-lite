package irvine.oeis.a351;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A351880 Expansion of e.g.f. 1 / (1 - x)^cos(x).
 * E.g.f.: 1 / (1 - x)^cos(x)
 * @author Georg Fischer
 */
public class A351880 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A351880() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.exp(RING.multiply(RING.log(RING.oneMinusXToTheN(1),mN),RING.cos(RING.x(),mN),mN),mN),mN);
  }
}
