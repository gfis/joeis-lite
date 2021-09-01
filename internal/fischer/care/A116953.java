package irvine.oeis.a116;
// manually floor at 2021-09-01 20:47

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.FloorSequence;

/**
 * A116953 a(n) = Floor[1/2((1-2/Sqrt[3])^n+(1-2/Sqrt[3])^n)]
 * @author Georg Fischer
 */
public class A116953 extends FloorSequence {
  /** Construct the sequence */
  public A116953() {
    super(0);
  }

  @Override
  public Z evalCR(final long mN) {
    return CR.HALF.multiply(CR.ONE.subtract(CR.TWO.divide(CR.THREE.sqrt())).pow(mN).add(CR.ONE.subtract(CR.TWO.divide(CR.THREE.sqrt())).pow(mN))).floor();
  }

}

/*
Solve[b*Sqrt[3]/2 - 1/(1 - 1/b) == 0, b];
beta = (2 + Sqrt[3])/Sqrt[3];
r[0] = 1; r[n_] := r[n] = N[r[n - 1]/(beta)];
c = Flatten[Table[{Circle[{(1 - r[n])*Cos[Pi/3], (1 - r[n])*Sin[ Pi/3]}, r[n]], Circle[{(1 - r[n])* Cos[Pi/3], -(1 - r[n])*Sin[Pi/3]}, r[n]], Circle[{-1 + r[n], 0}, r[n]]}, {n, 0, 25}]];
*/