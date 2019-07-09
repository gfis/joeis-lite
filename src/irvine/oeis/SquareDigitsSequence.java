package irvine.oeis;

import irvine.math.z.Z;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 * Numbers that contain only a subset of decimal digits in the number 
 * and in its square.
 * @author Georg Fischer
 */
public class SquareDigitsSequence implements Sequence {

  protected int mN; // index of current term to be returned
  protected Z mK; // current number with some property
  protected int mOffset; // OEIS offset1 as of generation time
  protected String mSubset; // the decimal digits of the subset in ascending order
  protected int mBase; // base of the numbers: 2-99
  protected int mMode; // type of the test: 2 = digits in square
  protected Pattern mAllowPattern; // pattern matching the subset of not-allowed decimal digits 
  protected int mDigLen; // number of digits in subset
  protected String[] mDigits; // the allowed digits as Strings
  
  private ArrayList<String> mQueue; // blocks of possible number endings, only with allowed digits
  private int mOldLen; // starting index of current block
  private int mNewLen; // ending index of current block + 1
  private int mIndDig; // index of current digit
  private int mIndQ; // index of number in mQueue
  private int mWidth; // width of numbers in current block
  protected int mDebug = 0;
  /**
   * Construct an instance which selects all numbers
   * that contain only a subset of decimal digits in the number 
   * and in its square.
   * @param offset first valid term has this index
   * @param base base of the numbers: 2-99
   * @param mode type of the test to be applied to the digits: 2 = digits in square
   * @param subset String of decimal digits in ascending order, representing the desire subset
   */
  protected SquareDigitsSequence(final int offset, final int base, final int mode, final String subset) {
    mOffset = offset;
    mN = 0;
    mK = Z.ZERO;
    mBase = base;
    mMode = mode;
    mSubset = subset;
    mDigLen = mSubset.length();
    mAllowPattern = Pattern.compile("[" + subset + "]*");
    mDigits = new String[mDigLen];
    for (int isub = 0; isub < mDigLen; isub++) {
      mDigits[isub] = mSubset.substring(isub, isub + 1);
    } // for isub
    mIndDig = 0;
    mWidth = 0;
    mQueue = new ArrayList<String>(1024);  
    mQueue.add("");
    mOldLen = 0;
    mNewLen = 0;
    mIndQ = 0;
  }

  /**
   * Get the next term of the sequence.
   * This is an example only.
   * The method is typically overwritten to get some other
   * element related to the runs of digits in this number.
   * @return the next term
   */
  @Override
  public Z next() { 
    Z result = null;
    boolean found = false;
    while (! found) { 
      if (mIndDig >= mDigLen) { // increase width - start a new Queue
        mWidth ++;
        // mQueue.removeRange(0, mOldLen);
        mOldLen = mNewLen;
        mNewLen = mQueue.size();
        mQueue.ensureCapacity(mOldLen + mOldLen * mDigLen);
        mIndDig = 0;
        mIndQ = mOldLen;
      } 
      if (mIndQ < mNewLen) { // prefix current digit to all in Queue
        String number = mDigits[mIndDig] + mQueue.get(mIndQ); // contains valid digits only, by construction
        result = new Z(number);
        String num2 = result.square().toString();
        if (mAllowPattern.matcher(num2).matches()) { // contains valid digits only
          if (mDigits[mIndDig].charAt(0) != '0' || mWidth <= 1) {
            found = true;
            if (mDebug >= 1) {
              System.out.println("push-num " + mQueue.size() + ": " + number.toString() + " " + num2);
            }
          }
          mQueue.add(number);
        } else { // test whether square mod width matches
          int len2 = num2.length();
          if (mAllowPattern.matcher(num2.substring(len2 - number.length(), len2)).matches()) { // and queue then
            if (mDebug >= 1) {
              System.out.println("push-sqp " + mQueue.size() + ": " + number.toString() + " " + num2);
            }
            mQueue.add(number);
          } else {
          /*
            if (mDebug >= 1) {
              System.out.println("push-sqf " + mQueue.size() + ": " + number.toString() + " " + num2);
            }
          */
          }
        }
        mIndQ ++;
      } else { // Queue is exhausted for current digit, take next digit 
        mIndDig++;
        mIndQ = mOldLen;
      } // next digit
    } // while not found 
    ++mN;
    return result;
  } // next

  //=====================================
  /** Test method 
   *  @param args command line arguments: [noterms [digits]]
   *  Show various elements related to the runs of digits for some base in n.
   */
  public static void main(String[] args) {
    int index = 1;
    int noTerms = 32;
    String subset = "23467"; // A137071
    int iarg = 0;
    if (iarg < args.length) {
      try {
        noTerms = Integer.parseInt(args[iarg ++]);
      } catch (Exception exc) {
      }
    }
    if (iarg < args.length) {
      subset = args[iarg ++];
    }
    SquareDigitsSequence seq = new SquareDigitsSequence(1, 10, 2, subset);
    seq.mDebug = noTerms & 3; /// last 2 bits
    while (index < noTerms) {
      System.out.println(index + " " + seq.next().toString());
      index ++;
    } // while index
  } // main

} // SquareDigitsSequence
