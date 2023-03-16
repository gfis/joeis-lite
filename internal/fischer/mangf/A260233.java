package irvine.oeis.a260;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000384;

/**
 * A260233 Smallest prime factor of the n-th hexagonal number (A000384).
 * @author Georg Fischer
 */
public class A260233 extends A000384 {

  {
    super.next();
    super.next();
  }
   
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).leastPrimeFactor();
  }
}
