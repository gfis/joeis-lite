package irvine.oeis.a219;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.Sequence1;
import irvine.oeis.a000.A000032;

/**
 * A219188 Sum of prime divisors (with repetition) of Lucas(n).
 * @author Georg Fischer
 */
public class A219188 extends Sequence1 {

  private final A000032 mSeq = new A000032();

  {
    mSeq.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(mSeq.next()).sopfr();
  }
}
