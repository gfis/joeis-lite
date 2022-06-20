package cheat.bridge;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/** Run GP/PARI with some script, fetch the output and split it into single terms.
 *  @author Dr. Georg Fischer
 */
public class CASBridge implements Sequence {

  private final static String ENCODING = "UTF-8"; // encoding for all files
  private Process mCasProcess; // the process of the Computer Algebra System to be called
  protected BufferedReader mCasOut; // reads CAS output
  protected BufferedReader mCasErr; // reads CAS error output
  protected PrintWriter mCasIn; // writes to standard input of the CAS

  /** 
   * Construct a specific CAS
   * @param osCommand start the subprocess with this operating system command
   */
  public CASBridge(String osCommand) {
    try {
      mCasProcess = Runtime.getRuntime().exec(osCommand); // start the subprocess
      mCasOut = new BufferedReader(new InputStreamReader(mCasProcess.getInputStream(), ENCODING));
      mCasErr = new BufferedReader(new InputStreamReader(mCasProcess.getErrorStream(), ENCODING));
      mCasIn = new PrintWriter(new OutputStreamWriter(mCasProcess.getOutputStream(), ENCODING));
    } catch (Exception exc) {
      System.err.println(exc.getMessage());
    }
  }

  /**
   * Destroy the subprocess.
   */
  public void destroy() {
    try {
      mCasProcess.destroy();
    } catch (Exception exc) {
      System.err.println(exc.getMessage());
    }
  }

  @Override
  public Z next() {
    String line = null;
    try {
      // assume that the subprocess emits single lines with terms of the form <code>\-?\d+</code>
      boolean busy = true;
      while (busy && (line = mCasOut.readLine()) != null) {
        char ch = line.charAt(0);
        if (Character.isDigit(ch) || ch == '-' && line.length() >= 2 && Character.isDigit(line.charAt(1))) {
          return new Z(line);
        } 
        if (line.indexOf("warning") >= 0) { 
          // ignore
        } else {
          busy = false;
          mCasOut.close();
          destroy();
          throw new RuntimeException("PARI error: " + line);
        }
      }
      mCasOut.close();
      while ((line = mCasErr.readLine()) != null) {
        throw new RuntimeException("PARI syntax: " + line);
      }
      mCasErr.close();
      mCasProcess.destroy();
    } catch (Exception exc) {
      System.err.println(exc.getMessage());
    }
    return null;
  }
}
