# PowerShell script
#Author: Milenko

#Install choco
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex


#Us chocolatey
refreshenv

#Get rid of anoying confirmations
choco feature enable -n allowGlobalConfirmation

#Install jdk8
choco install jdk8

#Install Maven
choco install maven

#Set Env variables
$env:JAVA_HOME="C:\Program Files\Java\jdk1.8.0_181"
$env:Path=%Path%;%JAVA_HOME%\bin;

#Refresh env variables
refreshenv