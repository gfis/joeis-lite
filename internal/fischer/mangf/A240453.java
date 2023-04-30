package irvine.oeis.a240;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a056.A056524;

/**
 * A240453 Greatest prime divisors of the palindromes with an even number of digits.
 * @author Georg Fischer
 */
public class A240453 extends A056524 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).largestPrimeFactor();
  }
}