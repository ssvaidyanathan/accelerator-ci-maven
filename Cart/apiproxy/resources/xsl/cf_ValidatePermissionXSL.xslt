<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:param name="facadeproxybasepath"/>
    <xsl:param name="uripathdefinition"/>
    <xsl:param name="verb"/>
     <xsl:template match="/">
    <xsl:variable name="facadeproxybasepathvar" select="if (string-length($facadeproxybasepath) gt 0) then 
                                                           concat('/', ((tokenize($facadeproxybasepath, '/'))[2])) else ''"/>
     <xsl:variable name="uripathdefinitionvar1" select="concat($facadeproxybasepathvar, $uripathdefinition)"/>   
     <xsl:variable name="uripathdefinitionvar" select="if (ends-with($uripathdefinitionvar1, '/')) then substring($uripathdefinitionvar1, 1, (string-length($uripathdefinitionvar1) - 1)) else $uripathdefinitionvar1"/>        
     <xsl:variable name="urivar" select="replace(replace($uripathdefinitionvar, '\{[^}]*\}', 'pathId_'), '/', 'forwardSlash_')"/>   
     <xsl:choose>
            <xsl:when test="exists(//*:userEntitlements/*:userEntitlement[((if (starts-with(./*:resource, '/forwardSlash_')) then
          	substring-after(./*:resource, '/') else
          	if (starts-with(./*:resource, '/')) then
          	    concat('forwardSlash_', substring-after(./*:resource, '/')) else
          	    ./*:resource)
          	    = $urivar) and (./*:grantedActions/*:action/*:name = $verb)])">
                <xsl:value-of select="'true'"></xsl:value-of>  
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'false'"></xsl:value-of>
            </xsl:otherwise>
     </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
