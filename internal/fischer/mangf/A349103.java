package irvine.oeis.a349;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A349103 Expansion of e.g.f. exp( (sin(x) + x*cos(x))/2 ).
 * E.g.f.: exp( (sin(x) + x*cos(x))/2 )
 * @author Georg Fischer
 */
public class A349103 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A349103() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.series(RING.add(RING.sin(RING.x(),mN),RING.multiply(RING.x(),RING.cos(RING.x(),mN),mN)),RING.monomial(new Q(2),0),mN),mN);
  }
}
