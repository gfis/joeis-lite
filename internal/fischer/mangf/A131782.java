package irvine.oeis.a131;
// Generated by gen_seq4.pl A131416/parmof6 at 2023-06-05 11:39

import irvine.oeis.a000.A000012;
import irvine.oeis.a004.A004736;
import irvine.oeis.a131.A131416;
/**
 * A131782 (A004736 * A000012) - (A000012 * A004736) - A000012.
 * @author Georg Fischer
 */
public class A131782 extends A131416 {

  /** Construct the sequence. */
  public A131782() {
    super(1, new A004736(), new A000012(), '+', new A000012(), new A004736());
  }
}
