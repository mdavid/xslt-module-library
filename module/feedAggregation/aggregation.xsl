<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom0.3="http://purl.org/atom/ns#" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:atom="http://www.w3.org/2005/Atom" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
    xmlns:admin="http://webns.net/mvcb/"
    xmlns:cc="http://web.resource.org/cc/"
    xmlns:rss="http://purl.org/rss/1.0/"
    version="2.0">
    
    <xsl:output name="xml" method="xml"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="subscriptions" />    
    </xsl:template>
    <xsl:template match="subscriptions">
        <xsl:result-document format="xml" href="file:///{@saveResult}">
            <xsl:apply-templates select="feed" />    
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="feed">
        <xsl:apply-templates select="document(@uri)/*" /> 
    </xsl:template>
    
    <xsl:template match="atom:feed|rdf:RDF|rdf:rdf|rss|atom0.3:feed">
        <feed  xmlns="http://www.w3.org/2005/Atom" xml:lang="en">
            <xsl:copy-of select="*"/>
        </feed>
    </xsl:template>
</xsl:stylesheet>
