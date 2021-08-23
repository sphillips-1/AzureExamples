# Setup
## Download Powershell 7
https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7.1
## Download AzureCLI
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
## Download Terraform
https://www.terraform.io/downloads.html
## Configure Terraform environment variable
https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows
# Terraform Cheat Sheet
## Initialize Terraform
To initialize the Terraform deployment, run terraform init. This command downloads the Azure modules required to create an Azure resource group.
```cmd
terraform init
```
## Create a Terraform execution plan
After initialization, you create an execution plan by running terraform plan.
```cmd
terraform plan -out main.tfplan
```
## Apply a Terraform execution plan
Once you're ready to apply the execution plan to your cloud infrastructure, you run terraform apply.
```cmd
terraform apply main.tfplan
```
## Clean Up
```cmd
terraform plan -destroy -out main.destroy.tfplan
terraform apply main.destroy.tfplan
```