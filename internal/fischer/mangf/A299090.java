package irvine.oeis.a299;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.oeis.a051.A051903;

/**
 * A299090 Number of &quot;digits&quot; in the binary representation of the multiset of prime factors of n.
 * @author Georg Fischer
 */
public class A299090 extends A051903 {
  @Override
  public Z next() {
    return Z.valueOf(super.next().bitLength());
  }
}
