package irvine.oeis.a114;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A114092 Number of partitions of n into parts that are distinct mod 4.
 * @author Georg Fischer
 */
public class A114092 extends HolonomicRecurrence {

  public A114092() {
    super(1, "[0,-1,0,0,0,4,0,0,0,-6,0,0,0,4,0,0,0,-1]", 
        "1,1,1,2,2,3,3,5,4,6,7,9,7,10,14,14", 0);
  }
}