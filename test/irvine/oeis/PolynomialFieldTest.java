package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
/**
 * Compute the coefficients of a generating function A(x) given by some equation that A(x) satifies.
 * @author Georg Fischer
 */
public class PolynomialFieldTest {

  /**
   * Main method, generate the coefficients of a generating function.
   * @param args command line arguments:
   * <ul>
   * <li>-b print in b-file format instead of comma separated list (default false)</li>
   * <li>-d level debugging level (default 0=none), 1=some, 2=more</li>
   * <li>-i additional degree (default 0)</li>
   * <li>-n numTerms number of terms to be computed (default: 16)</li>
   * <li>-o offset, first index (default 0)</li>
   * <li>-p polyList, list of vectors for polynomials in x (default [[0]])</li>
   * <li>-t type of the generating function: 0 = ordinary (default), 1 = exponential</li>
   * <li>-x expression in postfix notation</li>
   * </ul>
   */
  public static void main(String[] args) {
    boolean bfile = false;
    int debug     = 0;
    int dist      = 0;
    int gfType    = 0;
    int numTerms  = 16;
    int offset    = 0;
    String polyList  = "[[0]]";
    String postfix = null;
    int iarg = 0;
    while (iarg < args.length) { // consume all arguments
      String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-b")     ) {
          bfile    = true;
        } else if (opt.equals    ("-d")     ) {
          debug    = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-i")     ) {
          dist     = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-n")     ) {
          numTerms = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-o")     ) {
          offset   = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-p")     ) {
          polyList = args[iarg ++];
        } else if (opt.equals    ("-t")     ) {
          gfType   = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-x")     ) {
          postfix  = args[iarg ++];
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args

    if (postfix != null) {
      PolynomialFieldSequence.sDebug = debug;
      PolynomialFieldSequence prs = new PolynomialFieldSequence(offset, polyList, postfix, dist, gfType);
      int ind = offset - 1;
      boolean busy = true;
      while (--numTerms >= 0) {
        ++ind;
        Z term = prs.next();
        if (bfile) {
          System.out.print(String.valueOf(ind) + " " + term.toString() + "\n");
        } else {
          System.out.print((ind == offset ? "" : ", ") + term.toString());
        }
      } // while
      System.out.println();
    } else {
      System.out.println("Usage: java -cp joeis.jar irvine.oeis.PolynomialFieldTest"
          + " [-b] [-d mode] [-i dist] [-n noterms] [-o offset] [-p polys] [-t gftype] -x postfix");
    }
  } // main
}
