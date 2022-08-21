package irvine.oeis.a157;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A157052 Number of integer sequences of length n+1 with sum zero and sum of absolute values 6.
 * @author Georg Fischer
 */
public class A157052 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A157052() {
    super(1, "[0,-1,7,-21,35,-35,21,-7,1]", "[2,18,92,340,1010,2562,5768,11832]", 0);
  }
}
