package irvine.oeis.a187;
// manually (bisect) 2021-07-05

import irvine.math.z.Z;
import irvine.oeis.HolonomicRecurrence ;

/**
 * A187366 One half of a trisection of A001700: binomial(6n+5,3(n+1))/2, n>=0.
 * @author Georg Fischer
 */
public class A187366 extends HolonomicRecurrence {
  
  public A187366() {
    super(0, "[[0],[-40,-368,-864,-576],[2,11,18,9]]", "5", 0);
  }
}
