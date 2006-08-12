<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2005/Atom" version="2.0">
    <xsl:template match="feed">
        <feed  xml:lang="en">
            <xsl:apply-templates select="*"/>
        </feed>
    </xsl:template>
</xsl:transform>
