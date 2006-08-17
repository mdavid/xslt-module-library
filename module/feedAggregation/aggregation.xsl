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

    <xsl:variable name="default-header-data" select="document('./default-header-data.xml')/atom:feed"/>

    <xsl:strip-space elements="*"/>

    <xsl:output name="xml" method="xml" indent="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="subscriptions"/>
    </xsl:template>

    <xsl:template match="subscriptions">
        <xsl:result-document format="xml" href="file:///{concat(@saveResultBase, $default-header-data/atom:link/@href)}">
            <feed 
                xml:lang="{$default-header-data/@xml:lang}"
                xml:base="{$default-header-data/@xml:base}"
                >
                <xsl:apply-templates select="$default-header-data/*"/>
                <xsl:apply-templates select="feed"/>
            </feed>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="feed">
        <xsl:apply-templates select="document(@uri)/*" mode="init"/>
    </xsl:template>

    <xsl:template match="*" mode="init">
        <xsl:apply-templates select="atom:entry|channel|rdf:channel|rss:channel|atom0:entry"/>
    </xsl:template>

</xsl:transform>
