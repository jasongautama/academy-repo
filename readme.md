<h1> <b> Resources </b> </h1> <br> 
<br>
<b>S3</b> <br>

1. S3 Public Write Access <br>
2. S3 Public Read Access <br>

<br>

<b>EC2</b> <br>

1. EC2 HTTP Server <br>
2. EC2 SSH Server <br>
3. EC2 Tester <br>

<h1> Steps </h1>
<br>
<b>Step 1</b> <br>

git clone this repo to your laptop

<b>Step 2</b> <br>

Generate ssh key pair on AWS EC2 menu and then go to sub menu Network & Security > Key Pairs

Download the ssh private key.

<br>

Upload cloud formation template (main.yml) to AWS CloudFormation

<br>

Adjust paramaters: Random Unique for S3 bucket, Instance type, and Key pair name.

<b>Step 3</b> <br>


<h1> Testing </h1>

<b> Login to EC2 Tester </b>

<code> chmod 400 keypair-name.pem </code>

<br>

<code> ssh -i keypair-name.pem ec2-user@ip_address </code>

<br>

<b> Port Scanning </b>

<code> nmap -sT ip_address_webserver </code>



