package irvine.oeis.a022;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A022475 Sum of digits in n-th term of A022470.
 * @author Georg Fischer
 */
public class A022475 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A022475() {
    super(1, "[0,-6,9,-9,18,-16,11,-14,8,-1,5,-7,-2,-8,14,5,5,-19,-3,6,7,6,-16,7,-8,22,-17,12,-7,-5,-7,8,-4,7,9,-13,4,6,-14,14,-19,7,13,-2,4,-18,0,1,4,12,-8,5,0,-8,-1,-7,8,5,2,-3,-3,0,0,0,0,2,1,0,-3,-1,1,1,1,-1]", "[2,3,5,7,10,15,20,25,35,45,55,72,94,122,160,215,278,362,482,617,797,1047,1354,1773,2321,3028,3948,5165,6724,8751,11427,14859,19347,25255,32928,42926,55971,73036,95127,123982,161739,210577,274586,358046,466560,608330,793242,1033961,1347666,1757181,2290385,2985048,3892054,5072988,6612933,8621238,11238432,14650110,19097525,24896355,32451846,42304128,55148244,71885754,93711670,122161642,159244727,207590361,270611036,352762669,459846046,599455110,781427936]", 0);
  }
}