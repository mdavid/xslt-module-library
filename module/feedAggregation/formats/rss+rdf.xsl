<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:rss="http://purl.org/rss/1.0/"
    xmlns="http://www.w3.org/2005/Atom" 
    exclude-result-prefixes="#all"
    >
    <xsl:template match="rss:channel">
        <xsl:apply-templates select="item" />
    </xsl:template>
    
    <xsl:template match="rss:link">
        <link>
            <xsl:value-of select="."/>
        </link>
    </xsl:template>
    
    <xsl:template match="rss:title">
        <title><xsl:value-of select="."/></title>
    </xsl:template>
    
    <xsl:template match="rss:category">
        <category term="{.}" />
    </xsl:template>
    
    <xsl:template match="rss:lastBuildDate">
        <updated><xsl:value-of select="."/></updated>
    </xsl:template>
    
    <xsl:template match="rss:pubDate">
        <published><xsl:value-of select="."/></published>
    </xsl:template>
    
    <xsl:template match="rss:guid">
        <id><xsl:value-of select="."/></id>
    </xsl:template>
    
    <xsl:template match="rss:author">
        <author><xsl:apply-templates select="*"/></author>
    </xsl:template>
    
    <xsl:template match="rss:name">
        <name><xsl:value-of select="."/></name>
    </xsl:template>
    
    <xsl:template match="rss:uri">
        <uri><xsl:value-of select="."/></uri>
    </xsl:template>
    
    <xsl:template match="rss:email">
        <email><xsl:value-of select="."/></email>
    </xsl:template>
    
    <xsl:template match="rss:copyright">
        <rights><xsl:value-of select="."/></rights>
    </xsl:template>
    
    <xsl:template match="rss:generator">
        <generator>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="."/>
        </generator>
    </xsl:template>
    
    <xsl:template match="rss:item">
        <xsl:param name="source"/>
        <entry>
            <xsl:copy-of select="$source"/>
            <xsl:apply-templates />
        </entry>
    </xsl:template>
    
    <xsl:template match="rss:description">
        <content>
            <xsl:value-of select="normalize-space(.)"/>
        </content>
    </xsl:template>
    
    
    <xsl:template match="rss:docs"/>
    
    <xsl:template match="rss:cloud"/>
</xsl:stylesheet>
