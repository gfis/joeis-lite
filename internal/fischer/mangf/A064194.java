package irvine.oeis.a064;

import irvine.math.z.Z;
import irvine.oeis.recur.GeneralRecurrence;

/**
 * A064194 a(2n) = 3*a(n), a(2n+1) = 2*a(n+1)+a(n), with a(1) = 1.
 * @author Georg Fischer
 */
public class A064194 extends GeneralRecurrence {

  /** Construct the sequence. */
  public A064194() {
    super(1, 1);
  }

  protected void initialize() {
    mLambda.add(n -> a(n).multiply(3));
    mLambda.add(n -> a(n).add(a(n + 1).multiply2()));
  }
}
