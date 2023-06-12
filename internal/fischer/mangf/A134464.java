package irvine.oeis.a134;
// Generated by gen_seq4.pl A131416/parmof6 at 2023-06-05 11:39

import irvine.oeis.a000.A000012;
import irvine.oeis.a127.A127648;
import irvine.oeis.a127.A127773;
import irvine.oeis.a131.A131416;
/**
 * A134464 (A127648 * A000012 + A000012 * A127773) - A000012.
 * @author Georg Fischer
 */
public class A134464 extends A131416 {

  /** Construct the sequence. */
  public A134464() {
    super(1, new A127648(), new A000012(), '+', new A000012(), new A127773());
  }
}
