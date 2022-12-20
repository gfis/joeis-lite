package irvine.oeis.a082;
// Generated by gen_seq4.pl dersimple at 2022-12-15 22:48

import irvine.math.z.Z;
import irvine.oeis.a056.A056258;

/**
 * A082712 Numbers k such that (67*10^(k-1) + 23)/9 is a depression prime.
 * @author Georg Fischer
 */
public class A082712 extends A056258 {

  @Override
  public Z next() {
    return super.next().add(2);
  }
}
