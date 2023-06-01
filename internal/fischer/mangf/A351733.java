package irvine.oeis.a351;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A351733 Expansion of e.g.f. exp( 2 * x * (exp(x) - 1) ).
 * E.g.f.: exp( 2 * x * (exp(x) - 1) )
 * @author Georg Fischer
 */
public class A351733 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A351733() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.multiply(RING.monomial(new Q(2),1),RING.subtract(RING.exp(RING.x(),mN),RING.one()),mN),mN);
  }
}