<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:atom0="http://purl.org/atom/ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:lookup="http://xsltransformations.com/lookup/Atom"
    xmlns="http://www.w3.org/2005/Atom"
    exclude-result-prefixes="#all"
    >
    
    <xsl:template match="atom0:title">
        <title><xsl:value-of select="."/></title>
    </xsl:template>
    
    <xsl:template match="atom0:link">
        <link>
            <xsl:if test="@rel">
                <xsl:attribute name="rel"><xsl:value-of select="@rel"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@type">
                <xsl:attribute name="type"><xsl:value-of select="@rel"/></xsl:attribute>
            </xsl:if>
        </link>
    </xsl:template>
    
    <xsl:template match="atom0:tagline">
        <subtitle><xsl:value-of select="."/></subtitle>
    </xsl:template>
    
    <xsl:template match="atom0:modified">
        <updated><xsl:value-of select="."/></updated>
    </xsl:template>
    
    <xsl:template match="atom0:issued"/>

    <xsl:template match="atom0:created">
        <published><xsl:value-of select="."/></published>
    </xsl:template>
    
    <xsl:template match="atom0:id">
        <id><xsl:value-of select="."/></id>
    </xsl:template>
    
    <xsl:template match="atom0:summary">
        <summary><xsl:value-of select="."/></summary>
    </xsl:template>
    
    <xsl:template match="atom0:author">
        <author><xsl:apply-templates select="*"/></author>
    </xsl:template>
    
    <xsl:template match="atom0:name">
        <name><xsl:value-of select="."/></name>
    </xsl:template>
    
    <xsl:template match="atom0:url">
        <uri><xsl:value-of select="."/></uri>
    </xsl:template>
    
    <xsl:template match="atom0:email">
        <email><xsl:value-of select="."/></email>
    </xsl:template>
    
    <xsl:template match="atom0:copyright">
        <rights><xsl:value-of select="."/></rights>
    </xsl:template>
    
    <xsl:template match="atom0:generator">
        <generator>
            <xsl:if test="@version">
                <xsl:copy-of select="@version"/>
            </xsl:if>
            <xsl:if test="@url">
                <xsl:attribute name="uri"><xsl:value-of select="@url"/></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="."/>
        </generator>
    </xsl:template>
    
    <xsl:template match="atom0:entry">
        <xsl:param name="source"/>
        <entry>
            <xsl:copy-of select="$source"/>
            <xsl:apply-templates />
        </entry>
    </xsl:template>
    
    <xsl:template match="atom0:content">
        <content><xsl:value-of select="normalize-space(.)"/></content>
    </xsl:template>
    
    
</xsl:stylesheet>
