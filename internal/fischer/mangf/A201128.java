package irvine.oeis.a201;
// generated by patch_offset.pl at 2022-08-27 22:54

import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.oeis.ExponentialGeneratingFunction;

/**
 * A201128 E.g.f. satisfies: A(x) = 1 + tan(x*A(x)).
 * E.g.f.: <code>divx(reverse(x/(1+tan(x))))</code>
 * @author Georg Fischer
 */
public class A201128 extends ExponentialGeneratingFunction {

  /** Construct the sequence. */
  public A201128() {
    super(0);
    next();
  }

  @Override
  public Polynomial<Q> compute(final int n) {
    return n == 0 ? RING.one() : RING.divide(RING.reversion(RING.series(RING.x(), RING.add(RING.one(), RING.tan(RING.x(), n)), n), n), new Q(n));
  }
}