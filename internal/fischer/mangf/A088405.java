package irvine.oeis.a088;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a052.A052217;

/**
 * A088405 a(n) = A052217(n)/3.
 * @author Georg Fischer
 */
public class A088405 extends A052217 {

  @Override
  public Z next() {
    return super.next().divide(3);
  }
}