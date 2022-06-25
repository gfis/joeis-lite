package seqbox;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.TreeSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 
 * This class prints metadata for the application:
 * <ul>
 * <li>License,</li>
 * <li>JAR Manifest</li>
 * <li>Notices for included software packages</li>
 * </ul>
 * The relevant information is read from the JAR or WAR file.
 * From the MANIFEST, a version String may be extracted if that
 * file follows the conventions of teherba.org's build-import.xml for ant.
 * @author Georg Fischer
 */
public class MetaInfPage {
    public final static long serialVersionUID = 19470629;

    /** 
     * Empty constructor
     */
    public MetaInfPage() {
    } // Constructor()

    /** 
     * Show meta information for the application.
     * The manifest and other files are read from the JAR file.
     * @param request request with header fields
     * @param response response with writer
     * @param basePage refers to common web methods and messages
     * @param language 2-letter code en, de etc.
     * @param view denotes the particular subpage:
     * <ul>
     * <li>license </li>
     * <li>manifest</li>
     * <li>notice  </li>
     * <li>package (not used)</li>
     * <li>root    (not used)</li>
     * </ul>
     * @param callingServlet the HttpServlet instance calling this method,
     * for the determination of the proper ClassLoader
     * @throws IOException if an IO error occurs
     */
    public void showMetaInf(final HttpServletRequest request, final HttpServletResponse response
            , final BasePage basePage, final String language, String view, final HttpServlet callingServlet
            ) throws IOException {
        PrintWriter out = basePage.writeHeader(request, response, language);
        out.write("<title>" + basePage.getAppName() + " " + view + "</title>\n");
        out.write("</head>\n<body>\n");
        out.write("<!-- language=\"" + language + "\", view=\"" + view + "\" -->\n");
        String resourceName = null;
        if (view == null) {
            view = "manifest";
        }
        if (view.equals("package")) {
            // Package [] packs = this.getClass().getClassLoader().getPackages();
            out.write("<a name=\"package\" />\n<h3>Available Java Packages</h3>\n");
            Package [] packs = Package.getPackages();
            TreeSet<String> packNames = new TreeSet<String>();
            int ipack = 0;
            while (ipack < packs.length) {
                packNames.add(packs[ipack].getName());
                ipack ++;
            } // while ipack
            out.write("<tt>\n<pre>\n");
            Iterator<String> piter = packNames.iterator();
            while (piter.hasNext()) {
                String packName = piter.next();
                if (packName.startsWith("org.teherba.")) {
                    out.println("<strong>" + packName + "</strong>");
                } else {
                    out.println(packName);
                }
            } // while piter
            out.write("</pre>\n</tt>\n");
        } else { // read from a resource in the JAR file
            out.write("<h3>" + basePage.getAuxiliaryLink(language, view) + "</h3>\n");
            if (false) {
            } else if (view.equals("license")) {
                resourceName = "LICENSE.txt";
            } else if (view.equals("notice")) {
                resourceName = "NOTICE.txt";
            } else { // if (view.equals("manifest")) {
                resourceName = "META-INF/MANIFEST.MF";
            }
            out.write("<!-- appName=\"" + basePage.getAppName() + "\", resource=\"" + resourceName + "\" -->\n");
            URL url = getMyResourceURL(callingServlet, basePage.getAppName(), resourceName);
            out.write("<pre>\n");
            if (url != null) { // resource found
                BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
                String line = null;
                while ((line = reader.readLine()) != null) {
                    out.println(line);
                } // while
            } // url != null
            out.write("</pre>\n");
        } // not "package"

        basePage.writeTrailer(language, "back,quest");
    } // showMetaInf

    /** 
     * Get the URL of the proper resource for this application from the ClassLoader.
     * This is tricky because the resource may occur several times with the same name,
     * therefore all URLs in the Enumeration
     * obtained by ClassLoader.getResources must be examined.
     * See <a href="http://stackoverflow.com/questions/5193786/how-to-use-classloader-getresources-correctly">stackoverflow.com</a>.
     * @param localObject any object which is loaded with the relevant MANIFEST.MF
     * @param appName the applications base name (all lowercase, for example "common", "dbat" ...)
     * @param resourceName name of the resource file in the container JAR/WAR,
     * for example <em>"META-INF/MANIFEST.MF"</em>
     * @throws IOException if an IO error occurs
     * @return URL if the application was found, or <em>null</em> otherwise
     */
    private URL getMyResourceURL(final Object localObject, String appName, final String resourceName) throws IOException {
        URL result = null;
        appName = appName.toLowerCase();
        if (true) { // try {
            ClassLoader cloader = localObject.getClass().getClassLoader();
            Enumeration<URL> resEnum = cloader.getResources(resourceName);
            boolean busy = true;
            while (busy && resEnum.hasMoreElements()) {
                URL url = resEnum.nextElement();
                String urlst = url.toString();
                // log.info(urlst);
                if (    urlst.indexOf(appName + ".jar!/")            >= 0 ||
                        urlst.indexOf(appName + "/WEB-INF/classes/") >= 0) {
                    busy = false;
                    result = url;
                } else { // ignore appl-core.jar
                }
                // System.err.println("urlst=" + urlst + " ? \"" + appName + "\" = " + String.valueOf(! busy));
            } // while resEnum
        }
        return result;
    } // getMyResourceURL

    /** 
     * Gets the program's version.
     * The version string is built up from fields read out of the META-INF/MANAFEST.MF resource
     * in the JAR or WAR file which contains <em>this</em> class.
     * @param localObject any object which is loaded with the relevant MANIFEST.MF
     * @param appName the applications base name (all lowercase, for example "common", "dbat" ...)
     * @throws IOException if an IO error occurs
     * @return a String of the form "Vm.hhhh/yyyy-mm-dd",
     * where m is the major version,
     * and hhhh is the build number padded with zeroes or truncated to 4 digits
     */
    public String getVersionString(final Object localObject, final String appName) throws IOException {
        String result = "V";
        if (true) { // try {
            /* unzip -p dist/dbat.jar      META-INF/MANIFEST.MF shows:
Manifest-Version: 1.0
Ant-Version: Apache Ant 1.9.6
Created-By: 1.8.0_91-8u91-b14-3ubuntu1~16.04.1-b14 (Oracle Corporation
 )
Built-By: gfis
Main-Class: org.teherba.dbat.Dbat

Name: dbat
Specification-Title: dbat
Specification-Version: 10 for JDK 1.6
Specification-Vendor: Dr. Georg Fischer, D-79341 Kenzingen, Germany
Implementation-Title: teherba.org/dbat
Implementation-Version: 24 2016-09-16 13.51.24
Implementation-Vendor: www.teherba.org
           */
            URL url = getMyResourceURL(localObject, appName, "META-INF/MANIFEST.MF");
            if (url != null) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
                String line = null;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\s+");
                    if (false) {
                    } else if (line.startsWith("Specification-Version:" )) {
                        if (parts.length >= 2) {
                            result += parts[1];
                        } else {
                            result += "10";
                        }
                    } else if (line.startsWith("Implementation-Version:")) {
                        if (parts.length >= 4) {
                            String buildNo = parts[1].replaceAll("\\.", "");
                            if (false) { // force buildNo to 4 digits
                            } else if (buildNo.length() > 4) {
                                buildNo = buildNo.substring(buildNo.length() - 4);
                            } else if (buildNo.length() < 4) {
                                buildNo = ("0000".substring(buildNo.length())) + buildNo;
                            }
                            result += "." + buildNo + "/" + parts[2];
                        } // >= 4 parts
                    } // Implementation-Version
                } // while reading lines from MANIFEST.MF
            } else { // did not find my resource
                result = "V00.0000/0000-00-00"; // indicates failure
            } // while resEnum
        }
        return result;
    }
}
