package irvine.oeis.a112;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a051.A051037;

/**
 * A112758 Number of distinct prime factors of n-th 5-smooth number.
 * @author Georg Fischer
 */
public class A112758 extends A051037 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}