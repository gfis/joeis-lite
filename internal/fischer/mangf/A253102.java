package irvine.oeis.a253;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a071.A071053;

/**
 * A253102 a(n) = A071053(n)^3.
 * @author Georg Fischer
 */
public class A253102 extends A071053 {

  @Override
  public Z next() {
    return super.next().pow(3);
  }
}