package irvine.oeis.a187;
// manually

import irvine.oeis.HolonomicRecurrence;

/**
 * A187188 Parse the infinite string 0123456789012345678901234567890... into distinct phrases 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 01, 23, 45, 67, 89, 012, 34, 56, 78, 90, 12, 345, ...; a(n) = length of n-th phrase.
 * @author Georg Fischer
 */
public class A187188 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A187188() {
    super(1, 
       "[0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1]", 
       "[1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,3,2,2,2,2,2,3,3,3,3,3,3,3,3,3,4,4,4,4,4,5,4,4,4,4,4,5,6,5,5,6,5,5,6,5,5,6,5,5,6,7,6,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,9,8,8,8,8,8,9,9,9,9,9,9,9,9,9,10,11,10,11,10,11,10,11,10,11,10,11,10,11,10,11,10,11,10,11,12,12]", 0);
  }
}
