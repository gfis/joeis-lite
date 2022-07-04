package irvine.oeis.a178;
// manually somos4 at 2022-05-31 19:56

import irvine.math.z.Z;
import irvine.oeis.GeneralRecurrence;

/**
 * A178624 A (1,3) Somos-4 sequence associated to the elliptic curve E: y^2 + 2*x*y - y = x^3 - x.
 * @author Georg Fischer
 */
public class A178624 extends GeneralRecurrence {

  /** Construct the sequence */
  public A178624() {
    super(1, 1,1,-3,11);
  }

  @Override
  protected void initialize() {
    mLambda.add(n -> a(n - 1).multiply(a(n - 3)).multiply(1).add(a(n - 2).square().multiply(3)).divide(a(n - 4)));
  }
}
