<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="aspectDef" select="document('aspectXML_definition.xml')"/>

    <xsl:strip-space elements="*"/>

    <xsl:key match="@name" name="distinctElement_pointcuts" use="."/>

    <xsl:output indent="yes" method="xml"/>

    <xsl:template match="/">
        <xsl:apply-templates mode="instance" select="root/*"/>
    </xsl:template>

    <xsl:template match="*" mode="instance">
        <xsl:element name="{name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="element" select="*"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*" mode="element">
        <xsl:variable name="name" select="local-name()"/>
        <xsl:variable name="pointcuts" select="$aspectDef/aspects/aspect/pointcut"/>
        <xsl:variable name="matchPointcut">
            <xsl:element name="element">
                <xsl:attribute name="name">
                    <xsl:value-of select="$name"/>
                </xsl:attribute>
                <xsl:attribute name="matchPointcut">
                    <xsl:value-of select="$pointcuts[unaryPointcutExpr/@pattern = $name]/@name"/>
                </xsl:attribute>
            </xsl:element>
            <xsl:apply-templates mode="matchAttributes" select="@*">
                <xsl:with-param name="pointcuts"
                    select="$pointcuts[unaryPointcutExpr[substring-before(@pattern, '/') = $name]]"
                />
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:apply-templates select="$aspectDef/aspects/aspect">
            <xsl:with-param name="matchedPointcut" select="$matchPointcut"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="@*" mode="matchAttributes">
        <xsl:param name="pointcuts"/>
        <xsl:variable name="name" select="local-name()"/>
        <xsl:variable name="matchPointcut"
            select="$pointcuts[substring-after(unaryPointcutExpr/@pattern, '@') = $name]"/>
        <xsl:element name="attribute">
            <xsl:attribute name="matchPointcut">
                <xsl:value-of select="$matchPointcut/@name"/>
            </xsl:attribute>
            <xsl:element name="name">
                <xsl:value-of select="$name"/>
            </xsl:element>
            <xsl:element name="value">
                <xsl:value-of select="."/>
            </xsl:element>
            <xsl:element name="operator">
                <xsl:value-of select="$matchPointcut/unaryPointcutExpr/@operator"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="aspect">
        <xsl:param name="matchedPointcut"/>
        <xsl:apply-templates select="adviceDefinition/elementAdvice">
            <xsl:with-param name="attributeAdvice" select="adviceDefinition/attributeAdvice"/>
            <xsl:with-param name="matchedPointcut" select="$matchedPointcut"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="elementAdvice[@type = 'before']">
        <xsl:param name="attributeAdvice"/>
        <xsl:param name="matchedPointcut"/>
        <xsl:variable name="name" select="@name"/>
        <xsl:variable name="reference" select="pointcut/namedPointcutExpr/@reference"/>
        <xsl:variable name="matchElementToReference"
            select="$matchedPointcut/element[@matchPointcut
            = $reference]/@name"/>
        <xsl:copy-of select="adviceContents/*"/>
        <xsl:element name="{$matchElementToReference}">
            <xsl:apply-templates select="$attributeAdvice[@name = $name]">
                <xsl:with-param name="matchedPointcutAttributes" select="$matchedPointcut/attribute"
                />
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="elementAdvice[@type = 'around']">
        <xsl:param name="attributeAdvice"/>
        <xsl:param name="matchedPointcut"/>
        <xsl:variable name="name" select="@name"/>
        <xsl:variable name="reference" select="pointcut/namedPointcutExpr/@reference"/>
        <xsl:variable name="matchElementToReference"
            select="$matchedPointcut/element[@matchPointcut
            = $reference]/@name"/>
        <xsl:apply-templates mode="aroundChildren" select="adviceContents/*">
            <xsl:with-param name="attributeAdvice" select="$attributeAdvice[@name = $name]"/>
            <xsl:with-param name="matchedPointcutAttributes" select="$matchedPointcut/attribute"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="*" mode="aroundChildren">
        <xsl:param name="attributeAdvice"/>
        <xsl:param name="matchedPointcutAttributes"/>
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="$attributeAdvice">
                <xsl:with-param name="matchedPointcutAttributes" select="$matchedPointcutAttributes"
                />
            </xsl:apply-templates>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="elementAdvice[@type = 'after']">
        <xsl:param name="attributeAdvice"/>
        <xsl:param name="matchedPointcut"/>
        <xsl:variable name="name" select="@name"/>
        <xsl:variable name="reference" select="pointcut/namedPointcutExpr/@reference"/>
        <xsl:variable name="matchElementToReference"
            select="$matchedPointcut/element[@matchPointcut
            = $reference]/@name"/>
        <xsl:element name="{$matchElementToReference}">
            <xsl:apply-templates select="$attributeAdvice[@name = $name]">
                <xsl:with-param name="matchedPointcutAttributes" select="$matchedPointcut/attribute"
                />
            </xsl:apply-templates>
        </xsl:element>
        <xsl:copy-of select="adviceContents/*"/>
    </xsl:template>
    
    <xsl:template match="attributeAdvice[@type = 'flow']">
        <xsl:param name="matchedPointcutAttributes"/>
        <xsl:variable name="reference" select="pointcut/namedPointcutExpr/@reference"/>
        <xsl:apply-templates
            select="attribute | $matchedPointcutAttributes[@matchPointcut =
            $reference]"
        />
    </xsl:template>
    
    <xsl:template match="attributeAdvice[@type = 'around']">
        <xsl:apply-templates select="attribute"/>
    </xsl:template>
    
    <xsl:template match="attribute">
        <xsl:attribute name="{name}">
            <xsl:value-of select="value"/>
        </xsl:attribute>
    </xsl:template>
    
</xsl:stylesheet>
