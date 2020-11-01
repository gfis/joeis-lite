/* Test class, run an EulerTransform of a PeriodicSequence
 * @(#) $Id$
 * 2020-08-13, Georg Fischer: copied from EulerTransformPeriodTest
 */
package irvine.test;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.EulerTransform;
import irvine.oeis.PeriodicSequence;
import irvine.oeis.Sequence;

/**
 * @author Georg Fischer
 */
public class EulerTransformPeriodTest {

  /**
   * Main method, runs the transform from the arguments and writes a terms list to STDOUT.
   * @param args command line arguments:
   * <ul>
   * <li>-n number of terms to be generated (default: 32)
   * <li>-p period list of terms
   * <li>-s number of initial terms to skip (default: 0)
   * </ul>
   */
  public static void main(String[] args) {
    int iarg = 0;
    boolean bFile = false;
    int noTerms = 32;
    int offset    = 0;
    int skip = 0;
    String periodTerms = "1,0,1";
    while (iarg < args.length) { // consume all arguments
      String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-b")     ) {
          bFile        = true;
        } else if (opt.equals    ("-n")     ) {
          noTerms      = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-p")     ) {
          periodTerms  = args[iarg ++];
        } else if (opt.equals    ("-o")     ) {
          offset       = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-s")     ) {
          skip         = Integer.parseInt(args[iarg ++]);
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args
    final Sequence seq = new EulerTransform(new PeriodicSequence(ZUtils.toZ(periodTerms)), Z.ONE);
    int n = offset;
    for (int iTerm = 0; iTerm < noTerms; ++iTerm) {
      if (! bFile) {
        System.out.print(seq.next() + ","); // csv
      } else {
        System.out.println(n + " " + seq.next()); // b-file format
      }
      ++n;
    } // for iTerm
    System.out.println();
  } // main

} // EulerTransformPeriodTest
