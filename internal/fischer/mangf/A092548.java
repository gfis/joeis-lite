package irvine.oeis.a092;
// manually 2021-01-24

import irvine.oeis.GeneratingFunctionSequence;

/**
 * A092548 Molien series for complete weight enumerators of self-dual codes over GF(4) + GF(4)u with u^2 = 0.
 * @author Georg Fischer
 */
public class A092548 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A092548() {
    super(0, "[1,1,4,3,53,104,458,858,2474,4839,10667,19018,34193,55481,86078,125990,173466,230402,287430,346462,393648,431930,450648,450648,431930,393648,346462,287430,230402,173466,125990,86078,55481,34193,19018,10667,4839,2474,858,458,104,53,3,4,1,1]", 
        "[1,0,-5,-1,4,5,16,-4,-20,-16,-32,20,26,32,86,-26,-22,-86,-174,22,0,174,228,0,97,-228,-245,-97,-212,245,212,212,245,-212,-97,-245,-228,97,0,228,174,0,22,-174,-86,-22,-26,86,32,26,20,-32,-16,-20,-4,16,5,4,-1,-5,0,1]");
  }
}