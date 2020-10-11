/*  Reads the output of BatchTest, kills and restarts that process after a timeout
 *  @(#) $Id: BatchMonitor.java 744 2019-04-05 06:29:20Z gfis $
 *  2020-10-10, V1.3: EOF handling
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
  private static String VERSION = "BatchMonitor V1.3";

  /** How many milliseconds should be added to -t value */
  private long    addTimeout;
  
  /** Debugging level: 0 = none, 1 = some, 2 = more */
  private int     debug;

  /** Position where to start reading, or behind the last line read */
  private String  seekString;

  /** Name of file to be deleted when BatchTest reached the end of the input file */
  private String  seekFileName;

  /** How many milliseconds should we wait for output of BatchTest */
  private long    timeout;
  
  /** Wait so many milliseconds when input is not ready */
  private long    waitTime;

  /** Encoding of the input file */
  private String  srcEncoding;

  /** No-args Constructor
   */
  public BatchMonitor() {
    // set default for variables and arguments
    debug       = 0;
    addTimeout  = 4000L;
    seekString  = "0x0"; // start at beginning of input file
    srcEncoding = "UTF-8";
    timeout     = 4000L;
    waitTime    =  100L;
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
        long remainingSlots = (addTimeout + timeout) / waitTime;
        boolean blocked = true; // normally reading is blocked
        while (blocked && remainingSlots > 0) {
          if (charReader.ready()) {
            line = charReader.readLine();
            blocked = false; // we read 1 line
          } else { 
            -- remainingSlots;
            Thread.sleep(waitTime); // milliseconds
          }
        } // while remainingSlots
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
            } else if (line.startsWith("A")) { // valid A-number or EOF
              System.out.println(line);
            } else if (line.startsWith("Total")) { 
              System.out.println(line);
              remainingSlots = 0;
              blocked = false;
              state = 2;
            } else if (parts[0].startsWith("#BT start")) {
              aseqno = parts[1];
              seekString = parts[2];
            }
          } // process line
        } else { // still blocked 
          state = 2; // kill + restart
          if (debug >= 2) {
            System.out.println("#BM still blocked, restart at " + seekString);
          }
          System.out.println(aseqno + "\t0\tFATOK\tblocked\t" + String.format("%6d ms", timeout));
        } // to be killed and restarted
      } // while reading input
      charReader.close();
    } catch (Throwable exc) {
       System.out.println("#BM FATAL - input read error " + exc.getMessage());
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
   *  <li>-a addtimeout add this to -t value (default: 4000 ms)</li>
   *  <li>-d debug      level 0=none, 1=some, 2=more (default: 0)</li>
   *  <li>-s seekfile   file to be deleted when BatchTest reaches EOF (default: seekpos.mon)</li>
   *  <li>-t timeout    timeout after which the BatchTest process is killed (default: 4000 ms)</li>
   *  <li>-w waittime   wait so many milliseconds when input is not ready (default 100 ms)</li>
   *  <li>reads from STDIN</li>
   *  </ul>
   */
  public void processArguments(String[] args) {
    int iarg = 0;
    if (args.length == 0) {
      System.out.print("Usage: java BatchTest ... | java BatchMonitor [-d level] [-t timeout]\n"
          + "    -a addtimeout  add this time to -t value (default: 4000 ms)\n"
          + "    -d debug       level 0=none, 1=some, 2=more (default: 0)\n"
          + "    -s seekpos.mon file to be deleted when BatchTest reaches EOF\n"
          + "    -t timeout     interrupt a sequence after this time (default: 4000 ms)\n"
          + "    -w waittime    wait so many milliseconds when input is not ready (default: 100 ms)\n"
          );
      return;
    }
    String fileName = "-"; // default: read from STDIN
    while (iarg < args.length && args[iarg].startsWith("-")) {
      String arg = args[iarg ++];
      if (false) {
      } else if (arg.startsWith("-a")) {
        try {
          addTimeout = Long.decode(args[iarg ++]); // in milliseconds
        } catch (Throwable exc) {
          // silently assume the default
        }
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
          timeout = Long.decode(args[iarg ++]); // in milliseconds
        } catch (Throwable exc) {
          // silently assume the default
        }
      } else if (arg.startsWith("-w")) {
        try {
          waitTime = Long.decode(args[iarg ++]); // in milliseconds
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
