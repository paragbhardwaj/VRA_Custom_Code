param(
      [string]$user,
     [string]$password,
	 [string]$node,
	 [string]$vmsize,
	 [string]$to
   )
   # Please add the $to variable
   #please add Mail Server
   #add the cluster name in get-cluster
   #add the CC address
   
   Start-Sleep -Seconds 360
   Add-PSSnapin vmware.vimautomation.core -ErrorAction SilentlyContinue
Get-Module -Name "vmware*" -ListAvailable | Import-Module
Connect-VIServer XXXXXXX -User $user -Password $password -ErrorAction SilentlyContinue
if($vmsize -eq "small"){

$numcpu = "1"
$mem = "4"
}
elseif($vmsize -eq "medium"){

$numcpu = "2"
$mem = "8"
}
else{
$numcpu = "4"
$mem = "16"
}
#Start-Sleep -Seconds 60
#get-vm $node | Stop-VMguest -Confirm:$false
#Start-Sleep -Seconds 10
Get-VM $node | Set-VM -NumCpu $numcpu -MemoryGB $mem -Confirm:$false
Start-Sleep -Seconds 10

##Function to move the VM in folder#############
function Move-VMtoFolderPath {  
  
   Foreach ($FolderPath in $Input) {  
     $list = $FolderPath -split "\\"  
     $VMName = $list[-1]  
     $count = $list.count - 2  
     0..$count | ForEach-Object {  
          $number = $_  
       if ($_ -eq 0 -and $count -gt 2) {  
               $Datacenter = Get-Datacenter $list[0]  
          } #if ($_ -eq 0)  
       elseif ($_ -eq 0 -and $count -eq 0) {  
               $Datacenter = Get-Datacenter $list[$_]  
               #VM already in Datacenter no need to move  
         Continue  
       } #elseif ($_ -eq 0 -and $count -eq 0)  
       elseif ($_ -eq 0 -and $count -eq 1) {  
         $Datacenter = Get-Datacenter $list[$_]  
       } #elseif ($_ -eq 0 -and $count -eq 1)  
       elseif ($_ -eq 0 -and $count -eq 2) {  
         $Datacenter = Get-Datacenter $list[$_]  
       } #elseif ($_ -eq 0 -and $count -eq 2)  
          elseif ($_ -eq 1) {  
               $Folder = $Datacenter | Get-folder $list[$_]  
          } #elseif ($_ -eq 1)  
          else {  
         $Folder = $Folder | Get-Folder $list[$_]  
          } #else  
     } #0..$count | foreach  
     Move-VM -VM $VMName -Destination $Folder  
   } #Foreach ($FolderPath in $VMFolderPathList)  
 }#function Set-FolderPath
 $dcname= get-vm $node | Get-Datacenter
 $cluster=get-vm $node | Get-cluster
 $Folder = "$dcname\$cluster\$vmsize\$node"
 $folder | Move-VMtoFolderPath
 #get-vm $node | Start-VM -Confirm:$false -RunAsync
 Start-Sleep -Seconds 10
 get-cluster -name "######" | Get-ResourcePool $vmsize | move-vm $node -confirm:$false
 Start-Sleep -Seconds 15
$greenip = (get-vm $node).Guest.IPAddress[0]
$greyip = (get-vm $node).Guest.IPAddress[1]
 $imagePathArray = "C:\temp\logo2.png" 
  $emailFrom = "#######"  
  $emailSubject = "New Server Build $node"  
  $smtpServer = "XXXXXXXX"
  $SendTo = $to
  $cc = "xxxxxxx"
  #Create new mail  
$eMail = New-Object system.net.mail.mailmessage  
$body = "<p style='font-family: Calibri, sans-serif'>" 
$counter=1  
$attachArray=@()  
foreach ($Image in $imagePathArray) {  
  #Embed Image  
  $tempAttach = new-object Net.Mail.Attachment($Image)  
  $tempAttach.ContentType.MediaType = "image/png"  
  $tempAttach.ContentId = "Attachment" + $Counter  
  #Add attachment to the mail  
  $eMail.Attachments.Add($tempAttach)  
  #Mail body  
  $body += "<img src='cid:$($tempAttach.ContentId)' /><br />"  
  $attachArray += $tempAttach  
  $counter++  
}
$body += "
<br />  <font size='4'>
Hi Team,<br><br>
VM has been build and below are detail.<br><br>

Hostname=$node<br>
Number of CPU = $numcpu<br>
Memory = $mem GB<br>
Primary IP Address=$greenip<br>
Primary IP Netmask=255.255.252.0<br>
Primary IP Gateway=XXXXXX<br>
Secondary IP Address=$greyip<br>
Secondary IP Netmask= 255.255.252.0<br><br>                      

Please review the server and let me know if you see any discrepancies.<br><br>
This is system genterated mail and please donot reply on this mail.<br><br>
Thanks,<br>
EVSS AA Team<br>
 </font>  <br /> <br />
</p>"
#Mail info  
$eMail.from = $emailFrom  
$eMail.To.add($sendto)
$eMail.CC.add($cc)
$eMail.Subject = $emailSubject  
$eMail.Body = $body  
$eMail.IsBodyHTML = $true  
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 25)  
$SMTPClient.Send($eMail)  
#Dispose attachments  
foreach ($tempAttach in $attachArray) {  
  $tempAttach.dispose()  
} 