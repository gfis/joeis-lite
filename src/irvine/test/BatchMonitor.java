/*  Reads the output of BatchTest, kills and restarts that process after a timeout
 *  @(#) $Id: BatchMonitor.java 744 2019-04-05 06:29:20Z gfis $
 *  2020-06-19, V1.0, Georg Fischer
 */
package irvine.test;
import  java.io.BufferedReader;
import  java.io.InputStreamReader;
import  java.lang.Process;
import  java.lang.Runtime;
import  java.lang.Thread; // sleep

/** Reads the output of {@link BatchTest} from STDIN.
 *  If there is no progress for some time, the BatchTest process is
 *  determined and killed. Afterwards, BatchTest is restartet at
 *  last file position which was printed in the "# start " line.
 *  @author Dr. Georg Fischer
 */
public class BatchMonitor {
  public final static String CVSID = "@(#) $Id: BatchMonitor.java 744 2019-04-05 06:29:20Z gfis $";

  /** This program's version */
  private static String VERSION = "BatchMonitor V1.1";

  /** Debugging level: 0 = none, 1 = some, 2 = more */
  private int     debug;

  /** How many seconds should we wait for output of BatchTest */
  private int     timeout;
  
  /** Position where to start reading, or behind the last line read */
  private String  seekString;

  /** File which contains the {@link #seekString} */
  private String  seekFileName;

  /** Encoding of the input file */
  private String  srcEncoding;

  /** No-args Constructor
   */
  public BatchMonitor() {
    // set default for variables and arguments
    debug       = 0;
    timeout     = 8;
    seekString  = "0x0"; // start at beginning of input file
    srcEncoding = "UTF-8";
  } // no-args Constructor

  /** Waits for lines of the form "# start aseqno |> tab seekpos", and
   *  prints all other lines to STDOUT.
   *  If the input is not ready for some period of time, the BatchTest java process 
   *  is killed and restarted at the last seek position read from STDIN.
   *  @param fileName "-" for STDIN
   */
  public void processBatch(String fileName) {
    long totalTime = System.currentTimeMillis();
    int lineNo = 0;
    String aseqno = "A000000";
    try {
      BufferedReader charReader = new BufferedReader(new InputStreamReader(System.in, srcEncoding));
      String line = null;
      int state = 0;
      while (state == 0) { // try to read and process lines
        int remainingSeconds = timeout;
        boolean blocked = true; // normally reading is blocked
        while (blocked && remainingSeconds > 0) {
          if (charReader.ready()) {
            line = charReader.readLine();
            blocked = false; // we read 1 line
          } else { 
            -- remainingSeconds;
            if (debug >= 3) {
              System.out.println("#BM sleep 1 s - " + remainingSeconds + "s left");
            }
            Thread.sleep(1000L); // milliseconds
          }
        } // while remainingSeconds
        if (! blocked) { // we could read the next line within the timeout period
          if (line == null) { // normal EOF reached
            state = 1; // stop outer loop
          } else { // examine and process line
            lineNo ++;
            if (debug >= 1) {
              System.out.println("#BM BatchMonitor read \"" + line + "\"");
            }
            String[] parts = line.split("\\t");
            if (false) {
            } else if (line.startsWith("A")) { // valid A-number
              System.out.println(line);
            } else if (parts[0].startsWith("#BT start")) { // valid A-number
              aseqno = parts[1];
              seekString = parts[2];
            }
          } // process line
        } else { // still blocked 
          state = 2; // kill + restart
          if (debug >= 2) {
            System.out.println("#BM still blocked, restart at " + seekString);
          }
          System.out.println(aseqno + "\t0\tFATOK\tblocked for\t" + timeout + "000 ms");
        } // to be killed and restarted
      } // while reading input
      charReader.close();
    } catch (Throwable exc) {
       System.out.println( "#BM FATAL - input read error " + exc.getMessage());
    } // try
    System.err.println(seekString);
    System.err.println(seekString);
    runShellCommand("perl batchdog.pl");
    if (debug >= 2) {
        System.out.println("#BM end of loop, restart at " + seekString);
    }
  } // processBatch

  /** Runs a shell command
   *  @param cmd command line to be executed
   */
  public void runShellCommand(String cmd) {
    try {
      Runtime runtime = Runtime.getRuntime();
      Process process = runtime.exec(cmd);
      BufferedReader
      reader = new BufferedReader(new InputStreamReader(process.getInputStream(), srcEncoding));
      String line = null;
      while ((line = reader.readLine()) != null) {
        if (debug >= 1) {
          System.out.println("#BM cmd1> " + line);
        }
      } // while readLine
      reader.close();

      reader = new BufferedReader(new InputStreamReader(process.getErrorStream(), srcEncoding));
      while ((line = reader.readLine()) != null) {
        if (debug >= 1) {
          System.out.println("#BM cmd2> " + line);
        }
      } // while readLine
      reader.close();
    } catch (Exception exc) {
      System.out.println("#BM error in runShellCommand: " + exc.getMessage());
    } // try
  } // runShellCommand

  /** Processes the commandline arguments
   *  @param args commandline arguments:
   *  <ul>
   *  <li>-b b-file-directory</li>
   *  <li>-v, -vv, -vvv: level of verbosity</li>
   *  <li>-t seconds    interrupt a sequence after this time (default: 4 s)</li>
   *  <li>-u limit      give up after limit terms (default: process whole b-file)</li>
   *  <li>input filename or "-" for STDIN</li>
   *  </ul>
   */
  public void processArguments(String[] args) {
    int iarg = 0;
    if (args.length == 0) {
      System.out.print("Usage: java BatchTest ... | java BatchMonitor [-d level] [-t timeout]\n"
          + "    -d level      debugging level: 0=none, 1=some, 2=more (default: 0)\n"
          + "    -t seconds    interrupt a sequence after this time (default: 8 s)\n"
          );
      return;
    }
    String fileName = "-"; // default: read from STDIN
    while (iarg < args.length && args[iarg].startsWith("-")) {
      String arg = args[iarg ++];
      if (false) {
      } else if (arg.startsWith("-d")) {
        try {
          debug = Integer.parseInt(args[iarg ++]);
        } catch (Throwable exc) {
          // silently assume default
        }
      } else if (arg.startsWith("-s")) {
        seekFileName = args[iarg ++];
      } else if (arg.startsWith("-t")) {
        try {
          timeout = Integer.parseInt(args[iarg ++]); // in seconds
        } catch (Throwable exc) {
          // silently assume the default
        }
      } else {
        System.out.println("#BM BatchMonitor: unknown option: " + args[iarg]);
      }
    } // while iarg
    processBatch(fileName);
  } // processArguments

  /** Reads a subset of OEIS 'stripped', calls joeis sequences and compares the results
   *  @param args command line arguments: filename or "-"
   */
  public static void main(String[] args) {
    // System.out.println(VERSION);
    (new BatchMonitor()).processArguments(args);
  } // main

} // BatchMonitor
