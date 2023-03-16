package irvine.oeis.a073;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a007.A007948;

/**
 * A073184 Number of cubefree divisors of n.
 * @author Georg Fischer
 */
public class A073184 extends A007948 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}
