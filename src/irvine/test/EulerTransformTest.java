/* Test class, run an EulerTransform of a PeriodicSequence
 * @(#) $Id$
 * 2020-08-14, Georg Fischer: copied from EulerTransformTest
 */
package irvine.test;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.EulerTransform;
import irvine.oeis.PeriodicSequence;

/**
 * @author Georg Fischer
 */
public class EulerTransformTest {

  /**
   * Main method, runs the transform from the arguments and writes a terms list to STDOUT.
   * @param args command line arguments:
   * <ul>
   * <li>-m number of terms to be generated (default: 32)
   * <li>-p period list of terms
   * <li>-s number of initial terms to skip (default: 0)
   * </ul>
   */
  public static void main(String[] args) {
    int iarg = 0;
    int maxTerms = 32;
    int skip = 0;
    String periodTerms = "1,0,1";
    while (iarg < args.length) { // consume all arguments
      String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-m")     ) {
          maxTerms         = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-p")     ) {
          periodTerms      = args[iarg ++];
        } else if (opt.equals    ("-s")     ) {
          skip             = Integer.parseInt(args[iarg ++]);
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args
    EulerTransform eulerPer = new EulerTransform(new PeriodicSequence(ZUtils.toZ(periodTerms)));
    for (int iterm = 0; iterm < maxTerms; ++ iterm) {
      if (iterm > 0) {
        System.out.print(",");
      }
      System.out.print(eulerPer.next());
    } // for iterm
    System.out.println();
  } // main

} // EulerTransformTest
