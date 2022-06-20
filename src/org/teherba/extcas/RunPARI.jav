/* Generate a number of terms for an OEIS sequence by running GP/PARI
 * @(#) $Id$
 * 2022-06-09, Georg Fischer: copied from common/RegressionTester
 */
package org.teherba.extcas;
import  java.io.BufferedReader;
import  java.io.BufferedWriter;
import  java.io.File;
import  java.io.FileInputStream;
import  java.io.FileOutputStream;
import  java.io.InputStreamReader;
import  java.io.OutputStreamWriter;
import  java.io.PrintStream;
import  java.io.PrintWriter;
import  java.io.StringWriter;
import  java.lang.Process;
import  java.lang.Runtime;
import  java.nio.channels.Channels;
import  java.nio.channels.ReadableByteChannel;
import  java.util.ArrayList;
import  java.util.HashMap;

/** Runs GP/PARI with some script, fetches the output and splits it into single terms.
 *  @author Dr. Georg Fischer
 */
public class RunPARI {
  /** System-specific line separator (LF for Unix or CR/LF for Windows)*/
  private static final String nl      = System.getProperty("line.separator");
  /** System-specific file separator ("/" for Unix, "\" for Windows */
  private static final String slash   = "/"; // System.getProperty("file.separator");

  /** No-args Constructor. */
  public RunPARI() {
  }

  /** Runtime environment */
  private Runtime runtime = Runtime.getRuntime(); // for command execution
  /** Encoding of the logfile */
  private String logEncoding = "UTF-8"; // encoding for the result files and the log file
  /** Where to write the standard output */
  private PrintStream realStdOut = System.out; // System.out is redirected (with setOut)
  /** Where to write standard error */
  private PrintStream realStdErr = System.err; // System.err is redirected (with setErr)

  /** 
   * Runs a shell command.
   * @param cmd command line to be executed
   */
  public void runShellCommand(String cmd) {
    try {
      Process process = runtime.exec("gp -fq");
      BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(), logEncoding));
      PrintWriter writer = new PrintWriter(new OutputStreamWriter(process.getOutputStream(), logEncoding));
      writer.println("lista(nn) = {for (n=1, nn, ab = sigma(n)/n; for (i=2, n-1, if (sigma(i)/i == ab, print(n));););}");
      writer.println("lista(2000)");
      writer.close();
      String line = null;
      while ((line = reader.readLine()) != null) {
        System.out.println("gp: " + line);
      } // while readLine
      reader.close();

      reader = new BufferedReader(new InputStreamReader(process.getErrorStream(), logEncoding));
      while ((line = reader.readLine()) != null) {
        System.out.println(line);
      } // while readLine
      reader.close();
    } catch (Exception exc) {
      System.err.println(exc.getMessage());
    } // try
  } // runShellCommand

  protected void run(final String[] args) {
    try {
      String fileName = "-";
      // Open the file with the testcases
      BufferedReader tcaReader = null;
      if(fileName.equals("-")) { // STDIN
        tcaReader = new BufferedReader(new InputStreamReader(System.in, logEncoding));
      } else {
        File testCases = new File(fileName);
        ReadableByteChannel tcaChannel = (new FileInputStream(fileName)).getChannel();
        tcaReader = new BufferedReader(Channels.newReader(tcaChannel, logEncoding));
      } // not STDIN
      String[] cmd = new String[] { "java", "-v" };
      Process process = runtime.exec(cmd);
      BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(), logEncoding));
      int iline = 0;
      String line = null;
      while ((line = reader.readLine()) != null) {
        System.out.println(line);
        iline ++;
      } // while readLine
      reader.close();
    } catch (Exception exc) {
      System.err.println(exc.getMessage());
    }
  }

  /** Commandline activation:
   *  <pre>
   *  java -cp dist/joeis-lite.jar org.teherba.extcas.RunPARI [PARI script]
   *  </pre>
   *  @param args command line arguments: 
   */
  public static void main(String[] args) {
    new RunPARI().runShellCommand(args[0]);
  }
}
