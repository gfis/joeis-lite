package irvine.oeis.a261;
// Generated by gen_seq4.pl modi

import irvine.math.z.Z;
import irvine.oeis.a000.A000010;

/**
 * A261872 a(n) = phi(n) mod 5, where phi is the Euler totient function.
 * @author Georg Fischer
 */
public class A261872 extends A000010 {

  private static final Z BASE = Z.valueOf(5);
  
  @Override
  public Z next() {
    return super.next().mod(BASE);
  }
}