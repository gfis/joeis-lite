package irvine.oeis.a358;
// Generated by gen_seq4.pl holfsig/holos at 2023-05-05 23:17

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A358504 Number of genetic relatives of a person M in a genealogical tree extending back n generations and where everyone has 3 children down to the generation of M.
 * @author Georg Fischer
 */
public class A358504 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A358504() {
    super(0, "[0,12,-20,9,-1]", "1,5,25,137,793,4697,28057,168089,1008025", 0);
  }
}