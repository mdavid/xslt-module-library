<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns="http://www.w3.org/2005/Atom" 
    exclude-result-prefixes="#all"
    >
    <xsl:template match="dc:subject">
        <category term="{.}" />
    </xsl:template>
    
</xsl:transform>
