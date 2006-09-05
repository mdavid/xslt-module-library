<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://xsltransformations.com/functions/date">
    <xsl:template match="date:output">
        <xsl:if test="@current = 'yes'">
            <xsl:value-of select="format-dateTime(current-dateTime(), @format)"/>
        </xsl:if>
    </xsl:template>
</xsl:transform>
