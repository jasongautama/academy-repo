#Copyright 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#  
#  Licensed under the Apache License, Version 2.0 (the "License").
#  You may not use this file except in compliance with the License.
#  A copy of the License is located at
#  
#      http://www.apache.org/licenses/LICENSE-2.0
#  
#  or in the "license" file accompanying this file. This file is distributed 
#  on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either 
#  express or implied. See the License for the specific language governing 
#  permissions and limitations under the License.

#!/bin/bash

# 1 - CryptoCurrency Activity
echo '***********************************************************************'
echo '* Test #1 - CryptoCurrency Mining Activity                            *'
echo '* This simulates interaction with a cryptocurrency mining pool which *'
echo '* can be an indication of an instance compromise. In this case, we are*'
echo '* only interacting with the URL of the pool, but not downloading      *'
echo '* any files. This will trigger a threat intel based detection.        *'
echo '***********************************************************************'
echo
echo "Calling bitcoin wallets to download mining toolkits"
curl -s http://pool.minergate.com/dkjdjkjdlsajdkljalsskajdksakjdksajkllalkdjsalkjdsalkjdlkasj  > /dev/null &
curl -s http://xmr.pool.minergate.com/dhdhjkhdjkhdjkhajkhdjskahhjkhjkahdsjkakjasdhkjahdjk  > /dev/null &
echo
echo '-----------------------------------------------------------------------'
echo
# 2 - DNS Exfiltation 
echo '***********************************************************************'
echo '* Test #2 - DNS Exfiltration                                          *'
echo '* A common exfiltration technique is to tunnel data out over DNS      *'
echo '* to a fake domain.  Its an effective technique because most hosts    *'
echo '* have outbound DNS ports open.  This test wont exfiltrate any data,  *'
echo '* but it will generate enough unusual DNS activity to trigger the     *'
echo '* detection.                                                          *'
echo '***********************************************************************'
echo
echo "Calling large numbers of large domains to simulate tunneling via DNS" 
dig -f ./domains/queries.txt > /dev/null &
echo
# 3 - Backdoor:EC2/C&CActivity.B!DNS
echo '***********************************************************************'
echo '* Test #3 - Fake domain to prove that GuardDuty is working            *'
echo '* This is a permanent fake domain that customers can use to prove that*'
echo '* GuardDuty is working.  Calling this domain will always generate the *'
echo '* Backdoor:EC2/C&CActivity.B!DNS finding type                         *'
echo '***********************************************************************'
echo
echo "Calling a well known fake domain that is used to generate a known finding"
dig GuardDutyC2ActivityB.com any
echo
echo '*****************************************************************************************************'
echo 'Expected GuardDuty Findings'
echo 'Test 1: Cryptocurrency Activity'
echo 'Expected Finding: EC2 Instance Tester is querying a domain name that is associated with bitcoin activity'
echo 'Finding Type : CryptoCurrency:EC2/BitcoinTool.B!DNS'
echo
echo 'Test 2: DNS Exfiltration'
echo 'Expected Finding: EC2 instance Tester is attempting to query domain names that resemble exfiltrated data'
echo 'Finding Type : Trojan:EC2/DNSDataExfiltration'
echo
echo 'Test 3: C&C Activity'
echo 'Expected Finding: EC2 instance Tester is querying a domain name associated with a known Command & Control server. '
echo 'Finding Type : Backdoor:EC2/C&CActivity.B!DNS'
echo