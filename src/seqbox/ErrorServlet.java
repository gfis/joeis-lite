package seqbox;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * ErrorServlet handles severe (5xx) and other Http errors.
 * Cf. http://www.jvmhost.com/articles/custom-error-pages-handlers-tomcat-cpanel
 * @author Georg Fischer
 */
public class ErrorServlet extends HttpServlet {
    public final static long serialVersionUID = 19470629;

    /**
     * Process an http GET request.
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException if an IO error occurs
     */
    public void doGet(final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        generateResponse(request, response);
    } // doGet

    /**
     * Process an http POST request.
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException if an IO error occurs
     */
    public void doPost(final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        generateResponse(request, response);
    } // doPost

    /**
     * Generate the response (HTML page) for an http request.
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException if an IO error occurs
     */
    public void generateResponse(final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        Integer     errorCode   = (Integer)   request.getAttribute("javax.servlet.error.status_code");
        Throwable   throwable   = (Throwable) request.getAttribute("javax.servlet.error.exception");
        String      servletName = (String)    request.getAttribute("javax.servlet.error.servlet_name");
        String      requestUri  = (String)    request.getAttribute("javax.servlet.error.request_uri");
        if (servletName == null) {
            servletName = "unknown";
        }
        if (requestUri == null) {
            requestUri = "unknown";
        }

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        out.write("\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n");
        out.write("    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n");
        out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\">\n");
        out.write("<head>\n");
        out.write("<meta http-equiv=\"Content-Type\" content=\"application/xhtml+xml;charset=UTF-8\" />\n");
        out.write("<meta name=\"robots\" content=\"noindex, nofollow\" />\n");
        out.write("<link rel=\"stylesheet\" title=\"common\" type=\"text/css\" href=\"stylesheet.css\" />\n");
        out.write("<title>Exception or Error</title>");
        out.write("</head><body>");

        if (errorCode != 500) { // not Exception
            out.write("<h3>Server Error " + errorCode + "</h3>");
        } else {
            out.write("<h3>Exception in " + servletName + "</h3>");
            out.println("<pre>");
            StringWriter stringWriter = new StringWriter();
            PrintWriter  printWriter  = new PrintWriter(stringWriter);
            throwable.printStackTrace(printWriter);
            String buffer = stringWriter.toString();
            printWriter.close();
            stringWriter.close();
            int restPos = buffer.indexOf("at javax.servlet.http.HttpServlet.service");
            if (restPos >= 0) {
                buffer = buffer.substring(0, restPos) + "...";
            }
            out.println(buffer);
            out.println("</pre>");
        } // exception
        out.println("</body></html>");
    } // generateResponse
}
