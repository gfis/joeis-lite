package irvine.oeis.a022;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A022472 Number of 1&apos;s in n-th term of A022470.
 * @author Georg Fischer
 */
public class A022472 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A022472() {
    super(1, "[0,-6,9,-9,18,-16,11,-14,8,-1,5,-7,-2,-8,14,5,5,-19,-3,6,7,6,-16,7,-8,22,-17,12,-7,-5,-7,8,-4,7,9,-13,4,6,-14,14,-19,7,13,-2,4,-18,0,1,4,12,-8,5,0,-8,-1,-7,8,5,2,-3,-3,0,0,0,0,2,1,0,-3,-1,1,1,1,-1]", "[0,1,3,2,3,6,6,6,12,13,12,23,29,33,50,69,76,108,150,172,226,323,385,518,698,884,1146,1539,1961,2537,3378,4341,5628,7455,9662,12530,16453,21436,27807,36306,47519,61496,80491,105100,136535,178254,232820,302713,394751,515350,670974,874029,1141405,1486305,1937004,2527634,3293089,4292108,5596959,7296260,9507061,12397353,16162033,21061415,27461541,35801712,46658517,60832980,79301336,103367775,134745102,175669549,228978397]", 0);
  }
}