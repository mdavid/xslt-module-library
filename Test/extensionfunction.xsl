<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0" 
    xmlns:clitype="http://saxon.sf.net/clitype"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs">
    <xsl:template match="/">
        <xsl:variable name="arg" as="xs:double">2</xsl:variable>
      <hello-world>
        <output>
          <xsl:value-of select="math:Sqrt($arg)" xmlns:math="clitype:System.Math"/>
        </output>
      </hello-world>       
    </xsl:template>
</xsl:stylesheet>
