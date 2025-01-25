package irvine.oeis;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.regex.Pattern;

import irvine.math.group.PolynomialRingField;
import irvine.math.polynomial.Polynomial;
import irvine.math.q.Q;
import irvine.math.q.Rationals;
import irvine.math.z.Z;

/**
 * Compute the coefficients of a generating function A(x) given by some equation that is satisfied by A(x).
 * @author Georg Fischer
 */
public class PolynomialFieldSequence extends AbstractSequence {

  protected static int sDebug = 0;
  public static final int OGF = 0;
  public static final int EGF = 1;
  private static final PolynomialRingField<Q> RING = new PolynomialRingField<>(Rationals.SINGLETON);
  private final ArrayList<Polynomial<Q>> mPolys; // Polynomials referenced in the postfix string as "p0" (the initial value), "p1", "p2" and so on.
  private final String[] mPostfix; // list of operands and operators
  private int mDist; // addititional degree
  private int mGfType; // type of the generating function: 0 = ordinary, 1 = exponential
  private int mN; // index of the next sequence element to be computed
  private Polynomial<Q> mA; // the generating function A(x)
  private final ArrayList<Polynomial<Q>> mStack; // stack where the final expression is computed
  private Z mFactorial;

  /**
   * Compute successive coefficients for a generating function A(x) defined by a condition that A(x) must satisfy.
   * @param offset first index
   * @param polys array of polynomials, the coefficients of <code>x^i, i=0..m</code>
   * are given as comma-separated lists, enclosed in square brackets, for example "[[0],[0,1,2],[17,0,18]]"
   * @param postfix the equation with operands and operators in postfix polish notation, separated by the first character in
   * the string, for example <code>A(x) = 1 + x*A(x*A(x))^2</code> -&gt; <code>;1;x;x;ax;*;A(;2;^;*;+</code>,
   * with "ax" for <code>A(x)</code> and "A(" for substitution.
   */
  public PolynomialFieldSequence(final int offset, final String polys, final String postfix) {
    this(offset, polys, postfix, 0, OGF);
  }

  /**
   * Compute successive coefficients for a generating function A(x) defined by a condition that A(x) must satisfy.
   * @param offset first index
   * @param polys array of polynomials, the coefficients of <code>x^i, i=0..m</code>
   * are given as comma-separated lists, enclosed in square brackets, for example "[[0],[0,1,2],[17,0,18]]"
   * @param postfix the equation with operands and operators in postfix polish notation, separated by the first character in
   * the string, for example <code>A(x) = 1 + x*A(x*A(x))^2</code> -&gt; <code>;1;x;x;ax;*;A(;2;^;*;+</code>,
   * with "ax" for <code>A(x)</code> and "A(" for substitution.
   * @param dist additional degree
   * @param gfType type of the generating function: 0 = ordinary, 1 = exponential
   */
  public PolynomialFieldSequence(final int offset, final String polys, final String postfix, final int dist, final int gfType) {
    super(offset);
    mDist = dist;
    mGfType = gfType;
    mFactorial = Z.ONE;

    String post = trimQuotes(postfix);
    mPostfix = post.substring(1).split(Pattern.quote(post.substring(0, 1)));
    if (sDebug >= 1) {
      System.out.print("# mPostfix=");
      for (int k = 0; k < mPostfix.length; ++k) {
        System.out.print(mPostfix[k] + ";");
      }
      System.out.println();
    }
    mStack = new ArrayList<Polynomial<Q>>(mPostfix.length);
    for (int k = 0; k < mPostfix.length; ++k) {
      mStack.add(null);
    } // for k

    final String[] polarr = trimQuotes(polys).split("]\\s*,\\s*\\["); // the individual vectors
    mPolys = new ArrayList<>(polarr.length);
    for (int k = 0; k < polarr.length; ++k) {
      if (sDebug >= 1) {
        System.out.println("# polarr[" + k + "]=" + polarr[k]);
      }
      final String[] svect = polarr[k].split(" *\\, *");
      final Q[] qvect = new Q[svect.length];
      for (int j = 0; j < svect.length; ++j) {
        qvect[j] = new Q(svect[j]);
        if (sDebug >= 1) {
          System.out.println("# k=" + k + ", qvect[" + j + "]=" + qvect[j].toString());
        }
      }
      mPolys.add(RING.create(Arrays.asList(qvect)));
    } // for k

    mN = offset - 1;
    mA = mPolys.get(0);
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

  /**
   * Print the contents of the stack in readable form.
   * @param pfix current postfix element
   * @param top index of top stack element
   * @param str call point
   */
  protected void debugStack(final String pfix, int top, final String str) {
    System.out.print("# pfix=" + pfix + " \t");
    for (int is = 0; is <= top + 1 ; ++is) {
      if (mStack.get(is) != null) {
        System.out.print (" " + (is == top ? "top" : String.valueOf(is)) + ":" + mStack.get(is).toString());
      }
    }
    System.out.println("\t" + str);
  }

  @Override
  public Z next() {
    ++mN;
    // now perform a statement like "mA = RING.add(RING.one(), RING.multiply(RING.x(), RING.pow(RING.substitute(mA, RING.multiply(RING.x(), mA, mN), mN), mExpon, mN), mN));"
    // for example: A143046 poly -p "[[0],[1],[0,-1]]" -x ",p1,p2,sub,^3,<1,+"; G.f. satisfies A(x) = 1 + x*A(-x)^3.
    int ipfix = 0;
    int top = -1; // index of top element of <code>mStack</code>. Initially, the stack is empty.
    try {
      while (ipfix < mPostfix.length) { // scan over the operaands and operators
        String pfix = mPostfix[ipfix++];
        if (sDebug >= 2 && top >= 0) {
          debugStack(pfix, top, "before");
        }
        final char ch = pfix.charAt(0);
        if (ch >= '0' && ch <= '9') { // operand that is a single natural number
          final ArrayList<Q> num = new ArrayList<>();
          num.add(new Q(Integer.parseInt(pfix)));
          mStack.set(++top, RING.create(num));
        } else {
          switch (ch) { // discriminate with the first character
            default: // should not occur with proper postfix expressions
              throw new RuntimeException("invalid postfix code " + pfix);

          // operands
            case 'A': // this means A(x), the currently accumulated Polynomial mA for the generating function
              mStack.set(++top, mA);
              break;
            case 'p': // "p(\d+)"  = mPolys[$1], one of the predefined polynomials, numbered p0, p1, ...
              mStack.set(++top, mPolys.get(Integer.parseInt(pfix.substring(1))));
              break;
            case 'x': // the monic polynomial x
              mStack.set(++top, RING.x());
              break;
          
          // operations with 1 operand
            case 'd': // "dif", replace the current top element by its derivative
              mStack.set(top, RING.diff(mStack.get(top)));
              break;
            case 'e': // "exp", preplace the current top element te by exp(te)
              mStack.set(top, RING.exp(mStack.get(top), mN + mDist));
              break;
            case 'i': 
              switch (pfix) {
                case "inv": // "inv", replace the current top element te by 1/te
                  mStack.set(top, RING.inverse(mStack.get(top)));
                  break;
                case "int": // "int", replace the current top element by its formal integral
                  mStack.set(top, RING.integrate(mStack.get(top)));
                  break;
                default:
                  throw new RuntimeException("invalid postfix code with \"i\":" + pfix);
              }
              break;
            case 'l': // "log", preplace the current top element te by log(te)
              mStack.set(top, RING.log(mStack.get(top), mN + mDist));
              break;
            case 'n': // "neg", replace the current top element by its negation
              mStack.set(top, RING.negate(mStack.get(top)));
              break;
            case 'r': // "rev", replace the current top element by its series reversion
              mStack.set(top, RING.reversion(mStack.get(top), mN + mDist));
              break;
            case 's': 
              switch(pfix) {
                case "sub": // "sub", replace the current top element by a substitution
                  mStack.set(top, RING.substitute(mA, mStack.get(top), mN + mDist));
                  break;
                case "sin":
                  mStack.set(top, RING.sin(mStack.get(top), mN + mDist));
                  break;
                case "sqrt":
                  mStack.set(top, RING.sqrt(mStack.get(top), mN + mDist));
                  break;
                default:
                  throw new RuntimeException("invalid postfix code with \"s\":" + pfix);
              }
              break;
            case '<': // "<(\d+)" = shift x -> x^$1 (may be negative)
              mStack.set(top, RING.shift(mStack.get(top), (pfix.length() <= 1) ? 1 : Integer.parseInt(pfix.substring(1))));
              break;
            case '^': // P, m -> P^m, or "^(\d+)" P -> P^$1
              if (pfix.length() == 1) { // 2 operands
                --top;
                mStack.set(top, RING.pow(mStack.get(top), Long.valueOf(mStack.get(top + 1).toString()), mN + mDist));
              } else { // operation contains the 2nd operand
                if (pfix.indexOf('/') >= 0) { // e.g. "^2/3"
                  mStack.set(top, RING.pow(mStack.get(top), new Q(pfix.substring(1)), mN + mDist));
                } else {
                  mStack.set(top, RING.pow(mStack.get(top), Long.parseLong(pfix.substring(1)), mN + mDist));
                }
              }
              break;

          // arithmetic operations with 2 operands
            case '+':
              --top;
              mStack.set(top, RING.add(mStack.get(top), mStack.get(top + 1)));
              break;
            case '-':
              --top;
              mStack.set(top, RING.subtract(mStack.get(top), mStack.get(top + 1)));
              break;
            case '*':
              --top;
              mStack.set(top, RING.multiply(mStack.get(top), mStack.get(top + 1))); // , mN + mDist);
              break;
            case '/':
              --top;
              mStack.set(top, RING.series(mStack.get(top), mStack.get(top + 1), mN + mDist));
              break;
          } // switch
        }
        if (sDebug >= 3) {
          debugStack(pfix, top, "after");
        }
      } // while
    } catch (Exception exc) { // will never be reached with a proper generator
      throw new RuntimeException("# unexpected exception: " + exc.getMessage());
    }
    // mTop should be 0 here
    mA = mStack.get(top);
    Q result = mA.coeff(mN);
    if (mGfType == EGF) {
      result = result.multiply(mFactorial);
      if (mN > 0) {
        mFactorial = mFactorial.multiply(mN);
      }
    }
    return result.num();
   } // next

}
