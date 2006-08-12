<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:strip-space elements="*"/>
<xsl:variable name="foo">foo</xsl:variable>
<!-- this element tells the processor to strip the excess white space out of the results so that our output doesnt include all of the tabs and extra white space that tends to exist in the XML file -->
<xsl:template match="/html">
  <html>
    <head>
      <title><xsl:value-of select="head/title"/></title>
      <!-- you could also use <xsl:copy-of select="html/head/title"/> and accomplish the same thing.  its just a matter of preference and in some cases correct processor output but thats nothing to worry about here  -->
      <!-- if you had meta tags, and I know you do, given that there are multiple instance this would be where you put your first apply-templates with with head/meta-tags as the value of your select attribute -->
    </head>
    <body>
      <xsl:copy-of select="body/@*"/>
        <!-- and now we take the Result Tree Fragment contained within the body tag and begin to proces it with apply-templates -->
      <xsl:apply-templates select="body"/>
      <div style="visibility:hidden">
        <tr>
           <td>
             Total number: <xsl:value-of select="$foo"/>
           </td>
        </tr>
      </div>
    </body>
    
  </html>
</xsl:template>

<xsl:template match="h1 | p | b | i">
<!-- now heres where the funs starts.  -->
  <xsl:copy>
    <xsl:element name="name()">
    <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:copy>  
</xsl:template>
</xsl:stylesheet>