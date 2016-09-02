<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:v1="http://services.tmobile.com/CustomerManagement/FinancialAccountDetailsWSIL/V1"
    xmlns:base="http://services.tmobile.com/base">
    
    <xsl:template match="/"> 
        <xsl:param name="responseSubStatusCode" select="/soapenv:Envelope/soapenv:Body/v1:getFinancialAccountDetailsResponse/base:responseStatus/base:detail/@subStatusCode"/>
        <apiError>            
            <xsl:choose>
                <xsl:when test="$responseSubStatusCode='Customer-1001'">
                    <statusCode>
                        <xsl:value-of select="&quot;404&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Not Found&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:when test="$responseSubStatusCode='Customer-1002'">
                    <statusCode>
                        <xsl:value-of select="&quot;404&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Not Found&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:when test="$responseSubStatusCode='Customer-1004'">
                    <statusCode>
                        <xsl:value-of select="&quot;404&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Not Found&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:when test="$responseSubStatusCode='Customer-1005'">
                    <statusCode>
                        <xsl:value-of select="&quot;404&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Not Found&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:when test="$responseSubStatusCode='GENERAL-1001'">
                    <statusCode>
                        <xsl:value-of select="&quot;400&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Bad Request&quot;"/>
                    </reasonPhrase>
                </xsl:when>                
                <xsl:when test="$responseSubStatusCode='GENERAL-1002'">
                    <statusCode>
                        <xsl:value-of select="&quot;503&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Service unavailable&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:when test="$responseSubStatusCode='SYSTEM-1001'">
                    <statusCode>
                        <xsl:value-of select="&quot;500&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;System Error&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:when test="$responseSubStatusCode='SYSTEM-1002'">
                    <statusCode>
                        <xsl:value-of select="&quot;500&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;System Error&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:when test="$responseSubStatusCode='SYSTEM-1003'">
                    <statusCode>
                        <xsl:value-of select="&quot;503&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Service unavailable&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:when test="$responseSubStatusCode='SYSTEM-1005'">
                    <statusCode>
                        <xsl:value-of select="&quot;503&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Service unavailable&quot;"/>
                    </reasonPhrase>
                </xsl:when>
                <xsl:otherwise>
                    <statusCode>
                        <xsl:value-of select="&quot;503&quot;"/>
                    </statusCode>
                    <reasonPhrase>
                        <xsl:value-of select="&quot;Service unavailable&quot;"/>
                    </reasonPhrase>
                </xsl:otherwise>
            </xsl:choose>
            
            <errors>
                <xsl:choose>
                    <xsl:when test="$responseSubStatusCode='Customer-1001'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;Customer-1001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Customer account not found&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Customer account not found&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:when test="$responseSubStatusCode='Customer-1002'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;Customer-1002&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Customer MSISDN not found&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Customer MSISDN not found&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:when test="$responseSubStatusCode='Customer-1004'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;Customer-1004&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Customer line of service not found&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Customer line of service not found&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:when test="$responseSubStatusCode='Customer-1005'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;Customer-1005&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Customer not found&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Customer not found&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="$responseSubStatusCode='GENERAL-1001'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-1001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Invalid Request&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Invalid Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="$responseSubStatusCode='GENERAL-1002'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-1002&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Unknown backend error&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Unknown backend error&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="$responseSubStatusCode='SYSTEM-1001'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;SYSTEM-1001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Error occured while processing request&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Error occured while processing request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="$responseSubStatusCode='SYSTEM-1002'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;SYSTEM-1002&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Unknown System Error&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Unknown System Error&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="$responseSubStatusCode='SYSTEM-1003'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;SYSTEM-1003&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Backend Timeout&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Backend Timeout&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="$responseSubStatusCode='SYSTEM-1005'">                        
                        <error>
                            <code>
                                <xsl:value-of select="&quot;SYSTEM-1005&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Backend connection error&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Backend connection error&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:otherwise>
                        <error>
                            <code>
                                <xsl:value-of select="&quot;$responseSubStatusCode&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="/soapenv:Envelope/soapenv:Body/v1:getFinancialAccountDetailsResponse/base:responseStatus/base:detail/base:explanation/node()"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="/soapenv:Envelope/soapenv:Body/v1:getFinancialAccountDetailsResponse/base:responseStatus/base:detail/base:definition/node()"/>
                            </systemMessage>
                        </error>
                    </xsl:otherwise>
                </xsl:choose>
            </errors>
        </apiError>
    </xsl:template>
</xsl:stylesheet>