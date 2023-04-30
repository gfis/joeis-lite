package irvine.oeis.a088;
// Generated by gen_seq4.pl simple/nest at 2023-03-20 18:29

import irvine.oeis.NestedSequence;
import irvine.oeis.a006.A006512;

/**
 * A088463 Upper twin primes of upper twin prime index.
 * @author Georg Fischer
 */
public class A088463 extends NestedSequence {

  /** Construct the sequence. */
  public A088463() {
    super(1, new A006512(), new A006512(), 1, 1); 
  }

}