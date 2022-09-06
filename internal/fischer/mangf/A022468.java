package irvine.oeis.a022;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A022468 Number of 3&apos;s in n-th term of A007651.
 * @author Georg Fischer
 */
public class A022468 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A022468() {
    super(1, "[0,6,-9,9,-18,16,-11,14,-8,1,-5,7,2,8,-14,-5,-5,19,3,-6,-7,-6,16,-7,8,-22,17,-12,7,5,7,-8,4,-7,-9,13,-4,-6,14,-14,19,-7,-13,2,-4,18,0,-1,-4,-12,8,-5,0,8,1,7,-8,-5,-2,3,3,0,0,0,0,-2,-1,0,3,1,-1,-1,-1,1]", "[0,0,0,0,0,1,1,2,3,4,5,6,8,11,15,22,26,32,44,56,74,100,126,163,220,284,376,486,627,817,1077,1392,1829,2354,3108,4020,5271,6861,8949,11625,15209,19790,25821,33671,43875,57165,74629,97186,126692,165238,215188,280720,365777,477029,621549,810552,1056452,1377215,1795221,2340549,3050221,3977107,5183828,6758049,8808899,11484231,14969652,19513856,25439677,33160053,43227992,56350638,73457598,95756570,124828355,162722051,212121142,276514188,360465948]", 0);
  }
}