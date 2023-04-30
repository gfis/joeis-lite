package irvine.oeis.a319;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a045.A045948;

/**
 * A319187 Number of pairwise coprime subsets of {1,...,n} of maximum cardinality (A036234).
 * @author Georg Fischer
 */
public class A319187 extends A045948 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}