package irvine.oeis.a347;
// Generated by gen_seq4.pl beatty/beatty2 at 2023-05-08 13:57

import irvine.math.cr.CR;
import irvine.oeis.cons.BeattySequence;
/**
 * A347792 Beatty sequence for 2^(2/3).
 * @author Georg Fischer
 */
public class A347792 extends BeattySequence {

  /** Construct the sequence */
  public A347792() {
    super(0, CR.valueOf(2).pow(CR.valueOf(2).divide(CR.valueOf(3))));
  }
}
