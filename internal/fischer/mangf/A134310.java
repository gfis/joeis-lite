package irvine.oeis.a134;
// Generated by gen_seq4.pl A131416/parmof6 at 2023-06-05 11:39

import irvine.oeis.a000.A000012;
import irvine.oeis.a131.A131416;
import irvine.oeis.a134.A134309;
/**
 * A134310 (A000012 * A134309 + A134309 * A000012) - A000012, where the sequences are interpreted as lower triangular matrices.
 * @author Georg Fischer
 */
public class A134310 extends A131416 {

  /** Construct the sequence. */
  public A134310() {
    super(0, new A000012(), new A134309(), '+', new A134309(), new A000012());
  }
}