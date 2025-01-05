package irvine.oeis;

import java.util.ArrayList;
import java.util.regex.Pattern;

import irvine.math.group.IntegerField;
import irvine.math.group.PolynomialRingField;
import irvine.math.polynomial.Polynomial;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;

/**
 * Compute the coefficients of a generating function A(x) given by some equation that A(x) satifies.
 * @author Georg Fischer
 */
public class PolynomialFieldSequence extends AbstractSequence {

  protected static int sDebug = 0;
  private static final PolynomialRingField<Z> RING = new PolynomialRingField<>(IntegerField.SINGLETON);
  private final Polynomial<Z>[] mPolys; // Polynomials referenced in the postfix string as "p0" (the initial value), "p1", "p2" and so on.
  private final String[] mPostfix; // list of operands and operators
  private int mN; // index of the next sequence element to be computed
  private Polynomial<Z> mA; // the generating function A(x)
  private final Polynomial<Z>[] mStack; // stack where the final expression is computed

  /**
   * Compute successive coefficients for a generating function A(x) defined by a condition that A(x) must satisfy.
   * @param offset first index
   * @param polys array of polynomials, the coefficients of <code>x^i, i=0..m</code>
   * are given as comma-separated lists, enclosed in square brackets, for example "[[0],[0,1,2],[17,0,18]]"
   * @param postfix the equation with operands and operators in postfix polish notation, separated by the first character in
   * the string, for example <code>A(x) = 1 + x*A(x*A(x))^2</code> -&gt; <code>;1;x;x;ax;*;A(;2;^;*;+</code>,
   * with "ax" for <code>A(x)</code> and "A(" for substitution.
   */
  @SuppressWarnings("unchecked")
  public PolynomialFieldSequence(final int offset, final String polys, final String postfix) {
    super(offset);
    String post = trimQuotes(postfix);
    mPostfix = post.substring(1).split(Pattern.quote(post.substring(0, 1)));
    if (sDebug >= 1) {
      System.out.print("# mPostfix=");
      for (int k = 0; k < mPostfix.length; ++k) {
        System.out.print(mPostfix[k] + ";");
      }
      System.out.println();
    }

    ArrayList<Z[]> mPolyList = new ArrayList<>(16);// array of polynomials as arrays of coefficients of <code>x^i, i=0..m</code>
    final String[] polarr = trimQuotes(polys).split("]\\s*,\\s*\\[");
    for (int k = 0; k < polarr.length; ++k) {
      mPolyList.add(ZUtils.toZ(polarr[k]));
      if (sDebug >= 1) {
        System.out.println("# polarr[" + k + "]=" + polarr[k]);
      }
    } // for k
    mPolys = new Polynomial[mPolyList.size()]; 
    mStack = new Polynomial[mPostfix.length]; // <- how to avoid the 2 "unchecked" warnings?
    for (int k = 0; k < mPolyList.size(); ++k) {
      mPolys[k] = Polynomial.create(mPolyList.get(k));
      if (sDebug >= 1) {
        System.out.println("# mPolys[" + k + "]=" + mPolys[k].toString());
      }
    }

    mN = offset - 1;
    mA = mPolys[0];
  } // Constructor

  /**
   * Return the inner content of a String without surrounding square brackets, quotes or apostrophes, with all spaces removed.
   * @param str full String
   * @return String with surrounding characters removed
   */
  protected static String trimQuotes(final String str) {
    int start = 0;
    while (start < str.length() && (str.charAt(start) == '[' || str.charAt(start) == '"' || str.charAt(start) == '\'')) {
      ++start;
    }
    int behind = str.length();
    while (behind > start && (str.charAt(behind - 1) == ']' || str.charAt(behind - 1) == '"' || str.charAt(behind - 1) == '\'')) {
      --behind;
    }
    return str.substring(start, behind).replaceAll(" ", "");
  }
    
  @Override
  public Z next() {
    ++mN;
    // now perform a statement like "mA = RING.add(RING.one(), RING.multiply(RING.x(), RING.pow(RING.substitute(mA, RING.multiply(RING.x(), mA, mN), mN), mExpon, mN), mN));"
    // for example A143013: A(x) = 1 + x + A(x)*x + (A(x)*x)^2
    // polring  -p '"[[0],[1,1]]"'  -x '"p1,A,x,*,+,A,x,*,i2,^,+"' -b -d 0 -n 1000
    int ifix = 0;
    int top = -1; // index of top element of <code>mStack</code>. Initially, the stack is empty.
    try {
      while (ifix < mPostfix.length) { // scan over the operaands and operators
        String pfix = mPostfix[ifix++];
        if (sDebug >= 2 && top >= 0) {
          System.out.println("# pfix=" + pfix + ",  \t mStack[" + top + "]=" + mStack[top] + "\t before");
        } 
        switch (pfix.charAt(0)) {
          default: // should not occur
            throw new RuntimeException("invalid postfix code " + pfix);
        // operands
          case 'A': // this means A(x), the currently accumulated Polynomial mA
            mStack[++top] = mA;
            break;
          case 'i': // "i(\d+)" = push(int $1)
            mStack[++top] = Polynomial.create(Integer.parseInt(pfix.substring(1)));
            break;
          case 'p': // "p(\d+)"  = mPolys[$1], one of the predefined polynomials
            mStack[++top] = mPolys[Integer.parseInt(pfix.substring(1))];
            break;
          case 'x': // this means the independant variable x
            mStack[++top] = Polynomial.create(0, 1);
            break;

        // operations
          case 'e': // "exp", preplace the current top elementte by exp(te)
            mStack[top] = RING.diff(mStack[top]);
            break;
          case 'r': // "rev", replace the current top element by its series reversion
            mStack[top] = RING.diff(mStack[top]);
            break;
          case 's': // "sub", replace the current top element by a substitution
            mStack[top] = RING.substitute(mA, mStack[top], mN);
            break;
          case '+':
            --top;
            mStack[top] = RING.add(mStack[top], mStack[top + 1]);
            break;
          case '-':
            --top;
            mStack[top] = RING.subtract(mStack[top], mStack[top + 1]);
            break;
          case '*':
            --top;
            mStack[top] = RING.multiply(mStack[top], mStack[top + 1], mN);
            break;
          case '/':
            --top;
            mStack[top] = RING.series(mStack[top], mStack[top + 1], mN);
          case '<': // "<(\d+)" = shift x -> x^$1 (may be negative)
            mStack[top] = RING.shift(mStack[top], (pfix.length() <= 1) ? 1 : Integer.parseInt(pfix.substring(1)));
            break;
          case '^': // P, m -> P^m, or "^(\d+)" P -> P^$1
            if (pfix.length() == 1) {
              --top;
              mStack[top] = RING.pow(mStack[top], Long.valueOf(mStack[top + 1].toString()), mN);
            } else {
              mStack[top] = RING.pow(mStack[top], Long.parseLong(pfix.substring(1)), mN);
            }
            break;
        } // switch
        if (sDebug >= 3) {
          System.out.println("#      " + "  " + "   \t       [" + top + "]=" + mStack[top] + "\t after");
        } 
      } // while
    } catch (Exception exc) { // will never be reached with a proper generator
      System.err.println("# unexpected exception: " + exc.getMessage());
      exc.printStackTrace();
    }
    // mTop should be 0 here
    mA = mStack[top];
    return mA.coeff(mN);
  } // next

  /**
   * Main method, generate the coefficients of a generating function.
   * @param args command line arguments:
   * <ul>
   * <li>-b print in b-file format instead of comma separated list (default false)</li>
   * <li>-d level debugging level (default 0=none), 1=some, 2=more</li>
   * <li>-n numTerms number of terms to be computed (default: 16)</li>
   * <li>-o offset, first index (default 0)</li>
   * <li>-p polyList list of vectors for polynomials in x (default [[0]])</li>
   * <li>-x expression in postfix notation</li>
   * </ul>
   */
  public static void main(String[] args) {
    boolean bfile = false;
    int debug = 0;
    int numTerms = 16;
    int offset  = 0;
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
        } else if (opt.equals    ("-n")     ) {
          numTerms = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-o")     ) {
          offset   = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-p")     ) {
          polyList = args[iarg ++];
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
      PolynomialFieldSequence prs = new PolynomialFieldSequence(offset, polyList, postfix);
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
      System.out.println("Usage: java -cp joeis.jar irvine.oeis.PolynomialFieldSequence"
          + " [-b] [-d mode] [-n noterms] [-o offset] [-p polys] -x postfix");
    }
  } // main
}
