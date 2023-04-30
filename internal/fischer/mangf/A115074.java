package irvine.oeis.a115;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a013.A013929;

/**
 * A115074 a(n) is the largest prime dividing the n-th nonsquarefree positive integer.
 * @author Georg Fischer
 */
public class A115074 extends A013929 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).largestPrimeFactor();
  }
}