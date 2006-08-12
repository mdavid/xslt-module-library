<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom0="http://purl.org/atom/ns#" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:atom="http://www.w3.org/2005/Atom" 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
    xmlns:admin="http://webns.net/mvcb/"
    xmlns:cc="http://web.resource.org/cc/"
    xmlns:rss="http://purl.org/rss/1.0/"
    xmlns="http://www.w3.org/2005/Atom"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <xsl:import href="./formats/atom-0.3.xsl"/>
    <xsl:import href="./formats/atom.xsl"/>
    <xsl:import href="./formats/rss+rdf.xsl"/>
    <xsl:import href="./formats/rss.xsl"/>
    
    <xsl:import href="./formats/ext/dc.xsl"/>
    <xsl:import href="./formats/ext/sy.xsl"/>
    <xsl:import href="./formats/ext/cc.xsl"/>
    <xsl:import href="./formats/ext/admin.xsl"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:output name="xml" method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="subscriptions" />    
    </xsl:template>
    
    <xsl:template match="subscriptions">
        <xsl:result-document format="xml" href="file:///{@saveResult}">
            <feed  xml:lang="en">
                <title>XSLT:Blog[@author = 'M. David Peterson']/Main</title>
                <link rel="self"  type="application/atom+xml" href="http://xslt.googlecode.com/svn/trunk/module/feedAggregation/output.xml"/>
                <updated>2006-03-31T13:40:38Z</updated>
                <subtitle>An XSLT community news, commentary, code samples, and evangelism weblog developed, hosted, maintained, and edited by M. David Peterson and sponsored in full by FunctionalX Consulting.</subtitle>
                <id>tag:www.xsltblog.com,2006://1</id>
                <generator version="0.1" uri="http://www.xameleon.org">Xameleon</generator>
                <rights>Copyright (c) 2006, m.david</rights>
                <xsl:apply-templates select="feed" />    
            </feed>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="feed">   
            <xsl:apply-templates select="document(@uri)/*" /> 
    </xsl:template>
    
    <xsl:template match="atom:feed|rdf:RDF|rdf:rdf|rss|rss:rss|atom0:feed">
            <xsl:apply-templates select="atom:entry|channel|rdf:channel|rss:channel|atom0:entry"/>
    </xsl:template>
    
</xsl:transform>
