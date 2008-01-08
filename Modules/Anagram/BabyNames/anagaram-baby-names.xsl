<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://fxsl.sf.net/" xmlns:func="http://xameleon.org/function">

    <xsl:import href="./f/func-qsort.xsl" />
    <xsl:import href="./f/func-standardXSLTXpathFunctions.xsl" />

    <xsl:variable name="boyNames" as="xs:string*" select="tokenize(unparsed-text('./dist.male.first'), '\n')" />
    <xsl:variable name="girlNames" as="xs:string*" select="tokenize(unparsed-text('./dist.female.first'),'\n')" />

    <xsl:variable name="boynames">
        <names type="male">
            <xsl:for-each select="for $line in $boyNames return substring-before($line, ' ')">
                <name>
                    <xsl:value-of select="." />
                </name>
            </xsl:for-each>
        </names>
    </xsl:variable>

    <xsl:variable name="girlnames">
        <names type="female">
            <xsl:for-each select="for $line in $girlNames return substring-before($line, ' ')">
                <name>
                    <xsl:value-of select="." />
                </name>
            </xsl:for-each>
        </names>
    </xsl:variable>

    <xsl:variable name="anagrams">
        <anagrams>
            <xsl:for-each-group select="$boynames//name|$girlnames//name"
                group-by="codepoints-to-string(f:xsltSort(string-to-codepoints(.), 
                (f:_auxInt2Str()) 
                ) 
                )">
                <xsl:sort select="current-grouping-key()" />

                <xsl:if test="current-group()[2]">
                    <aChain key="{current-grouping-key()}">
                        <xsl:sequence select="current-group()" />
                    </aChain>
                    <xsl:sequence select="'&#xA;'" />
                </xsl:if>
            </xsl:for-each-group>
        </anagrams>
    </xsl:variable>

    <xsl:variable name="vZeroes" select="'000000000000'" as="xs:string" />

    <xsl:key name="kAngrmChain" match="aChain" use="@key" />

    <xsl:template match="/">
        <xsl:value-of select="concat('There are ', count($boyNames), ' boy names.&#xA;')" />
        <xsl:value-of select="concat('There are ', count($girlNames), ' girls names.&#xA;')" />
        <xsl:value-of
            select="concat('There are ', count($boyNames) + count($girlNames), ' total names resulting in ', count($anagrams//aChain), ' matching mixed sex combinations.&#xA;')" />
        <xsl:text>The name combinations are as follows,&#xA;</xsl:text>
        <xsl:apply-templates select="$anagrams//aChain" />
    </xsl:template>

    <xsl:template match="aChain">
        <xsl:if test="not(normalize-space(@key) = '')">
            <xsl:value-of select="concat('Key: ', @key, ' Names: ')" />
            <xsl:value-of select="for $name in name return concat($name/text(), ' ')" />
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:function name="f:anagrams" as="xs:string">
        <xsl:param name="pWord" as="xs:string" />
        <xsl:param name="pContext" as="node()" />
        <xsl:sequence select="key('kAngrmChain',f:anagramKey($pWord),$pContext)" />
    </xsl:function>

    <xsl:function name="f:anagramKey" as="xs:string">
        <xsl:param name="pWord" as="xs:string" />

        <xsl:sequence select="codepoints-to-string(f:qsort(string-to-codepoints($pWord)))" />
    </xsl:function>

    <xsl:function name="f:_auxInt2Str" as="xs:string">
        <xsl:param name="arg1" as="xs:integer" />

        <xsl:variable name="vstrParm" as="xs:string" select="xs:string($arg1)" />

        <xsl:sequence
            select="concat(substring($vZeroes,1, 
            10 - string-length($vstrParm) 
            ), 
            $vstrParm 
            )"
         />
    </xsl:function>

    <xsl:function name="f:_auxInt2Str" as="element()">
        <f:_auxInt2Str />
    </xsl:function>

    <xsl:template match="f:_auxInt2Str" as="xs:string" mode="f:FXSL">
        <xsl:param name="arg1" as="xs:integer" />
        <xsl:sequence select="f:_auxInt2Str($arg1)" />
    </xsl:template>
</xsl:stylesheet>
