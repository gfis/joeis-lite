package irvine.oeis.a275;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a023.A023194;

/**
 * A275940 a(n) = A000005(A023194(n)).
 * @author Georg Fischer
 */
public class A275940 extends A023194 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}