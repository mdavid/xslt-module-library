<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="ArrayOfAttendance">
  <xsl:apply-templates select="Attendance"/>
</xsl:template>
<xsl:template match="Attendance">
  Last Name: <xsl:value-of select="LastName"/> Generated ID:<xsl:value-of select="generate-id(LastName)"/><br/>
  First Name: <xsl:value-of select="FirstName"/> Generated ID:<xsl:value-of select="generate-id(FirstName)"/><br/>
</xsl:template>
</xsl:stylesheet>

      

