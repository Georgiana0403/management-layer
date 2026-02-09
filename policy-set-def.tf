# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Modify-RG-Tags"
resource "azurerm_policy_set_definition" "modify_rg_tags" {
  description  = "This policy initiative inherits the defined tags from resource groups to the underlying resources."
  display_name = "Inherit Resource Tags from Resource Group"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:55:00.5704033Z"
    updatedBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn = "2025-02-05T21:10:46.3339407Z"
    version   = "1.0.0"
  })
  name        = "Modify-RG-Tags"
  parameters  = null
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      tagName = {
        value = "environment"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Modify-ResourceGroup-Tags"
    policy_group_names   = []
    reference_id         = "Modify-ResourceGroup-Tags"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Control-VM-Backup-Tag"
resource "azurerm_policy_set_definition" "control_vm_backup_tag" {
  description  = "This policy initiative enforces existence of the vm-backup-tag on virtual machines and sets a default, if not defined."
  display_name = "Control Virtual Machine Backup Tags to adhere with defined Governance"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:55:00.4320993Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  name = "Control-VM-Backup-Tag"
  parameters = jsonencode({
    allowedBackupTagValues = {
      type = "Array"
    }
    defaultBackupTagValue = {
      type = "String"
    }
    vmBackupTagName = {
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      allowedBackupTagValues = {
        value = "[parameters('allowedBackupTagValues')]"
      }
      defaultBackupTagValue = {
        value = "[parameters('defaultBackupTagValue')]"
      }
      vmBackupTagName = {
        value = "[parameters('vmBackupTagName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-VirtualMachine-Backup-Tag"
    policy_group_names   = []
    reference_id         = "Append-VirtualMachine-Backup-Tag"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      allowedBackupTagValues = {
        value = "[parameters('allowedBackupTagValues')]"
      }
      vmBackupTagName = {
        value = "[parameters('vmBackupTagName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VirtualMachine-Backup-Tag"
    policy_group_names   = []
    reference_id         = "Deny-VirtualMachine-Backup-Tag"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Enforce-ACSB"
resource "azurerm_policy_set_definition" "enforce_acsb" {
  description  = "Enforce Azure Compute Security Benchmark compliance auditing for Windows and Linux virtual machines."
  display_name = "Enforce Azure Compute Security Benchmark compliance auditing"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Guest Configuration"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:53:24.5600718Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  name = "Enforce-ACSB"
  parameters = jsonencode({
    effect = {
      allowedValues = ["AuditIfNotExists", "Disabled"]
      defaultValue  = "AuditIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    includeArcMachines = {
      allowedValues = ["true", "false"]
      defaultValue  = "true"
      metadata = {
        description = "By selecting this option, you agree to be charged monthly per Arc connected machine."
        displayName = "Include Arc connected servers"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/3cf2ab00-13f1-4d0c-8971-2ac904541a7e"
    policy_group_names   = []
    reference_id         = "GcIdentity"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/331e8ea8-378a-410f-a2e5-ae22f38bb0da"
    policy_group_names   = []
    reference_id         = "GcLinux"
    version              = "3.*.*"
  }
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/385f5831-96d4-41db-9a3c-cd3af78aaae6"
    policy_group_names   = []
    reference_id         = "GcWindows"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      IncludeArcMachines = {
        value = "[parameters('includeArcMachines')]"
      }
      effect = {
        value = "[parameters('effect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/72650e9f-97bc-4b2a-ab5f-9781a9fcecbc"
    policy_group_names   = []
    reference_id         = "WinAcsb"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      IncludeArcMachines = {
        value = "[parameters('includeArcMachines')]"
      }
      effect = {
        value = "[parameters('effect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fc9b3da7-8347-4380-8e70-0a0361d8dedd"
    policy_group_names   = []
    reference_id         = "LinAcsb"
    version              = "2.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Storage-Blob-Backup"
resource "azurerm_policy_set_definition" "deploy_storage_blob_backup" {
  description  = "This policy initiative contains policies to deploy data protection vaults and backup policies per resource group (based on tags). It also onboards storage accounts to the backup service."
  display_name = "Configure backup on storage accounts without a given tag to a new data protection vault with a default policy"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:55:00.2907956Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  name = "Deploy-Storage-Blob-Backup"
  parameters = jsonencode({
    dailyRetentionDurationCountLong = {
      defaultValue = 60
      metadata = {
        description = "daily: retention of daily backup points for long term backups"
      }
      type = "Integer"
    }
    dailyRetentionDurationCountMid = {
      defaultValue = 30
      metadata = {
        description = "daily: retention of daily backup points for mid term backups"
      }
      type = "Integer"
    }
    dailyRetentionDurationCountShort = {
      defaultValue = 14
      metadata = {
        description = "daily: retention of daily backup points for short term backups"
      }
      type = "Integer"
    }
    policyNameLong = {
      defaultValue = "storage-blob-60d"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy (long term backup)"
      }
      type = "String"
    }
    policyNameMid = {
      defaultValue = "storage-blob-30d"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy (mid term backup)"
      }
      type = "String"
    }
    policyNameShort = {
      defaultValue = "storage-blob-14d"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy (short term backup)"
      }
      type = "String"
    }
    storageBackupTagName = {
      defaultValue = "storageaccount-backup-policy"
      metadata = {
        description = "the name of the tag key to filter Storage Accounts for"
      }
      type = "String"
    }
    vaultRedundancy = {
      allowedValues = ["LocallyRedundant", "GeoRedundant"]
      defaultValue  = "LocallyRedundant"
      metadata = {
        description = "Change Vault Storage Type (not allowed if the vault has registered backups)"
      }
      type = "String"
    }
    vaultTags = {
      defaultValue = {
        description = "vault used by Azure policy af-dine-sa-backup-rg"
      }
      type = "Object"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      dailyRetentionDurationCount = {
        value = "[parameters('dailyRetentionDurationCountShort')]"
      }
      policyName = {
        value = "[parameters('policyNameShort')]"
      }
      storageBackupTagName = {
        value = "[parameters('storageBackupTagName')]"
      }
      vaultRedundancy = {
        value = "[parameters('vaultRedundancy')]"
      }
      vaultTags = {
        value = "[parameters('vaultTags')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/StorageAccount-Blob-Backup-short"
    policy_group_names   = []
    reference_id         = "StorageAccount-Blob-Backup-2000-short"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      dailyRetentionDurationCount = {
        value = "[parameters('dailyRetentionDurationCountMid')]"
      }
      policyName = {
        value = "[parameters('policyNameMid')]"
      }
      storageBackupTagName = {
        value = "[parameters('storageBackupTagName')]"
      }
      vaultRedundancy = {
        value = "[parameters('vaultRedundancy')]"
      }
      vaultTags = {
        value = "[parameters('vaultTags')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/StorageAccount-Blob-Backup-mid"
    policy_group_names   = []
    reference_id         = "StorageAccount-Blob-Backup-2000-mid"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      dailyRetentionDurationCount = {
        value = "[parameters('dailyRetentionDurationCountLong')]"
      }
      policyName = {
        value = "[parameters('policyNameLong')]"
      }
      storageBackupTagName = {
        value = "[parameters('storageBackupTagName')]"
      }
      vaultRedundancy = {
        value = "[parameters('vaultRedundancy')]"
      }
      vaultTags = {
        value = "[parameters('vaultTags')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/StorageAccount-Blob-Backup-long"
    policy_group_names   = []
    reference_id         = "StorageAccount-Blob-Backup-2000-long"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Control-VM-Update-Tag"
resource "azurerm_policy_set_definition" "control_vm_update_tag" {
  description  = "This policy deny undefined values for vmUpdateTagName tag or append default value if not set. "
  display_name = "Control Virtual Machine Update Tags to adhere with defined Governance"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:55:00.0807871Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  name = "Control-VM-Update-Tag"
  parameters = jsonencode({
    allowedUpdateTagValues = {
      type = "Array"
    }
    defaultUpdateTagValue = {
      type = "String"
    }
    vmUpdateTagName = {
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      allowedUpdateTagValues = {
        value = "[parameters('allowedUpdateTagValues')]"
      }
      defaultUpdateTagValue = {
        value = "[parameters('defaultUpdateTagValue')]"
      }
      vmUpdateTagName = {
        value = "[parameters('vmUpdateTagName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-VirtualMachine-Update-Tag"
    policy_group_names   = []
    reference_id         = "Append-VirtualMachine-Backup-Tag"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      allowedUpdateTagValues = {
        value = "[parameters('allowedUpdateTagValues')]"
      }
      vmUpdateTagName = {
        value = "[parameters('vmUpdateTagName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VirtualMachine-Update-Tag"
    policy_group_names   = []
    reference_id         = "Deny-VirtualMachine-Update-Tag"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Enforce-Guardrails-KeyVault"
resource "azurerm_policy_set_definition" "enforce_guardrails_keyvault" {
  description  = "Enforce recommended guardrails for Azure Key Vault."
  display_name = "Enforce recommended guardrails for Azure Key Vault"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Key Vault"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:55:00.4833923Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  name = "Enforce-Guardrails-KeyVault"
  parameters = jsonencode({
    effectKvCertLifetime = {
      allowedValues = ["audit", "Audit", "deny", "Deny", "disabled", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effectKvFirewallEnabled = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effectKvKeysExpire = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effectKvKeysLifetime = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effectKvPurgeProtection = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effectKvSecretsExpire = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effectKvSecretsLifetime = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effectKvSoftDelete = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    maximumCertLifePercentageLife = {
      defaultValue = 80
      metadata = {
        description = "Enter the percentage of lifetime of the certificate when you want to trigger the policy action. For example, to trigger a policy action at 80% of the certificate's valid life, enter '80'."
        displayName = "The maximum lifetime percentage"
      }
      type = "Integer"
    }
    minimumCertLifeDaysBeforeExpiry = {
      defaultValue = 90
      metadata = {
        description = "Enter the days before expiration of the certificate when you want to trigger the policy action. For example, to trigger a policy action 90 days before the certificate's expiration, enter '90'."
        displayName = "The minimum days before expiry"
      }
      type = "Integer"
    }
    minimumKeysLifeDaysBeforeExpiry = {
      defaultValue = 90
      metadata = {
        description = "Enter the days before expiration of the certificate when you want to trigger the policy action. For example, to trigger a policy action 90 days before the certificate's expiration, enter '90'."
        displayName = "The minimum days before expiry"
      }
      type = "Integer"
    }
    minimumSecretsLifeDaysBeforeExpiry = {
      defaultValue = 90
      metadata = {
        description = "Enter the days before expiration of the certificate when you want to trigger the policy action. For example, to trigger a policy action 90 days before the certificate's expiration, enter '90'."
        displayName = "The minimum days before expiry"
      }
      type = "Integer"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectKvSoftDelete')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d"
    policy_group_names   = []
    reference_id         = "KvSoftDelete"
    version              = "3.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectKvPurgeProtection')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0b60c0b2-2dc2-4e1c-b5c9-abbed971de53"
    policy_group_names   = []
    reference_id         = "KvPurgeProtection"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectKvSecretsExpire')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/98728c90-32c7-4049-8429-847dc0f4fe37"
    policy_group_names   = []
    reference_id         = "KvSecretsExpire"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectKvKeysExpire')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/152b15f7-8e1f-4c1f-ab71-8c010ba5dbc0"
    policy_group_names   = []
    reference_id         = "KvKeysExpire"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectKvFirewallEnabled')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/55615ac9-af46-4a59-874e-391cc3dfb490"
    policy_group_names   = []
    reference_id         = "KvFirewallEnabled"
    version              = "3.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectKvCertLifetime')]"
      }
      maximumPercentageLife = {
        value = "[parameters('maximumCertLifePercentageLife')]"
      }
      minimumDaysBeforeExpiry = {
        value = "[parameters('minimumCertLifeDaysBeforeExpiry')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/12ef42cb-9903-4e39-9c26-422d29570417"
    policy_group_names   = []
    reference_id         = "KvCertLifetime"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectKvKeysLifetime')]"
      }
      minimumDaysBeforeExpiration = {
        value = "[parameters('minimumKeysLifeDaysBeforeExpiry')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5ff38825-c5d8-47c5-b70e-069a21955146"
    policy_group_names   = []
    reference_id         = "KvKeysLifetime"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectKvSecretsLifetime')]"
      }
      minimumDaysBeforeExpiration = {
        value = "[parameters('minimumSecretsLifeDaysBeforeExpiry')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b0eb591a-5e70-4534-a8bf-04b9c489584a"
    policy_group_names   = []
    reference_id         = "KvSecretsLifetime"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Auto-AS-Update"
resource "azurerm_policy_set_definition" "deploy_auto_as_update" {
  description  = "Configure auto-assessment (every 24 hours) for OS updates on native Azure virtual machines. You can control the scope of assignment according to machine subscription, resource group, location or tag. Learn more about this for Windows: https://aka.ms/computevm-windowspatchassessmentmode, for Linux: https://aka.ms/computevm-linuxpatchassessmentmode."
  display_name = "Configure periodic checking for missing system updates on azure virtual machines"
  metadata = jsonencode({
    category  = "Azure Update Manager"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:53:24.5978301Z"
    updatedBy = null
    updatedOn = null
    version   = "4.4.1"
  })
  name        = "Deploy-Auto-AS-Update"
  parameters  = null
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      osType = {
        value = "Windows"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/59efceea-0c96-497e-a4a1-4eb2290dac15"
    policy_group_names   = []
    reference_id         = "Append-Auto-AS-WUpdate"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      osType = {
        value = "Linux"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/59efceea-0c96-497e-a4a1-4eb2290dac15"
    policy_group_names   = []
    reference_id         = "Append-Auto-AS-LUpdate"
    version              = "4.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Enforce-EncryptTransit"
resource "azurerm_policy_set_definition" "enforce_encrypt_transit" {
  description  = "Choose either Deploy if not exist and append in combination with audit or Select Deny in the Policy effect. Deny polices shift left. Deploy if not exist and append enforce but can be changed, and because missing exsistense condition require then the combination of Audit. "
  display_name = "Deny or Deploy and append TLS requirements and SSL enforcement on resources without Encryption in transit"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Encryption"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:55:00.4302935Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "2.0.0"
  })
  name = "Enforce-EncryptTransit"
  parameters = jsonencode({
    AKSIngressHttpsOnlyEffect = {
      allowedValues = ["audit", "deny", "disabled"]
      defaultValue  = "deny"
      metadata = {
        description = "This policy enforces HTTPS ingress in a Kubernetes cluster. This policy is generally available for Kubernetes Service (AKS), and preview for AKS Engine and Azure Arc enabled Kubernetes. For instructions on using this policy, visit https://aka.ms/kubepolicydoc."
        displayName = "AKS Service. Enforce HTTPS ingress in Kubernetes cluster"
      }
      type = "String"
    }
    APIAppServiceHttpsEffect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "Choose Deny or Audit in combination with Append policy. Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks."
        displayName = "App Service API App. API App should only be accessible over HTTPS. Choose Deny or Audit in combination with Append policy."
      }
      type = "String"
    }
    AppServiceHttpEffect = {
      allowedValues = ["Modify", "Disabled"]
      defaultValue  = "Modify"
      metadata = {
        description = "Append the AppService sites object to ensure that min Tls version is set to required TLS version. Please note Append does not enforce compliance use then deny."
        displayName = "App Service. Appends the AppService sites config WebApp, APIApp, Function App with TLS version selected below"
      }
      type = "String"
    }
    AppServiceTlsVersionEffect = {
      allowedValues = ["Append", "Disabled"]
      defaultValue  = "Append"
      metadata = {
        description = "App Service. Appends the AppService sites object to ensure that  HTTPS only is enabled for  server/service authentication and protects data in transit from network layer eavesdropping attacks. Please note Append does not enforce compliance use then deny."
        displayName = "App Service. Appends the AppService WebApp, APIApp, Function App to enable https only"
      }
      type = "String"
    }
    AppServiceminTlsVersion = {
      allowedValues = ["1.2", "1.0", "1.1"]
      defaultValue  = "1.2"
      metadata = {
        description = "App Service. Select version  minimum TLS version for a  Web App config to enforce"
        displayName = "App Service. Select version minimum TLS Web App config"
      }
      type = "String"
    }
    FunctionLatestTlsEffect = {
      allowedValues = ["AuditIfNotExists", "Disabled"]
      defaultValue  = "AuditIfNotExists"
      metadata = {
        description = "Only Audit, deny not possible as it is a related resource. Upgrade to the latest TLS version."
        displayName = "App Service Function App. Latest TLS version should be used in your Function App"
      }
      type = "String"
    }
    FunctionServiceHttpsEffect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "App Service Function App. Choose Deny or Audit in combination with Append policy. Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks."
        displayName = "App Service Function App. Function App should only be accessible over HTTPS. Choose Deny or Audit in combination with Append policy."
      }
      type = "String"
    }
    MySQLEnableSSLDeployEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploy a specific min TLS version requirement and enforce SSL on Azure Database for MySQL server. Enforce the Server to client applications using minimum version of Tls to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
        displayName = "MySQL database servers. Deploy if not exist set minimum TLS version Azure Database for MySQL server"
      }
      type = "String"
    }
    MySQLEnableSSLEffect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "Azure Database for MySQL supports connecting your Azure Database for MySQL server to client applications using Secure Sockets Layer (SSL). Enforcing SSL connections between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
        displayName = "MySQL database servers. Enforce SSL connection should be enabled for MySQL database servers"
      }
      type = "String"
    }
    MySQLminimalTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_0", "TLS1_1", "TLSEnforcementDisabled"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "Select version  minimum TLS version Azure Database for MySQL server to enforce"
        displayName = "MySQL database servers. Select version minimum TLS for MySQL server"
      }
      type = "String"
    }
    PostgreSQLEnableSSLDeployEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploy a specific min TLS version requirement and enforce SSL on Azure Database for PostgreSQL server. Enforce the Server to client applications using minimum version of Tls to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
        displayName = "PostgreSQL database servers. Deploy if not exist set minimum TLS version Azure Database for PostgreSQL server"
      }
      type = "String"
    }
    PostgreSQLEnableSSLEffect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "Azure Database for PostgreSQL supports connecting your Azure Database for PostgreSQL server to client applications using Secure Sockets Layer (SSL). Enforcing SSL connections between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
        displayName = "PostgreSQL database servers. Enforce SSL connection should be enabled for PostgreSQL database servers"
      }
      type = "String"
    }
    PostgreSQLminimalTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_0", "TLS1_1", "TLSEnforcementDisabled"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "PostgreSQL database servers. Select version  minimum TLS version Azure Database for MySQL server to enforce"
        displayName = "PostgreSQL database servers. Select version minimum TLS for MySQL server"
      }
      type = "String"
    }
    RedisMinTlsVersion = {
      allowedValues = ["1.2", "1.0", "1.1"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version  minimum TLS version for a Azure Cache for Redis to enforce"
        displayName = "Azure Cache for Redis.Select version minimum TLS for Azure Cache for Redis"
      }
      type = "String"
    }
    RedisTLSDeployEffect = {
      allowedValues = ["Append", "Disabled"]
      defaultValue  = "Append"
      metadata = {
        description = "Deploy a specific min TLS version requirement and enforce SSL on Azure Cache for Redis. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
        displayName = "Azure Cache for Redis. Deploy a specific min TLS version requirement and enforce SSL Azure Cache for Redis"
      }
      type = "String"
    }
    RedisTLSEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Azure Cache for Redis. Audit enabling of only connections via SSL to Azure Cache for Redis. Use of secure connections ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking."
        displayName = "Azure Cache for Redis. Only secure connections to your Azure Cache for Redis should be enabled"
      }
      type = "String"
    }
    SQLManagedInstanceMinTlsVersion = {
      allowedValues = ["1.2", "1.0", "1.1"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version  minimum TLS version for Azure Managed Instanceto to  enforce"
        displayName = "Azure Managed Instance.Select version minimum TLS for Azure Managed Instance"
      }
      type = "String"
    }
    SQLManagedInstanceTLSDeployEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploy a specific min TLS version requirement and enforce SSL on SQL servers. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
        displayName = "Azure Managed Instance. Deploy a specific min TLS version requirement and enforce SSL on SQL servers"
      }
      type = "String"
    }
    SQLManagedInstanceTLSEffect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "Setting minimal TLS version to 1.2 improves security by ensuring your SQL Managed Instance can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not recommended since they have well documented security vulnerabilities."
        displayName = "SQL Managed Instance should have the minimal TLS version of 1.2"
      }
      type = "String"
    }
    SQLServerTLSDeployEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploy a specific min TLS version requirement and enforce SSL on SQL servers. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
        displayName = "Azure SQL Database. Deploy a specific min TLS version requirement and enforce SSL on SQL servers"
      }
      type = "String"
    }
    SQLServerTLSEffect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "Setting minimal TLS version to 1.2 improves security by ensuring your Azure SQL Database can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not recommended since they have well documented security vulnerabilities."
        displayName = "Azure SQL Database should have the minimal TLS version of 1.2"
      }
      type = "String"
    }
    SQLServerminTlsVersion = {
      allowedValues = ["1.2", "1.0", "1.1"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version  minimum TLS version for Azure SQL Database to enforce"
        displayName = "Azure SQL Database.Select version minimum TLS for Azure SQL Database"
      }
      type = "String"
    }
    StorageDeployHttpsEnabledEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking"
        displayName = "Azure Storage Account. Deploy Secure transfer to storage accounts should be enabled"
      }
      type = "String"
    }
    StorageHttpsEnabledEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking"
        displayName = "Azure Storage Account. Secure transfer to storage accounts should be enabled"
      }
      type = "String"
    }
    StorageminimumTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_1", "TLS1_0"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "Select version  minimum TLS version on Azure Storage Account to enforce"
        displayName = "Storage Account select minimum TLS version"
      }
      type = "String"
    }
    WebAppServiceHttpsEffect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "Choose Deny or Audit in combination with Append policy. Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks."
        displayName = "App Service Web App. Web Application should only be accessible over HTTPS. Choose Deny or Audit in combination with Append policy."
      }
      type = "String"
    }
    WebAppServiceLatestTlsEffect = {
      allowedValues = ["AuditIfNotExists", "Disabled"]
      defaultValue  = "AuditIfNotExists"
      metadata = {
        description = "Only Audit, deny not possible as it is a related resource. Upgrade to the latest TLS version."
        displayName = "App Service Web App. Latest TLS version should be used in your Web App"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AppServiceHttpEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-AppService-httpsonly"
    policy_group_names   = []
    reference_id         = "AppServiceHttpEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AppServiceTlsVersionEffect')]"
      }
      minTlsVersion = {
        value = "[parameters('AppServiceminTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-AppService-latestTLS"
    policy_group_names   = []
    reference_id         = "AppServiceminTlsVersion"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('FunctionLatestTlsEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f9d614c5-c173-4d56-95a7-b4437057d193"
    policy_group_names   = []
    reference_id         = "FunctionLatestTlsEffect"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('WebAppServiceLatestTlsEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f0e6e85b-9b9f-4a4b-b67b-f730d42f1b0b"
    policy_group_names   = []
    reference_id         = "WebAppServiceLatestTlsEffect"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('APIAppServiceHttpsEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceApiApp-http"
    policy_group_names   = []
    reference_id         = "APIAppServiceHttpsEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('FunctionServiceHttpsEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceFunctionApp-http"
    policy_group_names   = []
    reference_id         = "FunctionServiceHttpsEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('WebAppServiceHttpsEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceWebApp-http"
    policy_group_names   = []
    reference_id         = "WebAppServiceHttpsEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AKSIngressHttpsOnlyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d"
    policy_group_names   = []
    reference_id         = "AKSIngressHttpsOnlyEffect"
    version              = "8.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MySQLEnableSSLDeployEffect')]"
      }
      minimalTlsVersion = {
        value = "[parameters('MySQLminimalTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-MySQL-sslEnforcement"
    policy_group_names   = []
    reference_id         = "MySQLEnableSSLDeployEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MySQLEnableSSLEffect')]"
      }
      minimalTlsVersion = {
        value = "[parameters('MySQLminimalTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MySql-http"
    policy_group_names   = []
    reference_id         = "MySQLEnableSSLEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('PostgreSQLEnableSSLDeployEffect')]"
      }
      minimalTlsVersion = {
        value = "[parameters('PostgreSQLminimalTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-PostgreSQL-sslEnforcement"
    policy_group_names   = []
    reference_id         = "PostgreSQLEnableSSLDeployEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('PostgreSQLEnableSSLEffect')]"
      }
      minimalTlsVersion = {
        value = "[parameters('PostgreSQLminimalTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-PostgreSql-http"
    policy_group_names   = []
    reference_id         = "PostgreSQLEnableSSLEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('RedisTLSDeployEffect')]"
      }
      minimumTlsVersion = {
        value = "[parameters('RedisMinTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-Redis-sslEnforcement"
    policy_group_names   = []
    reference_id         = "RedisTLSDeployEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('RedisTLSDeployEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-Redis-disableNonSslPort"
    policy_group_names   = []
    reference_id         = "RedisdisableNonSslPort"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('RedisTLSEffect')]"
      }
      minimumTlsVersion = {
        value = "[parameters('RedisMinTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Redis-http"
    policy_group_names   = []
    reference_id         = "RedisDenyhttps"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SQLManagedInstanceTLSDeployEffect')]"
      }
      minimalTlsVersion = {
        value = "[parameters('SQLManagedInstanceMinTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-SqlMi-minTLS"
    policy_group_names   = []
    reference_id         = "SQLManagedInstanceTLSDeployEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SQLManagedInstanceTLSEffect')]"
      }
      minimalTlsVersion = {
        value = "[parameters('SQLManagedInstanceMinTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-SqlMi-minTLS"
    policy_group_names   = []
    reference_id         = "SQLManagedInstanceTLSEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SQLServerTLSDeployEffect')]"
      }
      minimalTlsVersion = {
        value = "[parameters('SQLServerminTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-SQL-minTLS"
    policy_group_names   = []
    reference_id         = "SQLServerTLSDeployEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SQLServerTLSEffect')]"
      }
      minimalTlsVersion = {
        value = "[parameters('SQLServerminTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Sql-minTLS"
    policy_group_names   = []
    reference_id         = "SQLServerTLSEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StorageHttpsEnabledEffect')]"
      }
      minimumTlsVersion = {
        value = "[parameters('StorageMinimumTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Storage-minTLS"
    policy_group_names   = []
    reference_id         = "StorageHttpsEnabledEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StorageDeployHttpsEnabledEffect')]"
      }
      minimumTlsVersion = {
        value = "[parameters('StorageMinimumTlsVersion')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Storage-sslEnforcement"
    policy_group_names   = []
    reference_id         = "StorageDeployHttpsEnabledEffect"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Control-Network-Traffic"
resource "azurerm_policy_set_definition" "control_network_traffic" {
  description  = "This policy initiative controls Network Traffic flows within Virtual Networks on the routing level."
  display_name = "Control network traffic routing"
  metadata = jsonencode({
    category  = "Network"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:55:00.3778245Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  name = "Control-Network-Traffic"
  parameters = jsonencode({
    appendDefaultRoute = {
      allowedValues = ["Disabled", "Modify"]
      metadata = {
        description = "Create default route on a RouteTable if it doesn't exist? Should be set to Disabled for seured-vhub vWAN, Modify for any other setup."
        displayName = "Append Default Route"
      }
      type = "String"
    }
    denyInternetRoute = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Should a direct route to Internet be denied? Allowed values are Audit, Deny and Disabled."
        displayName = "Deny Direct Internet Route effect"
      }
      type = "String"
    }
    requireRoutePropagation = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Should BGP route propagation be enabled? Allowed values are Audit, Deny and Disabled."
        displayName = "Require Route Propagation effect"
      }
      type = "String"
    }
    routeTableSettings = {
      metadata = {
        description = "Location-specific settings for route tables."
        displayName = "RouteTable Settings"
      }
      type = "Object"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      denyInternetRoute = {
        value = "[parameters('denyInternetRoute')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Routes-NextHop-Internet"
    policy_group_names   = []
    reference_id         = "Deny-Routes-NextHop-Internet"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      routeTableSettings = {
        value = "[parameters('routeTableSettings')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Routetable-Nexthop-VirtualAppliance"
    policy_group_names   = []
    reference_id         = "Deny-Routetable-Nexthop-VirtualAppliance"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      appendDefaultRoute = {
        value = "[parameters('appendDefaultRoute')]"
      }
      routeTableSettings = {
        value = "[parameters('routeTableSettings')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Modify-Routetable-Nexthop-VirtualAppliance"
    policy_group_names   = []
    reference_id         = "Modify-Routetable-Nexthop-VirtualAppliance"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      requireRoutePropagation = {
        value = "[parameters('requireRoutePropagation')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-Route-Propagation"
    policy_group_names   = []
    reference_id         = "Require-Route-Propagation"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deploy-MDFC-Config"
resource "azurerm_policy_set_definition" "deploy_mdfc_config" {
  description  = "Deploy Microsoft Defender for Cloud configuration"
  display_name = "Deploy Microsoft Defender for Cloud configuration"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Security Center"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:21:54.7938443Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "6.0.1"
  })
  name = "Deploy-MDFC-Config"
  parameters = jsonencode({
    ascExportResourceGroupLocation = {
      metadata = {
        description = "The location where the resource group and the export to Log Analytics workspace configuration are created."
        displayName = "Resource Group location for the export to Log Analytics workspace configuration"
      }
      type = "String"
    }
    ascExportResourceGroupName = {
      metadata = {
        description = "The resource group name where the export to Log Analytics workspace configuration is created. If you enter a name for a resource group that doesn't exist, it'll be created in the subscription. Note that each resource group can only have one export to Log Analytics workspace configured."
        displayName = "Resource Group name for the export to Log Analytics workspace configuration"
      }
      type = "String"
    }
    emailSecurityContact = {
      metadata = {
        description = "Provide email address for Microsoft Defender for Cloud contact details"
        displayName = "Security contacts email address"
      }
      type = "String"
    }
    enableAscForAppServices = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForArm = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForContainers = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForCosmosDbs = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForCspm = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForKeyVault = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForOssDb = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForServers = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForServersVulnerabilityAssessments = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSql = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlOnVm = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForStorage = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    logAnalytics = {
      metadata = {
        description = "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID."
        displayName = "Primary Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    minimalSeverity = {
      allowedValues = ["High", "Medium", "Low"]
      defaultValue  = "High"
      metadata = {
        description = "Defines the minimal alert severity which will be sent as email notifications"
        displayName = "Minimal severity"
      }
      type = "String"
    }
    vulnerabilityAssessmentProvider = {
      allowedValues = ["default", "mdeTvm"]
      defaultValue  = "default"
      metadata = {
        description = "Select the vulnerability assessment solution to provision to machines."
        displayName = "Vulnerability assessment provider type"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForOssDb')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/44433aa3-7ec2-4002-93ea-65c65ff0310a"
    policy_group_names   = []
    reference_id         = "defenderForOssDb"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForServers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8e86a5b6-b9bd-49d1-8e21-4bb8a0862222"
    policy_group_names   = []
    reference_id         = "defenderForVM"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForServersVulnerabilityAssessments')]"
      }
      vaType = {
        value = "[parameters('vulnerabilityAssessmentProvider')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/13ce0167-8ca6-4048-8e6b-f996402e3c1b"
    policy_group_names   = []
    reference_id         = "defenderForVMVulnerabilityAssessment"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlOnVm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/50ea7265-7d8c-429e-9a7d-ca1f410191c3"
    policy_group_names   = []
    reference_id         = "defenderForSqlServerVirtualMachines"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForAppServices')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d"
    policy_group_names   = []
    reference_id         = "defenderForAppServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForStorage')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cfdc5972-75b3-4418-8ae1-7f5c36839390"
    policy_group_names   = []
    reference_id         = "defenderForStorageAccountsV2"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForContainers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9ddb292-b203-4738-aead-18e2716e858f"
    policy_group_names   = []
    reference_id         = "defenderforContainers"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForContainers')]"
      }
      logAnalyticsWorkspaceResourceId = {
        value = "[parameters('logAnalytics')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/64def556-fbad-4622-930e-72d1d5589bf5"
    policy_group_names   = []
    reference_id         = "defenderforKubernetes"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForContainers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a8eff44f-8c92-45c3-a3fb-9880802d67a7"
    policy_group_names   = []
    reference_id         = "azurePolicyForKubernetes"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForKeyVault')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f725891-01c0-420a-9059-4fa46cb770b7"
    policy_group_names   = []
    reference_id         = "defenderForKeyVaults"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForArm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b7021b2b-08fd-4dc0-9de7-3c6ece09faf9"
    policy_group_names   = []
    reference_id         = "defenderForArm"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSql')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b99b73e7-074b-4089-9395-b7236f094491"
    policy_group_names   = []
    reference_id         = "defenderForSqlPaas"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForCosmosDbs')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/82bf5b87-728b-4a74-ba4d-6123845cf542"
    policy_group_names   = []
    reference_id         = "defenderForCosmosDbs"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForCspm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/72f8cee7-2937-403d-84a1-a4e3e57f3c21"
    policy_group_names   = []
    reference_id         = "defenderForCspm"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      emailSecurityContact = {
        value = "[parameters('emailSecurityContact')]"
      }
      minimalSeverity = {
        value = "[parameters('minimalSeverity')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-ASC-SecurityContacts"
    policy_group_names   = []
    reference_id         = "securityEmailContact"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      resourceGroupLocation = {
        value = "[parameters('ascExportResourceGroupLocation')]"
      }
      resourceGroupName = {
        value = "[parameters('ascExportResourceGroupName')]"
      }
      workspaceResourceId = {
        value = "[parameters('logAnalytics')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ffb6f416-7bd2-4488-8828-56585fef2be9"
    policy_group_names   = []
    reference_id         = "ascExport"
    version              = "4.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Enforce-ALZ-Sandbox"
resource "azurerm_policy_set_definition" "enforce_alz_sandbox" {
  description  = "Enforce policies in the Sandbox Landing Zone."
  display_name = "Enforce policies in the Sandbox Landing Zone"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Sandbox"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:53:24.6224511Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  name = "Enforce-ALZ-Sandbox"
  parameters = jsonencode({
    effectDenyVnetPeering = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effectNotAllowedResources = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    listOfResourceTypesNotAllowed = {
      defaultValue = []
      metadata = {
        description = "Not allowed resource types in the Sandbox landing zone, default is none."
        displayName = "Not allowed resource types in the Sandbox landing zone"
        strongType  = "resourceTypes"
      }
      type = "Array"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectNotAllowedResources')]"
      }
      listOfResourceTypesNotAllowed = {
        value = "[parameters('listOfResourceTypesNotAllowed')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6c112d4e-5bc7-47ae-a041-ea2d9dccd749"
    policy_group_names   = []
    reference_id         = "SandboxNotAllowed"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectDenyVnetPeering')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VNET-Peer-Cross-Sub"
    policy_group_names   = []
    reference_id         = "SandboxDenyVnetPeering"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Audit-UnusedResourcesCostOptimization"
resource "azurerm_policy_set_definition" "audit_unused_resources_cost_optimization" {
  description  = "Optimize cost by detecting unused but chargeable resources. Leverage this Azure Policy Initiative as a cost control tool to reveal orphaned resources that are contributing cost."
  display_name = "Unused resources driving cost should be avoided"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Cost Optimization"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:56:37.4310604Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:10:46.240328Z"
    version              = "2.0.0"
  })
  name = "Audit-UnusedResourcesCostOptimization"
  parameters = jsonencode({
    effectDisks = {
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy for Microsoft.Compute/disks"
        displayName = "Disks Effect"
      }
      type = "String"
    }
    effectPublicIpAddresses = {
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy for Microsoft.Network/publicIpAddresses"
        displayName = "PublicIpAddresses Effect"
      }
      type = "String"
    }
    effectServerFarms = {
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy for Microsoft.Web/serverfarms"
        displayName = "ServerFarms Effect"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectDisks')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-Disks-UnusedResourcesCostOptimization"
    policy_group_names   = []
    reference_id         = "AuditDisksUnusedResourcesCostOptimization"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectPublicIpAddresses')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-PublicIpAddresses-UnusedResourcesCostOptimization"
    policy_group_names   = []
    reference_id         = "AuditPublicIpAddressesUnusedResourcesCostOptimization"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effectServerFarms')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-ServerFarms-UnusedResourcesCostOptimization"
    policy_group_names   = []
    reference_id         = "AuditServerFarmsUnusedResourcesCostOptimization"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "Audit"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-AzureHybridBenefit"
    policy_group_names   = []
    reference_id         = "AuditAzureHybridBenefitUnusedResourcesCostOptimization"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-landingzones/providers/Microsoft.Authorization/policySetDefinitions/Deploy-ASCDF-Config"
resource "azurerm_policy_set_definition" "deploy_ascdf_config_lz" {
  description  = "Deploy Azure Security Center configuration"
  display_name = "Deploy Azure Security Center configuration"
  metadata = jsonencode({
    category  = "Security Center"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:55:00.563779Z"
    updatedBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn = "2025-02-05T21:10:46.3031759Z"
    version   = "2.0.0"
  })
  name = "Deploy-ASCDF-Config"
  parameters = jsonencode({
    emailSecurityContact = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Provide email address for Azure Security Center contact details"
        displayName = "Security contacts email address"
      }
      type = "String"
    }
    enableAscCsmp = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForAppServices = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForArm = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForContainers = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForCosmosDbs = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForDns = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForKeyVault = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForOssDb = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForServers = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSql = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlMi = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlOnVm = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlSynapse = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForStorage = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    isOnUploadMalwareScanningEnabled = {
      defaultValue = "true"
      metadata = {
        description = "Enable or disable the Malware Scanning add-on feature"
        displayName = "Malware Scanning Enabled"
      }
      type = "String"
    }
    isSensitiveDataDiscoveryEnabled = {
      defaultValue = "true"
      metadata = {
        description = "Enable or disable the Sensitive Data Threat Detection add-on feature"
        displayName = "Sensitive Data Threat Detection Enabledt"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForOssDb')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/44433aa3-7ec2-4002-93ea-65c65ff0310a"
    policy_group_names   = []
    reference_id         = "defenderForOssDb"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForServers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8e86a5b6-b9bd-49d1-8e21-4bb8a0862222"
    policy_group_names   = []
    reference_id         = "defenderForVM"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlOnVm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/50ea7265-7d8c-429e-9a7d-ca1f410191c3"
    policy_group_names   = []
    reference_id         = "defenderForSqlServerVirtualMachines"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForAppServices')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d"
    policy_group_names   = []
    reference_id         = "defenderForAppServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForStorage')]"
      }
      isOnUploadMalwareScanningEnabled = {
        value = "[parameters('isOnUploadMalwareScanningEnabled')]"
      }
      isSensitiveDataDiscoveryEnabled = {
        value = "[parameters('isSensitiveDataDiscoveryEnabled')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cfdc5972-75b3-4418-8ae1-7f5c36839390"
    policy_group_names   = []
    reference_id         = "defenderForStorageAccounts"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      Effect = {
        value = "[parameters('enableAscForKeyVault')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f725891-01c0-420a-9059-4fa46cb770b7"
    policy_group_names   = []
    reference_id         = "defenderForKeyVaults"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForDns')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2370a3c1-4a25-4283-a91a-c9c1a145fb2f"
    policy_group_names   = []
    reference_id         = "defenderForDns"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForArm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b7021b2b-08fd-4dc0-9de7-3c6ece09faf9"
    policy_group_names   = []
    reference_id         = "defenderForArm"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSql')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b99b73e7-074b-4089-9395-b7236f094491"
    policy_group_names   = []
    reference_id         = "defenderForSqlPaas"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      emailSecurityContact = {
        value = "[parameters('emailSecurityContact')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-ASC-SecurityContacts"
    policy_group_names   = []
    reference_id         = "securityEmailContact"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForContainers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9ddb292-b203-4738-aead-18e2716e858f"
    policy_group_names   = []
    reference_id         = "defenderForContainers"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlSynapse')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/951c1558-50a5-4ca3-abb6-a93e3e2367a6"
    policy_group_names   = []
    reference_id         = "defenderForSqlSynapse"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForCosmosDbs')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/82bf5b87-728b-4a74-ba4d-6123845cf542"
    policy_group_names   = []
    reference_id         = "defenderForCosmosDbs"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscCsmp')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/689f7782-ef2c-4270-a6d0-7664869076bd"
    policy_group_names   = []
    reference_id         = "defenderCsmp"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlMi')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c5a62eb0-c65a-4220-8a4d-f70dd4ca95dd"
    policy_group_names   = []
    reference_id         = "defenderForSqlMi"
    version              = "2.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deploy-ASCDF-Config"
resource "azurerm_policy_set_definition" "deploy_ascdf_config" {
  description  = "Deploy Azure Security Center configuration"
  display_name = "Deploy Azure Security Center configuration"
  metadata = jsonencode({
    category  = "Security Center"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:53:24.5429524Z"
    updatedBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn = "2025-02-05T21:10:46.3294848Z"
    version   = "2.0.0"
  })
  name = "Deploy-ASCDF-Config"
  parameters = jsonencode({
    emailSecurityContact = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Provide email address for Azure Security Center contact details"
        displayName = "Security contacts email address"
      }
      type = "String"
    }
    enableAscCsmp = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForAppServices = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForArm = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForContainers = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForCosmosDbs = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForDns = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForKeyVault = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForOssDb = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForServers = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSql = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlMi = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlOnVm = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlSynapse = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForStorage = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    isOnUploadMalwareScanningEnabled = {
      defaultValue = "true"
      metadata = {
        description = "Enable or disable the Malware Scanning add-on feature"
        displayName = "Malware Scanning Enabled"
      }
      type = "String"
    }
    isSensitiveDataDiscoveryEnabled = {
      defaultValue = "true"
      metadata = {
        description = "Enable or disable the Sensitive Data Threat Detection add-on feature"
        displayName = "Sensitive Data Threat Detection Enabledt"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForOssDb')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/44433aa3-7ec2-4002-93ea-65c65ff0310a"
    policy_group_names   = []
    reference_id         = "defenderForOssDb"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForServers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8e86a5b6-b9bd-49d1-8e21-4bb8a0862222"
    policy_group_names   = []
    reference_id         = "defenderForVM"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlOnVm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/50ea7265-7d8c-429e-9a7d-ca1f410191c3"
    policy_group_names   = []
    reference_id         = "defenderForSqlServerVirtualMachines"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForAppServices')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d"
    policy_group_names   = []
    reference_id         = "defenderForAppServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForStorage')]"
      }
      isOnUploadMalwareScanningEnabled = {
        value = "[parameters('isOnUploadMalwareScanningEnabled')]"
      }
      isSensitiveDataDiscoveryEnabled = {
        value = "[parameters('isSensitiveDataDiscoveryEnabled')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cfdc5972-75b3-4418-8ae1-7f5c36839390"
    policy_group_names   = []
    reference_id         = "defenderForStorageAccounts"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      Effect = {
        value = "[parameters('enableAscForKeyVault')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f725891-01c0-420a-9059-4fa46cb770b7"
    policy_group_names   = []
    reference_id         = "defenderForKeyVaults"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForDns')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2370a3c1-4a25-4283-a91a-c9c1a145fb2f"
    policy_group_names   = []
    reference_id         = "defenderForDns"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForArm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b7021b2b-08fd-4dc0-9de7-3c6ece09faf9"
    policy_group_names   = []
    reference_id         = "defenderForArm"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSql')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b99b73e7-074b-4089-9395-b7236f094491"
    policy_group_names   = []
    reference_id         = "defenderForSqlPaas"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      emailSecurityContact = {
        value = "[parameters('emailSecurityContact')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-ASC-SecurityContacts"
    policy_group_names   = []
    reference_id         = "securityEmailContact"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForContainers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9ddb292-b203-4738-aead-18e2716e858f"
    policy_group_names   = []
    reference_id         = "defenderForContainers"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlSynapse')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/951c1558-50a5-4ca3-abb6-a93e3e2367a6"
    policy_group_names   = []
    reference_id         = "defenderForSqlSynapse"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForCosmosDbs')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/82bf5b87-728b-4a74-ba4d-6123845cf542"
    policy_group_names   = []
    reference_id         = "defenderForCosmosDbs"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscCsmp')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/689f7782-ef2c-4270-a6d0-7664869076bd"
    policy_group_names   = []
    reference_id         = "defenderCsmp"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlMi')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c5a62eb0-c65a-4220-8a4d-f70dd4ca95dd"
    policy_group_names   = []
    reference_id         = "defenderForSqlMi"
    version              = "2.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Sql-Security"
resource "azurerm_policy_set_definition" "deploy_sql_security" {
  description  = "Deploy auditing, Alert, TDE and SQL vulnerability to SQL Databases when it not exist in the deployment"
  display_name = "Deploy SQL Database built-in SQL security configuration"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:53:24.6294032Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  name = "Deploy-Sql-Security"
  parameters = jsonencode({
    SqlDbAuditingSettingsDeploySqlSecurityEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploy auditing settings to SQL Database when it not exist in the deployment"
        displayName = "Deploy SQL database auditing settings"
      }
      type = "String"
    }
    SqlDbSecurityAlertPoliciesDeploySqlSecurityEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploy the security Alert Policies configuration with email admin accounts when it not exist in current configuration"
        displayName = "Deploy SQL Database security Alert Policies configuration with email admin accounts"
      }
      type = "String"
    }
    SqlDbTdeDeploySqlSecurityEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploy the Transparent Data Encryption when it is not enabled in the deployment"
        displayName = "Deploy SQL Database Transparent Data Encryption "
      }
      type = "String"
    }
    SqlDbVulnerabilityAssessmentsDeploySqlSecurityEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploy SQL Database vulnerability Assessments when it not exist in the deployment. To the specific  storage account in the parameters"
        displayName = "Deploy SQL Database vulnerability Assessments"
      }
      type = "String"
    }
    vulnerabilityAssessmentsEmail = {
      metadata = {
        description = "The email address to send alerts"
        displayName = "The email address to send alerts"
      }
      type = "String"
    }
    vulnerabilityAssessmentsStorageID = {
      metadata = {
        description = "The storage account ID to store assessments"
        displayName = "The storage account ID to store assessments"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SqlDbTdeDeploySqlSecurityEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/86a912f6-9a06-4e26-b447-11b16ba8659f"
    policy_group_names   = []
    reference_id         = "SqlDbTdeDeploySqlSecurity"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SqlDbSecurityAlertPoliciesDeploySqlSecurityEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-SecurityAlertPolicies"
    policy_group_names   = []
    reference_id         = "SqlDbSecurityAlertPoliciesDeploySqlSecurity"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SqlDbAuditingSettingsDeploySqlSecurityEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-AuditingSettings"
    policy_group_names   = []
    reference_id         = "SqlDbAuditingSettingsDeploySqlSecurity"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SqlDbVulnerabilityAssessmentsDeploySqlSecurityEffect')]"
      }
      vulnerabilityAssessmentsEmail = {
        value = "[parameters('vulnerabilityAssessmentsEmail')]"
      }
      vulnerabilityAssessmentsStorageID = {
        value = "[parameters('vulnerabilityAssessmentsStorageID')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-vulnerabilityAssessments"
    policy_group_names   = []
    reference_id         = "SqlDbVulnerabilityAssessmentsDeploySqlSecurity"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform
resource "azurerm_policy_set_definition" "deploy_private_dns_zones" {
  description  = "This policy initiative is a group of policies that ensures private endpoints to Azure PaaS services are integrated with Azure Private DNS zones"
  display_name = "Configure Azure PaaS services to use private DNS zones"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:53:25.0073857Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:10:46.3711727Z"
    version              = "2.1.1"
  })
  name = "Deploy-Private-DNS-Zones"
  parameters = jsonencode({
    azureAcrPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAcrPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAppPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAppPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAppServicesPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAppServicesPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAsrPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAsrPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAutomationDSCHybridPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAutomationDSCHybridPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAutomationWebhookPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAutomationWebhookPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureBatchPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureBatchPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCognitiveSearchPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCognitiveSearchPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCognitiveServicesPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCognitiveServicesPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosCassandraPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosCassandraPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosGremlinPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosGremlinPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosMongoPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosMongoPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosSQLPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosSQLPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosTablePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosTablePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDataFactoryPortalPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDataFactoryPortalPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDataFactoryPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDataFactoryPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDatabricksPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDatabricksPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDiskAccessPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDiskAccessPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureEventGridDomainsPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureEventGridDomainsPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureEventGridTopicsPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureEventGridTopicsPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureEventHubNamespacePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureEventHubNamespacePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureFilePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureFilePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureHDInsightPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureHDInsightPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureIotHubsPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureIotHubsPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureIotPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureIotPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureKeyVaultPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureKeyVaultPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMachineLearningWorkspacePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMachineLearningWorkspacePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMediaServicesKeyPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMediaServicesKeyPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMediaServicesLivePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMediaServicesLivePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMediaServicesStreamPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMediaServicesStreamPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMigratePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMigratePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId1 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId1"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId2 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId2"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId3 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId3"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId4 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId4"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId5 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId5"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureRedisCachePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureRedisCachePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureServiceBusNamespacePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureServiceBusNamespacePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSignalRPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSignalRPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageBlobPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageBlobPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageBlobSecPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageBlobSecPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageDFSPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageDFSPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageDFSSecPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageDFSSecPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageFilePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageFilePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageQueuePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageQueuePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageQueueSecPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageQueueSecPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageStaticWebPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageStaticWebPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageStaticWebSecPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageStaticWebSecPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSynapseDevPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSynapseDevPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSynapseSQLODPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSynapseSQLODPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSynapseSQLPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSynapseSQLPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureWebPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureWebPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effect1 = {
      allowedValues = ["deployIfNotExists", "Disabled"]
      defaultValue  = "deployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureFilePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06695360-db88-47f6-b976-7500d4297475"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-File-Sync"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAutomationWebhookPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "Webhook"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6dd01e4f-1be1-4e80-9d0b-d109e04cb064"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Automation-Webhook"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAutomationDSCHybridPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "DSCAndHybridWorker"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6dd01e4f-1be1-4e80-9d0b-d109e04cb064"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Automation-DSCHybrid"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosSQLPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "SQL"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-SQL"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosMongoPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "MongoDB"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-MongoDB"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosCassandraPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "Cassandra"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-Cassandra"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosGremlinPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "Gremlin"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-Gremlin"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosTablePrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "Table"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-Table"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      listOfGroupIds = {
        value = ["dataFactory"]
      }
      privateDnsZoneId = {
        value = "[parameters('azureDataFactoryPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/86cd96e1-1745-420d-94d4-d3f2fe415aa4"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-DataFactory"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      listOfGroupIds = {
        value = ["portal"]
      }
      privateDnsZoneId = {
        value = "[parameters('azureDataFactoryPortalPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/86cd96e1-1745-420d-94d4-d3f2fe415aa4"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-DataFactory-Portal"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "databricks_ui_api"
      }
      privateDnsZoneId = {
        value = "[parameters('azureDatabricksPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0eddd7f3-3d9b-4927-a07a-806e8ac9486c"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Databrics-UI-Api"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "browser_authentication"
      }
      privateDnsZoneId = {
        value = "[parameters('azureDatabricksPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0eddd7f3-3d9b-4927-a07a-806e8ac9486c"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Databrics-Browser-AuthN"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "cluster"
      }
      privateDnsZoneId = {
        value = "[parameters('azureHDInsightPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/43d6e3bd-fc6a-4b44-8b4d-2151d8736a11"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-HDInsight"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMigratePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7590a335-57cf-4c95-babd-ecbc8fafeb1f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Migrate"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageBlobPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/75973700-529f-4de2-b794-fb9b6781b6b0"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-Blob"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageBlobSecPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d847d34b-9337-4e2d-99a5-767e5ac9c582"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-Blob-Sec"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageQueuePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/bcff79fb-2b0d-47c9-97e5-3023479b00d1"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-Queue"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageQueueSecPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/da9b4ae8-5ddc-48c5-b9c0-25f8abf7a3d6"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-Queue-Sec"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageFilePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6df98d03-368a-4438-8730-a93c4d7693d6"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-File"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageStaticWebPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/9adab2a5-05ba-4fbd-831a-5bf958d04218"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-StaticWeb"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageStaticWebSecPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d19ae5f1-b303-4b82-9ca8-7682749faf0c"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-StaticWeb-Sec"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageDFSPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83c6fe0f-2316-444a-99a1-1ecd8a7872ca"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-DFS"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageDFSSecPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/90bd4cb3-9f59-45f7-a6ca-f69db2726671"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-DFS-Sec"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSynapseSQLPrivateDnsZoneId')]"
      }
      targetSubResource = {
        value = "Sql"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e5ed725-f16c-478b-bd4b-7bfa2f7940b9"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Synapse-SQL"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSynapseSQLODPrivateDnsZoneId')]"
      }
      targetSubResource = {
        value = "SqlOnDemand"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e5ed725-f16c-478b-bd4b-7bfa2f7940b9"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Synapse-SQL-OnDemand"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSynapseDevPrivateDnsZoneId')]"
      }
      targetSubResource = {
        value = "Dev"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e5ed725-f16c-478b-bd4b-7bfa2f7940b9"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Synapse-Dev"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "keydelivery"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMediaServicesKeyPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4a7f6c1-585e-4177-ad5b-c2c93f4bb991"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MediaServices-Key"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "liveevent"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMediaServicesLivePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4a7f6c1-585e-4177-ad5b-c2c93f4bb991"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MediaServices-Live"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "streamingendpoint"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMediaServicesStreamPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4a7f6c1-585e-4177-ad5b-c2c93f4bb991"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MediaServices-Stream"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId1 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId1')]"
      }
      privateDnsZoneId2 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId2')]"
      }
      privateDnsZoneId3 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId3')]"
      }
      privateDnsZoneId4 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId4')]"
      }
      privateDnsZoneId5 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId5')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/437914ee-c176-4fff-8986-7e05eb971365"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Monitor"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureWebPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0b026355-49cb-467b-8ac4-f777874e175a"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Web"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureBatchPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4ec38ebc-381f-45ee-81a4-acbc4be878f8"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Batch"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAppPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7a860e27-9ca2-4fc6-822d-c2d248c300df"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-App"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAsrPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/942bd215-1a66-44be-af65-6a1c0318dbe2"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Site-Recovery"
    version              = "1.0-preview"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureIotPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/aaa64d2d-2fa3-45e5-b332-0b031b9b30e8"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-IoT"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureKeyVaultPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ac673a9a-f77d-4846-b2d8-a57f8e1c01d4"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-KeyVault"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSignalRPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b0e86710-7fb7-4a6c-a064-32e9b829509e"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-SignalR"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAppServicesPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b318f84a-b872-429b-ac6d-a01b96814452"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-AppServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect1')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureEventGridTopicsPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/baf19753-7502-405f-8745-370519b20483"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-EventGridTopics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureDiskAccessPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/bc05b96c-0b36-4ca9-82f0-5c53f96ce05a"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-DiskAccess"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCognitiveServicesPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c4bc6f10-cb41-49eb-b000-d5ab82e2a091"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-CognitiveServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect1')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureIotHubsPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c99ce9c1-ced7-4c3e-aca0-10e69ce0cb02"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-IoTHubs"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect1')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureEventGridDomainsPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d389df0a-e0d7-4607-833c-75a6fdac2c2d"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-EventGridDomains"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureRedisCachePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e016b22b-e0eb-436d-8fd7-160c4eaed6e2"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-RedisCache"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAcrPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e9585a95-5b8c-4d03-b193-dc7eb5ac4c32"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-ACR"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureEventHubNamespacePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ed66d4f5-8220-45dc-ab4a-20d1749c74e6"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-EventHubNamespace"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMachineLearningWorkspacePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ee40564d-486e-4f68-a5ca-7a621edae0fb"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MachineLearningWorkspace"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureServiceBusNamespacePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f0fcf93c-c063-4071-9668-c47474bd3564"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-ServiceBusNamespace"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCognitiveSearchPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fbc14a67-53e4-4932-abcc-2049c6706009"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-CognitiveSearch"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deny-PublicPaaSEndpoints"
resource "azurerm_policy_set_definition" "deny_public_paas_endpoints" {
  description  = "This policy initiative is a group of policies that prevents creation of Azure PaaS services with exposed public endpoints"
  display_name = "Public network access should be disabled for PaaS services"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Network"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:10:46.3866714Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "3.1.0"
  })
  name = "Deny-PublicPaaSEndpoints"
  parameters = jsonencode({
    ACRPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies the creation of Azure Container Registires with exposed public endpoints "
        displayName = "Public network access on Azure Container Registry disabled"
      }
      type = "String"
    }
    AFSPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies the creation of Azure File Sync instances with exposed public endpoints "
        displayName = "Public network access on Azure File Sync disabled"
      }
      type = "String"
    }
    AKSPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies  the creation of  Azure Kubernetes Service non-private clusters"
        displayName = "Public network access on AKS API should be disabled"
      }
      type = "String"
    }
    ApiManPublicIpDenyEffect = {
      allowedValues = ["AuditIfNotExists", "Disabled"]
      defaultValue  = "AuditIfNotExists"
      metadata = {
        description = "This policy denies creation of API Management services with exposed public endpoints"
        displayName = "Public network access should be disabled for API Management services"
      }
      type = "String"
    }
    AppConfigPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of App Configuration with exposed public endpoints"
        displayName = "Public network access should be disabled for App Configuration"
      }
      type = "String"
    }
    AsPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of App Service apps with exposed public endpoints"
        displayName = "Public network access should be disabled for App Service apps"
      }
      type = "String"
    }
    AsePublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of App Service Environment apps with exposed public endpoints"
        displayName = "Public network access should be disabled for App Service Environment apps"
      }
      type = "String"
    }
    AutomationPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Automation accounts with exposed public endpoints. Bots should be seet to 'isolated only' mode"
        displayName = "Public network access should be disabled for Automation accounts"
      }
      type = "String"
    }
    BatchPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Azure Batch Instances with exposed public endpoints"
        displayName = "Public network access should be disabled for Azure Batch Instances"
      }
      type = "String"
    }
    BotServicePublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Bot Service with exposed public endpoints. Bots should be seet to 'isolated only' mode"
        displayName = "Public network access should be disabled for Bot Service"
      }
      type = "String"
    }
    CosmosPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies that  Cosmos database accounts  are created with out public network access is disabled."
        displayName = "Public network access should be disabled for CosmosDB"
      }
      type = "String"
    }
    FunctionPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Function apps with exposed public endpoints"
        displayName = "Public network access should be disabled for Function apps"
      }
      type = "String"
    }
    KeyVaultPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Key Vaults with IP Firewall exposed to all public endpoints"
        displayName = "Public network access should be disabled for KeyVault"
      }
      type = "String"
    }
    MariaDbPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Azure MariaDB with exposed public endpoints"
        displayName = "Public network access should be disabled for Azure MariaDB"
      }
      type = "String"
    }
    MlPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Azure Machine Learning with exposed public endpoints"
        displayName = "Public network access should be disabled for Azure Machine Learning"
      }
      type = "String"
    }
    MySQLFlexPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of MySql Flexible Server DB accounts with exposed public endpoints"
        displayName = "Public network access should be disabled for MySQL Flexible Server"
      }
      type = "String"
    }
    PostgreSQLFlexPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Postgre SQL Flexible DB accounts with exposed public endpoints"
        displayName = "Public network access should be disabled for PostgreSql Flexible Server"
      }
      type = "String"
    }
    RedisCachePublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Azure Cache for Redis with exposed public endpoints"
        displayName = "Public network access should be disabled for Azure Cache for Redis"
      }
      type = "String"
    }
    SqlServerPublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of Sql servers with exposed public endpoints"
        displayName = "Public network access on Azure SQL Database should be disabled"
      }
      type = "String"
    }
    StoragePublicIpDenyEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "This policy denies creation of storage accounts with IP Firewall exposed to all public endpoints"
        displayName = "Public network access onStorage accounts should be disabled"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('CosmosPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/797b37f7-06b8-444c-b1ad-fc62867f335a"
    policy_group_names   = []
    reference_id         = "CosmosDenyPaasPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('KeyVaultPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/405c5871-3e91-4644-8a63-58e19d68ff5b"
    policy_group_names   = []
    reference_id         = "KeyVaultDenyPaasPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SqlServerPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1b8ca024-1d5c-4dec-8995-b1a932b41780"
    policy_group_names   = []
    reference_id         = "SqlServerDenyPaasPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StoragePublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b2982f36-99f2-4db5-8eff-283140c09693"
    policy_group_names   = []
    reference_id         = "StorageDenyPaasPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AKSPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/040732e8-d947-40b8-95d6-854c95024bf8"
    policy_group_names   = []
    reference_id         = "AKSDenyPaasPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('ACRPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0fdf0491-d080-4575-b627-ad0e843cba0f"
    policy_group_names   = []
    reference_id         = "ACRDenyPaasPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AFSPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/21a8cd35-125e-4d13-b82d-2e19b7208bb7"
    policy_group_names   = []
    reference_id         = "AFSDenyPaasPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('PostgreSQLFlexPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5e1de0e3-42cb-4ebc-a86d-61d0c619ca48"
    policy_group_names   = []
    reference_id         = "PostgreSQLFlexDenyPublicIP"
    version              = "3.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MySQLFlexPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9299215-ae47-4f50-9c54-8a392f68a052"
    policy_group_names   = []
    reference_id         = "MySQLFlexDenyPublicIP"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('BatchPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/74c5a0ae-5e48-4738-b093-65e23a060488"
    policy_group_names   = []
    reference_id         = "BatchDenyPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MariaDbPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fdccbe47-f3e3-4213-ad5d-ea459b2fa077"
    policy_group_names   = []
    reference_id         = "MariaDbDenyPublicIP"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MlPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/438c38d2-3772-465a-a9cc-7a6666a275ce"
    policy_group_names   = []
    reference_id         = "MlDenyPublicIP"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('RedisCachePublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/470baccb-7e51-4549-8b1a-3e5be069f663"
    policy_group_names   = []
    reference_id         = "RedisCacheDenyPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('BotServicePublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5e8168db-69e3-4beb-9822-57cb59202a9d"
    policy_group_names   = []
    reference_id         = "BotServiceDenyPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AutomationPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/955a914f-bf86-4f0e-acd5-e0766b0efcb6"
    policy_group_names   = []
    reference_id         = "AutomationDenyPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AppConfigPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/3d9f5e4c-9947-4579-9539-2a7695fbc187"
    policy_group_names   = []
    reference_id         = "AppConfigDenyPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('FunctionPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/969ac98b-88a8-449f-883c-2e9adb123127"
    policy_group_names   = []
    reference_id         = "FunctionDenyPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AsePublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2d048aca-6479-4923-88f5-e2ac295d9af3"
    policy_group_names   = []
    reference_id         = "AseDenyPublicIP"
    version              = "3.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AsPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1b5ef780-c53c-4a64-87f3-bb9c8c8094ba"
    policy_group_names   = []
    reference_id         = "AsDenyPublicIP"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('ApiManPublicIpDenyEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/df73bd95-24da-4a4f-96b9-4e8b94b402bd"
    policy_group_names   = []
    reference_id         = "ApiManDenyPublicIP"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Enforce-ALZ-Decomm"
resource "azurerm_policy_set_definition" "enforce_alz_decomm" {
  description  = "Enforce policies in the Decommissioned Landing Zone."
  display_name = "Enforce policies in the Decommissioned Landing Zone"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Decommissioned"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:55:00.1114723Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  name = "Enforce-ALZ-Decomm"
  parameters = jsonencode({
    listOfResourceTypesAllowed = {
      defaultValue = []
      metadata = {
        description = "Allowed resource types in the Decommissioned landing zone, default is none."
        displayName = "Allowed resource types in the Decommissioned landing zone"
        strongType  = "resourceTypes"
      }
      type = "Array"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      listOfResourceTypesAllowed = {
        value = "[parameters('listOfResourceTypesAllowed')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a08ec900-254a-4555-9bf5-e42af04b5c5c"
    policy_group_names   = []
    reference_id         = "DecomDenyResources"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Vm-autoShutdown"
    policy_group_names   = []
    reference_id         = "DecomShutdownMachines"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Prvt-DNS-Zones-AF"
resource "azurerm_policy_set_definition" "deploy_prvt_dns_zones_af" {
  description  = "This policy initiative is a group of policies that ensures private endpoints to Azure PaaS services are integrated with Azure Private DNS zones"
  display_name = "Configure Azure PaaS services to use private DNS zones"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:56:38.0355875Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  name = "Deploy-Prvt-DNS-Zones-AF"
  parameters = jsonencode({
    azureAcrPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAcrPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAppPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAppPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAppServicesPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAppServicesPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAsrPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAsrPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAutomationDSCHybridPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAutomationDSCHybridPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureAutomationWebhookPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureAutomationWebhookPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureBatchPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureBatchPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCognitiveSearchPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCognitiveSearchPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCognitiveServicesPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCognitiveServicesPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosCassandraPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosCassandraPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosGremlinPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosGremlinPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosMongoPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosMongoPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosSQLPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosSQLPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureCosmosTablePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureCosmosTablePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDataFactoryPortalPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDataFactoryPortalPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDataFactoryPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDataFactoryPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDatabricksBrowserPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDatabricksBrowserPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDatabricksUIAPIPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDatabricksUIAPIPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureDiskAccessPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureDiskAccessPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureEventGridDomainsPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureEventGridDomainsPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureEventGridTopicsPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureEventGridTopicsPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureEventHubNamespacePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureEventHubNamespacePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureFilePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureFilePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureHDInsightPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureHDInsightPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureIotHubsPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureIotHubsPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureIotPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureIotPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureKeyVaultPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureKeyVaultPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMachineLearningWorkspacePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMachineLearningWorkspacePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMediaServicesKeyPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMediaServicesKeyPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMediaServicesLivePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMediaServicesLivePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMediaServicesStreamPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMediaServicesStreamPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMigratePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMigratePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId1 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId1"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId2 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId2"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId3 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId3"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId4 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId4"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMonitorPrivateDnsZoneId5 = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMonitorPrivateDnsZoneId5"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureMysqlPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureMysqlPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azurePostgresqlPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azurePostgresqlPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureRedisCachePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureRedisCachePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureServiceBusNamespacePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureServiceBusNamespacePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSignalRPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSignalRPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSqlServerPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSqlServerPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageBlobPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageBlobPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageBlobSecPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageBlobSecPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageDFSPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageDFSPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageDFSSecPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageDFSSecPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageFilePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageFilePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageQueuePrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageQueuePrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageQueueSecPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageQueueSecPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageStaticWebPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageStaticWebPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureStorageStaticWebSecPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureStorageStaticWebSecPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSynapseDevPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSynapseDevPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSynapseSQLODPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSynapseSQLODPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureSynapseSQLPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureSynapseSQLPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    azureWebPrivateDnsZoneId = {
      defaultValue = ""
      metadata = {
        description = "Private DNS Zone Identifier"
        displayName = "azureWebPrivateDnsZoneId"
        strongType  = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    effect1 = {
      allowedValues = ["deployIfNotExists", "Disabled"]
      defaultValue  = "deployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureFileprivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06695360-db88-47f6-b976-7500d4297475"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-File-Sync"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAutomationWebhookPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "Webhook"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6dd01e4f-1be1-4e80-9d0b-d109e04cb064"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Automation-Webhook"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAutomationDSCHybridPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "DSCAndHybridWorker"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6dd01e4f-1be1-4e80-9d0b-d109e04cb064"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Automation-DSCHybrid"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosSQLPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "SQL"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-SQL"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosMongoPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "MongoDB"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-MongoDB"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosCassandraPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "Cassandra"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-Cassandra"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosGremlinPrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "Gremlin"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-Gremlin"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCosmosTablePrivateDnsZoneId')]"
      }
      privateEndpointGroupId = {
        value = "Table"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a63cc0bd-cda4-4178-b705-37dc439d3e0f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Cosmos-Table"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      listOfGroupIds = {
        value = ["dataFactory"]
      }
      privateDnsZoneId = {
        value = "[parameters('azureDataFactoryPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/86cd96e1-1745-420d-94d4-d3f2fe415aa4"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-DataFactory"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      listOfGroupIds = {
        value = ["portal"]
      }
      privateDnsZoneId = {
        value = "[parameters('azureDataFactoryPortalPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/86cd96e1-1745-420d-94d4-d3f2fe415aa4"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-DataFactory-Portal"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "cluster"
      }
      privateDnsZoneId = {
        value = "[parameters('azureHDInsightPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/43d6e3bd-fc6a-4b44-8b4d-2151d8736a11"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-HDInsight"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMigratePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7590a335-57cf-4c95-babd-ecbc8fafeb1f"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Migrate"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageBlobPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/75973700-529f-4de2-b794-fb9b6781b6b0"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-Blob"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageBlobSecPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d847d34b-9337-4e2d-99a5-767e5ac9c582"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-Blob-Sec"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageQueuePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/bcff79fb-2b0d-47c9-97e5-3023479b00d1"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-Queue"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageQueueSecPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/da9b4ae8-5ddc-48c5-b9c0-25f8abf7a3d6"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-Queue-Sec"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageFilePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6df98d03-368a-4438-8730-a93c4d7693d6"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-File"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageStaticWebPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/9adab2a5-05ba-4fbd-831a-5bf958d04218"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-StaticWeb"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageStaticWebSecPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d19ae5f1-b303-4b82-9ca8-7682749faf0c"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-StaticWeb-Sec"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageDFSPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83c6fe0f-2316-444a-99a1-1ecd8a7872ca"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-DFS"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureStorageDFSSecPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/90bd4cb3-9f59-45f7-a6ca-f69db2726671"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Storage-DFS-Sec"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSynapseSQLPrivateDnsZoneId')]"
      }
      targetSubResource = {
        value = "Sql"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e5ed725-f16c-478b-bd4b-7bfa2f7940b9"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Synapse-SQL"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSynapseSQLODPrivateDnsZoneId')]"
      }
      targetSubResource = {
        value = "SqlOnDemand"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e5ed725-f16c-478b-bd4b-7bfa2f7940b9"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Synapse-SQL-OnDemand"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSynapseDevPrivateDnsZoneId')]"
      }
      targetSubResource = {
        value = "Dev"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e5ed725-f16c-478b-bd4b-7bfa2f7940b9"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Synapse-Dev"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "keydelivery"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMediaServicesKeyPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4a7f6c1-585e-4177-ad5b-c2c93f4bb991"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MediaServices-Key"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "liveevent"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMediaServicesLivePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4a7f6c1-585e-4177-ad5b-c2c93f4bb991"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MediaServices-Live"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      groupId = {
        value = "streamingendpoint"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMediaServicesStreamPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4a7f6c1-585e-4177-ad5b-c2c93f4bb991"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MediaServices-Stream"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId1 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId1')]"
      }
      privateDnsZoneId2 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId2')]"
      }
      privateDnsZoneId3 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId3')]"
      }
      privateDnsZoneId4 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId4')]"
      }
      privateDnsZoneId5 = {
        value = "[parameters('azureMonitorPrivateDnsZoneId5')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/437914ee-c176-4fff-8986-7e05eb971365"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Monitor"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureWebPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0b026355-49cb-467b-8ac4-f777874e175a"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Web"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureBatchPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4ec38ebc-381f-45ee-81a4-acbc4be878f8"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Batch"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAppPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7a860e27-9ca2-4fc6-822d-c2d248c300df"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-App"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAsrPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/942bd215-1a66-44be-af65-6a1c0318dbe2"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Site-Recovery"
    version              = "1.*.*-preview"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureIotPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/aaa64d2d-2fa3-45e5-b332-0b031b9b30e8"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-IoT"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureKeyVaultPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ac673a9a-f77d-4846-b2d8-a57f8e1c01d4"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-KeyVault"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSignalRPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b0e86710-7fb7-4a6c-a064-32e9b829509e"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-SignalR"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAppServicesPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b318f84a-b872-429b-ac6d-a01b96814452"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-AppServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect1')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureEventGridTopicsPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/baf19753-7502-405f-8745-370519b20483"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-EventGridTopics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureDiskAccessPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/bc05b96c-0b36-4ca9-82f0-5c53f96ce05a"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-DiskAccess"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCognitiveServicesPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c4bc6f10-cb41-49eb-b000-d5ab82e2a091"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-CognitiveServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect1')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureIotHubsPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c99ce9c1-ced7-4c3e-aca0-10e69ce0cb02"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-IoTHubs"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect1')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureEventGridDomainsPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d389df0a-e0d7-4607-833c-75a6fdac2c2d"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-EventGridDomains"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureRedisCachePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e016b22b-e0eb-436d-8fd7-160c4eaed6e2"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-RedisCache"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureAcrPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e9585a95-5b8c-4d03-b193-dc7eb5ac4c32"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-ACR"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureEventHubNamespacePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ed66d4f5-8220-45dc-ab4a-20d1749c74e6"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-EventHubNamespace"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMachineLearningWorkspacePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ee40564d-486e-4f68-a5ca-7a621edae0fb"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MachineLearningWorkspace"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureServiceBusNamespacePrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f0fcf93c-c063-4071-9668-c47474bd3564"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-ServiceBusNamespace"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureCognitiveSearchPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fbc14a67-53e4-4932-abcc-2049c6706009"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-CognitiveSearch"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureDatabricksBrowserPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-Databricks-Browser"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Databricks-Browser"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureDatabricksUIAPIPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-Databricks-UIAPI"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-Databricks-UIAPI"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureMysqlPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-MYSQL"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-MYSQL"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azurePostgresqlPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-POSTGRESQL"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-POSTGRESQL"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('effect')]"
      }
      privateDnsZoneId = {
        value = "[parameters('azureSqlServerPrivateDnsZoneId')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-SQLSERVER"
    policy_group_names   = []
    reference_id         = "DINE-Private-DNS-Azure-SQLSERVER"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
resource "azurerm_policy_set_definition" "deploy_diagnostics_log_analytics" {
  description  = "This policy set deploys the configurations of application Azure resources to forward diagnostic logs and metrics to an Azure Log Analytics workspace. See the list of policies of the services that are included "
  display_name = "Deploy Diagnostic Settings to Azure Services"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:56:37.787963Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "2.2.0"
  })
  name = "Deploy-Diagnostics-LogAnalytics"
  parameters = jsonencode({
    ACILogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Container Instances to stream to a Log Analytics workspace when any ACR which is missing this diagnostic settings is created or updated. The Policy willset the diagnostic with all metrics enabled."
        displayName = "Deploy Diagnostic Settings for Container Instances to Log Analytics workspace"
      }
      type = "String"
    }
    ACRLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Container Registry to stream to a Log Analytics workspace when any ACR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics  enabled."
        displayName = "Deploy Diagnostic Settings for Container Registry to Log Analytics workspace"
      }
      type = "String"
    }
    AKSLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Kubernetes Service to stream to a Log Analytics workspace when any Kubernetes Service which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled."
        displayName = "Deploy Diagnostic Settings for Kubernetes Service to Log Analytics workspace"
      }
      type = "String"
    }
    APIMgmtLogAnalyticsDestinationType = {
      allowedValues = ["AzureDiagnostics", "Dedicated"]
      defaultValue  = "AzureDiagnostics"
      metadata = {
        description = "Destination table for the diagnostic setting for API Management to Log Analytics workspace, allowed values are 'Dedicated' (for resource-specific) and 'AzureDiagnostics'. Default value is 'AzureDiagnostics'"
        displayName = "Destination table for the Diagnostic Setting for API Management to Log Analytics workspace"
      }
      type = "String"
    }
    APIMgmtLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for API Management to stream to a Log Analytics workspace when any API Management which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for API Management to Log Analytics workspace"
      }
      type = "String"
    }
    APIforFHIRLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Azure API for FHIR to stream to a Log Analytics workspace when any Azure API for FHIR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Azure API for FHIR to Log Analytics workspace"
      }
      type = "String"
    }
    AVDScalingPlansLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for AVD Scaling Plans to stream to a Log Analytics workspace when any application groups which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for AVD Scaling Plans to Log Analytics workspace"
      }
      type = "String"
    }
    AnalysisServiceLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Analysis Services to stream to a Log Analytics workspace when any Analysis Services which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Analysis Services to Log Analytics workspace"
      }
      type = "String"
    }
    AppServiceLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for App Service Plan to stream to a Log Analytics workspace when any App Service Plan which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for App Service Plan to Log Analytics workspace"
      }
      type = "String"
    }
    AppServiceWebappLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Web App to stream to a Log Analytics workspace when any Web App which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for App Service to Log Analytics workspace"
      }
      type = "String"
    }
    ApplicationGatewayLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Application Gateway to stream to a Log Analytics workspace when any Application Gateway which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Application Gateway to Log Analytics workspace"
      }
      type = "String"
    }
    AutomationLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Automation to stream to a Log Analytics workspace when any Automation which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Automation to Log Analytics workspace"
      }
      type = "String"
    }
    BastionLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Azure Bastion to stream to a Log Analytics workspace when any Bastion which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Azure Bastion to Log Analytics workspace"
      }
      type = "String"
    }
    BatchLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Batch to stream to a Log Analytics workspace when any Batch which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Batch to Log Analytics workspace"
      }
      type = "String"
    }
    CDNEndpointsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for CDN Endpoint to stream to a Log Analytics workspace when any CDN Endpoint which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for CDN Endpoint to Log Analytics workspace"
      }
      type = "String"
    }
    CognitiveServicesLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Cognitive Services to stream to a Log Analytics workspace when any Cognitive Services which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Cognitive Services to Log Analytics workspace"
      }
      type = "String"
    }
    CosmosLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Cosmos DB to stream to a Log Analytics workspace when any Cosmos DB which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Cosmos DB to Log Analytics workspace"
      }
      type = "String"
    }
    DataExplorerClusterLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Azure Data Explorer Cluster to stream to a Log Analytics workspace when any Azure Data Explorer Cluster which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Azure Data Explorer Cluster to Log Analytics workspace"
      }
      type = "String"
    }
    DataFactoryLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Data Factory to stream to a Log Analytics workspace when any Data Factory which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Data Factory to Log Analytics workspace"
      }
      type = "String"
    }
    DataLakeAnalyticsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Data Lake Analytics to stream to a Log Analytics workspace when any Data Lake Analytics which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Data Lake Analytics to Log Analytics workspace"
      }
      type = "String"
    }
    DataLakeStoreLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Azure Data Lake Store to stream to a Log Analytics workspace when anyAzure Data Lake Store which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Azure Data Lake Store to Log Analytics workspace"
      }
      type = "String"
    }
    DatabricksLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Databricks to stream to a Log Analytics workspace when any Databricks which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Databricks to Log Analytics workspace"
      }
      type = "String"
    }
    EventGridSubLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Event Grid subscriptions to stream to a Log Analytics workspace when any Event Grid subscriptions which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Event Grid subscriptions to Log Analytics workspace"
      }
      type = "String"
    }
    EventGridTopicLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Event Grid Topic to stream to a Log Analytics workspace when any Event Grid Topic which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Event Grid Topic to Log Analytics workspace"
      }
      type = "String"
    }
    EventHubLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Event Hubs to stream to a Log Analytics workspace when any Event Hubs which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Event Hubs to Log Analytics workspace"
      }
      type = "String"
    }
    EventSystemTopicLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Event Grid System Topic to stream to a Log Analytics workspace when any Event Grid System Topic which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Event Grid System Topic to Log Analytics workspace"
      }
      type = "String"
    }
    ExpressRouteLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for ExpressRoute to stream to a Log Analytics workspace when any ExpressRoute which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for ExpressRoute to Log Analytics workspace"
      }
      type = "String"
    }
    FirewallLogAnalyticsDestinationType = {
      allowedValues = ["AzureDiagnostics", "Dedicated"]
      defaultValue  = "AzureDiagnostics"
      metadata = {
        description = "Destination table for the diagnostic setting for Firewall to Log Analytics workspace, allowed values are 'Dedicated' (for resource-specific) and 'AzureDiagnostics'. Default value is 'AzureDiagnostics'"
        displayName = "Destination table for the Diagnostic Setting for Firewall to Log Analytics workspace"
      }
      type = "String"
    }
    FirewallLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Firewall to stream to a Log Analytics workspace when any Firewall which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Firewall to Log Analytics workspace"
      }
      type = "String"
    }
    FrontDoorLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Front Door to stream to a Log Analytics workspace when any Front Door which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Front Door to Log Analytics workspace"
      }
      type = "String"
    }
    FunctionAppLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Azure Function App to stream to a Log Analytics workspace when any function app which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Azure Function App to Log Analytics workspace"
      }
      type = "String"
    }
    HDInsightLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for HDInsight to stream to a Log Analytics workspace when any HDInsight which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for HDInsight to Log Analytics workspace"
      }
      type = "String"
    }
    IotHubLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for IoT Hub to stream to a Log Analytics workspace when any IoT Hub which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for IoT Hub to Log Analytics workspace"
      }
      type = "String"
    }
    KeyVaultLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Key Vault to stream to a Log Analytics workspace when any Key Vault which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Key Vault to Log Analytics workspace"
      }
      type = "String"
    }
    LoadBalancerLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Load Balancer to stream to a Log Analytics workspace when any Load Balancer which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Load Balancer to Log Analytics workspace"
      }
      type = "String"
    }
    LogAnalyticsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Log Analytics to stream to a Log Analytics workspace when any Log Analytics workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category Audit enabled"
        displayName = "Deploy Diagnostic Settings for Log Analytics to Log Analytics workspace"
      }
      type = "String"
    }
    LogicAppsISELogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Logic Apps integration service environment to stream to a Log Analytics workspace when any Logic Apps integration service environment which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Logic Apps integration service environment to Log Analytics workspace"
      }
      type = "String"
    }
    LogicAppsWFLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Logic Apps Workflows to stream to a Log Analytics workspace when any Logic Apps Workflows which are missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Logic Apps Workflows to Log Analytics workspace"
      }
      type = "String"
    }
    MariaDBLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for MariaDB to stream to a Log Analytics workspace when any MariaDB  which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for MariaDB to Log Analytics workspace"
      }
      type = "String"
    }
    MediaServiceLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Azure Media Service to stream to a Log Analytics workspace when any Azure Media Service which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Azure Media Service to Log Analytics workspace"
      }
      type = "String"
    }
    MlWorkspaceLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Machine Learning workspace to stream to a Log Analytics workspace when any Machine Learning workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Machine Learning workspace to Log Analytics workspace"
      }
      type = "String"
    }
    MySQLLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Database for MySQL to stream to a Log Analytics workspace when any Database for MySQL which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Database for MySQL to Log Analytics workspace"
      }
      type = "String"
    }
    NetworkNICLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Network Interfaces to stream to a Log Analytics workspace when any Network Interfaces which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Network Interfaces to Log Analytics workspace"
      }
      type = "String"
    }
    NetworkPublicIPNicLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Public IP addresses to stream to a Log Analytics workspace when any Public IP addresses which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Public IP addresses to Log Analytics workspace"
      }
      type = "String"
    }
    NetworkSecurityGroupsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Network Security Groups to stream to a Log Analytics workspace when any Network Security Groups which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Network Security Groups to Log Analytics workspace"
      }
      type = "String"
    }
    PostgreSQLLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Database for PostgreSQL to stream to a Log Analytics workspace when any Database for PostgreSQL which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Database for PostgreSQL to Log Analytics workspace"
      }
      type = "String"
    }
    PowerBIEmbeddedLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Power BI Embedded to stream to a Log Analytics workspace when any Power BI Embedded which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Power BI Embedded to Log Analytics workspace"
      }
      type = "String"
    }
    RedisCacheLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Redis Cache to stream to a Log Analytics workspace when any Redis Cache which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Redis Cache to Log Analytics workspace"
      }
      type = "String"
    }
    RelayLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Relay to stream to a Log Analytics workspace when any Relay which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Relay to Log Analytics workspace"
      }
      type = "String"
    }
    SQLDBsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for SQL Databases to stream to a Log Analytics workspace when any SQL Databases  which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for SQL Databases  to Log Analytics workspace"
      }
      type = "String"
    }
    SQLElasticPoolsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for SQL Elastic Pools to stream to a Log Analytics workspace when any SQL Elastic Pools which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for SQL Elastic Pools to Log Analytics workspace"
      }
      type = "String"
    }
    SQLMLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for SQL Managed Instances to stream to a Log Analytics workspace when any SQL Managed Instances which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for SQL Managed Instances to Log Analytics workspace"
      }
      type = "String"
    }
    SearchServicesLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Search Services to stream to a Log Analytics workspace when any Search Services which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Search Services to Log Analytics workspace"
      }
      type = "String"
    }
    ServiceBusLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for ServiceBus to stream to a Log Analytics workspace when any ServiceBus which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Service Bus namespaces  to Log Analytics workspace"
      }
      type = "String"
    }
    SignalRLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for SignalR to stream to a Log Analytics workspace when any SignalR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for SignalR to Log Analytics workspace"
      }
      type = "String"
    }
    StorageAccountsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Storage Accounts to stream to a Log Analytics workspace when any storage account which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Storage Accounts to Log Analytics workspace"
      }
      type = "String"
    }
    StreamAnalyticsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Stream Analytics to stream to a Log Analytics workspace when any Stream Analytics which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Stream Analytics to Log Analytics workspace"
      }
      type = "String"
    }
    TimeSeriesInsightsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Time Series Insights to stream to a Log Analytics workspace when any Time Series Insights which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Time Series Insights to Log Analytics workspace"
      }
      type = "String"
    }
    TrafficManagerLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Traffic Manager to stream to a Log Analytics workspace when any Traffic Manager which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Traffic Manager to Log Analytics workspace"
      }
      type = "String"
    }
    VMSSLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Virtual Machine Scale Sets  to stream to a Log Analytics workspace when any Virtual Machine Scale Sets  which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Virtual Machine Scale Sets to Log Analytics workspace"
      }
      type = "String"
    }
    VNetGWLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for VPN Gateway to stream to a Log Analytics workspace when any VPN Gateway which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled."
        displayName = "Deploy Diagnostic Settings for VPN Gateway to Log Analytics workspace"
      }
      type = "String"
    }
    VWanS2SVPNGWLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for VWAN S2S VPN gateway to stream to a Log Analytics workspace when any storage account which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for VWAN S2S VPN gateway to Log Analytics workspace"
      }
      type = "String"
    }
    VirtualMachinesLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Virtual Machines to stream to a Log Analytics workspace when any Virtual Machines which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Virtual Machines to Log Analytics workspace"
      }
      type = "String"
    }
    VirtualNetworkLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for Virtual Network to stream to a Log Analytics workspace when any Virtual Network which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for Virtual Network to Log Analytics workspace"
      }
      type = "String"
    }
    WVDAppGroupsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for AVD Application groups to stream to a Log Analytics workspace when any application groups which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for AVD Application Groups to Log Analytics workspace"
      }
      type = "String"
    }
    WVDHostPoolsLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for AVD Host pools to stream to a Log Analytics workspace when any host pool which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for AVD Host pools to Log Analytics workspace"
      }
      type = "String"
    }
    WVDWorkspaceLogAnalyticsEffect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Deploys the diagnostic settings for AVD Workspace to stream to a Log Analytics workspace when any Workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
        displayName = "Deploy Diagnostic Settings for AVD Workspace to Log Analytics workspace"
      }
      type = "String"
    }
    logAnalytics = {
      metadata = {
        description = "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID."
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    profileName = {
      defaultValue = "setbypolicy"
      metadata = {
        description = "The diagnostic settings profile name"
        displayName = "Profile name"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StorageAccountsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/59759c62-9a22-4cdf-ae64-074495983fef"
    policy_group_names   = []
    reference_id         = "StorageAccountDeployDiagnosticLogDeployLogAnalytics"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StorageAccountsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4fe1a3b-0715-4c6c-a5ea-ffc33cf823cb"
    policy_group_names   = []
    reference_id         = "StorageAccountBlobServicesDeployDiagnosticLogDeployLogAnalytics"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StorageAccountsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/25a70cc8-2bd4-47f1-90b6-1478e4662c96"
    policy_group_names   = []
    reference_id         = "StorageAccountFileServicesDeployDiagnosticLogDeployLogAnalytics"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StorageAccountsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7bd000e3-37c7-4928-9f31-86c4b77c5c45"
    policy_group_names   = []
    reference_id         = "StorageAccountQueueServicesDeployDiagnosticLogDeployLogAnalytics"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StorageAccountsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2fb86bf3-d221-43d1-96d1-2434af34eaa0"
    policy_group_names   = []
    reference_id         = "StorageAccountTableServicesDeployDiagnosticLogDeployLogAnalytics"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AVDScalingPlansLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AVDScalingPlans"
    policy_group_names   = []
    reference_id         = "AVDScalingPlansDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('WVDAppGroupsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDAppGroup"
    policy_group_names   = []
    reference_id         = "WVDAppGroupDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('WVDWorkspaceLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDWorkspace"
    policy_group_names   = []
    reference_id         = "WVDWorkspaceDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('WVDHostPoolsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDHostPools"
    policy_group_names   = []
    reference_id         = "WVDHostPoolsDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('ACILogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ACI"
    policy_group_names   = []
    reference_id         = "ACIDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('ACRLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ACR"
    policy_group_names   = []
    reference_id         = "ACRDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      diagnosticsSettingNameToUse = {
        value = "[parameters('profileName')]"
      }
      effect = {
        value = "[parameters('AKSLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6c66c325-74c8-42fd-a286-a74b0e2939d8"
    policy_group_names   = []
    reference_id         = "AKSDeployDiagnosticLogDeployLogAnalytics"
    version              = "3.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AnalysisServiceLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AnalysisService"
    policy_group_names   = []
    reference_id         = "AnalysisServiceDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('APIforFHIRLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ApiForFHIR"
    policy_group_names   = []
    reference_id         = "APIforFHIRDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('APIMgmtLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      logAnalyticsDestinationType = {
        value = "[parameters('APIMgmtLogAnalyticsDestinationType')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-APIMgmt"
    policy_group_names   = []
    reference_id         = "APIMgmtDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('ApplicationGatewayLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ApplicationGateway"
    policy_group_names   = []
    reference_id         = "ApplicationGatewayDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AutomationLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AA"
    policy_group_names   = []
    reference_id         = "AutomationDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('BastionLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Bastion"
    policy_group_names   = []
    reference_id         = "BastionDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('BatchLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c84e5349-db6d-4769-805e-e14037dab9b5"
    policy_group_names   = []
    reference_id         = "BatchDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('CDNEndpointsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CDNEndpoints"
    policy_group_names   = []
    reference_id         = "CDNEndpointsDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('CognitiveServicesLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CognitiveServices"
    policy_group_names   = []
    reference_id         = "CognitiveServicesDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('CosmosLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CosmosDB"
    policy_group_names   = []
    reference_id         = "CosmosDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('DatabricksLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Databricks"
    policy_group_names   = []
    reference_id         = "DatabricksDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('DataExplorerClusterLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DataExplorerCluster"
    policy_group_names   = []
    reference_id         = "DataExplorerClusterDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('DataFactoryLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DataFactory"
    policy_group_names   = []
    reference_id         = "DataFactoryDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('DataLakeStoreLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d56a5a7c-72d7-42bc-8ceb-3baf4c0eae03"
    policy_group_names   = []
    reference_id         = "DataLakeStoreDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('DataLakeAnalyticsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DLAnalytics"
    policy_group_names   = []
    reference_id         = "DataLakeAnalyticsDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('EventGridSubLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridSub"
    policy_group_names   = []
    reference_id         = "EventGridSubDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('EventGridTopicLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridTopic"
    policy_group_names   = []
    reference_id         = "EventGridTopicDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('EventHubLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f6e93e8-6b31-41b1-83f6-36e449a42579"
    policy_group_names   = []
    reference_id         = "EventHubDeployDiagnosticLogDeployLogAnalytics"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('EventSystemTopicLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridSystemTopic"
    policy_group_names   = []
    reference_id         = "EventSystemTopicDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('ExpressRouteLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ExpressRoute"
    policy_group_names   = []
    reference_id         = "ExpressRouteDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('FirewallLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      logAnalyticsDestinationType = {
        value = "[parameters('FirewallLogAnalyticsDestinationType')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Firewall"
    policy_group_names   = []
    reference_id         = "FirewallDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('FrontDoorLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-FrontDoor"
    policy_group_names   = []
    reference_id         = "FrontDoorDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('FunctionAppLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Function"
    policy_group_names   = []
    reference_id         = "FunctionAppDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('HDInsightLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-HDInsight"
    policy_group_names   = []
    reference_id         = "HDInsightDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('IotHubLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-iotHub"
    policy_group_names   = []
    reference_id         = "IotHubDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('KeyVaultLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47"
    policy_group_names   = []
    reference_id         = "KeyVaultDeployDiagnosticLogDeployLogAnalytics"
    version              = "3.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('LoadBalancerLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-LoadBalancer"
    policy_group_names   = []
    reference_id         = "LoadBalancerDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('LogAnalyticsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-LogAnalytics"
    policy_group_names   = []
    reference_id         = "LogAnalyticsDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('LogicAppsISELogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-LogicAppsISE"
    policy_group_names   = []
    reference_id         = "LogicAppsISEDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('LogicAppsWFLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b889a06c-ec72-4b03-910a-cb169ee18721"
    policy_group_names   = []
    reference_id         = "LogicAppsWFDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MariaDBLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MariaDB"
    policy_group_names   = []
    reference_id         = "MariaDBDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MediaServiceLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MediaService"
    policy_group_names   = []
    reference_id         = "MediaServiceDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MlWorkspaceLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MlWorkspace"
    policy_group_names   = []
    reference_id         = "MlWorkspaceDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MySQLLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MySQL"
    policy_group_names   = []
    reference_id         = "MySQLDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('NetworkSecurityGroupsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-NetworkSecurityGroups"
    policy_group_names   = []
    reference_id         = "NetworkSecurityGroupsDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('NetworkNICLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-NIC"
    policy_group_names   = []
    reference_id         = "NetworkNICDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('PostgreSQLLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-PostgreSQL"
    policy_group_names   = []
    reference_id         = "PostgreSQLDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('PowerBIEmbeddedLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-PowerBIEmbedded"
    policy_group_names   = []
    reference_id         = "PowerBIEmbeddedDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('NetworkPublicIPNicLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      metricsEnabled = {
        value = "True"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/752154a7-1e0f-45c6-a880-ac75a7e4f648"
    policy_group_names   = []
    reference_id         = "NetworkPublicIPNicDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c717fb0c-d118-4c43-ab3d-ece30ac81fb3"
    policy_group_names   = []
    reference_id         = "RecoveryVaultDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('RedisCacheLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-RedisCache"
    policy_group_names   = []
    reference_id         = "RedisCacheDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('RelayLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Relay"
    policy_group_names   = []
    reference_id         = "RelayDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SearchServicesLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/08ba64b8-738f-4918-9686-730d2ed79c7d"
    policy_group_names   = []
    reference_id         = "SearchServicesDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('ServiceBusLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/04d53d87-841c-4f23-8a5b-21564380b55e"
    policy_group_names   = []
    reference_id         = "ServiceBusDeployDiagnosticLogDeployLogAnalytics"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SignalRLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SignalR"
    policy_group_names   = []
    reference_id         = "SignalRDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      diagnosticsSettingNameToUse = {
        value = "[parameters('profileName')]"
      }
      effect = {
        value = "[parameters('SQLDBsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b79fa14e-238a-4c2d-b376-442ce508fc84"
    policy_group_names   = []
    reference_id         = "SQLDatabaseDeployDiagnosticLogDeployLogAnalytics"
    version              = "4.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SQLElasticPoolsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SQLElasticPools"
    policy_group_names   = []
    reference_id         = "SQLElasticPoolsDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SQLMLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SQLMI"
    policy_group_names   = []
    reference_id         = "SQLMDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StreamAnalyticsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/237e0f7e-b0e8-4ec4-ad46-8c12cb66d673"
    policy_group_names   = []
    reference_id         = "StreamAnalyticsDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('TimeSeriesInsightsLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-TimeSeriesInsights"
    policy_group_names   = []
    reference_id         = "TimeSeriesInsightsDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('TrafficManagerLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-TrafficManager"
    policy_group_names   = []
    reference_id         = "TrafficManagerDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('VirtualNetworkLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VirtualNetwork"
    policy_group_names   = []
    reference_id         = "VirtualNetworkDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('VirtualMachinesLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VM"
    policy_group_names   = []
    reference_id         = "VirtualMachinesDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('VMSSLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VMSS"
    policy_group_names   = []
    reference_id         = "VMSSDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('VNetGWLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VNetGW"
    policy_group_names   = []
    reference_id         = "VNetGWDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AppServiceLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WebServerFarm"
    policy_group_names   = []
    reference_id         = "AppServiceDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AppServiceWebappLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Website"
    policy_group_names   = []
    reference_id         = "AppServiceWebappDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('VWanS2SVPNGWLogAnalyticsEffect')]"
      }
      logAnalytics = {
        value = "[parameters('logAnalytics')]"
      }
      profileName = {
        value = "[parameters('profileName')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VWanS2SVPNGW"
    policy_group_names   = []
    reference_id         = "VWanS2SVPNGWDeployDiagnosticLogDeployLogAnalytics"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/DenyAction-DeleteProtection"
resource "azurerm_policy_set_definition" "denyaction_delete_protection" {
  description  = "Enforces DenyAction - Delete on Activity Log Settings and Diagnostic Settings."
  display_name = "DenyAction Delete - Activity Log Settings and Diagnostic Settings"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:10:46.4491626Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  name        = "DenyAction-DeleteProtection"
  parameters  = null
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DenyAction-DiagnosticLogs"
    policy_group_names   = []
    reference_id         = "DenyActionDelete-DiagnosticSettings"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DenyAction-ActivityLogs"
    policy_group_names   = []
    reference_id         = "DenyActionDelete-ActivityLogSettings"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Deploy-VM-Backup"
resource "azurerm_policy_set_definition" "deploy_vm_backup" {
  description  = "This policy initiative contains policies to deploy recovery services vaults and backup policies per resource group (based on tags). It also onboards virtual machines to the backup service."
  display_name = "Configure backup on virtual machines without a given tag to a new recovery services vault with a default policy"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:56:37.3475401Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  name        = "Deploy-VM-Backup"
  parameters  = null
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/VirtualMachine-Backup-2000-14d"
    policy_group_names   = []
    reference_id         = "VirtualMachine-Backup-2000-14d"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/VirtualMachine-Backup-2000-14d-4w"
    policy_group_names   = []
    reference_id         = "VirtualMachine-Backup-2000-14d-4w"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/VirtualMachine-Backup-2000-14d-4w-12m"
    policy_group_names   = []
    reference_id         = "VirtualMachine-Backup-2000-14d-4w-12m"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values     = jsonencode({})
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/VirtualMachine-Backup-2000-14d-4w-12m-10y"
    policy_group_names   = []
    reference_id         = "VirtualMachine-Backup-2000-14d-4w-12m-10y"
    version              = "1.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-landingzones-nonprd/providers/Microsoft.Authorization/policySetDefinitions/Deploy-ASCDF-Config"
resource "azurerm_policy_set_definition" "deploy_ascdf_config_lz_nonprd" {
  description  = "Deploy Azure Security Center configuration"
  display_name = "Deploy Azure Security Center configuration"
  metadata = jsonencode({
    category  = "Security Center"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-09-04T10:32:34.3527829Z"
    updatedBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn = "2025-02-05T21:10:46.3845468Z"
    version   = "2.0.0"
  })
  name = "Deploy-ASCDF-Config"
  parameters = jsonencode({
    emailSecurityContact = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Provide email address for Azure Security Center contact details"
        displayName = "Security contacts email address"
      }
      type = "String"
    }
    enableAscCsmp = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForAppServices = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForArm = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForContainers = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForCosmosDbs = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForDns = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForKeyVault = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForOssDb = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForServers = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSql = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlMi = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlOnVm = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlSynapse = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForStorage = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    isOnUploadMalwareScanningEnabled = {
      defaultValue = "true"
      metadata = {
        description = "Enable or disable the Malware Scanning add-on feature"
        displayName = "Malware Scanning Enabled"
      }
      type = "String"
    }
    isSensitiveDataDiscoveryEnabled = {
      defaultValue = "true"
      metadata = {
        description = "Enable or disable the Sensitive Data Threat Detection add-on feature"
        displayName = "Sensitive Data Threat Detection Enabledt"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForOssDb')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/44433aa3-7ec2-4002-93ea-65c65ff0310a"
    policy_group_names   = []
    reference_id         = "defenderForOssDb"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForServers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8e86a5b6-b9bd-49d1-8e21-4bb8a0862222"
    policy_group_names   = []
    reference_id         = "defenderForVM"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlOnVm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/50ea7265-7d8c-429e-9a7d-ca1f410191c3"
    policy_group_names   = []
    reference_id         = "defenderForSqlServerVirtualMachines"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForAppServices')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d"
    policy_group_names   = []
    reference_id         = "defenderForAppServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForStorage')]"
      }
      isOnUploadMalwareScanningEnabled = {
        value = "[parameters('isOnUploadMalwareScanningEnabled')]"
      }
      isSensitiveDataDiscoveryEnabled = {
        value = "[parameters('isSensitiveDataDiscoveryEnabled')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cfdc5972-75b3-4418-8ae1-7f5c36839390"
    policy_group_names   = []
    reference_id         = "defenderForStorageAccounts"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      Effect = {
        value = "[parameters('enableAscForKeyVault')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f725891-01c0-420a-9059-4fa46cb770b7"
    policy_group_names   = []
    reference_id         = "defenderForKeyVaults"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForDns')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2370a3c1-4a25-4283-a91a-c9c1a145fb2f"
    policy_group_names   = []
    reference_id         = "defenderForDns"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForArm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b7021b2b-08fd-4dc0-9de7-3c6ece09faf9"
    policy_group_names   = []
    reference_id         = "defenderForArm"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSql')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b99b73e7-074b-4089-9395-b7236f094491"
    policy_group_names   = []
    reference_id         = "defenderForSqlPaas"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      emailSecurityContact = {
        value = "[parameters('emailSecurityContact')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-ASC-SecurityContacts"
    policy_group_names   = []
    reference_id         = "securityEmailContact"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForContainers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9ddb292-b203-4738-aead-18e2716e858f"
    policy_group_names   = []
    reference_id         = "defenderForContainers"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlSynapse')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/951c1558-50a5-4ca3-abb6-a93e3e2367a6"
    policy_group_names   = []
    reference_id         = "defenderForSqlSynapse"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForCosmosDbs')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/82bf5b87-728b-4a74-ba4d-6123845cf542"
    policy_group_names   = []
    reference_id         = "defenderForCosmosDbs"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscCsmp')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/689f7782-ef2c-4270-a6d0-7664869076bd"
    policy_group_names   = []
    reference_id         = "defenderCsmp"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlMi')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c5a62eb0-c65a-4220-8a4d-f70dd4ca95dd"
    policy_group_names   = []
    reference_id         = "defenderForSqlMi"
    version              = "2.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-landingzones-prd/providers/Microsoft.Authorization/policySetDefinitions/Deploy-ASCDF-Config"
resource "azurerm_policy_set_definition" "deploy_ascdf_config_lz_prd" {
  description  = "Deploy Azure Security Center configuration"
  display_name = "Deploy Azure Security Center configuration"
  metadata = jsonencode({
    category  = "Security Center"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:53:24.925315Z"
    updatedBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn = "2025-02-05T21:10:46.479872Z"
    version   = "2.0.0"
  })
  name = "Deploy-ASCDF-Config"
  parameters = jsonencode({
    emailSecurityContact = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Provide email address for Azure Security Center contact details"
        displayName = "Security contacts email address"
      }
      type = "String"
    }
    enableAscCsmp = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForAppServices = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForArm = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForContainers = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForCosmosDbs = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForDns = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForKeyVault = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForOssDb = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForServers = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSql = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlMi = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlOnVm = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForSqlSynapse = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    enableAscForStorage = {
      defaultValue = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    isOnUploadMalwareScanningEnabled = {
      defaultValue = "true"
      metadata = {
        description = "Enable or disable the Malware Scanning add-on feature"
        displayName = "Malware Scanning Enabled"
      }
      type = "String"
    }
    isSensitiveDataDiscoveryEnabled = {
      defaultValue = "true"
      metadata = {
        description = "Enable or disable the Sensitive Data Threat Detection add-on feature"
        displayName = "Sensitive Data Threat Detection Enabledt"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForOssDb')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/44433aa3-7ec2-4002-93ea-65c65ff0310a"
    policy_group_names   = []
    reference_id         = "defenderForOssDb"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForServers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8e86a5b6-b9bd-49d1-8e21-4bb8a0862222"
    policy_group_names   = []
    reference_id         = "defenderForVM"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlOnVm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/50ea7265-7d8c-429e-9a7d-ca1f410191c3"
    policy_group_names   = []
    reference_id         = "defenderForSqlServerVirtualMachines"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForAppServices')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d"
    policy_group_names   = []
    reference_id         = "defenderForAppServices"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForStorage')]"
      }
      isOnUploadMalwareScanningEnabled = {
        value = "[parameters('isOnUploadMalwareScanningEnabled')]"
      }
      isSensitiveDataDiscoveryEnabled = {
        value = "[parameters('isSensitiveDataDiscoveryEnabled')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cfdc5972-75b3-4418-8ae1-7f5c36839390"
    policy_group_names   = []
    reference_id         = "defenderForStorageAccounts"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      Effect = {
        value = "[parameters('enableAscForKeyVault')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f725891-01c0-420a-9059-4fa46cb770b7"
    policy_group_names   = []
    reference_id         = "defenderForKeyVaults"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForDns')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2370a3c1-4a25-4283-a91a-c9c1a145fb2f"
    policy_group_names   = []
    reference_id         = "defenderForDns"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForArm')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b7021b2b-08fd-4dc0-9de7-3c6ece09faf9"
    policy_group_names   = []
    reference_id         = "defenderForArm"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSql')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b99b73e7-074b-4089-9395-b7236f094491"
    policy_group_names   = []
    reference_id         = "defenderForSqlPaas"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      emailSecurityContact = {
        value = "[parameters('emailSecurityContact')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-ASC-SecurityContacts"
    policy_group_names   = []
    reference_id         = "securityEmailContact"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForContainers')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9ddb292-b203-4738-aead-18e2716e858f"
    policy_group_names   = []
    reference_id         = "defenderForContainers"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlSynapse')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/951c1558-50a5-4ca3-abb6-a93e3e2367a6"
    policy_group_names   = []
    reference_id         = "defenderForSqlSynapse"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForCosmosDbs')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/82bf5b87-728b-4a74-ba4d-6123845cf542"
    policy_group_names   = []
    reference_id         = "defenderForCosmosDbs"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscCsmp')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/689f7782-ef2c-4270-a6d0-7664869076bd"
    policy_group_names   = []
    reference_id         = "defenderCsmp"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('enableAscForSqlMi')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c5a62eb0-c65a-4220-8a4d-f70dd4ca95dd"
    policy_group_names   = []
    reference_id         = "defenderForSqlMi"
    version              = "2.*.*"
  }
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policySetDefinitions/Enforce-Encryption-CMK"
resource "azurerm_policy_set_definition" "enforce_encryption_cmk" {
  description  = "Deny or Audit resources without Encryption with a customer-managed key (CMK)"
  display_name = "Deny or Audit resources without Encryption with a customer-managed key (CMK)"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Encryption"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:53:24.4522807Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "2.0.0"
  })
  name = "Enforce-Encryption-CMK"
  parameters = jsonencode({
    ACRCmkEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Use customer-managed keys to manage the encryption at rest of the contents of your registries. By default, the data is encrypted at rest with service-managed keys, but customer-managed keys (CMK) are commonly required to meet regulatory compliance standards. CMKs enable the data to be encrypted with an Azure Key Vault key created and owned by you. You have full control and responsibility for the key lifecycle, including rotation and management. Learn more about CMK encryption at https://aka.ms/acr/CMK."
        displayName = "Container registries should be encrypted with a customer-managed key (CMK)"
      }
      type = "String"
    }
    AksCmkEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Encrypting OS and data disks using customer-managed keys provides more control and greater flexibility in key management. This is a common requirement in many regulatory and industry compliance standards."
        displayName = "Azure Kubernetes Service clusters both operating systems and data disks should be encrypted by customer-managed keys"
      }
      type = "String"
    }
    AzureBatchCMKEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Use customer-managed keys (CMKs) to manage the encryption at rest of your Batch account's data. By default, customer data is encrypted with service-managed keys, but CMKs are commonly required to meet regulatory compliance standards. CMKs enable the data to be encrypted with an Azure Key Vault key created and owned by you. You have full control and responsibility for the key lifecycle, including rotation and management. Learn more about CMK encryption at https://aka.ms/Batch-CMK."
        displayName = "Azure Batch account should use customer-managed keys to encrypt data"
      }
      type = "String"
    }
    CognitiveServicesCMKEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Customer-managed keys (CMK) are commonly required to meet regulatory compliance standards. CMKs enable the data stored in Cognitive Services to be encrypted with an Azure Key Vault key created and owned by you. You have full control and responsibility for the key lifecycle, including rotation and management. Learn more about CMK encryption at https://aka.ms/cosmosdb-cmk."
        displayName = "Cognitive Services accounts should enable data encryption with a customer-managed key (CMK)"
      }
      type = "String"
    }
    CosmosCMKEffect = {
      allowedValues = ["audit", "deny", "disabled"]
      defaultValue  = "audit"
      metadata = {
        description = "Use customer-managed keys to manage the encryption at rest of your Azure Cosmos DB. By default, the data is encrypted at rest with service-managed keys, but customer-managed keys (CMK) are commonly required to meet regulatory compliance standards. CMKs enable the data to be encrypted with an Azure Key Vault key created and owned by you. You have full control and responsibility for the key lifecycle, including rotation and management. Learn more about CMK encryption at https://aka.ms/cosmosdb-cmk."
        displayName = "Azure Cosmos DB accounts should use customer-managed keys to encrypt data at rest"
      }
      type = "String"
    }
    DataBoxCMKEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Use a customer-managed key to control the encryption of the device unlock password for Azure Data Box. Customer-managed keys also help manage access to the device unlock password by the Data Box service in order to prepare the device and copy data in an automated manner. The data on the device itself is already encrypted at rest with Advanced Encryption Standard 256-bit encryption, and the device unlock password is encrypted by default with a Microsoft managed key."
        displayName = "Azure Data Box jobs should use a customer-managed key to encrypt the device unlock password"
      }
      type = "String"
    }
    EncryptedVMDisksEffect = {
      allowedValues = ["AuditIfNotExists", "Disabled"]
      defaultValue  = "AuditIfNotExists"
      metadata = {
        description = "Virtual machines without an enabled disk encryption will be monitored by Azure Security Center as recommendations."
        displayName = "Disk encryption should be applied on virtual machines"
      }
      type = "String"
    }
    HealthcareAPIsCMKEffect = {
      allowedValues = ["audit", "disabled"]
      defaultValue  = "audit"
      metadata = {
        description = "Use a customer-managed key to control the encryption at rest of the data stored in Azure API for FHIR when this is a regulatory or compliance requirement. Customer-managed keys also deliver double encryption by adding a second layer of encryption on top of the default one done with service-managed keys."
        displayName = "Azure API for FHIR should use a customer-managed key (CMK) to encrypt data at rest"
      }
      type = "String"
    }
    MySQLCMKEffect = {
      allowedValues = ["AuditIfNotExists", "Disabled"]
      defaultValue  = "AuditIfNotExists"
      metadata = {
        description = "Use customer-managed keys to manage the encryption at rest of your MySQL servers. By default, the data is encrypted at rest with service-managed keys, but customer-managed keys (CMK) are commonly required to meet regulatory compliance standards. CMKs enable the data to be encrypted with an Azure Key Vault key created and owned by you. You have full control and responsibility for the key lifecycle, including rotation and management."
        displayName = "Azure MySQL servers bring your own key data protection should be enabled"
      }
      type = "String"
    }
    PostgreSQLCMKEffect = {
      allowedValues = ["AuditIfNotExists", "Disabled"]
      defaultValue  = "AuditIfNotExists"
      metadata = {
        description = "Use customer-managed keys to manage the encryption at rest of your PostgreSQL servers. By default, the data is encrypted at rest with service-managed keys, but customer-managed keys (CMK) are commonly required to meet regulatory compliance standards. CMKs enable the data to be encrypted with an Azure Key Vault key created and owned by you. You have full control and responsibility for the key lifecycle, including rotation and management."
        displayName = "Azure PostgreSQL servers bring your own key data protection should be enabled"
      }
      type = "String"
    }
    SqlServerTDECMKEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Implementing Transparent Data Encryption (TDE) with your own key provides increased transparency and control over the TDE Protector, increased security with an HSM-backed external service, and promotion of separation of duties. This recommendation applies to organizations with a related compliance requirement."
        displayName = "SQL servers should use customer-managed keys to encrypt data at rest"
      }
      type = "String"
    }
    StorageCMKEffect = {
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Secure your storage account with greater flexibility using customer-managed keys (CMKs). When you specify a CMK, that key is used to protect and control access to the key that encrypts your data. Using CMKs provides additional capabilities to control rotation of the key encryption key or cryptographically erase data."
        displayName = "Storage accounts should use customer-managed key (CMK) for encryption, no deny as this would result in not able to create storage account because the first need of MSI for encryption"
      }
      type = "String"
    }
    StreamAnalyticsCMKEffect = {
      allowedValues = ["audit", "deny", "disabled"]
      defaultValue  = "audit"
      metadata = {
        description = "Use customer-managed keys when you want to securely store any metadata and private data assets of your Stream Analytics jobs in your storage account. This gives you total control over how your Stream Analytics data is encrypted."
        displayName = "Azure Stream Analytics jobs should use customer-managed keys to encrypt data"
      }
      type = "String"
    }
    SynapseWorkspaceCMKEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Use customer-managed keys to control the encryption at rest of the data stored in Azure Synapse workspaces. Customer-managed keys deliver double encryption by adding a second layer of encryption on top of the default encryption with service-managed keys."
        displayName = "Azure Synapse workspaces should use customer-managed keys to encrypt data at rest"
      }
      type = "String"
    }
    WorkspaceCMKEffect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Manage encryption at rest of your Azure Machine Learning workspace data with customer-managed keys (CMK). By default, customer data is encrypted with service-managed keys, but CMKs are commonly required to meet regulatory compliance standards. CMKs enable the data to be encrypted with an Azure Key Vault key created and owned by you. You have full control and responsibility for the key lifecycle, including rotation and management. Learn more about CMK encryption at https://aka.ms/azureml-workspaces-cmk."
        displayName = "Azure Machine Learning workspaces should be encrypted with a customer-managed key (CMK)"
      }
      type = "String"
    }
  })
  policy_type = "Custom"
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('ACRCmkEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5b9159ae-1701-4a6f-9a7a-aa9c8ddd0580"
    policy_group_names   = []
    reference_id         = "ACRCmkDeny"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AksCmkEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7d7be79c-23ba-4033-84dd-45e2a5ccdd67"
    policy_group_names   = []
    reference_id         = "AksCmkDeny"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('WorkspaceCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ba769a63-b8cc-4b2d-abf6-ac33c7204be8"
    policy_group_names   = []
    reference_id         = "WorkspaceCMK"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('CognitiveServicesCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/67121cc7-ff39-4ab8-b7e3-95b84dab487d"
    policy_group_names   = []
    reference_id         = "CognitiveServicesCMK"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('CosmosCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f905d99-2ab7-462c-a6b0-f709acca6c8f"
    policy_group_names   = []
    reference_id         = "CosmosCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('DataBoxCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/86efb160-8de7-451d-bc08-5d475b0aadae"
    policy_group_names   = []
    reference_id         = "DataBoxCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StreamAnalyticsCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/87ba29ef-1ab3-4d82-b763-87fcd4f531f7"
    policy_group_names   = []
    reference_id         = "StreamAnalyticsCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SynapseWorkspaceCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f7d52b2d-e161-4dfa-a82b-55e564167385"
    policy_group_names   = []
    reference_id         = "SynapseWorkspaceCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('StorageCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6fac406b-40ca-413b-bf8e-0bf964659c25"
    policy_group_names   = []
    reference_id         = "StorageCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('MySQLCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83cef61d-dbd1-4b20-a4fc-5fbc7da10833"
    policy_group_names   = []
    reference_id         = "MySQLCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('PostgreSQLCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/18adea5e-f416-4d0f-8aa8-d24321e3e274"
    policy_group_names   = []
    reference_id         = "PostgreSQLCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('SqlServerTDECMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0a370ff3-6cab-4e85-8995-295fd854c5b8"
    policy_group_names   = []
    reference_id         = "SqlServerTDECMKEffect"
    version              = "2.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('HealthcareAPIsCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/051cba44-2429-45b9-9649-46cec11c7119"
    policy_group_names   = []
    reference_id         = "HealthcareAPIsCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('AzureBatchCMKEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/99e9ccd8-3db9-4592-b0d1-14b1715a4d8a"
    policy_group_names   = []
    reference_id         = "AzureBatchCMKEffect"
    version              = "1.*.*"
  }
  policy_definition_reference {
    parameter_values = jsonencode({
      effect = {
        value = "[parameters('EncryptedVMDisksEffect')]"
      }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0961003e-5a0a-4549-abde-af6a37f2724d"
    policy_group_names   = []
    reference_id         = "EncryptedVMDisksEffect"
    version              = "2.*.*"
  }
}
