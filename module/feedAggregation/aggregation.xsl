<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom0="http://purl.org/atom/ns#" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:atom="http://www.w3.org/2005/Atom" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" 
    xmlns:admin="http://webns.net/mvcb/"
    xmlns:cc="http://web.resource.org/cc/" 
    xmlns:rss="http://purl.org/rss/1.0/"
    xmlns:date="http://xsltransformations.com/functions/date"
    xmlns:error="http://xsltransformations.com/errors/invalidDoc"
    xmlns:init="http://xsltransformations.com/webfeeds/feed-transform-init"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns="http://www.w3.org/2005/Atom"
    exclude-result-prefixes="#all">

    <xsl:import href="./formats/atom-0.3.xsl"/>
    <xsl:import href="./formats/atom.xsl"/>
    <xsl:import href="./formats/rss+rdf.xsl"/>
    <xsl:import href="./formats/rss.xsl"/>

    <xsl:import href="./formats/ext/dc.xsl"/>
    <xsl:import href="./formats/ext/sy.xsl"/>
    <xsl:import href="./formats/ext/cc.xsl"/>
    <xsl:import href="./formats/ext/admin.xsl"/>
    <xsl:import href="./formats/ext/date.xsl"/>

    <xsl:variable name="init" select="/init:feed-transform-init" />
    <xsl:variable name="base" select="$init/@xml:base"/>
    <xsl:variable name="default-header-data" select="document(resolve-uri($init/init:default-header-data/@file, $base))/atom:feed"/>
    <xsl:variable name="error-document" select="resolve-uri($init/init:error-document/@file, $base)"/>
    <xsl:variable name="result-document" 
        select="resolve-uri(
        if ($default-header-data/atom:link/@href) 
        then ($default-header-data/atom:link/@href )
        else $init/init:result-document/@file, $base
        )" />
    
    
    <xsl:strip-space elements="*"/>

    <xsl:output name="xml" method="xml" indent="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="init:feed-transform-init"/>
    </xsl:template>
    
    <xsl:template match="init:feed-transform-init">
        <xsl:variable name="processed-feed-data">
            <temp>
                <xsl:apply-templates select="init:file"/>
            </temp>
        </xsl:variable>
        <xsl:result-document format="xml" href="{$result-document}">
            <feed 
                xml:lang="{$default-header-data/@xml:lang}"
                xml:base="{$default-header-data/@xml:base}"
                >
                <xsl:apply-templates select="$default-header-data/*"/>
                <xsl:copy-of select="$processed-feed-data/atom:temp/atom:entry"/>
            </feed>
        </xsl:result-document>
        <xsl:result-document format="xml" href="{$error-document}">
            <document-errors xmlns="http://xsltransformations.com/webfeeds/document-errors">
                    <xsl:copy-of select="$processed-feed-data/atom:temp/atom:file-error"/>         
            </document-errors>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="init:file">
        <xsl:apply-templates select="document(@uri)/opml/body/outline"/>>
    </xsl:template>

    <xsl:template match="outline">
        <xsl:variable name="document">
            <xsl:copy-of select="document(@xmlUrl)"/>
        </xsl:variable>
        <xsl:variable name="processDocument">
            <xsl:choose>
                <xsl:when test="$document/*">
                    <xsl:copy-of select="$document"/>
                </xsl:when>
                <xsl:otherwise>
                    <error:doc  xmlns:error="http://xsltransformations.com/errors/invalidDoc">
                        <error:uri><xsl:value-of select="@xmlUrl"/></error:uri>
                    </error:doc>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:apply-templates select="$processDocument" mode="process"/>
    </xsl:template>

    <xsl:template match="*" mode="process">
        <xsl:variable name="temp-source">
                <xsl:apply-templates select="*[not(atom:entry|channel|rdf:channel|rss:channel|atom0:entry)]"/>
        </xsl:variable>
        <xsl:variable name="source">
            <source>
                <xsl:copy-of select="$temp-source/atom:id|atom:title|atom:updated|atom:rights"/>
            </source>
        </xsl:variable>
        <xsl:apply-templates select="atom:entry|channel|rdf:channel|rss:channel|atom0:entry">
            <xsl:with-param name="source" select="$source"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="error:doc" mode="process">
        <file-error><xsl:value-of select="error:uri"/></file-error>
    </xsl:template>
    
</xsl:transform>
