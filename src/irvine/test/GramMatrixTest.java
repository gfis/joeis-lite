package irvine.test;

import irvine.math.function.Functions;
import irvine.math.z.Z;
import irvine.oeis.GramMatrixThetaSeries;
import irvine.oeis.transform.InverseEulerTransform;
import irvine.oeis.Sequence;

/**
 * Test of {@link GramMatrixThetaSeries}.
 * Derived from the main method in that class.
 * @author Georg Fischer
 */
public class GramMatrixTest extends GramMatrixThetaSeries {

  public GramMatrixTest(final long[][] matrix) {
    super(matrix);
    super.next(); // the leading one is implied and not output
  }
  
  /**
   * Main method
   * @param args command line arguments:
   * <ul>
   * <li>-b   output is b-file format (default: comma separated data line)</li>
   * <li>-d   debugging level (default 0=none; 1=some, 2=more)</li>
   * <li>-eit skip 1 in result and apply an InverseEulerTransform (default false)</li>
   * <li>-gm  Gram matrix (default "[[1,0],[0,1]]")</li>
   * <li>-gmd Gram matrix, but diagonal only</li>
   * <li>-n   number of terms to be computed (default 64)</li>
   * <li>-o   offset (default 0)</li>
   * </ul>
   */
  public static void main(String[] args) {
    boolean bFile = false;
    int debug     = 0;
    boolean diag  = false;
    boolean eit   = false;
    int noTerms   = 64;
    String matrix = "[[1,0],[0,1]]";
    int offset    = 0;
    int iarg = 0;
    while (iarg < args.length) { // consume all arguments
      String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-b")     ) {
          bFile   = true;
        } else if (opt.equals    ("-eit")   ) {
          eit     = true;
        } else if (opt.equals    ("-d")     ) {
          debug   = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-n")     ) {
          noTerms = Integer.parseInt(args[iarg ++]);
        } else if (opt.startsWith("-gm")    ) {
          matrix  = args[iarg ++].replaceAll("[^0-9\\-\\,]", ""); // remove spaces and brackets
          diag    = opt.equals   ("-gmd");
        } else if (opt.equals    ("-o")     ) {
          offset  = Integer.parseInt(args[iarg ++]);
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args

    final String[] elems = matrix.split("\\,");
    final int dim = diag ? elems.length : Functions.SQRT.i(elems.length);
    final long[][] gMatrix = new long[dim][dim];
    int iElem = 0;
    if (diag) {
      for (int row = 0; row < dim; ++row) {
        for (int col = 0; col < dim; ++col) {
          gMatrix[row][col] = row != col ? 0 : Integer.parseInt(elems[iElem ++]);
        }
      }
    } else {
      if (dim * dim != elems.length) {
        throw new IllegalArgumentException("Not a square matrix");
      }
      for (int row = 0; row < dim; ++row) {
        for (int col = 0; col < dim; ++col) {
          gMatrix[row][col] = Integer.parseInt(elems[iElem ++]);
        }
      }
    }
    final Sequence seq = ! eit ? new GramMatrixTest(gMatrix)
        : new  InverseEulerTransform(new GramMatrixTest(gMatrix));
    int n = offset;
    for (int iTerm = 0; iTerm < noTerms; ++iTerm) {
      if (! bFile) {
        System.out.print(seq.next() + ","); // csv
      } else {
        System.out.println(n + " " + seq.next()); // b-file format
      }
      ++n;
    } // for iTerm
  } // main
}
