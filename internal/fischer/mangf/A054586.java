package irvine.oeis.a054;
// Generated by gen_seq4.pl mult3/mult at 2022-07-19 22:09

import irvine.math.z.Z;
import irvine.oeis.MultiplicativeSequence;

/**
 * A054586 Sum_{d|2n+1} phi(d)*mu(d).
 * @author Georg Fischer
 */
public class A054586 extends MultiplicativeSequence {

  /** Construct the sequence. */
  public A054586() {
    super(1, 2, (p, e) -> Z.TWO.subtract(p));
  }

  public int getOffset() {
    return 0;
  }
}
