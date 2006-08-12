<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:atom="http://www.w3.org/2005/Atom"  
    xmlns="http://www.w3.org/2005/Atom" 
    exclude-result-prefixes="#all"
    >
    <xsl:template match="atom:title">
        <title><xsl:value-of select="."/></title>
    </xsl:template>
    
    <xsl:template match="atom:link">
        <link>
            <xsl:copy-of select="@*"/>
        </link>
    </xsl:template>
    
    <xsl:template match="atom:subtitle">
        <subtitle><xsl:value-of select="."/></subtitle>
    </xsl:template>
    
    <xsl:template match="atom:category">
        <category>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="."/>
        </category>
    </xsl:template>
    
    <xsl:template match="atom:updated">
        <updated><xsl:value-of select="."/></updated>
    </xsl:template>
    
    <xsl:template match="atom:published">
        <published><xsl:value-of select="."/></published>
    </xsl:template>
    
    <xsl:template match="atom:id">
        <id><xsl:value-of select="."/></id>
    </xsl:template>
    
    <xsl:template match="atom:summary">
        <summary><xsl:value-of select="."/></summary>
    </xsl:template>
    
    <xsl:template match="atom:author">
        <author><xsl:apply-templates select="*"/></author>
    </xsl:template>
    
    <xsl:template match="atom:name">
        <name><xsl:value-of select="."/></name>
    </xsl:template>
    
    <xsl:template match="atom:uri">
        <uri><xsl:value-of select="."/></uri>
    </xsl:template>
    
    <xsl:template match="atom:email">
        <email><xsl:value-of select="."/></email>
    </xsl:template>
    
    <xsl:template match="atom:rights">
        <rights><xsl:value-of select="."/></rights>
    </xsl:template>
    
    <xsl:template match="atom:generator">
        <generator>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="."/>
        </generator>
    </xsl:template>
    
    <xsl:template match="atom:entry">
        <entry>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates />
        </entry>
    </xsl:template>
    
    <xsl:template match="atom:content">
        <content>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="normalize-space(.)"/>
        </content>
    </xsl:template>
</xsl:stylesheet>
