<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:rss="http://purl.org/rss/1.0/" xmlns:dc="http://purl.org/dc/elements/1.1/">

    <xsl:output method="text" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/">
        <xsl:apply-templates select="//foaf:member">
            <xsl:sort select="." />
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="foaf:member">
        <xsl:text>[</xsl:text>
        <xsl:value-of
            select="foaf:Agent[1]/foaf:weblog[1]/foaf:Document[1]/rdfs:seeAlso[1]/rss:channel[1]/@rdf:about" />
        <xsl:text>]</xsl:text>
        <xsl:text>
</xsl:text>
        <xsl:text>name = </xsl:text>
        <xsl:value-of select="foaf:Agent/foaf:name" />
        <xsl:text>
            
</xsl:text>
    </xsl:template>

</xsl:stylesheet>
