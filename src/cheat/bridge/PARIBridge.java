package cheat.bridge;

/** 
 * Run GP/PARI with some script, and return the terms as a Sequence.
 * The output of the PARI script must be single lines with the terms.
 * @author Dr. Georg Fischer
 */
public class PARIBridge extends CASBridge {

  private int mN; // current index; for counting terms only, not depending on the offset of the sequence
  private int mNoTerms; // maximum number of terms to be extracted from the CAS script

  /** 
   * Construct a subprocess for a number of terms and a script.
   * @param offset index of first term
   * @param noTerms number of terms 
   * @param pattern name for additional commands that generate the output
   * @param script the PARI script to be run
   */
  public PARIBridge(final int offset, final int noTerms, final String pattern, final String script) {
    super("gpbridge -fq");
    mNoTerms = noTerms;
    try {
      mCasIn.println(script);
      if (false) {
      } else if (pattern.equals("a(n)")) {
        mCasIn.println("for(mN=" + offset + ",+oo,print(a(mN)))");
      } else if (pattern.equals("lista")) {
        mCasIn.println("lista(" + mNoTerms + ")");
      }
      mCasIn.close();
    } catch (Exception exc) {
      System.err.println(exc.getMessage());
    }
  }
}
