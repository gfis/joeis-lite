package irvine.oeis.a100;
// manually 2021-01-20

import irvine.math.z.Z;
import irvine.oeis.a000.A000931;

/**
 * A100891 Prime Padovan numbers..
 * @author Georg Fischer
 */
public class A100891 extends A000931 {

  public A100891() {
    for (int i = 0; i <= 8; ++i) {
      super.next();
    }
  }

  @Override
  public Z next() {
    Z result = super.next();
    while (! result.isPrime()) {
      result = super.next();
    }
    return result;
  }
}
