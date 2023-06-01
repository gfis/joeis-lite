package irvine.oeis.a352;
// Generated by gen_seq4.pl beatty/beatty2 at 2023-05-08 13:57

import irvine.math.cr.CR;
import irvine.oeis.cons.BeattySequence;
/**
 * A352674 Beatty sequence for (3/2)(1+sqrt(3)).
 * @author Georg Fischer
 */
public class A352674 extends BeattySequence {

  /** Construct the sequence */
  public A352674() {
    super(1, CR.valueOf(3).divide(CR.valueOf(2)).multiply(CR.valueOf(1).add(CR.valueOf(3).sqrt())));
  }
}