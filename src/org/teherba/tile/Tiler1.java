/* Generate tilings from Galebach's list
 * @(#) $Id$
 * Copyright (c) 2020 Dr. Georg Fischer
 * 2020-05-14: new colors
 * 2020-05-12: mHashPosition only, comparing Position.toString()
 * 2020-05-08: -a aseqno
 * 2020-04-30: cleaned
 * 2020-04-29: 4th version, flipped straight from backwards
 * 2020-04-21, Georg Fischer
 */
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Serializable;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.nio.channels.WritableByteChannel;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.TreeMap;
import java.util.Iterator;
import java.util.LinkedList;
// import  org.apache.log4j.Logger;

/**
 * Class for the generation of tilings and their coordinations sequences.
 * @author Georg Fischer
 */
public class Tiler1 implements Serializable {
    private static final long serialVersionUID = 3L;
    public final static String CVSID = "@(#) $Id: Tiler1.java $";
    /** log4j logger (category) */
    // private Logger log;

    /**
     * Empty constructor.
     */
    protected Tiler1() {
        // log = Logger.getLogger(Tiler1.class.getName());
        mNumTerms = 32;
        mOffset   = 0;
        mBFile    = false;
        mBFilePrefix = "./";
        mSVG      = false;
        mGalId    = null;
        mASeqNo   = null; // not specified
    } // Tiler1()

    /** Debugging mode: 0=none, 1=some, 2=more */
    protected static int sDebug;

    /**
     * Set the debugging level.
     * @param level code for the debugging level: 0 = none, 1 = some, 2 = more.
     */
    public void setDebug(int level) {
        sDebug = level;
    }

    /** Standard encoding for all files */
    private static final String sEncoding = "UTF-8";

    /** OEIS A-number of the coordination sequence */
    private String mASeqNo;

    /** Brian Galebach's identification of a VertexType, of the form "Gal.u.t.v" */
    private String mGalId;

    /** Amount of indenting for JSON output */
    protected static String sIndent = "";

    /** Increase the indent
     */
    protected void  pushIndent() {
        sIndent += "    ";
    } // pushIndent

    /** Decrease the indent
     */
    protected void popIndent() {
        if (sIndent.length() >= 4) {
            sIndent = sIndent.substring(4);
        }
    } // popIndent

    /** number of terms to be generated */
    private int mNumTerms;

    /** current number of generated edges (1 based) */
    private int mNumEdges;

    /** Maximum distance from origin */
    private int mMaxDistance;

    /** Offset1 of the sequences */
    private int mOffset;

    /** Allowed vertex types for this tiling */
    public static VertexType[] mVertexTypes; // [0] is reserved
    /** first free allowed VertexType */
    public static int ffVertexTypes;

    /** Allocated vertices */
    public static ArrayList<Vertex> mVertices; // [0] is reserved

    /**
     * Join an array of integers
     * @param delim delimiter
     * @param vector integer array
     * @return a String of the form "[elem1,elem2.elem3]"
     */
    protected static String join(String delim, int[] vector) {
        StringBuffer result = new StringBuffer(128);
        result.append('[');
        for (int ind = 0; ind < vector.length; ind ++) {
            if (ind > 0) {
                result.append(delim);
            }
            result.append(String.valueOf(vector[ind]));
        } // for
        result.append(']');
        return result.toString();
    } // join

    /** Whether an OEIS b-file should be written */
    private boolean mBFile;

    /** Number of terms which were written to the b-file */
    private int mBFileCount;

    /** Prefix ("directory/") for b-file names */
    private String mBFilePrefix;

    /** Writer for b-file output */
    private PrintWriter mBFileWriter;

    /**
     * Writes an OEIS b-file
     * @param param either "head prefix" for file open, "tail" for close,
     * or a tuple (index space term)
     */
    private void writeBFile(String param) {
        if (mBFile) {
            try {
                if (false) {
                } else if (param.startsWith("head")) { // special tag - open file
                    mBFileCount = 0;
                    String fileName = param.substring(4).trim();
                    if (fileName.startsWith("A")) {
                        fileName = "b" + fileName.substring(1);
                    }
                    if (! fileName.endsWith(".txt")) {
                        fileName += ".txt";
                    }
                    if (param.equals("-")) { // stdout
                         mBFileWriter = new PrintWriter(Channels.newWriter(Channels.newChannel(System.out), sEncoding));
                    } else { // not stdout
                         WritableByteChannel channel = (new FileOutputStream (mBFilePrefix + fileName, false)).getChannel();
                         mBFileWriter = new PrintWriter(Channels.newWriter(channel, sEncoding));
                    } // not stdout
                } else if (param.startsWith("tail")) { // special tag - close file
                    mBFileWriter.close();
                } else {
                    mBFileWriter.println(param);
                    mBFileCount ++;
                }
            } catch (Exception exc) {
                // log.error(exc.getMessage(), exc);
                System.err.println(exc.getMessage());
                exc.printStackTrace();
            } // try
        } // b-file output enabled
    } // writeBFile

    /** Whether an SVG image file should be written */
    private boolean mSVG;

    /** How many &gt;line&lt; elements should be written */
    private int mSVGCount;

    /** Writer for SVG output */
    private PrintWriter mSVGWriter;

    /**
     * Writes some portion of an SVG file.
     * @param param one or more complete SVG XML elements, or
     * "&gt;x-head&lt;filename&gt;/x-head&lt;" for file open and SVG prelude, or
     * "&gt;x-tail /&lt;" for SVG postlude and file close.
     */
    private void writeSVG(String param) {
        String text = param;
        try {
            if (! param.startsWith("<x-")) { // normal SVG XML element(s)
                if (mNumEdges <= mSVGCount) { // number of <line> elements can be limited
                    mSVGWriter.println(text);
                }
            } else if (param.startsWith("<x-head")) { // special tag
            	// viewBox="-w1 -w1 w2 w2"
                int w1 = mMaxDistance;
                int w2 = 2 * w1; 
                param = param.replaceAll("\\<[^\\>]+\\>([^\\<]+)\\<.*", "$1");
                mSVGCount = mNumTerms;
                if (param.equals("-")) { // stdout
                     mSVGWriter = new PrintWriter(Channels.newWriter(Channels.newChannel(System.out), sEncoding));
                } else { // not stdout
                     WritableByteChannel channel = (new FileOutputStream (param, false)).getChannel();
                     mSVGWriter = new PrintWriter(Channels.newWriter(channel, sEncoding));
                } // not stdout
                String timestamp = (new SimpleDateFormat("yyyy-MM-dd' 'HH:mm")).format(new java.util.Date());
                text = ""
                + "<?xml version=\"1.0\"?>\n"
                + "<!--\n"
                + "    Written with Tiler1.java at " + timestamp + " - Georg Fischer. Do NOT edit here!\n"
                + "-->\n"
                + "<?xml-stylesheet type=\"text/css\" href=\"tiling.css\" ?>\n"
                + "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n"
                + "<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\"\n"
                + "    width=\"192mm\" height=\"192mm\" viewBox=\"-" + w1 + " -" + w1 + " " + w2 + " " + w2 + "\" >\n" // spaces are important!
                + "<title>Uniform Tiling</title>\n"
                + "<g id=\"tile\">\n"
                + "<rect x=\"-" + w1 +"\" y=\"-" + w1 + "\" width=\"" + w2 +"\" height=\"" + w2 + "\" />\n"
                + "<text class=\"nota\" x=\"-" + w1 +"\" y=\"-" + (w1 - 1) + "\">&#xa0;" + mGalId + "</text>"
                ;
                mSVGWriter.println(text);
            } else if (param.startsWith("<x-tail")) { // special tag
                text = ""
                + "</g>\n"
                + "</svg>\n"
                ;
                mSVGWriter.println(text);
                mSVGWriter.close();
            }
        } catch (Exception exc) {
            // log.error(exc.getMessage(), exc);
            System.err.println(exc.getMessage());
            exc.printStackTrace();
        } // try
    } // writeSVG

    /** Color in dices in tilings.css cycle through 0..5 */
    private static final int COLOR_MOD = 6;
    
    /**
     * Writes an edge from the focus to a successur {@link Vertex} to the SVG file.
     * @param focus starting Vertex
     * @param succ  ending   Vertex
     * @param distance distance from baseVertex, for coloring
     * @param mode  0=normal, 1=tentative, 2=test
     */
    public void writeSVGEdge(Vertex focus, Vertex succ, int distance, int mode) {
        switch (mode) {
            default:
            case 0: // normal
                writeSVG("<line class=\"l" + String.valueOf(distance % COLOR_MOD)
                        + "\" x1=\"" + focus.expos.getX()
                        + "\" y1=\"" + focus.expos.getY()
                        + "\" x2=\"" + succ.expos.getX()
                        + "\" y2=\"" + succ.expos.getY()
                        + "\"><title>" + focus.index + mVertexTypes[focus.iType].name
                        + "->"         + succ .index + mVertexTypes[succ .iType].name
                        + "</title></line>");
                break;
            case 1: // tentative
                writeSVG("<line class=\"tent dash"
                        + "\" x1=\"" + focus.expos.getX()
                        + "\" y1=\"" + focus.expos.getY()
                        + "\" x2=\"" + succ.expos.getX()
                        + "\" y2=\"" + succ.expos.getY()
                        + "\"><title>" + focus.index + mVertexTypes[focus.iType].name
                        + "->"         + succ .index + mVertexTypes[succ .iType].name
                        + "</title></line>");
                break;
            case 2: // test
                writeSVG("<line class=\"test dash"
                        + "\" x1=\"" + focus.expos.getX()
                        + "\" y1=\"" + focus.expos.getY()
                        + "\" x2=\"" + succ.expos.getX()
                        + "\" y2=\"" + succ.expos.getY()
                        + "\"><title>" + focus.index + mVertexTypes[focus.iType].name
                        + "->"         + succ .index + mVertexTypes[succ .iType].name
                        + "</title></line>");
                break;
        } // switch (mode)
    } // writeSVGEdge

    /**
     * Writes a circle centered at the position of a {@link Vertex} to the SVG file.
     * @param focus Vertex to be drawn
     * @param mode  0=normal, 1=tentative, 2=test
     */
    public void writeSVGVertex(Vertex focus, int mode) {
        String color = String.valueOf(focus.distance % COLOR_MOD);
        String name = mVertexTypes[focus.iType].name;
        switch (mode) {
            default:
            case 0:
                writeSVG("<g><circle class=\"c" + color
                        + "\" cx=\"" + focus.expos.getX()
                        + "\" cy=\"" + focus.expos.getY()
                        + "\" r=\""  + (focus.index == 2 ? "0.3" : "0.15") + "\">" // bigger if baseVertex
                        + "</circle>"
                        + "<text class=\"t"  + color
                        + "\" x=\""  + focus.expos.getX()
                        + "\" y=\""  + focus.expos.getY()
                        + "\" dy=\"0.03px\">" + name + "</text>"
                        + "<title>"  + String.valueOf(focus.index) + name + focus.rotate + "</title>"
                        + "</g>"
                        );
                break;
            case 1:
            case 2:
                writeSVG("<g><circle class=\"test"
                        + "\" cx=\"" + focus.expos.getX()
                        + "\" cy=\"" + focus.expos.getY()
                        + "\" r=\""  + (focus.index == 2 ? "0.3" : "0.15") + "\">"
                        + "</circle>"
                        + "<text class=\"t"  + color
                        + "\" x=\""  + focus.expos.getX()
                        + "\" y=\""  + focus.expos.getY()
                        + "\" dy=\"0.03px\">" + name + "</text>"
                        + "<title>"  + String.valueOf(focus.index) + name + focus.rotate + "</title>"
                        + "</g>"
                        );
                break;
        } // switch (mode)
    } // writeSVGVertex

    private static final Double SQRT2 = Math.sqrt(2.0);
    private static final Double SQRT3 = Math.sqrt(3.0);
    private static final Double SQRT6 = Math.sqrt(6.0);

    /**
     * Class for an exact position of a {@link Vertex}.
     * The x axis is to the right and the y axis leads downwards (SVG coordinate system).
     * The x and y coordinates are represented by tuples (a,b,c,d)
     * such that (a + b*sqrt(2) + c*sqrt(3) + d*sqrt(6)) / 4 give the
     * real value for a position.
     * All edges of unit length under angles of n * 15 degrees can exactly be represented by such tuples.
     * Cf. https://math.stackexchange.com/questions/96946/how-to-prove-1-sqrt2-sqrt3-and-sqrt6-are-linearly-independent-ove 
     * r Q
     */
    protected  class Position implements Serializable, Comparable<Position> {
        protected int/*s*/[] xtuple;
        protected int/*s*/[] ytuple;

        /**
         * Empty constructor - creates the origin (0,0).
         */
        public Position() {
            xtuple = new int/*s*/[4];
            ytuple = new int/*s*/[4];
            Arrays.fill(xtuple, (int/*s*/) 0);
            Arrays.fill(ytuple, (int/*s*/) 0);
        } // Position()

        /**
         * Constructor
         * @param xparm tuple for exact x representation
         * @param yparm tuple for exact y representation
         */
        public Position(int/*s*/[] xparm, int/*s*/[]yparm) {
            xtuple = xparm;
            ytuple = yparm;
        } // Position(int/*s*/[], int/*s*/[])

        /**
         * Determines whether <em>this</em> Position is equal to a second
         * @param pos2 second Position
         * @return true if the underlaying arrays have the same values
         */
    
        public boolean equals(Position pos2) {
        /*
            return compareTo(pos2) == 0;
        */
            boolean result = true; // assume succes
            int ipos = 0;
            while (result && ipos < 4) {
                if (  xtuple[ipos] != pos2.xtuple[ipos]
                   || ytuple[ipos] != pos2.ytuple[ipos]) { 
                   result = false;
                }
                ipos ++;
            } // while ipos
            return result;
        } // equals
    
        public int hashCode() {
            int result = 0; // sum here
            int ipos = 0;
            while (ipos < 4) {
            	result = result << 8 + xtuple[ipos];
            	result = result << 8 + ytuple[ipos];
                ipos ++;
            } // while ipos
            return result;
        } // hashCode
    
        /**
         * Compares <em>this</em> Position with a second
         * @param pos2 second Position
         * @return -1, 0, 1 if this < = > pos2 in lexicographical order of the tuple elements
         */
        public int compareTo(Position pos2) {
            int result = 0; // assume equality
            int ipos = 0;
            while (result == 0 && ipos < 4) { // as long as there is no difference
                if (false) {
                } else if (xtuple[ipos] < pos2.xtuple[ipos]) {
                    result = -1;
                } else if (xtuple[ipos] > pos2.xtuple[ipos]) {
                    result =  1;
                } else { // x =
                    if (false) {
                    } else if (ytuple[ipos] < pos2.ytuple[ipos]) {
                        result = -1;
                    } else if (ytuple[ipos] > pos2.ytuple[ipos]) {
                        result =  1;
                    }
                } // else check next position
                ipos ++;
            } // while ipos
            // maybe still result == 0 
            return result;
        } // compareTo

        /**
         * Computes the cartesian coordinate value from an exact position tuple
         * @return a double value
         */
        public Double cartesian(int/*s*/[] tuple) {
            return ( tuple[0]
                   + tuple[1] * SQRT2
                   + tuple[2] * SQRT3
                   + tuple[3] * SQRT6
                   ) / 4.0;
        } // cartesian

        /**
         * Adds a Position to <em>this</em> Position.
         * @param pos2 Position to be added
         * @return this + pos2
         */
        public Position add(Position pos2) {
            Position result = new Position();
            for (int ipos = 0; ipos < 4; ipos ++) {
                result.xtuple[ipos] = (xtuple[ipos] + pos2.xtuple[ipos]);
                result.ytuple[ipos] = (ytuple[ipos] + pos2.ytuple[ipos]);
            } // for ipos
            return result;
        } // add

        /**
         * Subtracts a Position from <em>this</em> Position.
         * @param pos2 Position to be subtracted
         * @return this - pos2
         */
        public Position subtract(Position pos2) {
            Position result = new Position();
            for (int ipos = 0; ipos < 4; ipos ++) {
                result.xtuple[ipos] = (xtuple[ipos] - pos2.xtuple[ipos]);
                result.ytuple[ipos] = (ytuple[ipos] - pos2.ytuple[ipos]);
            } // for ipos
            return result;
        } // subtract

        /**
         * Returns a representation of the Position
         * @return the cartesian coordinates like "[-3.0981,1.3660]"
         */
        public String toString() {
        /*
            return join(",", xtuple) + join(",", ytuple);
        */
            StringBuffer result = new StringBuffer(64);
            for (int ipos = 0; ipos < 4; ipos ++) {
                result.append(',');
                result.append(String.valueOf(xtuple[ipos]));
                result.append(',');
                result.append(String.valueOf(ytuple[ipos]));
            } // for ipos
            result.append(']');
            result.setCharAt(0, '[');
            return result.toString();
        } // Position.toString

        /**
         * Returns an internal representation of the Position
         * @return a tuple "[x0-x1-x2-x3/y0-y1-y2-y3]" of integers
         */
        public String toList() {
            return join(",", xtuple) + join(",", ytuple);
        } // toList

        /**
         * Gets the cartesian x coordinate (to the right) from <em>this</em> Position
         * @return a String with 4 decimal digits
         */
        public String getX() {
            return String.format("%.4f", cartesian(xtuple)).replaceAll("\\,", "."); // for German Locale
        } // getX

        /**
         * Gets the cartesian y coordinate (downwards, because of SVG) from <em>this</em> Position
         * @return a String with 4 decimal digits
         */
        public String getY() {
            return String.format("%.4f", cartesian(ytuple)).replaceAll("\\,", "."); // for German Locale
        } // getY

        /**
         * Moves <em>this</em> Position by a unit distance in some angle
         * @param angle in degrees 0..360
         * @return new Position
         */
        public Position moveUnit(int angle) {
            int icircle = Math.round(angle / 15) % 24;
            return add(mUnitCirclePoints[icircle]);
        }

    } // class Position

    /** Positions in the unit circle = increments for the next {@link Vertex} */
    private final Position[] mUnitCirclePoints = new Position[]
            { new Position(new int/*s*/[] { 4, 0, 0, 0}, new int/*s*/[] { 0, 0, 0, 0}) // [ 0]   0     1.0000,    0.0000
            , new Position(new int/*s*/[] { 0, 1, 0, 1}, new int/*s*/[] { 0,-1, 0, 1}) // [ 1]  15     0.9659,    0.2588
            , new Position(new int/*s*/[] { 0, 0, 2, 0}, new int/*s*/[] { 2, 0, 0, 0}) // [ 2]  30     0.8660,    0.5000
            , new Position(new int/*s*/[] { 0, 2, 0, 0}, new int/*s*/[] { 0, 2, 0, 0}) // [ 3]  45     0.7071,    0.7071
            , new Position(new int/*s*/[] { 2, 0, 0, 0}, new int/*s*/[] { 0, 0, 2, 0}) // [ 4]  60     0.5000,    0.8660
            , new Position(new int/*s*/[] { 0,-1, 0, 1}, new int/*s*/[] { 0, 1, 0, 1}) // [ 5]  75     0.2588,    0.9659
            , new Position(new int/*s*/[] { 0, 0, 0, 0}, new int/*s*/[] { 4, 0, 0, 0}) // [ 6]  90     0.0000,    1.0000
            , new Position(new int/*s*/[] { 0, 1, 0,-1}, new int/*s*/[] { 0, 1, 0, 1}) // [ 7] 105    -0.2588,    0.9659
            , new Position(new int/*s*/[] {-2, 0, 0, 0}, new int/*s*/[] { 0, 0, 2, 0}) // [ 8] 120    -0.5000,    0.8660
            , new Position(new int/*s*/[] { 0,-2, 0, 0}, new int/*s*/[] { 0, 2, 0, 0}) // [ 9] 135    -0.7071,    0.7071
            , new Position(new int/*s*/[] { 0, 0,-2, 0}, new int/*s*/[] { 2, 0, 0, 0}) // [10] 150    -0.8660,    0.5000
            , new Position(new int/*s*/[] { 0,-1, 0,-1}, new int/*s*/[] { 0,-1, 0, 1}) // [11] 165    -0.9659,    0.2588
            , new Position(new int/*s*/[] {-4, 0, 0, 0}, new int/*s*/[] { 0, 0, 0, 0}) // [12] 180    -1.0000,    0.0000
            , new Position(new int/*s*/[] { 0,-1, 0,-1}, new int/*s*/[] { 0, 1, 0,-1}) // [13] 195    -0.9659,   -0.2588
            , new Position(new int/*s*/[] { 0, 0,-2, 0}, new int/*s*/[] {-2, 0, 0, 0}) // [14] 210    -0.8660,   -0.5000
            , new Position(new int/*s*/[] { 0,-2, 0, 0}, new int/*s*/[] { 0,-2, 0, 0}) // [15] 225    -0.7071,   -0.7071
            , new Position(new int/*s*/[] {-2, 0, 0, 0}, new int/*s*/[] { 0, 0,-2, 0}) // [16] 240    -0.5000,   -0.8660
            , new Position(new int/*s*/[] { 0, 1, 0,-1}, new int/*s*/[] { 0,-1, 0,-1}) // [17] 255    -0.2588,   -0.9659
            , new Position(new int/*s*/[] { 0, 0, 0, 0}, new int/*s*/[] {-4, 0, 0, 0}) // [18] 270     0.0000,   -1.0000
            , new Position(new int/*s*/[] { 0,-1, 0, 1}, new int/*s*/[] { 0,-1, 0,-1}) // [19] 285     0.2588,   -0.9659
            , new Position(new int/*s*/[] { 2, 0, 0, 0}, new int/*s*/[] { 0, 0,-2, 0}) // [20] 300     0.5000,   -0.8660
            , new Position(new int/*s*/[] { 0, 2, 0, 0}, new int/*s*/[] { 0,-2, 0, 0}) // [21] 315     0.7071,   -0.7071
            , new Position(new int/*s*/[] { 0, 0, 2, 0}, new int/*s*/[] {-2, 0, 0, 0}) // [22] 330     0.8660,   -0.5000
            , new Position(new int/*s*/[] { 0, 1, 0, 1}, new int/*s*/[] { 0, 1, 0,-1}) // [23] 345     0.9659,   -0.2588
            };

    /** Angles in degrees for regular polygones */
    private static final int[] mRegularAngles = new int[] { 0
            , 360 // [ 1] full circle
            , 180 // [ 2] half circle
            ,  60 // [ 3] triangle
            ,  90 // [ 4] square
            , 108 // [ 5] pentagon
            , 120 // [ 6] hexagon
            ,   0 // [ 7] (heptagon)
            , 135 // [ 8] octogon
            , 140 // [ 9] nonagon
            , 144 // [10] decagon
            ,   0 // [11] (hendecagon)
            , 150 // [12] dodecagon
            };

    /** 
     * Maps exact {@link Position}s of vertices to their index in {@link mVertices}.
     * Used for the detection of duplicate target vertices.
     */
    public HashMap<String, Integer> mHashPosition;
    // public TreeMap<String, Integer> mTreePosition;
    
    /** 
     * Gets the size of the position map.
     */ 
    public int positionSize() {
    	return mHashPosition.size();
    } // positionSize

    /**
     * Determines whether a {@link Vertex} exists at some {@link Position}.
     * @param expos the Position where a vertex is expected
     * @return index of the vertex at expos, or -1 if the position is still empty
     */
    public int findVertex(Position expos) {
        int result = -1; // assume not found
        Integer posh = mHashPosition.get(expos.toString());
    /*    
        Integer post = mTreePosition.get(expos.toString());
        if (post == null && posh != null || posh == null && post != null) {
            System.out.println("# assertion 7: mTrHaPosition difference post=" + post + " <> posh=" + posh + " for expos=" + expos.toString());
        } else if (post != null && post.intValue() != posh.intValue()) {
            System.out.println("# assertion 8: mTrHaPosition difference post=" + post + " <> posh=" + posh + " for expos=" + expos.toString());
        }
    */
        if (posh != null) {
            result = posh.intValue();
        }
        return result;
    } // findVertex

    /**
     * Normalizes an angle
     * @param angle in degrees, maybe negative or >= 360
     * @return non-negative degrees mod 360
     */
    public int normAngle(int angle) {
        while (angle < 0) {
            angle += 360;
        }
        return angle % 360;
    } // normAngle

    /**
     * Tests the computation of {@link Position}s
     */
    public void testCirclePositions() {
        Position origin = new Position();
        for (int ipos = 0; ipos < mUnitCirclePoints.length + 1; ipos ++) {
            Position pos = origin.moveUnit(ipos * 15);
            System.out.println(String.format("[%2d], %3d = %s", ipos, ipos * 15, pos.toString()));
            if (mSVG) {
                writeSVG("<line class=\"k" + String.valueOf(ipos % 8)
                       + " x1=\"0.0\" y1=\"0.0\" x2=\"" + pos.getX() + "\" y2=\"" + pos.getY()
                       + "\"><title>" + mNumEdges
                       + "</title></line>");
            }
        } // for ipos
        for (int ipos = 0; ipos < mUnitCirclePoints.length; ipos += 4) {
            int ipos8 = (ipos + 8) % 24;
            Position hexPos = mUnitCirclePoints[ipos].add(mUnitCirclePoints[ipos8]);
            System.out.println(String.format("[%2d] + [%2d] = %8s,%8s"
                    , ipos, ipos8, hexPos.getX(), hexPos.getY()));
        } // for ipos
    } // testCirclePositions

    //----------------------------------------------------------------

    /**
     * Class for an allowed vertex type.
     */
    protected class VertexType implements Serializable { // numbered 1, 2, 3 ... ; 0 is not used
        int    index; // even for normal type, odd for flipped version
        boolean chiral; // whether the vertices are chiral and have a flipped variant
        int    edgeNo; // number of edges; the following arrays are indexed by iedge=0..edgeNo-1
        int[]  polys; // number of corners of the regular (3,4,6,8, or 12) polygones (shapes)
                // are arranged clockwise (for SVG, counter-clockwise by Galebach)
                // around this vertex type.
                // First edge goes from (x,y)=(0,0) to (1,0); the shape is to the left of the edge
        int[]  tipes; // VertexType indices of target vertices (normally even, odd if flipped / C')
        int[]  rotas; // how many degrees must the target vertices be rotated, from Galebach
        int[]  sweeps; // positive angles from iedge to iedge+1 for (iedge=0..edgeNo) mod edgeNo
    /*Shas    
        int[]  leShas; // shapes / polygones from the focus to the left  of the edge
        int[]  riShas; // shapes / polygones from the focus to the right of the edge
    Shas*/
        String galId; // e.g. "Gal.2.1.1"
        String name; // for example "A" for normal or "a" (lowercase) for flipped version
        String aSeqNo; // OEIS A-number of {@link #sequence}
        String sequence; // list of terms of the coordination sequence

        /**
         * Empty constructor
         */
        VertexType() {
            index    = 0;
            chiral   = false;
            edgeNo   = 0;
            polys    = new int[0];
            tipes    = new int[0];
            rotas    = new int[0];
        /*Shas    
            leShas   = new int[0];
            riShas   = new int[0];
        Shas*/
            sweeps   = new int[0];
            galId    = "Gal.0.0.0";
            name     = "Z";
            aSeqNo   = "";
            sequence = "";
        } // VertexType()

        /**
         * Returns a simple representation of the VertexType
         * @return the most important properties
         */
        public String toString() {
            return "{" + index + name + "}";
        } // VertexType.toString

        /**
         * Returns a representation of the VertexType
         * @return JSON for all properties
         */
        public String toJSON() {
            pushIndent();
            String result
                    = "{ \"i\": \""     + index + "\""
                    + ", \"name\": \""  + name  + "\""
                    + ", \"chiral\": \""  + chiral + "\""
                    + ", \"polys\": "   + join(",", polys)
                    + ", \"sweeps\": "  + join(",", sweeps)
                    + ", \"rotas\": "  + join(",", rotas)
                    + ", \"tipes\": "  + join(",", tipes)
            /*
                    + ", \"leShas\": "  + join(",", leShas)
                    + ", \"riShas\": "  + join(",", riShas)
            */
                    + ", \"galId\": \"" + galId + "\""
                    + " }\n";
            popIndent();
            return result;
        } // VertexType.toJSON

        /**
         * Determines whether <em>this</em> {@link VertexType} is flipped
         * @return true if the index is odd, false otherwise
         */
        public boolean isFlipped() {
            return  // chiral &&
                    (index & 1) == 1;
        } // isFlipped

        /**
         * Constructor from input file parameters
         * @param aSeqNo OEIS A-number of the sequence
         * @param galId Galebach's identification of a vertex type: "Gal.u.t.v"
         * @param vertexId clockwise dot-separated list of
         *     the polygones followed by the list of types and angles
         * @param taRotList clockwise semicolon-separated list of
         *     vertex type names and angles (and apostrophe if flipped)
         * @param sequence a list of initial terms of the coordination sequence
         */
        VertexType(String aSeqNo, String galId, String vertexId, String taRotList, String sequence) {
            // for example: A265035 tab Gal.2.1.1 tab 3.4.6.4; 4.6.12 tab 12.6.4 tabA 180'; A 120'; B 90 tab 1,3,6,9,11,14,17,21,25,28,30,32,35,39,43,46,48,50,53,57,61,64,66,68,71,75,79,82,84,86,89,93,97,100,102,104,107,111,115,118,120,122,125,129,133,136,138,140,143,147
            String[] corners = vertexId.split("\\.");
            String[] parts   = taRotList.split("[\\;\\,]\\s*");
            index  = ffVertexTypes; // even = not flipped
            name   = "ZABCDEFGHIJKLMNOP".substring(index >> 1, (index >> 1) + 1);
            this.aSeqNo = aSeqNo;
            this.galId  = galId;
            this.sequence = sequence;
            edgeNo = parts.length;
            polys  = new int[edgeNo];
            tipes  = new int[edgeNo];
            rotas  = new int[edgeNo];
        /*Shas    
            leShas = new int[edgeNo];
            riShas = new int[edgeNo];
        Shas*/
            sweeps = new int[edgeNo];
            for (int iedge = 0; iedge < edgeNo; iedge ++) {
                String part  = parts[iedge];
                tipes[iedge] = (part.charAt(0) - 'A' + 1) * 2; // even, A -> 2
                if (part.contains("-")) { // reverse orientation
                    tipes[iedge] ++; // make it odd
                }
                part = part.replaceAll("[\\+\\-]\\d+\\Z", ""); // remove edge, for angle, below
                polys[iedge] = 0;
                rotas[iedge] = 0;
                try {
                    polys[iedge] = Integer.parseInt(corners[iedge]);
                    rotas[iedge] = Integer.parseInt(part.replaceAll("\\D", "")); // keep the digits only
                } catch (Exception exc) {
                    if (sDebug >= 1) {
                        System.err.println("# ** assertion 4: descriptor for \"" + galId + "\" bad");
                    }
                }
            } // for iedge
            chiral = false;
            // now determine chirality; reverse the vertexId
            StringBuffer revId = new StringBuffer(128);
            // revId.append("rev");
            for (int iedge = 0; iedge < edgeNo; iedge ++) { // increasing
                int dedge = edgeNo - 1 - iedge; // decreasing
                revId.append('.');
                revId.append(String.valueOf(polys[dedge]));
                sweeps[iedge] = iedge == 0
                        ? 0
                        : sweeps[iedge - 1] + mRegularAngles[polys[iedge - 1]];
            /*Shas    
                riShas[iedge] = polys[iedge];
                leShas[iedge] = polys[dedge];
            Shas*/
            } // for iedge
            revId.append(revId.substring(0, revId.length())); // duplicate it
            revId.append('.');
            chiral = revId.indexOf(vertexId + ".") < 0; // is it found in some rotation?
            if (sDebug >= 3) {
                System.out.println("# determine chiral: \"." + vertexId + ".\" contained in \"" + revId + "\" ? -> " + chiral);
            }
        } // VertexType(String, String, String)

        /**
         * Returns a new, flipped version of <em>this</em> VertexType,
         * which must be normal.
         * @return a VertexType which is a deep copy of <em>this</em>.
         * The index becomes odd, and all edges are visited in reverse orientation.
         */
        public VertexType getFlippedClone() {
            VertexType result = new VertexType();
            result.index    = index + 1; // odd -> edges turn counter-clockwise
            result.chiral   = chiral;
            result.name     = chiral ? name.toLowerCase() : name;
            result.galId    = galId;
            result.sequence = sequence;
            result.edgeNo   = edgeNo;
            result.polys    = new int[edgeNo];
            result.tipes    = new int[edgeNo];
            result.rotas    = new int[edgeNo];
        /*Shas    
            result.leShas   = new int[edgeNo];
            result.riShas   = new int[edgeNo];
        Shas*/
            result.sweeps   = new int[edgeNo];
            int dedge = 0;
            for (int iedge = 0; iedge < edgeNo; iedge ++) { // increasing
                result.tipes [iedge] =   tipes [iedge];
                result.rotas [iedge] =   rotas [iedge];
                result.sweeps[iedge] =   sweeps[iedge];
                result.polys [iedge] =   polys [iedge];
                /*Shas    
                    result.riShas[iedge] =   polys [iedge];
                    result.leShas[iedge] =   polys [iedge];
                Shas*/
                dedge = normEdge(result, dedge - 1); // decreasing
            } // for iedge
            return result;
        } // getFlippedClone

    } // class VertexType

    //--------
    /**
     * Limits the index of an edge to the range 0..edgeNo - 1.
     * @param vtype VertexType
     * @param iedge number of edge, maybe negative
     * @return an edge number in the range 0..edgeNo - 1
     */
    public int normEdge(VertexType vtype, int iedge) {
        int result = iedge;
        while (result < 0) {
            result += vtype.edgeNo;
        } // while negative
        return result % vtype.edgeNo;
    } // normEdge

    //----------------------------------------------------------------

    /**
     * Class for an allocated vertex.
     */
    protected class Vertex implements Serializable { // numbered 1, 2, 3 ... ; 0 is not used
        int index; // in mVertices
        int iType; // 0, 1 reserved; even for clockwise, odd for counter-clockwise variant
        int distance; // length of shortest path to origin, for coloring
        int rotate; // the vertex type was rotated clockwise by so many degrees
        Position expos; // exact Position of the Vertex
        int fixedEdges; // number of allocated neighbours = edges
        int[] succs; // list of indices in successor vertices
    /*
        int[] shapes; // list of indices in left shapes
        int[] preds; // list of indices in predecessor vertices
    */
        int bedge; // temporary edge pointing backwards to the last focus of this successor

        /**
         * Empty constructor, only a placeholder in order to avoid vertex index 0
         */
        public Vertex() {
            this(0);
        } // Vertex()

        /**
         * Constructor with an index of a VertexType
         * @param itype index of type of the new vertex,
         * is even for clockwise, odd for clockwise orientation
         * @param ipred index of predecessor vertex which needs <em>this</em> new successor vertex
         * @param iedge which edge of the predecessor leads to <em>this</em> new successor vertex
         */
        public Vertex(int itype) {
            // setting 'index' is postponed to addVertex
            this.iType  = itype;
            distance   = 0;
            rotate     = 0;
            expos      = new Position();
            int edgeNo = iType == 0 ? 0 : getVertexType(iType).edgeNo;
            succs      = new int[edgeNo];
            Arrays.fill(succs , 0);
        /*
            shapes     = new int[edgeNo];
            preds      = new int[edgeNo];
            Arrays.fill(shapes, 0);
            Arrays.fill(preds , 0);
        */
        } // Vertex(int)

        /**
         * Gets the type of <em>this</em> Vertex
         * @return a {@link VertexType}
         */
        public VertexType getType() {
            return mVertexTypes[iType];
            // return getVertexType(iType);
        } // getType

        /**
         * Returns a JSON representation of the Vertex
         * @return JSON for all properties
         */
        public String toJSON() {
            pushIndent();
            String result
                    = "{ \"i\": "        + String.format("%4d", index)
                    + ", \"type\": "     + String.format("%2d", iType)
                    + ", \"rot\": "      + String.format("%3d", rotate)
                    + ", \"fix\": "      + fixedEdges
                    + ", \"succs\": \""  + join(",", succs ) + "\""
                //  + ", \"preds\": \""  + join(",", preds ) + "\""
                //  + ", \"shapes\": \"" + join(",", shapes) + "\""
                    + ", \"pos\": \""    + expos.toString()  + "\""
                    + ", \"dist\": \""   + distance + "\""
                    + " }\n";
            popIndent();
            return result;
        } // Vertex.toJSON

        /**
         * Returns a representation of the Vertex
         * @return JSON for edges
         */
        public String toString() {
            return index + getType().name + " @" + rotate + expos + "->" + join(",", succs).replaceAll("[\\[\\]]", "");
        } // Vertex.toString

        /**
         * Draws the edges of <em>this</em> rotated {@link #Vertex} with thin
         * lines for debugging purposes
         */
        public void showSVGVertex() {
           VertexType vtype = getType();
           for (int iedge = 0; iedge < vtype.edgeNo; iedge ++) {
               Vertex succ = this.getSuccessor(iedge);
               writeSVGEdge(this, succ, iedge, 2); // mode = test
           } // for iedge
           writeSVGVertex(this, 2); // mode = test
        } // showSVGVertex

        //--------
        /**
         * Gets the absolute angle where an edge of <em>this</em> {@link #Vertex}
         * (which is already rotated) is pointing to.
         * This is the only place where the orientation of the Vertex is relevant.
         * The orientation is implemented by a proper access to <em>sweeps</em>.
         * This method corresponds with {@link #getEdge}.
         * @param iedge number of the edge
         * @return degrees [0..360) where the edge points to,
         * relative to a right horizontal edge from (x,y)=(0,0) to (x,y)=(0,1),
         * turning clockwise := positive (downwards, because of SVG's y axis)
         */
        public int getAngle(int iedge) {
            VertexType vtype  = mVertexTypes[iType];
            int siType  = vtype.tipes[
                    vtype.isFlipped() ? normEdge(vtype, - iedge) : normEdge(vtype, + iedge)
                    ];
            if (vtype.isFlipped()) {
                siType ^= 1;
            }
            VertexType suType = mVertexTypes[siType];
            int sum       = rotate;
            int swFlipped = - vtype.sweeps[normEdge(vtype, - iedge)];
            int swNormal  =   vtype.sweeps[normEdge(vtype, + iedge)];
            boolean foFlip =  vtype.isFlipped();
            boolean suFlip = suType.isFlipped();
            if (foFlip) {
                if (suFlip) {
                    sum += - vtype.sweeps[normEdge(vtype, - iedge)];
                } else {
                    sum += - vtype.sweeps[normEdge(vtype, - iedge)];
                }

            } else {
                if (suFlip) {
                    sum += + vtype.sweeps[normEdge(vtype, + iedge)];
                } else {
                    sum += + vtype.sweeps[normEdge(vtype, + iedge)];
                }
            }
            sum = normAngle(sum);
            if (sDebug >= 2) {
                    System.out.println("#         getAngle(iedge " + iedge + ")." + index + vtype.name + "@" + rotate + expos
                            + ", suType " + suType.toString()
                            + " -> swNormal " + normAngle(swNormal) + ", swFlipped " + normAngle(swFlipped)
                            + ", focus.flipped " + vtype.isFlipped() + ", succ.flipped " + suType.isFlipped()
                            + ", sum " + sum);
            }
            return sum;
        } // getAngle

        /**
         * Gets the matching edge of <em>this</em> {@link Vertex} (which is already rotated)
         * for a given absolute angle, or -1 if no such edge was found
         * This method corresponds with {@link #getAngle}.
         * @param angle degrees 0..360 where the edge points to,
         * already inverted,
         * counted from (x,y)=(0,0) to (x,y)=(0,1), clockwise
         * @return iedge=0..edgeNo -1 if a fitting edge was found, or -1 otherwise
         */
        public int getEdge(int angle) {
            angle = normAngle(angle);
            VertexType vtype = mVertexTypes[iType];
            if (sDebug >= 3) {
                    System.out.println("#       try getEdge(angle " + angle + ")." + index + vtype.name + "@" + rotate + " ?");
            }
            int iedge = 0;
            boolean busy = true;
            while (busy && iedge < vtype.edgeNo) {
                int edgeAngle = getAngle(iedge);
                if (sDebug >= 3) {
                    System.out.println("#         compare " + edgeAngle + " with " + angle);
                }
                if (edgeAngle == angle) {
                    busy = false;
                } else { // angles still different
                    iedge ++;
                } // still different
            } // while +
            if (busy) {
                iedge = -1; // no matching angle found
            }
            if (sDebug >= 2) {
                if (iedge >= 0) {
                    System.out.println("#       getEdge(angle " + angle + ")." + index + vtype.name + "@" + rotate + expos
                            + " -> " + iedge + " -> "
                            + mVertexTypes[vtype.tipes[iedge]].name);
                } else {
                    System.out.println("# ** assertion 5: getEdge(angle " + angle + ")." + index + vtype.name + "@" + rotate + expos
                            + " -> " + iedge + " -> edge not found");
                }
            }
            return iedge;
        } // getEdge

        /**
         * Creates and returns a new successor {@link #Vertex} of <em>this</em> Vertex (which is already rotated).
         * @param iedge=0..edgeNo -1; the successor is at the end of this edge
         * @return successor Vertex which is properly rotated and linked back to <em>this</em>
         */
        public Vertex getSuccessor(int iedge) {
            VertexType vtype = mVertexTypes[iType]; // of the focus
            int siType  = vtype.tipes[vtype.isFlipped() 
                    ? normEdge(vtype, - iedge) 
                    : normEdge(vtype, + iedge)];
            if (vtype.isFlipped()) {
                siType ^= 1; // normal -> flipped or flipped -> normal
            }
            VertexType suType = mVertexTypes[siType];
            int suRota  = normAngle(vtype.rotas[vtype.isFlipped() 
                    ? normEdge(vtype, - iedge) 
                    : normEdge(vtype, + iedge)
                    ] * (vtype.isFlipped() ? -1 : +1));
            int fAngle  = getAngle(iedge); // points to the successor
            if (sDebug >= 2) {
                System.out.println("#     getSuccessor(iedge " + iedge + ")." + index + vtype.name + "@" + rotate + expos
                        + " start: siType " + siType + ", suRota " + suRota);
            }
            Vertex succ = new Vertex(siType); // create a new Vertex
            succ.expos  = expos.moveUnit(fAngle);
            succ.rotate = normAngle(rotate + suRota);
            int bangle  = normAngle(fAngle + 180); // points backwards to the focus
            succ.bedge  = succ.getEdge(bangle);
            if (sDebug >= 2) {
                System.out.println("#             got (iedge " + iedge + ")." + index + vtype.name + "@" + rotate + expos
                        + " -> " + succ.toString() + ", fAngle " + fAngle + ", bangle " + bangle + ", bedge " + bedge);
            }
            return succ;
        } // getSuccessor

    } // class Vertex
 
    //----------------------------------------------------------------

    /**
     * Creates a successor {@link Vertex} of the focus and connects the successor back to the focus
     * @param focus the Vertex which gets the new successor
     * @param iedge attach the successor at this edge of the focus
     * @param distance from the origin Vertex
     * @return index of new successor vertex, or 0 if attached to an existing vertex
     */
    public int attach(Vertex focus, int iedge, int distance) {
        int isucc = 0; // future result; assume that the successor already exists
        VertexType foType = mVertexTypes[focus.iType];
        if (focus.succs[iedge] == 0) { // determine successor
            Vertex succ = focus.getSuccessor(iedge);
            if (sDebug >= 2) {
                System.out.println("#--------\n# call attach(vertex " + focus.toString() + ", iedge " + iedge + ")");
                System.out.println("#     candidate successor is "
                        + succ.getType().name + "@" + succ.rotate + succ.expos + ", bedge " + succ.bedge);
            }
            int suEdge = succ.bedge;
            if (suEdge < 0) { // not found
            	if (mSVG) {
                    succ.showSVGVertex();
                }
                if (sDebug >= 1) {
                    System.out.println("# ** assertion 1 in attach(focus " + focus.index + foType.name + "\t, edge " + iedge
                            + "): no match in succ " + succ.toString());
                }
                if (mSVG) {
                    writeSVGEdge(focus, succ, iedge, 1);
                }
            } else { // matching angles
                int ioldv = findVertex(succ.expos); // does the successor Vertex already exist?
                if (ioldv < 0) { // not found
                    isucc = addVertex(succ);
                    focus.succs[iedge] = isucc; // set forward link
                } else { // old, successor Vertex already exist
                    // succ  = mVertices.get(ioldv);
                    focus.succs[iedge] = ioldv; // set forward link
                    isucc = 0; // do not enqueue it
                } // successor Vertex already exist
                if (succ.succs[suEdge] == 0) { // edge was not yet connected
                    succ.succs[suEdge] = focus.index; // set backward link
                } else if (succ.succs[suEdge] != focus.index) {
                    if (mSVG) {
                    	succ.showSVGVertex();
                    }
                    if (sDebug >= 1) {
                        System.out.println("# ** assertion 2 in attach(focus " + focus.toString()
                        + "\t, edge " + iedge + "): focus not in succ " + succ.toString()
                        + "[" + suEdge + "]=" + succ.succs[suEdge] + " <> " + focus.index);
                    }
                    succ.succs[suEdge] = focus.index;
                }
                if (sDebug >= 2) {
                    System.out.println("#   attached focus " + focus.toString()
                            + ", iedge "  + iedge
                            + " -> succ " + succ.toString()
                            + ", suEdge " + suEdge
                            );
                }
                if (mSVG) {
                    writeSVGEdge(focus, succ, distance, 0); // normal
                }
                mNumEdges ++;
            } // matching angles
            focus.fixedEdges ++;
        } else { // focus.succs[iedge] != 0 - ignore
            if (sDebug >= 2) {
                System.out.println("#   attach(" + focus.toString() + ", " + iedge
                        + "): ignore attached edge " + iedge + " -> " + focus.succs[iedge]);
            }
        }
        return isucc;
    } // attach

    private static final int MAX_ERROR = 2;

    /**
     * Computes the neighbourhood of the start vertex up to some distance
     * @param iBaseType index of the initial vertex type
     */
    public void computeNet(int iBaseType) {
        VertexType baseType = getVertexType(iBaseType);
        int errorCount = MAX_ERROR;
        LinkedList<Integer> queue = new LinkedList<Integer>();
        initializeTiling(0); // reset dynamic structures only
        String[] parts = baseType.sequence.split("\\,");
        int termNo = parts.length;
        int[] terms = new int[termNo];
        for (int iterm = 0; iterm < termNo; iterm ++) {
            try {
                terms[iterm] = Integer.parseInt(parts[iterm]);
            } catch (Exception exc) {
            }
        } // for iterm
        if (mMaxDistance == -1) {
            mMaxDistance = termNo - 1;
        }
        if (mASeqNo != null) {
            baseType.aSeqNo = mASeqNo;
        }
        if (mBFile) { // open b-file
            writeBFile("head " + baseType.aSeqNo);
        }
        if (sDebug >= 3) {
            System.out.println("# compute neighbours of vertex type " + iBaseType + " up to distance " + mMaxDistance);
            String result  = sIndent + "# \"ffVertexTypes\": " + ffVertexTypes  + "\n"
                                     + sIndent + ", \"mVertexTypes\":\n";
            String sep = "  , ";
            for (int ind = 0; ind < ffVertexTypes; ind ++) { // even (normal) and odds (flipped) versions
                result += sIndent + (ind == 0 ? "  [ " : sep) + getVertexType(ind).toJSON();
            } // for types
            result += sIndent + "  ]\n";
            System.err.println(result);
        }
        int distance = 0; // also index for terms
        queue.add(addVertex(iBaseType));
        int addedVertices = 1;
        StringBuffer coordSeq = new StringBuffer(256);
        coordSeq.append("1");
        if (mBFile) { // data line
            writeBFile(distance + " " + addedVertices);
        }
                
        distance ++;
        while (distance <= mMaxDistance) {
            addedVertices = 0;
            int levelPortion = queue.size();
            while (levelPortion > 0 && queue.size() > 0) { // queue not empty
                int ifocus = queue.poll();
                if (sDebug >= 2) {
                    System.out.println("# dequeue ifocus " + ifocus);
                }
                Vertex focus = mVertices.get(ifocus);
                focus.distance = distance;
                VertexType foType = mVertexTypes[focus.iType];
                for (int iedge = 0; iedge < foType.edgeNo; iedge ++) {
                    int isucc = attach(focus, iedge, distance);
                    if (isucc > 0) { // did not yet exist
                        addedVertices ++;
                        queue.add(isucc);
                        if (sDebug >= 2) {
                            System.out.println("# enqueue isucc " + isucc + ", attached to ifocus " + ifocus + " at edge " + iedge);
                        }
                    }
                } // for iedge
                levelPortion --;
            } // while portion not exhausted and queue not empty
            if (distance < terms.length && terms[distance] != addedVertices && errorCount > 0) {
                System.out.println("# ** assertion 6: " + baseType.aSeqNo + " " + baseType.galId
                        + ":\tdifference in terms[" + distance + "], expected " + terms[distance] + ", computed " +addedVertices);
                errorCount --;
            }
            coordSeq.append(',');
            coordSeq.append(String.valueOf(addedVertices));
            if (mBFile) { // data line
                writeBFile(distance + " " + addedVertices);
            }
            if (sDebug >= 2) {
                System.out.println("# distance " + distance + ": " + addedVertices + " vertices added\n");
            }
            distance ++;
        } // while distance
        int ffVertices = mVertices.size();
        if (positionSize() != ffVertices - 2) {
            if (sDebug >= 3) {
                System.out.println("# ** assertion 3 in tiling.toString: " + positionSize()
                        + " different positions, but " + (ffVertices - 2) + " vertices\n");
            }
        }
        if (sDebug >= 3) {
            System.out.println("# final net\n" + toJSON());
        }
        if (true) { // this is always output
            System.out.println(baseType.aSeqNo + "\ttiler\t0\t" + mVertexTypes[iBaseType].galId + "\t" + coordSeq.toString());
        }
        if (mBFile) { // close b-file
            writeBFile("tail");
        }
        if (errorCount == MAX_ERROR || mMaxDistance == termNo - 1) { // was -1
            System.err.println("# " + baseType.aSeqNo + " " + baseType.galId + ":\t" + termNo + " terms verified");
        }
        if (mSVG) {
            for (int ind = 2; ind < ffVertices; ind ++) { // ignore reserved [0..1]
                Vertex focus = mVertices.get(ind);
                writeSVGVertex(focus, 0);
            } // for vertices
        } // SVG
    } // computeNet

    //----------------------------------------------------------------

    /**
     * Adds an existing VertexType and creates and adds the flipped version
     * @param normalType the VertexType to be added
     * @return iType of the resulting, normal VertexType
     */
    public int addTypeVariants(VertexType normalType) {
        int result = ffVertexTypes;
        mVertexTypes[ffVertexTypes ++] = normalType;
        mVertexTypes[ffVertexTypes ++] = normalType.getFlippedClone();
        return result;
    } // addTypeVariants

    /**
     * Creates and adds a new VertexType from Galebach's parameters
     * together with the flipped version
     * @param aSeqNo OIES A-number of the sequence
     * @param galId Galebach's id "Gal.u.t.v"
     * @param vertexId clockwise dot-separated list of
     *     the polygones followed by the list of types and angles
     * @param taRotList clockwise semicolon-separated list of
     *     vertex type names and angles (and apostrophe if flipped)
     * @param sequence a list of initial terms of the coordination sequence
     * @return iType of the resulting VertexType
     */
    public int addTypeVariants(String aSeqNo, String galId, String vertexId, String taRotList, String sequence) {
        return addTypeVariants(new VertexType(aSeqNo, galId, vertexId, taRotList, sequence));
    } // addTypeVariants

    /**
     * Gets a VertexType
     * @param iType index of type, even for normal, odd for flipped variant
     * @return the corresponding VertexType with edges rotated clockwise in both versions
     */
    public static VertexType getVertexType(int iType) {
        return mVertexTypes[iType];
    } // getVertexType

    /**
     * Gets the number of allocated {@link VertexType} pairs
     * @return half of {@link #ffVertexTypes}
     * (normal and flipped version count as one)
     */
    public int numVertexTypes() {
        return ffVertexTypes >> 1; // half
    } // numVertexTypes

    /**
     * Initializes the dynamic data structures of <em>this</em> Tiling.
     * @param numTypes number of {@link VertexTypes},
     * or 0 if only the dynamic structures are to be cleared
     */
    public void initializeTiling(int numTypes) {
        if (numTypes > 0) { // full
            mVertexTypes  = new VertexType[(numTypes + 1) * 2]; // "+1": [0..1] are not used / reserved
            ffVertexTypes = 0;
            addTypeVariants(new VertexType()); // the reserved elements [0..1]
        } // full
        // clear the dynamic structures:
        sIndent  = "";
        mNumEdges = 1; // used for titles on SVG <line>s and for limitation of number of lines to be output
        mHashPosition = new HashMap<String, Integer>(1024); 
        // mTreePosition = new TreeMap<String, Integer>(); 
        mVertices = new ArrayList<Vertex>(256);
        addVertex(new Vertex()); // [0] is not used / reserved
        addVertex(new Vertex()); // [1] is not used / reserved
    } // initializeTiling

    /**
     * Creates and adds a new Vertex
     * @param itype index in {@link mVertexTypes}
     * @return index of added Vertex in {@link mVertices}
     */
    public int addVertex(int itype) {
        return addVertex(new Vertex(itype));
    } // addVertex

    /**
     * Adds a Vertex
     * @param itype index in {@link mVertexTypes}
     * @return index of added Vertex in {@link mVertices}
     */
    public int addVertex(Vertex vertex) {
        vertex.index = mVertices.size();
        mVertices.add(vertex);
        mHashPosition.put(vertex.expos.toString(), vertex.index);
        // mTreePosition.put(vertex.expos.toString(), vertex.index);
    /*
        if (sDebug >= 3) {
        	System.out.println("# assigned mTrHaPosition[" + vertex.expos.toString() + "] := " + vertex.index);
        }
    */
        return vertex.index;
    } // addVertex

    /**
     * Returns a JSON representation of the tiling
     * @return JSON for {@link #mVertexTypes} and {@link #mVertices}
     */
    public String toJSON() {
        // pushIndent();
        String result  = sIndent + "{ \"ffVertexTypes\": " + ffVertexTypes  + "\n"
                                     + sIndent + ", \"mVertexTypes\":\n";
        try {
            String sep = "  , ";
            for (int ind = 0; ind < ffVertexTypes; ind ++) { // even (normal) and odds (flipped) versions
                result += sIndent + (ind == 0 ? "  [ " : sep) + getVertexType(ind).toJSON();
            } // for types
            result += sIndent + "  ]\n";

            int ffVertices = mVertices.size();
            result += sIndent + ", \"ffVertices\": " + ffVertices + "\n" +  sIndent + ", \"mVertices\":\n";
            for (int ind = 0; ind < ffVertices; ind ++) {
                Vertex focus = mVertices.get(ind);
                result += sIndent + (ind == 0 ? "  [ " : sep) + focus.toJSON();
            } // for vertices
            result += sIndent + "  ]\n";

            result += sIndent + ", \"size\": " + positionSize() + ", \"mHashPosition\": \n";
            Iterator<String> piter = mHashPosition.keySet().iterator();
            while (piter.hasNext()) {
                String pos = piter.next();
                int ind = mHashPosition.get(pos).intValue();
                result += sIndent + (ind == 0 ? "  [ " : sep) + "{ \"pos\": \"" + pos + ", index: " + ind + " }\n";
            } // while piter
            result += sIndent + "  ]\n}\n";

        } catch(Exception exc) {
            // log.error(exc.getMessage(), exc);
            System.err.println("partial result: " + result);
            System.err.println(exc.getMessage());
            exc.printStackTrace();
        }
        // popIndent();
        return result;
    } // Tiler1.toJSON

    /**
     * Process one record from the file
     * @param line record to be processed
     */
    private void processRecord(String line) {
        // e.g. line = A265035 tab Gal.2.1.1 tab 3.4.6.4; 4.6.12 tab 12.6.4; A 180'; A 120'; B 90 tab 1,3,6,9,11,14,17,21,25,28,30,32,35,39,43,46,48,50,53,57,61,64,66,68,71,75,79,82,84,86,89,93,97,100,102,104,107,111,115,118,120,122,125,129,133,136,138,140,143,147
        String[] fields   = line.split("\\t");
        int ifield = 0;
        String aSeqNo     = fields[ifield ++];
        String galId      = fields[ifield ++];
        ifield ++; // skip standard notation
        String vertexId   = fields[ifield ++];
        String taRotList  = fields[ifield ++];
        String sequence   = fields[ifield ++];
        try {                                     //  0      1    2    3
            String[] gutv = galId.split("\\."); // "Gal", "2", "9", "1"
            if (gutv[3].equals("1")) { // first of new tiling
                initializeTiling(Integer.parseInt(gutv[1]));
            }
            addTypeVariants(aSeqNo, galId, vertexId, taRotList, sequence);
            if (gutv[3].equals(gutv[1])) { // last of new tiling
                if (sDebug >= 1) {
                    System.out.println(toJSON());
                }
                // compute the nets
                for (int ind = 2; ind < ffVertexTypes; ind += 2) {
                    if (mGalId == null || getVertexType(ind).galId.equals(mGalId)) { 
                        // either all in the input file, or only the specified mGalId
                        computeNet(ind);
                    }
                } // for itype
            }
        } catch(Exception exc) {
            // log.error(exc.getMessage(), exc);
            System.err.println(exc.getMessage());
            exc.printStackTrace();
        }
    } // processRecord

    /**
     * Reads a file and processes all input lines.
     * @param fileName name of the input file, or "-" for STDIN
     */
    private void processFile(String fileName) {
        BufferedReader lineReader; // Reader for the input file
        String line = null; // current line from text file
        try {
            if (fileName == null || fileName.length() <= 0 || fileName.equals("-")) {
                lineReader = new BufferedReader(new InputStreamReader(System.in, sEncoding));
            } else {
                ReadableByteChannel lineChannel = (new FileInputStream(fileName)).getChannel();
                lineReader = new BufferedReader(Channels.newReader(lineChannel , sEncoding));
            }
            while ((line = lineReader.readLine()) != null) { // read and process lines
                if (! line.matches("\\s*#.*")) { // is not a comment
                    if (sDebug >= 2) {
                        System.out.println(line); // repeat it unchanged
                    }
                    processRecord(line);
                } // is not a comment
            } // while ! eof
            lineReader.close();
        } catch (Exception exc) {
            // log.error(exc.getMessage(), exc);
            System.err.println(exc.getMessage());
            exc.printStackTrace();
        } // try
    } // processFile

    /**
     * Main method, filters a file, selects a VertexType group for a tiling,
     * dumps the progress of the tilings' generation and
     * possibly writes an SVG drawing file.
     * @param args command line arguments
     */
    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        Tiler1 tiler = new Tiler1();
        sDebug = 0;
        try {
            int iarg = 0;
            String fileName = "-"; // assume STDIN/STDOUT
            while (iarg < args.length) { // consume all arguments
                String opt        = args[iarg ++];
                if (false) {
                } else if (opt.equals("-a")     ) {
                    tiler.mASeqNo       = args[iarg ++];
                } else if (opt.equals("-bfile") ) {
                    tiler.mBFile = true;
                    tiler.mBFilePrefix  = args[iarg ++];
                } else if (opt.equals("-circle")) {
                    tiler.testCirclePositions();
                } else if (opt.equals("-dist")  ) {
                    tiler.mMaxDistance = Integer.parseInt(args[iarg ++]);
                } else if (opt.equals("-d")     ) {
                    sDebug          = Integer.parseInt(args[iarg ++]);
                } else if (opt.equals("-f")     ) {
                    tiler.processFile(args[iarg ++]);
                } else if (opt.equals("-id")    ) {
                    tiler.mGalId    = args[iarg ++];
                } else if (opt.equals("-n")     ) {
                    tiler.mNumTerms = Integer.parseInt(args[iarg ++]);
                } else if (opt.equals("-svg")   ) {
                    tiler.mSVG = true;
                    tiler.writeSVG("<x-head>" + args[iarg ++] + "</x-head>");
                } else {
                    System.err.println("??? invalid option: \"" + opt + "\"");
                }
            } // while args
            if (tiler.mSVG) {
                tiler.writeSVG("<x-tail />"); // also closes mSVGWriter
            }
        } catch (Exception exc) {
            // log.error(exc.getMessage(), exc);
            System.err.println(exc.getMessage());
            exc.printStackTrace();
        }
        System.err.println("# elapsed: " + String.valueOf(System.currentTimeMillis() - startTime) + " ms");
    } // main

} // Tiler1

