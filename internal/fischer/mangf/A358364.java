package irvine.oeis.a358;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A358364 a(n) = 16^n * Sum_{k=0..n} binomial(1/2, k)^2.
 * @author Georg Fischer
 */
public class A358364 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A358364() {
    super(0, "[[0],[4,0,-48,64],[0,0,3,-4]]", "1,20,324,5200,83300,1333584,21344400", 0);
  }
}