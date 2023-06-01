package irvine.oeis.a354;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A354412 Expansion of e.g.f. 1/(2 - exp(x))^(x/2).
 * E.g.f.: 1/(2 - exp(x))^(x/2)
 * @author Georg Fischer
 */
public class A354412 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A354412() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.exp(RING.multiply(RING.log(RING.subtract(RING.monomial(new Q(2),0),RING.exp(RING.x(),mN)),mN),RING.series(RING.x(),RING.monomial(new Q(2),0),mN),mN),mN),mN);
  }
}