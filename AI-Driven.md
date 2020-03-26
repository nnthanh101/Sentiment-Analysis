<h2 id="ai---driven-social-media-dashboard">AI - Driven Social Media Dashboard</h2>
<h2 id="aws-implementation-guide">AWS Implementation Guide</h2>
<h1 id="about-this-guide">About This Guide</h1>
<p>This  implementation  guide  discusses  architectural  considerations  and  configuration  steps  for deploying  an  AI-Driven  Social  Media  Dashboard  on  the  Amazon  Web  Services  (AWS)  Cloud. It  includes  links  to  an  <a href="http://aws.amazon.com/cloudformation/">AWS  CloudFormation</a> template  that  launches,  configures,  and  runs  the AWS services required to deploy this solution using AWS best practices for security and availability.</p>
<p>The guide is intended for IT infrastructure architects, administrators, and DevOps professionals who have practical experience architecting on the AWS Cloud.</p>
<h2 id="overview"><strong>Overview</strong></h2>
<p>Companies can gain valuable insight and deepen brand awareness by analyzing their social media interactions with customers. Using machine learning (ML) and business intelligence (BI) services from Amazon Web Services (AWS), including <a href="https://aws.amazon.com/translate/">Amazon Translate</a>, <a href="https://aws.amazon.com/comprehend/">Amazon</a>  <a href="https://aws.amazon.com/comprehend/">Comprehend</a>, <a href="https://aws.amazon.com/kinesis/">Amazon Kinesis</a>, <a href="https://aws.amazon.com/athena/">Amazon Athena</a>, and <a href="https://aws.amazon.com/quicksight/">Amazon QuickSight</a>, businesses can build meaningful, low-cost social media dashboards to analyze customer sentiment, which can lead to better opportunities for acquiring leads, improve website traffic, strengthen customer relationships, and improve customer service.</p>
<p>To help customers more easily build a natural-language-processing (NLP)-powered social media  dashboard  for  customer  feedback,  AWS  offers  the  AI-Driven  Social  Media  Dashboard. This  solution  automatically  provisions  and  configures  the  AWS  services  necessary  to  capture multi-language tweets in near real-time, translate them, and display them on a dashboard powered by Amazon  QuickSight.</p>
<p>You can also capture both the raw and enriched datasets and durably store them in the solution’s data lake. This allows data analysts to quickly and easily perform new types of analytics and ML on this data.</p>
<h2 id="cost">Cost</h2>
<p>You are responsible for the cost of the AWS services used while running this reference deployment.  As  of  the  date  of publication,  the  total  cost  for  running  this  solution  with  default settings  in  the  US  East (N.  Virginia)  Region  is  approximately <strong>$190  per  month</strong> for  ingesting 10,000  tweets  per  day  and  storing  them  for  one  year.  Refer  to <a href="#_bookmark22">Appendix  A</a> for  a  breakdown of  the  cost.</p>
<h1 id="architecture-overview">Architecture Overview</h1>
<p>Deploying this solution builds the following environment in the AWS Cloud.<br>
<img src="https://user-images.githubusercontent.com/38825810/77616867-4c421280-6f65-11ea-8ed0-931b7785933e.jpg" alt="d1"></p>
<p>The AWS CloudFormation  template deploys  an <a href="https://aws.amazon.com/ec2/">Amazon Elastic Compute Cloud</a>  (Amazon EC2)  instance  in  an <a href="https://aws.amazon.com/vpc/">Amazon  Virtual  Private  Cloud</a> (Amazon  VPC)  that  ingests  tweets  from Twitter.  An <a href="https://aws.amazon.com/kinesis/data-firehose/">Amazon  Kinesis  Data  Firehose</a> delivery  stream  loads  the  streaming  tweets  into the raw prefix  in  the  solution’s <a href="https://aws.amazon.com/s3/">Amazon  Simple  Storage  Service</a> (Amazon  S3)  bucket.  Amazon S3  invokes  an <a href="https://aws.amazon.com/lambda/">AWS  Lambda</a> function  to  analyze  the  raw  tweets  using  Amazon  Translate  to translate  non-English  tweets into  English,  and  Amazon Comprehend  to use natural- language-processing  (NLP)  to  perform entity  extraction and  sentiment  analysis.</p>
<p>A second Kinesis Data Firehose delivery stream loads the translated tweets and sentiment values into the sentiment prefix in the Amazon S3 bucket. A third delivery stream loads entities in the entities prefix in the Amazon S3 bucket.</p>
<p>The solution also deploys a data lake that includes <a href="https://aws.amazon.com/glue/">AWS Glue</a>  for data transformation, Amazon Athena for data analysis, and Amazon QuickSight for data visualization. AWS Glue Data  Catalog  contains  a  logical  database  (<strong>ai_driven_social_media_dashboard</strong>)  which is used to organize the tables for the data in Amazon S3. Athena uses these table definitions to query the data stored in Amazon S3 and return the information to an Amazon QuickSight dashboard.</p>
<h1 id="solution-components">Solution Components</h1>
<h2 id="tweet-ingestion">Tweet Ingestion</h2>
<p>The solution’s Amazon Elastic Compute Cloud (Amazon EC2) instance has a Node.js application that monitors  tweets  for a  list  of  terms  you specify  during initial  deployment. When  the  solution finds  a  tweet  containing one or  more  of  the  terms,  the  solution  will  ingest that  tweet.  You  can  modify  the terms  that  will  be  pulled  from  the  Twitter  streaming  API.  By default,  this  solution uses  stream processing  for  tweets.  After  tweet  ingestion,  AWS  Lambda analyzes  your  tweets  using Amazon Translate and  Amazon Comprehend.</p>
<p>To retrieve tens or hundreds of tweets per second, you can perform batch calls or leverage AWS Glue with triggers to perform batch processing.</p>
<h2 id="social-media-data-lake">Social Media Data Lake</h2>
<p>This solution includes a data lake to store your tweet data. The data lake consists of Amazon S3 to store raw and enriched datasets, Amazon Kinesis Data Firehose delivery streams to write  the  ingested  tweet  data  to  the  data  lake,  and AWS  Glue  Data  Catalog  to  be  the  metadata catalog for analytics. By default, this solution uses Amazon Athena to query data in the data lake.  But,  you  can  extend  this  solution  to  use  <a href="https://docs.aws.amazon.com/redshift/latest/dg/c-getting-started-using-spectrum.html">Amazon  Redshift  Spectrum</a>,  <a href="https://aws.amazon.com/emr/">Amazon  EMR</a>,  and <a href="https://aws.amazon.com/sagemaker/">Amazon  SageMaker</a>.</p>
<h1 id="design-considerations">Design Considerations</h1>
<h2 id="supported-languages">Supported Languages</h2>
<p>By default, this solution can ingest tweets in English, Spanish, German, French, Arabic, and Portuguese. To add additional languages, add the language code to the list in the <strong>Twitter Language</strong> AWS CloudFormation template parameter.</p>
<p>Note  that  this  solution  does  not  automatically  map  the  language  codes  in  Twitter  to  the  codes in Amazon Translate. The solution includes a default set of language codes that match in Twitter and Amazon Translate. Customers who want to add additional languages should either verify that Twitter and Amazon Translate use the same language code, or modify the included Lambda function to map the languages. For a list of codes for Amazon Translate, see <a href="https://docs.aws.amazon.com/translate/latest/dg/how-it-works.html#how-it-works-language-codes">Supported Language Codes</a> in the <em>Amazon Translate Developer  Guide</em>.</p>
<h2 id="data-visualization">Data Visualization</h2>
<p>You  can  use  Amazon  QuickSight  to  build  dashboards  that  enable  you  to  visualize  tweets  over time, the sentiment of the tweets, and the relationship between the entities being discussed and  the  sentiment  values  from  the  tweets. For  more  information  on  how  to  leverage  Amazon QuickSight to visualize tweet data, see <a href="#_bookmark18">Step 4</a> of the Automated Deployment  section.</p>
<h2 id="stack-deletion">Stack Deletion</h2>
<p>The AI-Driven Social Media Dashboard is designed to enable you to retain the tweet data stored  in  Amazon  S3.  If  you  delete  the  solution  stack,  the  Amazon  S3  bucket with  your  tweet data will not be deleted. You must manually delete this  bucket.</p>
<h2 id="regional-deployment">Regional Deployment</h2>
<p>This solution uses Amazon QuickSight, Amazon Athena, Amazon Translate, Amazon Comprehend, and AWS Glue which are currently available in specific AWS Regions only. Therefore, you must launch this solution in an AWS Region where these services are available.  For  the  most  current  service  availability  by  AWS  Region,  see <a href="https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/">AWS  service  offerings</a>  <a href="https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/">by  regions</a>.</p>
<p><a href="https://s3.amazonaws.com/solutions-reference/ai-driven-social-media-dashboard/latest/ai-driven-social-media-dashboard.template"><strong>View template</strong></a></p>
<p>This is the primary solution template you use to launch AI-Driven Social Media<br>
Dashboard and all associated components. The default configuration deploys an Amazon Elastic Compute Cloud (Amazon EC2) instance, Amazon Kinesis Data Firehose delivery streams, an AWS Lambda function, Amazon Athena, AWS Glue Data Catalog, Amazon Translate,  and  Amazon  Comprehend,  but  you  can  also  customize  the  template  based  on  your specific  needs.</p>
<h1 id="automated-deployment">Automated Deployment</h1>
<p>Before you launch the automated deployment, please review the architecture, configuration, and  other  considerations  discussed  in  this  guide.  Follow  the  step-by-step  instructions  in  this section to configure and deploy the AI-Driven Social Media Dashboard template into your account.</p>
<p><strong>Time to deploy:</strong> Approximately five minutes</p>
<h2 id="prerequisites">Prerequisites</h2>
<p>Before  you  launch  this  solution,  you  must  have  a  Twitter  consumer  key  (API  key)  and  secret, and  a  Twitter  access  key  and  secret.  If  you  do  not  already  have  these  keys,  you  must <a href="https://developer.twitter.com/en/apps">create  an</a>  <a href="https://developer.twitter.com/en/apps">app in  Twitter</a>.</p>
<p>You  must  also  have  an  Amazon  Elastic  Compute  Cloud  (Amazon  EC2)  key pair.  If  you  do  not already  have  a  key pair,  see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair">Creating  a Key Pair  Using Amazon EC2</a> in  the  <em>Amazon  EC2  User Guide  for Linux  Instances</em>.</p>
<h2 id="what-we’ll-cover">What We’ll Cover</h2>
<p>The procedure for deploying this architecture on AWS consists of the following steps. For detailed instructions, follow the links for each step.</p>
<p><strong>[Step  1.  Launch  the  Stack]</strong></p>
<ul>
<li>
<p>Launch the AWS CloudFormation template into your AWS  account.</p>
</li>
<li>
<p>Enter values for required parameters: <strong>Stack Name</strong>, <strong>Auth Access<br>
Token</strong>, <strong>Auth Access Token Secret, Twitter Consumer Key, Twitter<br>
Consumer Key  Secret</strong>.</p>
</li>
<li>
<p>Review the other template parameters and<br>
adjust if necessary.</p>
</li>
</ul>
<p><strong>[Step  2.  Build  the Queries]</strong></p>
<ul>
<li>Build the Amazon Athena  queries.</li>
</ul>
<p><strong>[Step 3. Create the Data Source]</strong></p>
<ul>
<li>Create the Amazon QuickSight data  source.</li>
</ul>
<p><strong>[Step 4. Build the Dashboard]</strong></p>
<ul>
<li>Create the Amazon QuickSight dashboard to visualize the  data.</li>
</ul>

