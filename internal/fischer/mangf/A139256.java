package irvine.oeis.a139;
// Generated by gen_seq4.pl sigman1/sigma1 at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000396;

/**
 * A139256 Twice even perfect numbers. Also a(n) = M(n)*(M(n)+1), where M(n) is the n-th Mersenne prime A000668(n).
 * @author Georg Fischer
 */
public class A139256 extends A000396 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}
