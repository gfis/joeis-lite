package irvine.oeis.a072;
// Generated by gen_seq4.pl simple/nest at 2023-03-20 18:29

import irvine.oeis.NestedSequence;
import irvine.oeis.a072.A072010;

/**
 * A072012 a(n) = A072010(A072010(n)).
 * @author Georg Fischer
 */
public class A072012 extends NestedSequence {

  /** Construct the sequence. */
  public A072012() {
    super(1, new A072010(), new A072010(), 1, 1); 
  }

}
