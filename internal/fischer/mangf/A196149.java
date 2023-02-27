package irvine.oeis.a196;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.a052.A052287;

/**
 * A196149 Numbers whose divisors increase by a factor of 3 or less.
 * @author Georg Fischer
 */
public class A196149 extends A052287 {

  @Override
  public Z next() {
    return super.next().divide(3);
  }
}