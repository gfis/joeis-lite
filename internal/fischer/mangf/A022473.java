package irvine.oeis.a022;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A022473 Number of 2&apos;s in n-th term of A022470.
 * @author Georg Fischer
 */
public class A022473 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A022473() {
    super(1, "[0,-6,9,-9,18,-16,11,-14,8,-1,5,-7,-2,-8,14,5,5,-19,-3,6,7,6,-16,7,-8,22,-17,12,-7,-5,-7,8,-4,7,9,-13,4,6,-14,14,-19,7,13,-2,4,-18,0,1,4,12,-8,5,0,-8,-1,-7,8,5,2,-3,-3,0,0,0,0,2,1,0,-3,-1,1,1,1,-1]", "[1,1,1,1,2,3,4,5,7,7,11,14,16,22,34,37,56,70,94,113,161,191,252,341,435,568,762,973,1276,1661,2169,2817,3657,4811,6200,8178,10603,13878,18015,23582,30617,39919,52100,67898,88298,115624,150200,196145,255716,333151,434317,566100,738240,961464,1254465,1634888,2130814,2778560,3622057,4720415,6155032,8021700,10459066,13629722,17774330,23163476,30198931,39369117,51315822,66896969,87206036,113676934,148186484]", 0);
  }
}