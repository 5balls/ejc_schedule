<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">

<xsl:output method="text"/>

<xsl:template match="/">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="div[@class='elementor-text-editor elementor-clearfix']/p">
<xsl:if test="contains(preceding::h2[1],'August')">
<xsl:value-of select="preceding::h2[1]"/>| <xsl:value-of select="."/><xsl:text>&#xa;</xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>

