package irvine.oeis.a246;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a071.A071053;

/**
 * A246035 Number of odd terms in f^n, where f = (1/x+1+x)*(1/y+1+y).
 * @author Georg Fischer
 */
public class A246035 extends A071053 {

  @Override
  public Z next() {
    return super.next().square();
  }
}
