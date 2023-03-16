package irvine.oeis.a074;
// Generated by gen_seq4.pl sigman1/sigma1s at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.Sequence1;
import irvine.oeis.a007.A007504;

/**
 * A074370 Sum of the divisors of Sum_{i=1..n} prime(i).
 * @author Georg Fischer
 */
public class A074370 extends Sequence1 {

  private final A007504 mSeq = new A007504();

  {
    mSeq.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(mSeq.next()).sigma();
  }
}
