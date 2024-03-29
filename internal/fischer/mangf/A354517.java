package irvine.oeis.a354;
// Generated by gen_seq4.pl robots/egfu at 2023-05-07 23:33

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A354517 Expansion of e.g.f. cos(x)^exp(x).
 * E.g.f.: cos(x)^exp(x)
 * @author Georg Fischer
 */
public class A354517 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A354517() {
    super(0);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return RING.exp(RING.multiply(RING.log(RING.cos(RING.x(),mN),mN),RING.exp(RING.x(),mN),mN),mN);
  }
}
