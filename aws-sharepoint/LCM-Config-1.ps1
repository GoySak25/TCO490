# This block sets the LCM configuration to what we need for QS
[DSCLocalConfigurationManager()]
configuration LCMConfig
{
    Node 'localhost' {
        Settings {
            RefreshMode = 'Push'
            ActionAfterReboot = 'StopConfiguration'                      
            RebootNodeIfNeeded = $false
            CertificateId = $DscCertThumbprint  
        }
    }
}

"Setting Execution Policy to Remote Signed"
Set-ExecutionPolicy RemoteSigned -Force

$DscCertThumbprint = (get-childitem -path cert:\LocalMachine\My | where { $_.subject -eq "CN=AWSQSDscEncryptCert" }).Thumbprint

#~dk, upon advice from Adam Yee
$DscCertThumbprint = [system.String]::Join("", $DscCertThumbprint)

#Generates MOF File for LCM
LCMConfig -OutputPath 'C:\AWSQuickstart\LCMConfig'

