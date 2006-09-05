<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="shift_jis"/>

<xsl:template match="test">
<xsl:variable name="singleQuote"><xsl:text>'</xsl:text></xsl:variable>
  <html>
    <body>
      <a href="matlab:disp('{label}');">foo</a>
    </body>
  </html>
</xsl:template>

</xsl:stylesheet>

