package irvine.oeis.a255;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A255415 Row 5 of Ludic array A255127.
 * @author Georg Fischer
 */
public class A255415 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A255415() {
    // /(x^49-x^48-x+1)
    super(1, "[0,1,-1,0,0,0,0,0,0,0,0,0,0 ,0,0,0,0,0,0,0,0,0,0 ,0,0,0,0,0,0,0,0,0,0 ,0,0,0,0,0,0,0,0,0,0 ,0,0,0,0,0,0 ,-1,1]", 
        "11,55,103,151,203,251,299,343,391,443,491,539,587,631,683,731,779,827,877,923,971,1019,1067,1117,1165,1211,1259,1307,1357,1405,1453,1499,1547,1597,1645,1693,1741,1787,1837,1885,1933,1981,2033,2077,2125,2173,2221,2273,2321", 0);
  }
}
