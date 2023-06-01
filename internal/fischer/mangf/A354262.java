package irvine.oeis.a354;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A354262 Expansion of e.g.f. 1/sqrt(1 + 8 * log(1-x)).
 * E.g.f.: 1/sqrt(1 + 8 * log(1-x))
 * @author Georg Fischer
 */
public class A354262 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A354262() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.pow(RING.add(RING.one(),RING.multiply(RING.monomial(new Q(8),0),RING.log(RING.oneMinusXToTheN(1),mN),mN)),Q.HALF,mN),mN);
  }
}