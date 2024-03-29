package irvine.oeis.a062;
// Generated by gen_seq4.pl n2 at 2022-10-25 22:41

import irvine.math.z.Z;
import irvine.oeis.a006.A006218;

/**
 * A062550 a(n) = Sum_{k = 1..2n} floor(2n/k).
 * @author Georg Fischer
 */
public class A062550 extends A006218 {

  @Override
  public Z next() {
    final Z result = super.next();
    super.next();
    return result;
  }
}
