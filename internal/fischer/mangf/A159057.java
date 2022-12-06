package irvine.oeis.a159;
// Generated by gen_seq4.pl modi

import irvine.math.z.Z;
import irvine.oeis.a102.A102370;

/**
 * A159057 a(n) = A102370(n) mod 10.
 * @author Georg Fischer
 */
public class A159057 extends A102370 {

  private static final Z BASE = Z.valueOf(10);
  
  @Override
  public Z next() {
    return super.next().mod(BASE);
  }
}
