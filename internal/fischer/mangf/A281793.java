package irvine.oeis.a281;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a281.A281660;

/**
 * A281793 The largest prime factor of (1+n)*(1+n^2).
 * @author Georg Fischer
 */
public class A281793 extends A281660 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).largestPrimeFactor();
  }
}