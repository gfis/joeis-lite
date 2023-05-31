package irvine.oeis.a351;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A351905 Expansion of e.g.f. exp(x * (1 - x^3)).
 * E.g.f.: exp(x * (1 - x^3))
 * @author Georg Fischer
 */
public class A351905 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A351905() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.multiply(RING.x(),RING.oneMinusXToTheN(3),mN),mN);
  }
}
