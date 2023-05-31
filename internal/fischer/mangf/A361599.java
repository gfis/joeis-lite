package irvine.oeis.a361;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A361599 Expansion of e.g.f. exp( x/(1-x)^3 ) / (1-x).
 * @author Georg Fischer
 */
public class A361599 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A361599() {
    super(0, "[[0],[-18,39,-29,9,-1],[-18,35,-21,4],[-11,17,-6],[-2,4],[-1]]", "1,2,11,88,881,10526,145867,2294636,40302593,780263866", 0);
  }
}
