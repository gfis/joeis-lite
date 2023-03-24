package irvine.oeis.a256;
// Generated by gen_seq4.pl simple/nest at 2023-03-20 18:29

import irvine.oeis.NestedSequence;
import irvine.oeis.a007.A007733;

/**
 * A256607 Eventual period of 2^(2^k) mod n.
 * @author Georg Fischer
 */
public class A256607 extends NestedSequence {

  /** Construct the sequence. */
  public A256607() {
    super(1, new A007733(), new A007733(), 1, 1); 
  }

}
