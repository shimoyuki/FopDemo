package com.cisetech.put.utils.fop;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.xml.sax.SAXException;

/**
 * FopReport
 * @author bin.yin 2012/12/23
 */
public class FopReport {
	//private static Logger log = new ConsoleLogger(ConsoleLogger.LEVEL_DEBUG);
	// Step 1: Construct a FopFactory
	private static FopFactory fopFactory;
	static {
		try {
			fopFactory = FopFactory.newInstance(new File("conf/fop.xconf"));
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * ����xslģ�弰xml�����ļ�����pdf
	 * @param xsltFile xslģ��
	 * @param xmlFile xml�����ļ�
	 * @return ReportData
	 * @throws Exception
	 * @author bin.yin 2012/12/25
	 */
	public static ReportData createReport(String xsltFile, String xmlFile) throws Exception {
		ReportData reportData = new ReportData();
		reportData.setContentType("application/pdf");

		// Step 2: Set up output stream.
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		try {
			// Step 3: Construct fop with desired output format
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out);

			// Step 4: Setup XSLT using identity transformer
			TransformerFactory factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer(new StreamSource(new File(xsltFile)));

			// Step 5: Setup input and output for XSLT transformation
			Source src = new StreamSource(new File(xmlFile));
			// Source src = new StreamSource(new StringReader(myString));

			// Step 6: Resulting SAX events (the generated FO) must be piped through to FOP
			Result res = new SAXResult(fop.getDefaultHandler());

			// Step 7: Start XSLT transformation and FOP processing
			transformer.transform(src, res);

			reportData.setData(out.toByteArray());
		} catch(Exception e) {
			throw e;
		} finally {
			out.close();
		}
		return reportData;
	}

	/**
	 * ����xslģ�弰xml�ֽ���������pdf
	 * @param xsltFile xslģ��
	 * @param bXmlData xml�ֽ����� eg. StringBuffer xmlContent = new StringBuffer(); xmlContent.getBytes("UTF-8");
	 * @return ReportData
	 * @throws Exception
	 * @author bin.yin 2012/12/25
	 */
	public static ReportData createReport(String xsltFile, byte[] bXmlData) throws Exception {
		ReportData reportData = new ReportData();
		try {
			// convert xml bytes to a temp file
			File xmlFile = File.createTempFile("FOP", ".tmp");
			FileOutputStream fos = new FileOutputStream(xmlFile);
			fos.write(bXmlData);
			fos.close();
			
			reportData = createReport(xsltFile, xmlFile.getAbsolutePath());
			// delete temp file
			xmlFile.delete();
		} catch (Exception e) {
			throw e;
		}
		return reportData;
	}

	public static void writeCase() {
		String path = FopReport.class.getClassLoader().getResource("").toString().replace("web/WEB-INF/classes/", "");
		try {
			StringBuffer xmlContent = new StringBuffer();
			
			xmlContent.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			xmlContent.append("<ItemListReport>");
			xmlContent.append("	<CaseHeader>");
			xmlContent.append("		<Banner>"+path+"images/pdfbanner.jpg</Banner>");
			xmlContent.append("		<Time>Time</Time>");
			xmlContent.append("		<Code>Code</Code>");
			xmlContent.append("	</CaseHeader>");
			
			xmlContent.append("	<CaseBody>");
			xmlContent.append("		<CaseTable>");
			xmlContent.append("		    <Name>Name</Name>");
			xmlContent.append("		    <FileNo>FileNo</FileNo>");
			xmlContent.append("		    <Position>Position</Position>");
			xmlContent.append("		    <StartTime>StartTime</StartTime>");
			xmlContent.append("		    <EndTime>EndTime</EndTime>");
			xmlContent.append("		    <Status>Status</Status>");
			xmlContent.append("		    <Type>Type</Type>");
			xmlContent.append("		    <Content>Content</Content>");
			xmlContent.append("		</CaseTable>");
			xmlContent.append("		<RelevantTable>");
			xmlContent.append("		    <PolicePhoto>"+path+"images/ms-icon-01.png</PolicePhoto>");
			xmlContent.append("		    <PoliceNumber>5</PoliceNumber>");
			xmlContent.append("		    <Leader>Leader</Leader>");
			xmlContent.append("		    <Members>Member1\tMember2\tMember3\tMember4\tMember5</Members>");
			xmlContent.append("		    <SuspectPhoto>"+path+"images/ms-icon-02.png</SuspectPhoto>");
			xmlContent.append("		    <SuspectNumber>5</SuspectNumber>");
			xmlContent.append("		    <Suspects>Suspect1\tSuspect2\tSuspect3\tSuspect4\tSuspect5</Suspects>");
			xmlContent.append("		    <WitnessPhoto>"+path+"images/ms-icon-03.png</WitnessPhoto>");
			xmlContent.append("		    <WitnessNumber>5</WitnessNumber>");
			xmlContent.append("		    <Witnesses>Witness1\tWitness2\tWitness3\tWitness4\tWitness5</Witnesses>");
			xmlContent.append("		    <VictimPhoto>"+path+"images/ms-icon-04.png</VictimPhoto>");
			xmlContent.append("		    <VictimNumber>5</VictimNumber>");
			xmlContent.append("		    <Victims>Victim1\tVictim2\tVictim3\tVictim4\tVictim5</Victims>");
			xmlContent.append("		</RelevantTable>");
			xmlContent.append("	</CaseBody>");
			xmlContent.append("</ItemListReport>");

			ReportData data = FopReport.createReport("report/CaseReport.xsl", xmlContent.toString().getBytes("UTF-8"));
			FileOutputStream fos = new FileOutputStream(path.substring(path.indexOf(":")+1)+"report/CaseReport.pdf");
			fos.write(data.getData());
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void writeArchive() {
		String path = FopReport.class.getClassLoader().getResource("").toString().replace("web/WEB-INF/classes/", "");
		
		StringBuffer xmlContent = new StringBuffer();
		/*SimpleDateFormat sdfStart = new SimpleDateFormat("yyyy-MM-dd HH:mm"),
				sdfEnd = new SimpleDateFormat("HH:mm"),
				sdfSlot = new SimpleDateFormat("HH:mm:ss");*/
		
		xmlContent.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		xmlContent.append("<ItemListReport>");
		xmlContent.append("	<RegisterHeader>");
		xmlContent.append("		<Icon>"+path+"images/gh-ico.png</Icon>");
		xmlContent.append("		<Title>入区登记</Title>");
		xmlContent.append("		<Time>2017-09-07 18:58:33</Time>");
		xmlContent.append("		<Code>20170520A</Code>");
		xmlContent.append("		<QRCode>"+path+"images/ewm.jpg</QRCode>");
		xmlContent.append("	</RegisterHeader>");
		
		xmlContent.append("	<RegisterBody>");
		xmlContent.append("		<IdentityTable>");
		xmlContent.append("		    <Photo>"+path+"images/sfzz.jpg</Photo>");
		xmlContent.append("		    <PhotoLeft>"+path+"images/pic-1.jpg</PhotoLeft>");
		xmlContent.append("		    <PhotoFront>"+path+"images/pic-2.jpg</PhotoFront>");
		xmlContent.append("		    <PhotoRight>"+path+"images/pic-3.jpg</PhotoRight>");
		xmlContent.append("		</IdentityTable>");
		xmlContent.append("		<RegisterTable>");
		xmlContent.append("		    <Name>Name</Name>");
		xmlContent.append("		    <Gender>Gender</Gender>");
		xmlContent.append("		    <Nation>Nation</Nation>");
		xmlContent.append("		    <Lang>Lang</Lang>");
		xmlContent.append("		    <Birth>Birth</Birth>");
		xmlContent.append("		    <House>House</House>");
		xmlContent.append("		    <Contact>Contact</Contact>");
		xmlContent.append("		    <Addr>Addr</Addr>");
		
		xmlContent.append("		    <Brace>Brace</Brace>");
		xmlContent.append("		    <Identity>Identity</Identity>");
		xmlContent.append("		    <Time>2017-09-07 18:58:33</Time>");
		xmlContent.append("		    <Reason>Reason</Reason>");
		xmlContent.append("		    <Remark>Remark</Remark>");
		
		xmlContent.append("		    <BusinessIn1>BusinessIn1</BusinessIn1>");
		xmlContent.append("		    <OnDutyIn>OnDutyIn</OnDutyIn>");
		xmlContent.append("		    <BusinessIn2>BusinessIn2</BusinessIn2>");
		
		xmlContent.append("		    <LeaveTime>LeaveTime</LeaveTime>");
		xmlContent.append("		    <LeaveReason>LeaveReason</LeaveReason>");
		xmlContent.append("		    <StayTime>StayTime</StayTime>");
		
		xmlContent.append("		    <BusinessOut1>BusinessOut1</BusinessOut1>");
		xmlContent.append("		    <OnDutyOut>OnDutyOut</OnDutyOut>");
		xmlContent.append("		    <BusinessOut2>BusinessOut2</BusinessOut2>");
		
		xmlContent.append("		</RegisterTable>");
		xmlContent.append("		<SignTable>");
		xmlContent.append("		</SignTable>");
		xmlContent.append("	</RegisterBody>");
		
		xmlContent.append("	<SecurityHeader>");
		xmlContent.append("		<Title>人身安全检查</Title>");
		xmlContent.append("		<Drink>Drink</Drink>");
		xmlContent.append("		<Disease>Disease</Disease>");
		xmlContent.append("		<Symptom>Symptom</Symptom>");
		xmlContent.append("		<Image>"+path+"images/pdflunku1.png</Image>");
		xmlContent.append("		<A1>true</A1>");
		xmlContent.append("		<B2>true</B2>");
		xmlContent.append("		<B5>true</B5>");
		xmlContent.append("		<C2>true</C2>");
		xmlContent.append("		<C4>true</C4>");
		xmlContent.append("	</SecurityHeader>");
		
		xmlContent.append("	<SecurityBody>");
		xmlContent.append("		<SecurityTable>");
		xmlContent.append("		    <SecurityRow>");
		xmlContent.append("		        <Number>Number1</Number>");
		xmlContent.append("		        <Explain>Explain1</Explain>");
		xmlContent.append("		        <Description>Description1</Description>");
		xmlContent.append("		        <Photo>Photo1</Photo>");
		xmlContent.append("		    </SecurityRow>");
		xmlContent.append("		    <SecurityRow>");
		xmlContent.append("		        <Number>Number2</Number>");
		xmlContent.append("		        <Explain>Explain2</Explain>");
		xmlContent.append("		        <Description>Description2</Description>");
		xmlContent.append("		        <Photo>Photo2</Photo>");
		xmlContent.append("		    </SecurityRow>");
		xmlContent.append("		</SecurityTable>");
		xmlContent.append("		<FinanceTable>");
		xmlContent.append("		    <FinanceRow>");
		xmlContent.append("		        <Number>Number1</Number>");
		xmlContent.append("		        <Name>Name1</Name>");
		xmlContent.append("		        <Feature>Feature1</Feature>");
		xmlContent.append("		        <Amount>Amount1</Amount>");
		xmlContent.append("		        <Classify>Classify1</Classify>");
		xmlContent.append("		        <Method>Method1</Method>");
		xmlContent.append("		        <Position>Position1</Position>");
		xmlContent.append("		    </FinanceRow>");
		xmlContent.append("		    <Business1>Business1</Business1>");
		xmlContent.append("		    <OnDuty>OnDuty</OnDuty>");
		xmlContent.append("		    <Business2>Business2</Business2>");
		xmlContent.append("		</FinanceTable>");
		xmlContent.append("		<SignTable>");
		xmlContent.append("		</SignTable>");
		xmlContent.append("	</SecurityBody>");
		
		//Calendar calendar = Calendar.getInstance();
		xmlContent.append("	<InformationBody>");
		xmlContent.append("		<InformationTable>");
		xmlContent.append("		<Title>信息采集</Title>");
		//xmlContent.append("		<StartTime>"+sdfStart.format(calendar.getTime())+"</StartTime>");
		//calendar.add(Calendar.MINUTE, 30);
		//xmlContent.append("		<EndTime>"+sdfEnd.format(calendar.getTime())+"</EndTime>");
		xmlContent.append("		<StartTime>2017-09-07 18:58:33</StartTime>");
		xmlContent.append("		<EndTime>2017-09-07 18:58:33</EndTime>");
		xmlContent.append("		<Integrity>Integrity</Integrity>");
		xmlContent.append("		    <InformationRow>");
		xmlContent.append("	        	<Number>Number</Number>");
		xmlContent.append("		        <Project>Project</Project>");
		xmlContent.append("	        	<Content>Content</Content>");
		xmlContent.append("	        	<Time>2017-09-07 18:58:33</Time>");
		xmlContent.append("		    </InformationRow>");
		xmlContent.append("		</InformationTable>");
		xmlContent.append("	</InformationBody>");
		
		/*calendar = Calendar.getInstance();
		Date dateStart = calendar.getTime(), dateEnd, dateSlot;
		calendar.add(Calendar.SECOND, 1000000);
		dateEnd = calendar.getTime();
		dateSlot = new Date(dateEnd.getTime() - dateStart.getTime());*/
		xmlContent.append("	<ActivityBody>");
		xmlContent.append("		<ActivityTable>");
		xmlContent.append("		<Title>入区活动记录</Title>");
		xmlContent.append("		<Name>Name</Name>");
		//xmlContent.append("		<Time>"+sdfSlot.format(dateSlot)+"</Time>");
		xmlContent.append("		<Time>2017-09-07 18:58:33</Time>");
		xmlContent.append("		    <ActivityRow>");
		xmlContent.append("	        	<Number>Number</Number>");
		xmlContent.append("		        <Project>Project</Project>");
		xmlContent.append("	        	<Room>Room</Room>");
		xmlContent.append("	        	<StartTime>2017-09-07 18:58:33</StartTime>");
		xmlContent.append("	        	<EndTime>2017-09-07 18:58:33</EndTime>");
		xmlContent.append("	        	<Record>Record</Record>");
		xmlContent.append("	        	<Remark>Remark</Remark>");
		xmlContent.append("		    </ActivityRow>");
		xmlContent.append("		</ActivityTable>");
		xmlContent.append("	</ActivityBody>");
		
		xmlContent.append("	<LeaveBody>");
		xmlContent.append("		<TemporaryTable>");
		xmlContent.append("		<Title>临时出区</Title>");
		xmlContent.append("		    <TemporaryRow>");
		xmlContent.append("	        	<Number>Number</Number>");
		xmlContent.append("		        <Name>Name</Name>");
		xmlContent.append("	        	<ID>ID</ID>");
		xmlContent.append("	        	<LeaveTime>2017-09-07 18:58:33</LeaveTime>");
		xmlContent.append("	        	<ReturnTime>2017-09-07 18:58:33</ReturnTime>");
		xmlContent.append("	        	<Reason>Reason</Reason>");
		xmlContent.append("	        	<Police>Police</Police>");
		xmlContent.append("		    </TemporaryRow>");
		xmlContent.append("		    <ChargeSign>ChargeSign</ChargeSign>");
		xmlContent.append("		</TemporaryTable>");
		xmlContent.append("		<FinalTable>");
		xmlContent.append("		    <FinalRow>");
		xmlContent.append("	        	<Number>Number</Number>");
		xmlContent.append("		        <Name>Name</Name>");
		xmlContent.append("	        	<Feature>Feature</Feature>");
		xmlContent.append("	        	<Amount>Amount</Amount>");
		xmlContent.append("	        	<Classify>Classify</Classify>");
		xmlContent.append("	        	<Method>Method</Method>");
		xmlContent.append("	        	<Situation>Situation</Situation>");
		xmlContent.append("	        	<RuturnTime>2017-09-07 18:58:33</RuturnTime>");
		xmlContent.append("		    </FinalRow>");
		xmlContent.append("		<Sign>Sign</Sign>");
		xmlContent.append("		<Identity>Identity</Identity>");
		xmlContent.append("		<ReceiptorTime>2017-09-07 18:58:33</ReceiptorTime>");
		xmlContent.append("		</FinalTable>");
		xmlContent.append("		<SignTable>");
		xmlContent.append("		</SignTable>");
		xmlContent.append("	</LeaveBody>");
		
		xmlContent.append("	<ReportFooter>");
		xmlContent.append("	</ReportFooter>");
		xmlContent.append("</ItemListReport>");
		
		try {
			ReportData data = FopReport.createReport("report/ArchiveReport.xsl", xmlContent.toString().getBytes("UTF-8"));
			FileOutputStream fos = new FileOutputStream(path.substring(path.indexOf(":")+1)+"report/ArchiveReport.pdf");
			fos.write(data.getData());
			fos.close();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void writeLeave() {
String path = FopReport.class.getClassLoader().getResource("").toString().replace("web/WEB-INF/classes/", "");
		
		StringBuffer xmlContent = new StringBuffer();
		
		xmlContent.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		xmlContent.append("<ItemListReport>");
		xmlContent.append("	<LeaveBody>");
		xmlContent.append("		<LeaveTable>");
		xmlContent.append("		<Icon>"+path+"images/sjx.png</Icon>");
		xmlContent.append("		<LeaveTime>LeaveTime</LeaveTime>");
		xmlContent.append("		<DetainTime>DetainTime</DetainTime>");
		xmlContent.append("		<Reason>Reason</Reason>");
		xmlContent.append("		<Code>Code</Code>");
		xmlContent.append("		<Cabinet>Cabinet</Cabinet>");
		xmlContent.append("		    <LeaveRow>");
		xmlContent.append("	        	<Number>Number</Number>");
		xmlContent.append("		        <Name>Name</Name>");
		xmlContent.append("	        	<Feature>Feature</Feature>");
		xmlContent.append("	        	<Amount>Amount</Amount>");
		xmlContent.append("	        	<Classify>Classify</Classify>");
		xmlContent.append("	        	<Method>Method</Method>");
		xmlContent.append("	        	<Regist>Regist</Regist>");
		xmlContent.append("	        	<Time>Time</Time>");
		xmlContent.append("		    </LeaveRow>");
		/*xmlContent.append("		<Sign>Sign</Sign>");
		xmlContent.append("		<Identity>Identity</Identity>");
		xmlContent.append("		<RuturnTime>RuturnTime</RuturnTime>");*/
		xmlContent.append("		</LeaveTable>");
		xmlContent.append("		<SignTable>");
		xmlContent.append("		</SignTable>");
		xmlContent.append("	</LeaveBody>");
		xmlContent.append("</ItemListReport>");
		
		try {
			ReportData data = FopReport.createReport("report/LeaveReport.xsl", xmlContent.toString().getBytes("UTF-8"));
			FileOutputStream fos = new FileOutputStream(path.substring(path.indexOf(":")+1)+"report/LeaveReport.pdf");
			fos.write(data.getData());
			fos.close();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void writeNote() {
		String path = FopReport.class.getClassLoader().getResource("").toString().replace("web/WEB-INF/classes/", "");
		try {
			StringBuffer xmlContent = new StringBuffer();
			
			xmlContent.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			xmlContent.append("<ItemListReport>");
			
			xmlContent.append("	<NoteBody>");
			xmlContent.append("	    <StartTime>2017年7月25日18时32分</StartTime>");
			xmlContent.append("	    <EndTime>2017年7月25日21时32分</EndTime>");
			xmlContent.append("	    <Position>山西省太原市小店区学府街长治路220号</Position>");
			xmlContent.append("	    <Enquire>张三丰</Enquire>");
			xmlContent.append("	    <EnquireSpace>山西省太原市小店区学府街长治路220号</EnquireSpace>");
			xmlContent.append("	    <Record>张三丰</Record>");
			xmlContent.append("	    <RecordSpace>山西省太原市小店区学府街长治路220号</RecordSpace>");
			xmlContent.append("	    <Enquired>王麻子</Enquired>");
			xmlContent.append("	    <Gender>男</Gender>");
			xmlContent.append("	    <Birthday>1985年1月23日</Birthday>");
			xmlContent.append("	    <Household>山西省太原市小店区学府街长治路220号</Household>");
			xmlContent.append("	    <Address>山西省太原市小店区学府街长治路220号</Address>");
			xmlContent.append("	    <Identity>身份证：123456789987654321</Identity>");
			xmlContent.append("	    <Contact>12345678912</Contact>");
			xmlContent.append("	    <ArriveTime>12345678912</ArriveTime>");
			xmlContent.append("	    <LeaveTime>7月25日36分</LeaveTime>");
			xmlContent.append("	    <Confirm>王麻子</Confirm>");
			xmlContent.append("	<Paragraph>");
			xmlContent.append("	    <Content></Content>");
			xmlContent.append("	</Paragraph>");
			xmlContent.append("	<Paragraph>");
			xmlContent.append("	    <Content>　　习近平指出，昨天，金砖国家领导人厦门会晤圆满闭幕。会晤通过了《金砖国家领导人厦门宣言》，重申开放包容、合作共赢的金砖精神，全面总结了金砖合作10年来的成功经验，为加强金砖伙伴关系、深化各领域务实合作规划了新蓝图。五国领导人认为，金砖国家应该深化在重大问题上的沟通和协调，捍卫国际关系基本准则，合作应对各种全球性挑战，加快全球经济治理改革；加强宏观政策协调，对接发展战略；深化政治安全合作，增进战略互信；将人文交流活动经常化、机制化，加深五国人民相互了解和友谊；与时俱进加强金砖机制建设，为各领域合作走深走实提供坚实保障。各国领导人决心以厦门会晤为新起点，共同打造更紧密、更广泛、更全面的战略伙伴关系，开创金砖合作第二个“金色十年”。</Content>");
			xmlContent.append("	</Paragraph>");
			xmlContent.append("	<Paragraph>");
			xmlContent.append("	    <Content>　　习近平指出，会晤期间，中方举行了新兴市场国家与发展中国家对话会，金砖国家和埃及、墨西哥、泰国、塔吉克斯坦、几内亚领导人共商国际发展合作大计，一致同意建立广泛的发展伙伴关系，加快落实2030年可持续发展议程，发出了深化南南合作和全球发展合作的强烈信号。各国领导人一致认为应该打造“金砖+”合作模式，携手走出一条创新、协调、绿色、开放、共享的可持续发展之路，为促进世界经济增长、实现各国共同发展注入更多正能量。</Content>");
			xmlContent.append("	</Paragraph>");
			String str = "问：习近平指出，明年，南非将担任金砖国家主席国，并将在约翰内斯堡举办领导人第十次会晤。答：中方愿同各方一道，全力支持南方办会，携手推动金砖合作继续向前发展。问：相信通过各国各界共同努力，金砖合作前景一定会更加光明，金砖国家未来一定会更加美好。";
			str = str.replaceAll("问：", "</Content></Paragraph><Paragraph><Content>问：");
			str =  str.replaceFirst("</Content></Paragraph>", "");
			str = str.replaceAll("答：", "</Content></Paragraph><Paragraph><Content>答：");
			str += "</Content></Paragraph>";
			xmlContent.append(str);
			xmlContent.append("	</NoteBody>");
			
			xmlContent.append("	<ReportFooter>");
			xmlContent.append("	</ReportFooter>");
			xmlContent.append("</ItemListReport>");

			ReportData data = FopReport.createReport("report/NoteReport.xsl", xmlContent.toString().getBytes("UTF-8"));
			FileOutputStream fos = new FileOutputStream(path.substring(path.indexOf(":")+1)+"report/NoteReport.pdf");
			fos.write(data.getData());
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void writeStdCase() {
		String path = FopReport.class.getClassLoader().getResource("").toString().replace("web/WEB-INF/classes/", "");
		try {
			StringBuffer xmlContent = new StringBuffer();
			
			xmlContent.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			xmlContent.append("<ItemListReport>");
			xmlContent.append("	<CaseHeader>");
			xmlContent.append("		<Icon>"+path+"images/gha.png</Icon>");
			xmlContent.append("		<Time>2017-05-20 17:25:36</Time>");
			xmlContent.append("		<Code>060613adsd</Code>");
			xmlContent.append("		<QRCode>"+path+"images/ewm.jpg</QRCode>");
			xmlContent.append("	</CaseHeader>");
			
			xmlContent.append("	<CaseBody>");
			xmlContent.append("		<CaseTable>");
			xmlContent.append("		    <Name>交城县315纵火行凶案 </Name>");
			xmlContent.append("		    <FileNo>01020102 </FileNo>");
			xmlContent.append("		    <Unit>山西省吕梁市交城县天宁派出所  </Unit>");
			xmlContent.append("		    <Position>交城县天宁派出所保险柜09号</Position>");
			xmlContent.append("		    <Type>刑事案件</Type>");
			xmlContent.append("		    <StartTime>2017-05-20 17:25:36 </StartTime>");
			xmlContent.append("		    <EndTime>2017-05-20 17:25:36 </EndTime>");
			xmlContent.append("		    <Status>结案</Status>");
			xmlContent.append("		    <Description>Description</Description>");
			xmlContent.append("		    <Relevant>Relevant</Relevant>");
			xmlContent.append("		</CaseTable>");
			
			xmlContent.append("		<OfficialTable>");//执法人员表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>职务</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>警编</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>工作单位</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>部门</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王正义</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>组长</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>00613</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>山西省交城县天宁派出所</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>刑警大队</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</OfficialTable>");
			
			xmlContent.append("		<RelevantTable>");//涉案人员表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Title>违法嫌疑人</Title>");
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>民族</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>入区时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>汉</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-07-20 15:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</RelevantTable>");
			
			xmlContent.append("		<RelevantTable>");//涉案人员表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Title>犯罪嫌疑人</Title>");
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>民族</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>入区时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>汉</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-07-20 15:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</RelevantTable>");
			
			xmlContent.append("		<RelevantTable>");//涉案人员表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Title>证人</Title>");
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>民族</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>入区时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>汉</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-07-20 15:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</RelevantTable>");
			
			xmlContent.append("		<RelevantTable>");//涉案人员表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Title>被害人</Title>");
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>民族</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>入区时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>汉</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-07-20 15:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</RelevantTable>");
			
			xmlContent.append("		<RelevantTable>");//涉案人员表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Title>可疑人员</Title>");
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>民族</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>入区时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>汉</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-07-20 15:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</RelevantTable>");
			
			xmlContent.append("		<RelevantTable>");//涉案人员表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Title>吸毒人员</Title>");
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>民族</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>入区时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>汉</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-07-20 15:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</RelevantTable>");
			
			xmlContent.append("		<RelevantTable>");//涉案人员表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Title>在逃人员</Title>");
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>民族</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>入区时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>汉</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-07-20 15:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</RelevantTable>");
			
			xmlContent.append("		<ArticlesTable>");//涉案物品表，该表必须为11列，重用时构造新表
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>物品提供者</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>财物名称</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>财物分类</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>财物规格</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>单位</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>数量</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>保管时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>保管情况</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>保管位置</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>备注</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>尼泊尔军刀</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>涉案物品</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>90cm</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>把</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-05-20 17:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>扣押</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>涉案物品柜09</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>交接</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>2</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>尼泊尔军刀</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>涉案物品</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>90cm</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>把</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-05-20 17:25:36</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>扣押</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>涉案物品柜09</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>交接</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</ArticlesTable>");
			
			xmlContent.append("		<RecordTable>");//涉案人员笔录档案表，该表必须为9列，重用时构造新表
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>身份</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>问话记录</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>问话内容</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>笔录视频(前)</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>笔录视频(后)</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>嫌疑人</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789aa</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>第3次讯问</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>讯问笔录</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>视频名称</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>视频名称</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</RecordTable>");
			
			xmlContent.append("		<ArchiveTable>");//涉案人员档案材料表，该表必须为7列，重用时构造新表
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>身份</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>档案编号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>视频档案名称</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>原文件</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>嫌疑人</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王正义</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>1234656sddddd</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>060613-20170823-王麻子入区档案.mp4</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>8</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</ArchiveTable>");
			
			xmlContent.append("		<SceneTable>");//现场勘察表，该表必须为10列，重用时构造新表
			xmlContent.append("		    <Caption>");//重用时构造新一列的表头
			xmlContent.append("		        <TH>序号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>身份</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>姓名</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>性别</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>民族</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>证件号</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>勘查时间</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>办案民警</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>照片</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Caption>");
			xmlContent.append("		        <TH>视频</TH>");
			xmlContent.append("		    </Caption>");
			xmlContent.append("		    <Row>");//重用时构造新一行表格
			xmlContent.append("		        <Col>");//重用时构造新的单元格
			xmlContent.append("		            <TD>1</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>嫌疑人</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>王麻子</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>男</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>汉</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>123456789987654321</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2017-05-20 15:25</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		        <Col>");
			xmlContent.append("		            <TD>2</TD>");
			xmlContent.append("		        </Col>");
			xmlContent.append("		    </Row>");
			xmlContent.append("		</SceneTable>");
			
			xmlContent.append("	</CaseBody>");
			xmlContent.append("</ItemListReport>");

			ReportData data = FopReport.createReport("report/StdCaseReport.xsl", xmlContent.toString().getBytes("UTF-8"));
			FileOutputStream fos = new FileOutputStream(path.substring(path.indexOf(":")+1)+"report/StdCaseReport.pdf");
			fos.write(data.getData());
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		//writeCase();
		writeArchive();
		//writeLeave();
		//writeNote();
		//writeStdCase();
	}
}
