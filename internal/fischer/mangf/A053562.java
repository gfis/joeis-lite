package irvine.oeis.a056;
// manually 

import irvine.oeis.HolonomicRecurrence;

/**
 * A056543 a(n) = n*a(n-1) - 1 with a(1)=1..
 * 1, 1, 2, 7, 34, 203, 1420, 11359, 102230
 * @author Georg Fischer
 */
public class A053562 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A053562() {
    super(0, "[[-1],[0,1],[-1]]", "[1,1]", 0);
  }
}
