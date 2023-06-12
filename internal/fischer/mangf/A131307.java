package irvine.oeis.a131;
// Generated by gen_seq4.pl A131416/parmof6 at 2023-06-05 11:39

import irvine.oeis.a000.A000012;
import irvine.oeis.a097.A097807;
import irvine.oeis.a127.A127701;
import irvine.oeis.a131.A131416;
/**
 * A131307 (A127701 * A000012 + A000012(signed) * A127701) - A000012.
 * @author Georg Fischer
 */
public class A131307 extends A131416 {

  /** Construct the sequence. */
  public A131307() {
    super(1, new A127701(), new A000012(), '+', new A097807(), new A127701());
  }
}
