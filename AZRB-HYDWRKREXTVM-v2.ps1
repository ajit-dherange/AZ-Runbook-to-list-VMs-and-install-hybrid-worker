################################################################################
### AZ RB Add Hybrid Worker Extn to VMs v2 - Ajit D.                         ###
### List All VMs, Filter Vms which don't have Hybrid Worker Group Extantion  ###
################################################################################
$resourceGroupName = "myResourceGroup"		
# Ensure you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context
# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext
# List all VMs status
$vms = Get-AzVM -ResourceGroupName $resourceGroupName -Status -DefaultProfile $AzureContext
foreach ($VM in $vms.Name) {
	$rbkwrk = (Get-AzVMExtension -ResourceGroupName $resourceGroupName -VMName $VM -Name "HybridWorkerExtension").Name
	if ($rbkwrk -ne 'HybridWorkerExtension') {
		Write-output "Hybrid Worker Extension not updated on $VM , updating ..."
		Set-AzVMExtension -ResourceGroupName $resourceGroupName -VMName $VM -Name "HybridWorkerExtension" -Publisher "Microsoft.Azure.Automation.HybridWorker" -ExtensionType HybridWorkerForWindows -TypeHandlerVersion 0.1 
        Write-output "Updated Hybrid Worker Extension on $VM !!!"
		}		
    else {
        Write-output "Hybrid Worker Extension is already present on $VM !"
        }
}
Write-Output "Account ID of current context: " $AzureContext.Account.Id



