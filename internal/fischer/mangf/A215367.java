package irvine.oeis.a215;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.oeis.a005.A005478;

/**
 * A215367 Lengths of binary representations of prime Fibonacci numbers.
 * @author Georg Fischer
 */
public class A215367 extends A005478 {
  @Override
  public Z next() {
    return Z.valueOf(super.next().bitLength());
  }
}
