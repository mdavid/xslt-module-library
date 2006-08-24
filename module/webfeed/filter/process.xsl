<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" xmlns:filter="http://xsltransformations.com/webfeed/filter" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <xsl:result-document href="{resolve-uri(filter:filter/@output-file, filter:filter/@xml:base)}">
            <filterered-url-list>
                <xsl:apply-templates select="filter:filter/filter:key">
                    <xsl:with-param name="data" select="document(resolve-uri(filter:filter/@src, filter:filter/@xml:base))"/>
                </xsl:apply-templates>
            </filterered-url-list>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="filter:key">
        <xsl:param name="data"/>
        <xsl:variable name="filtered-data" select="$data/weblogUpdates/weblog[contains(@url, current()/@value)]"/>
        <key value="{@value}" count="{count($filtered-data)}">
            <xsl:apply-templates select="$filtered-data"/>
        </key>
    </xsl:template>
    <xsl:template match="weblog">
        <blog url="{@url}"/>
    </xsl:template>
</xsl:transform>
