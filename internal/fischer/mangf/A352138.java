package irvine.oeis.a352;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A352138 Expansion of e.g.f. 1/(exp(x) - log(1 + x)).
 * E.g.f.: 1/(exp(x) - log(1 + x))
 * @author Georg Fischer
 */
public class A352138 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A352138() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.exp(RING.x(),mN),RING.log(RING.onePlusXToTheN(1),mN)),mN);
  }
}
