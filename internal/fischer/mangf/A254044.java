package irvine.oeis.a254;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.oeis.a064.A064216;

/**
 * A254044 a(1) = 1, for n&gt;1: a(n) = a(A253889(n)) + (1 if n is of the form 3n or 3n+1, otherwise 0).
 * @author Georg Fischer
 */
public class A254044 extends A064216 {
  @Override
  public Z next() {
    return Z.valueOf(super.next().bitCount());
  }
}