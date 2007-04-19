<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:rss="http://purl.org/rss/1.0/" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:planet="http://xslt.googlecode.com/svn/trunk/Modules/WebFeed/FOAF-to-Planet.ini/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:variable name="lb" as="xs:string">
        <xsl:text>           
</xsl:text>
    </xsl:variable>
    <xsl:output name="text" method="text" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/">
        <xsl:result-document method="text"
            href="{resolve-uri(planet:planet/@output-file, planet:planet/@xml:base)}">
            <xsl:value-of select="concat('[Planet]', $lb)" />
            <xsl:apply-templates select="planet:planet/*" />
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="planet:source-files">
        <xsl:apply-templates select="document(planet:foaf/@src)/rdf:RDF/foaf:Group/foaf:member">
            <xsl:sort select="." />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="planet:*[@output-type = 'section']">
        <xsl:variable name="TODO">
            <xsl:text>#TODO: Create proper output syntax for children of DEFAULT element.  For now we won't do anything.</xsl:text>
        </xsl:variable>
        <xsl:value-of select="concat('[', local-name(), ']', $lb, $TODO, $lb)" />
    </xsl:template>

    <xsl:template match="planet:*">
        <xsl:variable name="output-name">
            <xsl:if test="not(*) and text()">
                <xsl:value-of select="local-name()" />
                <xsl:apply-templates select="text()" mode="append-value" />
            </xsl:if>
            <xsl:apply-templates select="*" mode="append-child">
                <xsl:with-param name="parent" select="local-name()" />
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:value-of select="$output-name" />
    </xsl:template>

    <xsl:template match="planet:*" mode="append-child">
        <xsl:param name="parent" />
        <xsl:value-of select="concat($parent, '_', local-name())" />
        <xsl:if test="last()">
            <xsl:apply-templates select="text()" mode="append-value" />
        </xsl:if>
    </xsl:template>

    <xsl:template match="text()" mode="append-value">
        <xsl:text> = </xsl:text>
        <xsl:value-of select="concat(., $lb)" />
    </xsl:template>

    <xsl:template match="foaf:member">
        <xsl:value-of
            select="concat(
                '[', 
                foaf:Agent[1]/foaf:weblog[1]/foaf:Document[1]/rdfs:seeAlso[1]/rss:channel[1]/@rdf:about, 
                ']', 
                $lb, 
                'name = ', 
                foaf:Agent/foaf:name, 
                $lb
            )"
         />
    </xsl:template>

</xsl:stylesheet>
