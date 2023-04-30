package irvine.oeis.a175;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.oeis.a000.A000203;

/**
 * A175548 Binary weight of sigma(n).
 * @author Georg Fischer
 */
public class A175548 extends A000203 {
  @Override
  public Z next() {
    return Z.valueOf(super.next().bitCount());
  }
}