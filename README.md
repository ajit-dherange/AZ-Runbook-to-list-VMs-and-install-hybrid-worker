# AZ-Runbook-to-list-VMs-and-install-hybrid-worker

AZ Powershell Runbook to List All VMs, Filter Vms which don't have Hybrid Worker Group Extantion and install it

# I. using Azure default ID
LAB Prerequisite:

1. Login to Azure portal, open cloud shell, select powershell and create lab using below powershell commands ...

2. Create resource group
$ New-AzResourceGroup -Name 'myResourceGroup' -Location 'EastUS'

3. Create VM
$ New-AzVm -ResourceGroupName 'myResourceGroup' -Name 'myVM01' -Location 'East US' -VirtualNetworkName 'myVnet' -SubnetName 'mySubnet' -SecurityGroupName 'myNetworkSecurityGroup' -PublicIpAddressName 'myPublicIpAddress' -OpenPorts 80,3389

4. Change size of the VM (optional)
$ $vm = Get-AzureRmVM -ResourceGroupName "myResourceGroup" -VMName "myVM01"

$ $vm.HardwareProfile.VmSize = "Standard_B2s"

5. Power off VM
$ Stop-AzVM -ResourceGroupName "myResourceGroup" -Name "myVM01"

6. Create Automation account (Home > Automation Accounts > Create > Select Resource Group Name "myResourceGroup" & provide Automation account Name "autouser01"> Review + Create)
Note: you can repeat steps 2 and 3 for creating more VMs (don't forget to change VM names)

# Create Runbook ....
1. Open Automation Account "autouser01"

2. Select Runbook

3. Create a runbook (Select + Create a runbook) Name the runbook "AZRB-ADDHYDWRKRGRPMBR" From the Runbook type drop-down menu, select "PowerShell" From the Runtime version drop-down, select "5.1" Enter applicable Description "Azure PowerShell Runbook to detect and start power off VMs" Select Create

4. Add code to the runbook copy code from the attached script "AZRB-Test002_v2.ps1" and paste it into your new runbook code pane Note: Verify your $resourceGroupName in the line no. 5, update it if required

5. Test the runbook a. Select Test pane to open the Test page. b. Select Start to start the test. A runbook job is created and its status is displayed in the pane. The job status starts as Queued, indicating that the job is waiting for a runbook worker in the cloud to become available. The status changes to Starting when a worker claims the job. Finally, the status becomes Running when the runbook actually starts to run. c. When the runbook job completes, the Test page displays its output. The output should show names of all started VMs like "started myVM01 ...."

6. Publish and start the runbook

The runbook that you've created is still in Draft mode. You must publish it before you can run it in production. When you publish a runbook, you overwrite the existing Published version with the Draft version. In this case, you don't have a Published version yet because you just created the runbook.

Select Publish to publish the runbook and then Yes when prompted.

Note: 1) Now your runbook is ready, you can open and run it anytime, if you want you can shedule job to run it.
      2) Don't forget to delete all resources if your testing the runbook

# II. Using Azure ID

Prerequisite : Resourese group, Azure ID with Ditributed permission on the Resourese group

# Create Runbook ....

1. Open Automation Account "autouser01"

2. Select Runbook

3. Create a runbook (Select Select + Create a runbook) Name the runbook "AZRB-PWRON-VM" From the Runbook type drop-down menu, select "PowerShell" From the Runtime version drop-down, select "5.1" Enter applicable Description "Azure PowerShell Runbook to detect and start power off VMs" Select Create

4. Add code to the runbook copy code from the attached script "AZRB-Test002_v2.ps1" and paste it into your new runbook code pane Note: Update youre $resourceGroupName in the line no. 5

5. Test the runbook a. Select Test pane to open the Test page. b. Select Start to start the test. A runbook job is created and its status is displayed in the pane. The job status starts as Queued, indicating that the job is waiting for a runbook worker in the cloud to become available. The status changes to Starting when a worker claims the job. Finally, the status becomes Running when the runbook actually starts to run. c. When the runbook job completes, the Test page displays its output. The output should show names of all started VMs like "started myVM01 ...."

6. Publish and start the runbook

The runbook that you've created is still in Draft mode. You must publish it before you can run it in production. When you publish a runbook, you overwrite the existing Published version with the Draft version. In this case, you don't have a Published version yet because you just created the runbook.

Select Publish to publish the runbook and then Yes when prompted.

Note: Now your runbook is ready, you can open and run it anytime, if you want you can shedule job to run it.
