package irvine.oeis.a349;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A349105 Expansion of e.g.f. 1/(1 - (sinh(x) + x*cosh(x))/2 ).
 * E.g.f.: 1/(1 - (sinh(x) + x*cosh(x))/2 )
 * @author Georg Fischer
 */
public class A349105 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A349105() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.series(RING.one(),RING.subtract(RING.one(),RING.series(RING.add(RING.sinh(RING.x(),mN),RING.multiply(RING.x(),RING.cosh(RING.x(),mN),mN)),RING.monomial(new Q(2),0),mN)),mN);
  }
}
