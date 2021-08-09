package irvine.oeis.a095;
// manually 2021-05-14

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A095425 a(n) = 10 written in base n.
 * @author Georg Fischer
 */
public class A095425 implements Sequence {

  protected int mParm;
  protected int mN;
  
  /** Construct the sequence */
  public A095425() {
    this(10);
  }
  
  /**
   * Generic constructor with parameter
   * @param parm number to be written in base n
   */
  public A095425(final int parm) {
    mParm = parm;
    mN = 0;
  }
  
  /**
   * Write a number n in base b by using decimal digits only.
   * Speed is not important, and n is in the int range.
   * @param n number to be written
   * @param b base 
   * @return a Z number built from a String of decimal digits, 
   * or null if the number cannot be written with decimal digits.
   */
  public static Z toString10(int num, final int base) {
    StringBuilder buf = new StringBuilder();
    boolean busy = true;
    while (num > 0) {
      final int digit = (base > 1) ? num % base : 1;
      if (digit >= 10) {
        return null;
      } else {
        buf.insert(0, String.valueOf(digit)); // append on the left
      }
      if (base > 1) {
        num /= base;
      } else {
        --num;
      }
    }
    return new Z(buf.toString());
  } 
  
  @Override
  public Z next() {
    ++mN;
    return toString10(mParm, mN);
  }
  
  /**
   * Test method
   * @param args command line argument: base
   */
  public static void main(final String[] args) {
    int num = 10;
    int noTerms = 128;
    int iarg = 0;
    if (iarg < args.length) {
      try {
        num = Integer.parseInt(args[iarg++]);
      } catch (final NumberFormatException exc) {
        // ignored
      }
    }
    Sequence seq = new A095425(num);
    for (int index = 1; index <= noTerms; ++index) {
      System.out.print((index == 1 ? "" : ",") + seq.next());
    }
    System.out.println();
  }
}
