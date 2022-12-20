package irvine.oeis.a082;
// Generated by gen_seq4.pl dersimple at 2022-12-15 22:48

import irvine.math.z.Z;
import irvine.oeis.a056.A056245;

/**
 * A082698 Numbers k such that (13*10^(k-1) - 31)/9 is a plateau prime.
 * @author Georg Fischer
 */
public class A082698 extends A056245 {

  {
    super.next();
  }

  @Override
  public Z next() {
    return super.next().add(2);
  }
}
