package irvine.oeis.a360;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A360586 Expansion of e.g.f.: exp(x)*(exp(x)-1)*(exp(x)-x).
 * E.g.f.: exp(x)*(exp(x)-1)*(exp(x)-x)
 * @author Georg Fischer
 */
public class A360586 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A360586() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.multiply(RING.multiply(RING.exp(RING.x(),mN),RING.subtract(RING.exp(RING.x(),mN),RING.one()),mN),RING.subtract(RING.exp(RING.x(),mN),RING.x()),mN);
  }
}