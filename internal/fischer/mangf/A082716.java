package irvine.oeis.a082;
// Generated by gen_seq4.pl dersimple at 2022-12-15 22:48

import irvine.math.z.Z;
import irvine.oeis.a056.A056263;

/**
 * A082716 Numbers k such that (72*10^(k-1) - 27)/9 is a plateau prime.
 * @author Georg Fischer
 */
public class A082716 extends A056263 {

  @Override
  public Z next() {
    return super.next().add(2);
  }
}
