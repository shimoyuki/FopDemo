<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">

	<!-- 根元素 -->
	<xsl:template match="/">
		<xsl:apply-templates select="ItemListReport" />
	</xsl:template>

	<!--主模板// -->
	<xsl:template match="ItemListReport">
		<xsl:processing-instruction name="cocoon-format">
			type="text/xslfo"
		</xsl:processing-instruction>
		<!--在此可以定义一些全局的风格信息，如字体等 -->
		<fo:root font-family="SimSun" xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!--版面定义// -->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="first">
					<!--主体// -->
					<fo:region-body margin="1cm" margin-top="2cm" />
					<!--页眉// -->
					<fo:region-before region-name="header-first"
						extent="1cm" />
					<!--页脚// -->
					<fo:region-after extent="1cm" />
				</fo:simple-page-master>
				<fo:simple-page-master master-name="rest">
					<!--主体// -->
					<fo:region-body margin="1cm" />
					<!--页眉// -->
					<fo:region-before region-name="header-rest"
						extent="1cm" />
					<!--页脚// -->
					<fo:region-after extent="1cm" />
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference
							page-position="first" master-reference="first" />
						<fo:conditional-page-master-reference
							page-position="rest" master-reference="rest" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="document">
				<!--首页页眉显示内容 -->
				<fo:static-content flow-name="header-first">
					<fo:block width="760px" margin-top="20px" margin-bottom="20px"
						height="30px" margin-left="12px" font-size="16px" color="#434344">
						<xsl:text>第</xsl:text>
						<fo:inline border-bottom-width="1px"
							border-bottom-style="solid" border-bottom-color="black" color="white">
							<xsl:text>··</xsl:text>
						</fo:inline>
						<xsl:text>次询问  </xsl:text>
					</fo:block>
				</fo:static-content>
				<!--页眉显示内容 -->
				<fo:static-content flow-name="header-rest">
					<fo:block>
					</fo:block>
				</fo:static-content>

				<!--页脚显示内容 -->
				<fo:static-content flow-name="xsl-region-after">
					<fo:block line-height="10px" font-size="10px" text-align="center">
						第
						<fo:page-number />
						/
						<fo:page-number-citation ref-id="endofdoc" />
						页
					</fo:block>
				</fo:static-content>

				<!--页面主体内容 -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<!--报表头 -->
						<xsl:apply-templates select="NoteHeader" />
						<!--报表体(若有多个部分内容，参照下面一行重复) -->
						<xsl:apply-templates select="NoteBody" />
						<!--报表尾 -->
						<xsl:apply-templates select="ReportFooter" />
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!--报表第一页// -->
	<xsl:template match="NoteBody">
		<fo:block width="760px" height="30px" margin-left="12px"
			font-size="15px" font-weight="bold" color="#434344" text-align="center">
			<xsl:text>询 问 笔 录</xsl:text>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>询问时间</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="35px" padding-right="35px">
				<xsl:value-of select="StartTime" />
			</fo:inline>
			<xsl:text>至</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="35px" padding-right="35px">
				<xsl:value-of select="EndTime" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>询问地点</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="100px" padding-right="100px">
				<xsl:value-of select="Position" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>询问人（签名）</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="10px" padding-right="10px">
				<xsl:value-of select="Enquire" />
			</fo:inline>
			<xsl:text>工作单位</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="20px" padding-right="20px">
				<xsl:value-of select="EnquireSpace" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>记录人（签名）</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="10px" padding-right="10px">
				<xsl:value-of select="Record" />
			</fo:inline>
			<xsl:text>工作单位</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="20px" padding-right="20px">
				<xsl:value-of select="RecordSpace" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>被询问人</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="30px" padding-right="30px">
				<xsl:value-of select="Enquired" />
			</fo:inline>
			<xsl:text>性别</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="20px" padding-right="20px">
				<xsl:value-of select="Gender" />
			</fo:inline>
			<xsl:text>出生日期</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="55px" padding-right="55px">
				<xsl:value-of select="Birthday" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>户籍所在地</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="93px" padding-right="93px">
				<xsl:value-of select="Household" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>现住址</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="107px" padding-right="107px">
				<xsl:value-of select="Address" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>被询问人身份证件种类及号码</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="70px" padding-right="70px">
				<xsl:value-of select="Identity" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>联系方式</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="180px" padding-right="180px">
				<xsl:value-of select="Contact" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>口头传唤的被询问人到达时间：</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="110px" padding-right="110px">
				<xsl:value-of select="ArriveTime" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>口头传唤的被询问人离开时间：</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="110px" padding-right="110px">
				<xsl:value-of select="LeaveTime" />
			</fo:inline>
		</fo:block>
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>本人签名确认</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" padding-left="185px" padding-right="185px">
				<xsl:value-of select="Confirm" />
			</fo:inline>
		</fo:block>
		<fo:block margin-top="20px">
		<xsl:apply-templates select="Paragraph" />
		</fo:block>
		
		<fo:block width="760px" margin-top="20px" height="30px"
			margin-left="12px" font-size="14px" color="#434344">
			<xsl:text>被传唤人签字:</xsl:text>
			<fo:inline border-bottom-width="1px" border-bottom-style="solid"
				border-bottom-color="black" color="white" padding-left="180px"
				padding-right="180px">
				<xsl:text>····</xsl:text>
			</fo:inline>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="Paragraph">
	<fo:block width="760px" height="30px"
			margin-left="20px" margin-right="20px" font-size="14px" font-weight="bold"
			color="#434344">
			<xsl:value-of select="Content" />
		</fo:block>
	</xsl:template>
	
	<!--报表尾// -->
	<xsl:template match="ReportFooter">
		<fo:block id="endofdoc"></fo:block>
	</xsl:template>
</xsl:stylesheet>