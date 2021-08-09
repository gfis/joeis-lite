package irvine.oeis.a212;
// manually 2021-06-18

import irvine.oeis.HolonomicRecurrence;

/**
 * A212404 Number of binary arrays of length 2*n+2 with no more than n ones in any length 2n subsequence (=50% duty cycle).
 * Recurrence: (n-4)*n*a(n)=2*(n-1)*(4*n-15)*a(n-1)-8*(n-3)*(2*n-5)*a(n-2) for n &gt;= 5.
 * @author Georg Fischer
 */
public class A212404 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A212404() {
    super(1, "[[0],[-120, 88,-16],[30,-38, 8],[0, 4,-1]]", "[8,33,132,527]");
  }
}
