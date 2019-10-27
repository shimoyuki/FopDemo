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
				<fo:simple-page-master master-name="content" page-height="317mm" page-width="230mm" margin="10mm">
					<!--主体// -->
					<fo:region-body />
					<!--页脚// -->
					<fo:region-after extent="1cm" />
				</fo:simple-page-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="content">
				<!--页面主体内容 -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<!--报表体(若有多个部分内容，参照下面一行重复) -->
						<xsl:apply-templates select="LeaveBody" />
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!--报表第一页// -->
	<xsl:template match="LeaveBody">
		<xsl:apply-templates select="LeaveTable" />
		<xsl:apply-templates select="SignTable" />
	</xsl:template>

	<!--最终离区记录表格数据// -->
	<xsl:template match="LeaveTable">
		<fo:block color="#267DD2" height="30px" line-height="30px"
			border-after-width="0.5px" border-after-style="solid"
			border-after-color="#267DD2" margin-top="10px">
			<fo:external-graphic src="{Icon}" width="24px"
				height="16x" content-width="24px" content-height="16px" padding-left="12px" padding-bottom="12px">
				<xsl:value-of select="Icon" />
			</fo:external-graphic>
			最终离区记录
		</fo:block>
		<fo:block font-size="12px">
		<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="10px" height="20px" line-height="20px" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="7cm" />
				<fo:table-column column-width="7cm" />
				<fo:table-column column-width="7cm" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-left="22px" color="#0066B3">
								<xsl:text>离开时间：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="LeaveTime" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-left="10px" margin-right="12px" color="#0066B3">
								<xsl:text>离区事由：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Reason" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-left="10px" color="#0066B3">
								<xsl:text>羁押时长：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="DetainTime" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row  text-align="center">
						<fo:table-cell>
							<fo:block margin-left="12px" margin-top="10px" color="white" background-color="#0066B3">
								<xsl:text>随身物品返还情况表</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-top="10px" color="white" background-color="#0066B3">
								<xsl:text>手环编号：</xsl:text>
								<fo:inline>
									<xsl:value-of select="Code" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-top="10px" margin-right="12px" color="white" background-color="#0066B3">
								<xsl:text>对应保管柜号：</xsl:text>
								<fo:inline>
									<xsl:value-of select="Cabinet" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<fo:table table-layout="fixed" width="100%" text-align="center" font-size="9px" margin-left="0.4cm" margin-right="0.4cm">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="2.6cm" />
				<fo:table-column column-width="2.5cm" />
				<fo:table-column column-width="2.5cm" />
				<fo:table-column column-width="2.5cm" />
				<fo:table-column column-width="2.5cm" />
				<fo:table-column column-width="2.5cm" />
				<fo:table-column column-width="2.5cm" />
				<fo:table-column column-width="2.6cm" />

				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#0066B3" color="white">
						<fo:table-cell>
							<fo:block>序号</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>物品名称</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>物品特征</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>数量单位</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>物品分类</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>保管措施</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>返还登记</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>返还时间</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="LeaveRow" />
				</fo:table-body>
			</fo:table>
			<fo:table table-layout="fixed" width="100%" text-align="start" font-size="10px"
				margin-top="20px" height="25px" line-height="25px" border-after-width="0.5px" border-after-style="solid" border-after-color="#0066B3">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="10.5cm" />
				<fo:table-column column-width="10.5cm" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell >
							<fo:block margin-left="12px" color="#0066B3">
								<xsl:text>领取人：</xsl:text>
								<fo:inline color="black" border-width="0.2px" border-style="solid" border-color="black">
									<xsl:value-of select="Sign" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-left="12px" color="#0066B3">
								<xsl:text>领取人身份证号：</xsl:text>
								<fo:inline color="black" border-width="0.2px" border-style="solid" border-color="black">
									<xsl:value-of select="Identity" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
					<fo:table-cell>
							<fo:block margin-left="12px" color="#0066B3">
								<xsl:text>领取时间：</xsl:text>
								<fo:inline color="black" border-width="0.2px" border-style="solid" border-color="black">
									<xsl:value-of select="Time" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
						<fo:block>
						</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--最终离区记录表格每一行的模板// -->
	<xsl:template match="LeaveRow">
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Number" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Name" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Feature" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Amount" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Classify" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Method" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Regist" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="RuturnTime" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<!--签字表格数据// -->
	<xsl:template match="SignTable">
		<fo:block font-size="10px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="20px" margin-bottom="20px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="3.4cm" />
				<fo:table-column column-width="6cm" />
				<fo:table-column column-width="4cm" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell margin-left="0.4cm" margin-top="10px">
							<fo:block line-height="20px" color="#22608e">
								<xsl:text>办案民警：</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell margin-left="1cm" margin-top="10px">
							<fo:block line-height="20px">
								<xsl:text>警员姓名：</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell margin-left="0.4cm" margin-top="10px">
							<fo:block line-height="20px">
								<xsl:text>警员编号：</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					
					<fo:table-row>
						<fo:table-cell margin-left="0.4cm" margin-top="10px">
							<fo:block line-height="20px">
							</fo:block>
						</fo:table-cell>
						<fo:table-cell margin-left="1cm" margin-top="10px">
							<fo:block line-height="20px">
								<xsl:text>警员姓名：</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell margin-left="0.4cm" margin-top="10px">
							<fo:block line-height="20px">
								<xsl:text>警员编号：</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>

					<fo:table-row>
					<fo:table-cell margin-left="0.4cm" margin-top="10px">
							<fo:block line-height="20px" color="#22608e">
								<xsl:text>管理员签字：</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell margin-left="1cm" margin-top="10px">
							<fo:block line-height="20px">
								<xsl:text>警员姓名：</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell margin-left="0.4cm" margin-top="10px">
							<fo:block line-height="20px">
								<xsl:text>警员编号：</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

</xsl:stylesheet>