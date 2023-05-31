package irvine.oeis.a196;
// manually egfu/egfux at 2023-05-06 22:14

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A196873 E.g.f. A(x) satisfies: A(x*cos(x)) = 1/cos(x).
 * E.g.f.: divx(reverse(x*cos(x)))
 * @author Georg Fischer
 */
public class A196873 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A196873() {
    super(0 + 1);
  }
  
  @Override
  public Polynomial<Q> compute(final int n) {
    return n == 0 ? RING.one() : RING.divide(RING.reversion(RING.multiply(RING.x(),RING.cos(RING.x(),mN),mN),mN),new Q(mN));
  }

  @Override
  public Z next() {
    final Z result = super.next();
    super.next();
    return result;
  }
}
