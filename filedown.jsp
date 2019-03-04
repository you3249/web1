<%@ page language="java" contentType="text/html; charset=UTF-8" %>
 
<%@ page import="java.io.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
 
 
<%
    request.setCharacterEncoding("UTF-8");
 
 
    // ���� ���ε�� ���
    String root = request.getSession().getServletContext().getRealPath("/");
    //String savePath = root + "upload";
	String savePath = "D:\\APP\\download";
	
	System.out.println(root);
	System.out.println(savePath);
 
    // ������ ���� ����� ���ϸ�
    String filename = "download.zip" ;
	System.out.println(filename);
     
    // ���� ������ ���ϸ�
    String orgfilename = "db_1.zip" ;
      
 
    InputStream in = null;
    OutputStream os = null;
    File file = null;
    boolean skip = false;
    String client = "";
 
 
    try{
         
 
        // ������ �о� ��Ʈ���� ���
        try{
			System.out.println("in stream start...");
            file = new File(savePath, filename);
            in = new FileInputStream(file);
			System.out.println("in stream end...");
        }catch(FileNotFoundException fe){
			System.out.println("in stream error...");
            skip = true;
        }
 
 
 
         
        client = request.getHeader("User-Agent");
 
        // ���� �ٿ�ε� ��� ����
        response.reset() ;
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Description", "JSP Generated Data");
 
 
        if(!skip){
 
             
            // IE
            if(client.indexOf("MSIE") != -1){
                response.setHeader ("Content-Disposition", "attachment; filename="+new String(orgfilename.getBytes("KSC5601"),"ISO8859_1"));
 
            }else{
                // �ѱ� ���ϸ� ó��
                orgfilename = new String(orgfilename.getBytes("utf-8"),"iso-8859-1");
 
                response.setHeader("Content-Disposition", "attachment; filename=\"" + orgfilename + "\"");
                response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
            } 
             
            response.setHeader ("Content-Length", ""+file.length() );
 
 
       
            os = response.getOutputStream();
			System.out.println(file.length());
			System.out.println(Integer.MAX_VALUE);
			System.out.println((int)file.length());
			System.out.println(Byte.MAX_VALUE);
            /*byte b[] = new byte[(int)file.length() *2];
            int leng = 0;
            
			System.out.print("STATE : ");
            while( (leng = in.read(b)) > 0 ){
				System.out.print("*");
                os.write(b,0,leng);
            }
			System.out.println(".");*/
			
			
			byte[] bytestream = new byte[2048]; 
			FileInputStream filestream = new FileInputStream(file);

			int i = 0, j = 0;

			try {
				OutputStream outStream = response.getOutputStream();
				System.out.print("STATE : ");
				while ((i = filestream.read(bytestream)) != -1) { 
					outStream.write(bytestream,0,i); 
					System.out.print("*");
				} 
				System.out.println("OK");
				outStream.close();
			}catch(IOException e){
    
			}finally{ }

 
        }else{
            response.setContentType("text/html;charset=UTF-8");
            out.println("<script language='javascript'>alert('������ ã�� �� �����ϴ�');history.back();</script>");
 
        }
         
        in.close();
        os.close();
 
    }catch(Exception e){
      e.printStackTrace();
    }
%>