package irvine.oeis.a074;
// manually loda at 2023-04-15 20:49

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.producer.LodaSequence;

/**
 * A074701 Numbers k such that k = Sum_{d|phi(k)} mu(phi(d))*phi(k)/d.
 * @author Georg Fischer
 */
public class A074701 extends LodaSequence {

  /** Construct the sequence. */
  public A074701() {
    super(1);
  }
    
  
  private Z t0 = Z.ZERO, t1 = Z.ZERO, t2 = Z.ZERO;

  @Override
  public Z next() {
    t0 = Z.valueOf(++mN);
    t1 = Z.ZERO;
    t2 = Z.ZERO;
    t0 = t0.subtract(1);
    t1 = Z.FIVE;
    t1 = (t0.compareTo(Z.ZERO) < 0) ? Z.ZERO : t1.pow(t0);
    t2 = Z.TWO;
    t2 = Binomial.binomial(t2, t1);
    t1 = t1.add(t2);
    t0 = t1;
    return t0;
  }
}
