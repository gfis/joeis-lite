package irvine.oeis.a187;
// manually

import irvine.oeis.HolonomicRecurrence;

/**
 * A187187 Parse the infinite string 0123456780123456780123456780... into distinct phrases 0, 1, 2, 3, 4, 5, 6, 7, 8, 01, 23, 45, 67, 80, 12, 34, 56, 78, 012, ...; a(n) = length of n-th phrase.
 * @author Georg Fischer
 */
public class A187187 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A187187() {
    super(1, 
       "[0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1]", 
       "[1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3,3,3,4,3,3,3,4,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,6,6,6,7,6,6,6,7,6,6,6,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,9,10,9,10,9,10,9,10,9,10,9,10,9,10,9,10,9,10,11,11]", 0);
  }
}
