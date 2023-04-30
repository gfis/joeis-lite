package irvine.oeis.a079;
// Generated by gen_seq4.pl sigman1/sigma1 at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a005.A005150;

/**
 * A079561 Sum of divisors of n-th term of Look and Say Sequence A005150.
 * @author Georg Fischer
 */
public class A079561 extends A005150 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}