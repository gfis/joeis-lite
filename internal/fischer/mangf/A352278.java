package irvine.oeis.a352;
// Generated by gen_seq4.pl robots/egfue at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A352278 a(0) = 1; a(n) = -3 * Sum_{k=1..n} binomial(2*n-1,2*k-1) * a(n-k).
 * E.g.f.: exp( 3 * (1 - cosh(x)) )
 * @author Georg Fischer
 */
public class A352278 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A352278() {
    super(0, 0, 2);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.multiply(RING.monomial(new Q(3),0),RING.subtract(RING.one(),RING.cosh(RING.x(),mN)),mN),mN);
  }
}
