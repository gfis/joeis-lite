package irvine.oeis.a256;
// Generated by gen_seq4.pl decexp at 2021-07-13 19:14

import irvine.math.cr.CR;
import irvine.oeis.cons.DecimalExpansionSequence;

/**
 * A256784 Decimal expansion of the generalized Euler constant gamma(5,12) (negated).
 * @author Georg Fischer
 */
public class A256784 extends DecimalExpansionSequence {

  /** Construct the sequence. */
  public A256784() {
    super(0, CR.GAMMA.divide(CR.valueOf(12)).add(CR.ONE.divide(CR.valueOf(24)).multiply(CR.PI.multiply(CR.TWO.subtract(CR.THREE.sqrt()))
        .add(CR.TWO.multiply(CR.THREE.sqrt().add(CR.ONE)).multiply(CR.TWO.log())).add(CR.THREE.log())
        .subtract(CR.FOUR.multiply(CR.THREE.sqrt()).multiply(CR.THREE.sqrt().add(CR.ONE).log())))));
    next();
    next();
  }
}