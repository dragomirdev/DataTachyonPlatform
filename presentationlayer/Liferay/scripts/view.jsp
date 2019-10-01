<%@ include file="/init.jsp" %>
<!-- link href="/css/main.scss" rel="stylesheet" type="text/css" -->

<table width="500" border="1" cellpadding="5">

  <tr>
    <th text-align="center" color="#D35400">User Layer</th>
    <th text-align="center" color="#3498DB">Integration Layer</th>
    <th text-align="center" color="#27AE60">Data Layer</th>
    <th text-align="center" color="#E74C3C">Business Layer</th>
    <th text-align="center" color="#2980B9">Presentation Layer</th>
    <th text-align="center" color="#F5B041">CI-CD Layer</th>
  </tr>
  
  <tr>
    <td align="center">
    	<a href="http://dtp-jupyter.northeurope.cloudapp.azure.com:8888/">
    		<img src="<%=request.getContextPath()%>/images/user.png"  alt="Edge Node" 
    		style="width:100px;height:100px;border:0">
		</a>
	</td>
    <td align="center">
    	<a href="http://nifiint.southindia.cloudapp.azure.com:9090/nifi">
    		<img src="<%=request.getContextPath()%>/images/apache_nifi.png"  alt="Apache Nifi" 
    		style="width:100px;height:100px;border:0">
		</a>
	</td>
    <td align="center">
    	<a href="http://dtp-haddop.southindia.cloudapp.azure.com:9870/">
    		<img src="<%=request.getContextPath()%>/images/apache_hadoop.png"  alt="Apache Hadoop" 
    		style="width:100px;height:100px;border:0">
		</a>
		<a href="http://dtp-haddop.southindia.cloudapp.azure.com:9870/">
    		<img src="<%=request.getContextPath()%>/images/apache_spark.png"  alt="Apache Spark" 
    		style="width:100px;height:100px;border:0">
		</a>
	</td>	
	<td align="center">
    	<a href="http://dtp-ai.francecentral.cloudapp.azure.com:6006/">
    		<img src="<%=request.getContextPath()%>/images/tensorboard.png"  alt="Artificial Intelligence" 
    		style="width:100px;height:100px;border:0">
		</a>
	</td>	
	<td align="center">
    	<a href="http://dtp-elk.southindia.cloudapp.azure.com:9200/">
    		<img src="<%=request.getContextPath()%>/images/elasticsearch.png"  alt="Elasticsearch" 
    		style="width:150px;height:100px;border:0">
		</a>
		<a href="http://dtp-elk.southindia.cloudapp.azure.com:5601/">
    		<img src="<%=request.getContextPath()%>/images/kibana.png"  alt="Kibana" 
    		style="width:150px;height:150px;border:0">
		</a>
		<a href="http://dtp-elk.southindia.cloudapp.azure.com:8000/">
    		<img src="<%=request.getContextPath()%>/images/hue.png"  alt="Hue" 
    		style="width:100px;height:75px;border:0">
		</a>
	</td>	
    <td align="center">
    	<a href="http://dtp-cicd.westeurope.cloudapp.azure.com:8080">
    		<img src="<%=request.getContextPath()%>/images/jenkins.png" 
    			 alt="CI-CD" style="width:125px;height:125px;border:0">
		</a>
	</td>
  </tr>
 
</table>	