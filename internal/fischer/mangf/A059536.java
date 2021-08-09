package irvine.oeis.a059;
// Generated by gen_seq4.pl beatty at 2021-07-09 19:32

import irvine.math.cr.CR;
import irvine.math.cr.Zeta;
import irvine.oeis.BeattySequence;

/**
 * A059536 Beatty sequence for zeta(2)/(zeta(2)-1).
 * @author Georg Fischer
 */
public class A059536 extends BeattySequence {

  private static final CR N = Zeta.zeta(2).divide(Zeta.zeta(2).subtract(CR.ONE));

  /** Construct the sequence */
  public A059536() {
    super(1);
  }
 
  @Override
  protected CR getCR() {
    return N;
  }
}
