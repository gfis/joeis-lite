package irvine.oeis.a045;
// manually quots/quot at 2021-11-26 22:57

import irvine.oeis.QuotientSequence;
import irvine.oeis.a003.A003418;
import irvine.oeis.a034.A034386;

/**
 * A045948 a(n) = A003418(n)/A034386(n).
 * @author Georg Fischer
 */
public class A045948 extends QuotientSequence {

  /** Construct the sequence. */
  public A045948 () {
    super(new A003418(), new A034386(), 1, 1);
  }
}
