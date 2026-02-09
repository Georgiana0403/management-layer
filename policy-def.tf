resource "azurerm_policy_definition" "deny_classic_resources" {
  description         = "This policy denies the creation of Azure Classic resources (ASM)."
  display_name        = "Deny Creation of classic (ASM) resources"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "General"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:30:21.0448848Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode       = "All"
  name       = "Deny-Classic-Resources"
  parameters = null
  policy_rule = jsonencode({
    if = {
      field = "type"
      like  = "Microsoft.Classic*"
    }
    then = {
      effect = "Deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceApiApp-http"
resource "azurerm_policy_definition" "deny_appserviceapiapp_http" {
  description         = "Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks."
  display_name        = "API App should only be accessible over HTTPS"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "App Service"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:43:10.2935057Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-AppServiceApiApp-http"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Web/sites"
        field  = "type"
        }, {
        field = "kind"
        like  = "*api"
        }, {
        equals = "false"
        field  = "Microsoft.Web/sites/httpsOnly"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Sql-minTLS"
resource "azurerm_policy_definition" "deny_sql_mintls" {
  description         = "Setting minimal TLS version to 1.2 improves security by ensuring your Azure SQL Database can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not reccomended since they have well documented security vunerabilities."
  display_name        = "Azure SQL Database should have the minimal TLS version set to the highest version"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:23:55.9002876Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-Sql-minTLS"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    minimalTlsVersion = {
      allowedValues = ["1.2", "1.1", "1.0"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version minimum TLS version SQL servers to enforce"
        displayName = "Select version for SQL server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Sql/servers"
        field  = "type"
        }, {
        anyOf = [{
          exists = "false"
          field  = "Microsoft.Sql/servers/minimalTlsVersion"
          }, {
          field     = "Microsoft.Sql/servers/minimalTlsVersion"
          notequals = "[parameters('minimalTlsVersion')]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MachineLearning-ComputeCluster-RemoteLoginPortPublicAccess"
resource "azurerm_policy_definition" "deny_machinelearning_computecluster_remoteloginportpublicaccess" {
  description         = "Deny public access of Azure Machine Learning clusters via SSH."
  display_name        = "Deny public access of Azure Machine Learning clusters via SSH"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Machine Learning"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:47:54.6928791Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "All"
  name = "Deny-MachineLearning-ComputeCluster-RemoteLoginPortPublicAccess"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces/computes"
        field  = "type"
        }, {
        equals = "AmlCompute"
        field  = "Microsoft.MachineLearningServices/workspaces/computes/computeType"
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.MachineLearningServices/workspaces/computes/remoteLoginPortPublicAccess"
          }, {
          field     = "Microsoft.MachineLearningServices/workspaces/computes/remoteLoginPortPublicAccess"
          notEquals = "Disabled"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Storage-SFTP"
resource "azurerm_policy_definition" "deny_storage_sftp" {
  description         = "This policy denies the creation of Storage Accounts with SFTP enabled for Blob Storage."
  display_name        = "Storage Accounts with SFTP enabled should be denied"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Storage"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:03:59.0508256Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-Storage-SFTP"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "The effect determines what happens when the policy rule is evaluated to match"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Storage/storageAccounts"
        field  = "type"
        }, {
        equals = "true"
        field  = "Microsoft.Storage/storageAccounts/isSftpEnabled"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-iotHub"
resource "azurerm_policy_definition" "deploy_diagnostics_iothub" {
  description         = "Deploys the diagnostic settings for IoT Hub to stream to a Log Analytics workspace when any IoT Hub which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for IoT Hub to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:27:08.0567576Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-iotHub"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Devices/IotHubs"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Connections"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DeviceTelemetry"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "C2DCommands"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DeviceIdentityOperations"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "FileUploadOperations"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Routes"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "D2CTwinOperations"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "C2DTwinOperations"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "TwinQueries"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "JobsOperations"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DirectMethods"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DistributedTracing"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Configurations"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DeviceStreams"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Devices/IotHubs/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-APIMgmt"
resource "azurerm_policy_definition" "deploy_diagnostics_apimgmt" {
  description         = "Deploys the diagnostic settings for API Management to stream to a Log Analytics workspace when any API Management which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for API Management to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:39:58.4066138Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-APIMgmt"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logAnalyticsDestinationType = {
      allowedValues = ["AzureDiagnostics", "Dedicated"]
      defaultValue  = "AzureDiagnostics"
      metadata = {
        description = "Select destination type for Log Analytics. Allowed values are 'Dedicated' (resource specific) and 'AzureDiagnostics'. Default is 'AzureDiagnostics'"
        displayName = "Log Analytics destination type"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.ApiManagement/service"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logAnalyticsDestinationType = {
                value = "[parameters('logAnalyticsDestinationType')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logAnalyticsDestinationType = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logAnalyticsDestinationType = "[parameters('logAnalyticsDestinationType')]"
                  logs = [{
                    category = "GatewayLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "WebSocketConnectionLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.ApiManagement/service/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-PublicEndpoint-MariaDB"
resource "azurerm_policy_definition" "deny_publicendpoint_mariadb" {
  description         = "This policy denies the creation of Maria DB accounts with exposed public endpoints. Superseded by https://www.azadvertizer.net/azpolicyadvertizer/fdccbe47-f3e3-4213-ad5d-ea459b2fa077.html"
  display_name        = "[Deprecated] Public network access should be disabled for MariaDB"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:46:19.3835685Z"
    deprecated           = true
    source               = "https://github.com/Azure/Enterprise-Scale/"
    supersededBy         = "fdccbe47-f3e3-4213-ad5d-ea459b2fa077"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:05:33.3171129Z"
    version              = "1.0.0-deprecated"
  })
  mode = "Indexed"
  name = "Deny-PublicEndpoint-MariaDB"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.DBforMariaDB/servers"
        field  = "type"
        }, {
        field     = "Microsoft.DBforMariaDB/servers/publicNetworkAccess"
        notequals = "Disabled"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Redis-http"
resource "azurerm_policy_definition" "deny_redis_http" {
  description         = "Audit enabling of only connections via SSL to Azure Cache for Redis. Validate both minimum TLS version and enableNonSslPort is disabled. Use of secure connections ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking"
  display_name        = "Azure Cache for Redis only secure connections should be enabled"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Cache"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:27:08.0169379Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-Redis-http"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "The effect determines what happens when the policy rule is evaluated to match"
        displayName = "Effect"
      }
      type = "String"
    }
    minimumTlsVersion = {
      allowedValues = ["1.2", "1.1", "1.0"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select minimum TLS version for Azure Cache for Redis."
        displayName = "Select minumum TLS version for Azure Cache for Redis."
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Cache/redis"
        field  = "type"
        }, {
        anyOf = [{
          equals = "true"
          field  = "Microsoft.Cache/Redis/enableNonSslPort"
          }, {
          field     = "Microsoft.Cache/Redis/minimumTlsVersion"
          notequals = "[parameters('minimumTlsVersion')]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MySQL"
resource "azurerm_policy_definition" "deploy_diagnostics_mysql" {
  description         = "Deploys the diagnostic settings for Database for MySQL to stream to a Log Analytics workspace when any Database for MySQL which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Database for MySQL to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:24:57.8829096Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-MySQL"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DBforMySQL/servers"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "MySqlSlowLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "MySqlAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DBforMySQL/servers/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDWorkspace"
resource "azurerm_policy_definition" "deploy_diagnostics_wvdworkspace" {
  description         = "Deploys the diagnostic settings for AVD Workspace to stream to a Log Analytics workspace when any Workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all and categorys enabled."
  display_name        = "Deploy Diagnostic Settings for AVD Workspace to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:38:21.6970052Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.1"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-WVDWorkspace"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DesktopVirtualization/workspaces"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Checkpoint"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Error"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Management"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Feed"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DesktopVirtualization/workspaces/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-SecurityAlertPolicies"
resource "azurerm_policy_definition" "deploy_sql_securityalertpolicies" {
  description         = "Deploy the security Alert Policies configuration with email admin accounts when it not exist in current configuration"
  display_name        = "Deploy SQL Database security Alert Policies configuration with email admin accounts"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:43:10.5521539Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.1"
  })
  mode = "Indexed"
  name = "Deploy-Sql-SecurityAlertPolicies"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    emailAddresses = {
      defaultValue = ["admin@contoso.com", "admin@fabrikam.com"]
      type         = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Sql/servers/databases"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              emailAddresses = {
                value = "[parameters('emailAddresses')]"
              }
              location = {
                value = "[field('location')]"
              }
              sqlServerDataBaseName = {
                value = "[field('name')]"
              }
              sqlServerName = {
                value = "[first(split(field('fullname'),'/'))]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                emailAddresses = {
                  type = "Array"
                }
                location = {
                  type = "String"
                }
                sqlServerDataBaseName = {
                  type = "String"
                }
                sqlServerName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2018-06-01-preview"
                name       = "[concat(parameters('sqlServerName'),'/',parameters('sqlServerDataBaseName'),'/default')]"
                properties = {
                  disabledAlerts          = [""]
                  emailAccountAdmins      = true
                  emailAddresses          = "[parameters('emailAddresses')]"
                  retentionDays           = 0
                  state                   = "Enabled"
                  storageAccountAccessKey = ""
                  storageEndpoint         = null
                }
                type = "Microsoft.Sql/servers/databases/securityAlertPolicies"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "Enabled"
            field  = "Microsoft.Sql/servers/databases/securityAlertPolicies/state"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/056cd41c-7e88-42e1-933e-88ba6a50c9c3"]
        type              = "Microsoft.Sql/servers/databases/securityAlertPolicies"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-All-Operations"
resource "azurerm_policy_definition" "deny_all_operations" {
  description         = "This policy should be assigned on the quarantine management group. It denies all operations/deployments to the subscriptions in scope, until the subscriptions are proper onboarded and moved into the correct management group."
  display_name        = "Deny all operations on a subscription until onboarded"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:27:08.1606852Z"
    updatedBy = null
    updatedOn = null
  })
  mode       = "All"
  name       = "Deny-All-Operations"
  parameters = null
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        equals = "Microsoft.Resources/subscriptions/resourceGroups"
        field  = "type"
        }, {
        field     = "type"
        notEquals = "Microsoft.Resources/subscriptions/resourceGroups"
      }]
    }
    then = {
      effect = "Deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-AuditingSettings"
resource "azurerm_policy_definition" "deploy_sql_auditingsettings" {
  description         = "Deploy auditing settings to SQL Database when it not exist in the deployment"
  display_name        = "Deploy SQL database auditing settings"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:47:54.9257953Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deploy-Sql-AuditingSettings"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Sql/servers/databases"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              sqlServerDataBaseName = {
                value = "[field('name')]"
              }
              sqlServerName = {
                value = "[first(split(field('fullname'),'/'))]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                sqlServerDataBaseName = {
                  type = "String"
                }
                sqlServerName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-03-01-preview"
                name       = "[concat( parameters('sqlServerName'),'/',parameters('sqlServerDataBaseName'),'/default')]"
                properties = {
                  auditActionsAndGroups       = ["BATCH_COMPLETED_GROUP", "DATABASE_OBJECT_CHANGE_GROUP", "SCHEMA_OBJECT_CHANGE_GROUP", "BACKUP_RESTORE_GROUP", "APPLICATION_ROLE_CHANGE_PASSWORD_GROUP", "DATABASE_PRINCIPAL_CHANGE_GROUP", "DATABASE_PRINCIPAL_IMPERSONATION_GROUP", "DATABASE_ROLE_MEMBER_CHANGE_GROUP", "USER_CHANGE_PASSWORD_GROUP", "DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP", "DATABASE_OBJECT_PERMISSION_CHANGE_GROUP", "DATABASE_PERMISSION_CHANGE_GROUP", "SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP", "SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP", "FAILED_DATABASE_AUTHENTICATION_GROUP"]
                  isAzureMonitorTargetEnabled = true
                  state                       = "enabled"
                }
                type = "Microsoft.Sql/servers/databases/auditingSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "enabled"
            field  = "Microsoft.Sql/servers/databases/auditingSettings/state"
            }, {
            equals = "true"
            field  = "Microsoft.Sql/servers/databases/auditingSettings/isAzureMonitorTargetEnabled"
          }]
        }
        name              = "default"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/056cd41c-7e88-42e1-933e-88ba6a50c9c3"]
        type              = "Microsoft.Sql/servers/databases/auditingSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-TimeSeriesInsights"
resource "azurerm_policy_definition" "deploy_diagnostics_timeseriesinsights" {
  description         = "Deploys the diagnostic settings for Time Series Insights to stream to a Log Analytics workspace when any Time Series Insights which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Time Series Insights to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:41:34.5555902Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-TimeSeriesInsights"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.TimeSeriesInsights/environments"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Ingress"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Management"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.TimeSeriesInsights/environments/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-NetworkSecurityGroups"
resource "azurerm_policy_definition" "deploy_diagnostics_networksecuritygroups" {
  description         = "Deploys the diagnostic settings for Network Security Groups to stream to a Log Analytics workspace when any Network Security Groups which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Network Security Groups to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:44:45.0963603Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-NetworkSecurityGroups"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/networkSecurityGroups"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "NetworkSecurityGroupEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "NetworkSecurityGroupRuleCounter"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics     = []
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/networkSecurityGroups/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DenyAction-DiagnosticLogs"
resource "azurerm_policy_definition" "denyaction_diagnosticlogs" {
  description         = "DenyAction implementation on Diagnostic Logs."
  display_name        = "DenyAction implementation on Diagnostic Logs."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:07:06.4980711Z"
    deprecated           = false
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode       = "Indexed"
  name       = "DenyAction-DiagnosticLogs"
  parameters = null
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Insights/diagnosticSettings"
      field  = "type"
    }
    then = {
      details = {
        actionNames = ["delete"]
      }
      effect = "denyAction"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/StorageAccount-Blob-Backup-long"
resource "azurerm_policy_definition" "storageaccount_blob_backup_long" {
  description         = "Enforce backup for blobs on all storage accounts that contain a given tag to a central backup vault. Doing this can help you manage backup of blobs contained across multiple storage accounts at scale. For more details, refer to https://aka.ms/AB-BlobBackupAzPolicies"
  display_name        = "Configure backup for blobs on storage accounts with a given tag to an existing backup vault in the same region"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:23:55.9558375Z"
    preview   = true
    updatedBy = null
    updatedOn = null
    version   = "2.0.0-preview"
  })
  mode = "Indexed"
  name = "StorageAccount-Blob-Backup-long"
  parameters = jsonencode({
    dailyRetentionDurationCount = {
      defaultValue = 60
      metadata = {
        description = "daily: retention of daily backup points"
      }
      type = "Integer"
    }
    policyName = {
      defaultValue = "storage-blob-60d"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy"
      }
      type = "String"
    }
    storageBackupTagName = {
      defaultValue = "storageaccount-backup-policy"
      metadata = {
        description = "the name of the tag key to filter virtual machines for"
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
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Storage/StorageAccounts"
        field  = "type"
        }, {
        contains = "[parameters('policyName')]"
        field    = "[concat('tags[', parameters('storageBackupTagName'), ']')]"
        }, {
        equals = "StorageV2"
        field  = "kind"
        }, {
        contains = "Standard"
        field    = "Microsoft.Storage/storageAccounts/sku.name"
        }, {
        field     = "Microsoft.Storage/storageAccounts/isHnsEnabled"
        notEquals = "true"
        }, {
        field     = "Microsoft.Storage/storageAccounts/isNfsV3Enabled"
        notEquals = "true"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              dailyRetentionDurationCount = {
                value = "[parameters('dailyRetentionDurationCount')]"
              }
              policyName = {
                value = "[parameters('policyName')]"
              }
              storageAccountResourceId = {
                value = "[field('id')]"
              }
              storageResourceGroupLocation = {
                value = "[field('location')]"
              }
              storageResourceGroupName = {
                value = "[resourceGroup().name]"
              }
              vaultRedundancy = {
                value = "[parameters('vaultRedundancy')]"
              }
              vaultTags = {
                value = "[parameters('vaultTags')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                dailyRetentionDurationCount = {
                  type = "int"
                }
                policyName = {
                  type = "string"
                }
                storageAccountResourceId = {
                  metadata = {
                    description = "ResourceId of the Storage Account"
                  }
                  type = "string"
                }
                storageResourceGroupLocation = {
                  type = "string"
                }
                storageResourceGroupName = {
                  type = "string"
                }
                vaultRedundancy = {
                  type = "string"
                }
                vaultTags = {
                  type = "object"
                }
              }
              resources = [{
                apiVersion = "2021-04-01"
                name       = "[concat('DeployProtection-',uniqueString(variables('storageAccountName')))]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    parameters     = {}
                    resources = [{
                      apiVersion = "2021-01-01"
                      identity = {
                        type = "systemAssigned"
                      }
                      location = "[parameters('storageResourceGroupLocation')]"
                      name     = "[variables('BackupVaultName')]"
                      properties = {
                        storageSettings = [{
                          datastoreType = "VaultStore"
                          type          = "[parameters('vaultRedundancy')]"
                        }]
                      }
                      type = "Microsoft.DataProtection/backupVaults"
                      }, {
                      apiVersion = "2021-01-01"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]"]
                      name       = "[format('{0}/{1}', variables('BackupVaultName'), variables('backupPolicyName'))]"
                      properties = {
                        datasourceTypes = ["[variables('dataSourceType')]"]
                        objectType      = "BackupPolicy"
                        policyRules = [{
                          isDefault = true
                          lifecycles = [{
                            deleteAfter = {
                              duration   = "[concat('P',parameters('dailyRetentionDurationCount'), 'D')]"
                              objectType = "AbsoluteDeleteOption"
                            }
                            sourceDataStore = {
                              dataStoreType = "OperationalStore"
                              objectType    = "DataStoreInfoBase"
                            }
                          }]
                          name       = "Default"
                          objectType = "AzureRetentionRule"
                          ruleType   = "Retention"
                        }]
                      }
                      type = "Microsoft.DataProtection/backupVaults/backupPolicies"
                      }, {
                      apiVersion = "2020-04-01-preview"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]"]
                      name       = "[guid(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), variables('roleDefinitionId'), resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName')))]"
                      properties = {
                        principalId      = "[reference(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), '2021-01-01', 'Full').identity.principalId]"
                        principalType    = "ServicePrincipal"
                        roleDefinitionId = "[variables('roleDefinitionId')]"
                      }
                      scope = "[format('Microsoft.Storage/storageAccounts/{0}', variables('storageAccountName'))]"
                      type  = "Microsoft.Authorization/roleAssignments"
                      }, {
                      apiVersion = "2021-01-01"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]", "[resourceId('Microsoft.DataProtection/backupVaults/backupPolicies', variables('BackupVaultName'), variables('backupPolicyName'))]", "[extensionResourceId(resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName')), 'Microsoft.Authorization/roleAssignments', guid(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), variables('roleDefinitionId'), resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))))]"]
                      name       = "[concat(variables('BackupVaultName'), '/', variables('storageAccountName'))]"
                      properties = {
                        dataSourceInfo = {
                          datasourceType   = "[variables('dataSourceType')]"
                          objectType       = "Datasource"
                          resourceID       = "[parameters('storageAccountResourceId')]"
                          resourceLocation = "[parameters('storageResourceGroupLocation')]"
                          resourceName     = "[variables('storageAccountName')]"
                          resourceType     = "[variables('resourceType')]"
                          resourceUri      = "[parameters('storageAccountResourceId')]"
                        }
                        objectType = "BackupInstance"
                        policyInfo = {
                          name     = "[variables('backupPolicyName')]"
                          policyId = "[resourceId('Microsoft.DataProtection/backupVaults/backupPolicies', variables('BackupVaultName'), variables('backupPolicyName'))]"
                        }
                      }
                      type = "Microsoft.DataProtection/backupvaults/backupInstances"
                    }]
                  }
                }
                resourceGroup  = "[variables('vaultResourceGroup')]"
                subscriptionId = "[variables('vaultSubscriptionId')]"
                type           = "Microsoft.Resources/deployments"
              }]
              variables = {
                BackupVaultName     = "[concat('rsv-', parameters('storageResourceGroupName'))]"
                backupPolicyName    = "[concat('policy-', parameters('policyName'))]"
                dataSourceType      = "Microsoft.Storage/storageAccounts/blobServices"
                resourceType        = "Microsoft.Storage/storageAccounts"
                roleDefinitionId    = "[subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e5e2a7ff-d759-4cd2-bb51-3152d37e2eb1')]"
                storageAccountName  = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 8))]"
                vaultResourceGroup  = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 4))]"
                vaultSubscriptionId = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 2))]"
              }
            }
          }
        }
        existenceCondition = {
          equals = true
          field  = "Microsoft.Storage/storageAccounts/blobServices/default.restorePolicy.enabled"
        }
        name              = "default"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635"]
        type              = "Microsoft.Storage/storageAccounts/blobServices"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Lighthouse-Contributor-Delegation-To-Subscription"
resource "azurerm_policy_definition" "deploy_lighthouse_contributor_delegation_to_subscription" {
  description         = "Policy deploys the GKGAB Azure Lighthouse delegation with permission CONTRIBUTOR to the subscriptions in scope."
  display_name        = "Deploy Lighthouse Contributor delegation to Subscription"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Lighthouse"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:25:33.5971054Z"
    updatedBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn = "2025-02-05T21:04:01.559001Z"
    version   = "1.0.0"
  })
  mode = "All"
  name = "Deploy-Lighthouse-Contributor-Delegation-To-Subscription"
  parameters = jsonencode({
    ContributorPrincipalID = {
      defaultValue = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      metadata = {
        description = "Object ID of Contributor Group provided by GKGAB"
      }
      type = "string"
    }
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the Policy."
        displayName = "Effects"
      }
      type = "String"
    }
    managedByTenantId = {
      defaultValue = "a53834b7-42bc-46a3-b004-369735c3acf9"
      metadata = {
        description = "Tenant ID provided by GKGAB"
      }
      type = "string"
    }
    mspOfferDescription = {
      defaultValue = "The Policy will grant glueckkanja-gab AG following RBAC role to all subscribtions in scope: Contributor - GKGAB Azure Lighthouse Contributor (covered by PIM)"
      metadata = {
        description = "Name of the Managed Service Provider offering"
      }
      type = "string"
    }
    mspOfferName = {
      defaultValue = "GKGAB Azure Managed Service - Access privileges - contributor"
      metadata = {
        description = "Specify a unique name for your offer"
      }
      type = "string"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions"
        field  = "type"
      }]
    }
    then = {
      details = {
        ExistenceScope = "Subscription"
        deployment = {
          location = "westeurope"
          properties = {
            mode = "incremental"
            parameters = {
              ContributorPrincipalID = {
                value = "[parameters('ContributorPrincipalID')]"
              }
              managedByTenantId = {
                value = "[parameters('managedByTenantId')]"
              }
              mspOfferDescription = {
                value = "[parameters('mspOfferDescription')]"
              }
              mspOfferName = {
                value = "[parameters('mspOfferName')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                ContributorPrincipalID = {
                  type = "string"
                }
                managedByTenantId = {
                  type = "String"
                }
                mspOfferDescription = {
                  type = "String"
                }
                mspOfferName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2019-09-01"
                name       = "[variables('mspRegistrationName')]"
                properties = {
                  authorizations             = "[variables('authorizations')]"
                  description                = "[parameters('mspOfferDescription')]"
                  managedByTenantId          = "[parameters('managedByTenantId')]"
                  registrationDefinitionName = "[parameters('mspOfferName')]"
                }
                type = "Microsoft.ManagedServices/registrationDefinitions"
                }, {
                apiVersion = "2019-09-01"
                dependsOn  = ["[resourceId('Microsoft.ManagedServices/registrationDefinitions/', variables('mspRegistrationName'))]"]
                name       = "[variables('mspAssignmentName')]"
                properties = {
                  registrationDefinitionId = "[resourceId('Microsoft.ManagedServices/registrationDefinitions/', variables('mspRegistrationName'))]"
                }
                type = "Microsoft.ManagedServices/registrationAssignments"
              }]
              variables = {
                authorizations = [{
                  principalId            = "[parameters('ContributorPrincipalID')]"
                  principalIdDisplayName = "GKGAB Azure Lighthouse Contributor"
                  roleDefinitionId       = "b24988ac-6180-42a0-ab88-20f7382dd24c"
                  }, {
                  principalId            = "[parameters('ContributorPrincipalID')]"
                  principalIdDisplayName = "Remove GKGAB Azure Lighthouse Delegation"
                  roleDefinitionId       = "91c1777a-f3dc-4fae-b103-61d183457e46"
                }]
                mspAssignmentName   = "[guid(parameters('mspOfferName'))]"
                mspRegistrationName = "[guid(parameters('mspOfferName'))]"
              }
            }
          }
        }
        deploymentScope = "Subscription"
        existenceCondition = {
          allOf = [{
            equals = "[guid(parameters('mspOfferName'))]"
            field  = "name"
          }]
        }
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635"]
        type              = "Microsoft.ManagedServices/registrationAssignments"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Resource-Locks"
resource "azurerm_policy_definition" "resource_locks" {
  description         = "Deny the deletion of resources with locks on many levels"
  display_name        = "Resource Locks"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    createdBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn = "2025-02-05T21:05:32.9861667Z"
    updatedBy = null
    updatedOn = null
  })
  mode = "Indexed"
  name = "Resource-Locks"
  parameters = jsonencode({
    ids = {
      defaultValue = []
      type         = "array"
    }
    tag_field = {
      defaultValue = "deny"
      type         = "string"
    }
    tags = {
      defaultValue = []
      type         = "array"
    }
    types = {
      defaultValue = []
      type         = "array"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        field = "id"
        in    = "[parameters('ids')]"
        }, {
        field = "type"
        in    = "[parameters('types')]"
        }, {
        field = "[concat('tags[', parameters('tag_field'), ']')]"
        in    = "[parameters('tags')]"
      }]
    }
    then = {
      details = {
        actionNames = ["delete"]
        cascadeBehaviors = {
          resourceGroup = "deny"
        }
      }
      effect = "denyAction"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Activity-Logs"
resource "azurerm_policy_definition" "deploy_activity_logs" {
  description         = "policy configures automatic log shipping of Azure Activity Logs to Log Analytics and Storage Account in Audit Subscription."
  display_name        = "Configure Subscription Activity Log forwarding"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Regulatory Compliance"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:33:32.251398Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Deploy-Activity-Logs"
  parameters = jsonencode({
    auditLogAnalyticsWorkspaceId = {
      metadata = {
        description = "ResourceID of the Log Analytics workspace in which resource logs should be saved."
      }
      type = "String"
    }
    auditStorageAccountId = {
      metadata = {
        description = "ResourceID of the Storage Account in which resource logs should be saved."
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions"
        field  = "type"
      }]
    }
    then = {
      details = {
        deployment = {
          location = "westeurope"
          properties = {
            mode = "incremental"
            parameters = {
              auditLogAnalyticsWorkspaceId = {
                value = "[parameters('auditLogAnalyticsWorkspaceId')]"
              }
              auditStorageAccountId = {
                value = "[parameters('auditStorageAccountId')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                auditLogAnalyticsWorkspaceId = {
                  metadata = {
                    description = "ResourceID of the Log Analytics workspace in which resource logs should be saved."
                  }
                  type = "string"
                }
                auditStorageAccountId = {
                  metadata = {
                    description = "ResourceID of the Storage Account in which resource logs should be saved."
                  }
                  type = "string"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                location   = "global"
                name       = "AF-SetByPolicy"
                properties = {
                  logs = [{
                    category = "Administrative"
                    enabled  = true
                    }, {
                    category = "Security"
                    enabled  = true
                    }, {
                    category = "ServiceHealth"
                    enabled  = true
                    }, {
                    category = "Alert"
                    enabled  = true
                    }, {
                    category = "Recommendation"
                    enabled  = true
                    }, {
                    category = "Policy"
                    enabled  = true
                    }, {
                    category = "Autoscale"
                    enabled  = true
                    }, {
                    category = "ResourceHealth"
                    enabled  = true
                  }]
                  storageAccountId = "[parameters('auditStorageAccountId')]"
                  workspaceId      = "[parameters('auditLogAnalyticsWorkspaceId')]"
                }
                type = "Microsoft.Insights/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        deploymentScope = "Subscription"
        existenceCondition = {
          allOf = [{
            equals = "[parameters('auditStorageAccountId')]"
            field  = "Microsoft.Insights/diagnosticSettings/storageAccountId"
            }, {
            equals = "[parameters('auditLogAnalyticsWorkspaceId')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
            }, {
            equals = true
            field  = "Microsoft.Insights/diagnosticSettings/logs[*].enabled"
          }]
        }
        existenceScope    = "subscription"
        name              = "AF-SetByPolicy"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MachineLearning-Compute-SubnetId"
resource "azurerm_policy_definition" "deny_machinelearning_compute_subnetid" {
  description         = "Enforce subnet connectivity for Azure Machine Learning compute clusters and compute instances."
  display_name        = "Enforce subnet connectivity for Azure Machine Learning compute clusters and compute instances"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Machine Learning"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.4924469Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-MachineLearning-Compute-SubnetId"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces/computes"
        field  = "type"
        }, {
        field = "Microsoft.MachineLearningServices/workspaces/computes/computeType"
        in    = ["AmlCompute", "ComputeInstance"]
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.MachineLearningServices/workspaces/computes/subnet.id"
          }, {
          equals = true
          value  = "[empty(field('Microsoft.MachineLearningServices/workspaces/computes/subnet.id'))]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Databricks-VirtualNetwork"
resource "azurerm_policy_definition" "deny_databricks_virtualnetwork" {
  description         = "Enforces the use of vnet injection for Databricks workspaces."
  display_name        = "Deny Databricks workspaces without Vnet injection"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Databricks"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:25:33.62029Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-Databricks-VirtualNetwork"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Databricks/workspaces"
        field  = "type"
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.DataBricks/workspaces/parameters.customVirtualNetworkId.value"
          }, {
          exists = false
          field  = "Microsoft.DataBricks/workspaces/parameters.customPublicSubnetName.value"
          }, {
          exists = false
          field  = "Microsoft.DataBricks/workspaces/parameters.customPrivateSubnetName.value"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Subnet-Without-Nsg"
resource "azurerm_policy_definition" "deny_subnet_without_nsg" {
  description         = "This policy denies the creation of a subnet without a Network Security Group. NSG help to protect traffic across subnet-level."
  display_name        = "Subnets should have a Network Security Group"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.3328058Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "2.0.0"
  })
  mode = "All"
  name = "Deny-Subnet-Without-Nsg"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    excludedSubnets = {
      defaultValue = ["GatewaySubnet", "AzureFirewallSubnet", "AzureFirewallManagementSubnet"]
      metadata = {
        description = "Array of subnet names that are excluded from this policy"
        displayName = "Excluded Subnets"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks"
          field  = "type"
          }, {
          count = {
            field = "Microsoft.Network/virtualNetworks/subnets[*]"
            where = {
              allOf = [{
                exists = "false"
                field  = "Microsoft.Network/virtualNetworks/subnets[*].networkSecurityGroup.id"
                }, {
                field = "Microsoft.Network/virtualNetworks/subnets[*].name"
                notIn = "[parameters('excludedSubnets')]"
              }]
            }
          }
          notEquals = 0
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks/subnets"
          field  = "type"
          }, {
          field = "name"
          notIn = "[parameters('excludedSubnets')]"
          }, {
          exists = "false"
          field  = "Microsoft.Network/virtualNetworks/subnets/networkSecurityGroup.id"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CDNEndpoints"
resource "azurerm_policy_definition" "deploy_diagnostics_cdnendpoints" {
  description         = "Deploys the diagnostic settings for CDN Endpoint to stream to a Log Analytics workspace when any CDN Endpoint which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for CDN Endpoint to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:28:44.1338581Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-CDNEndpoints"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Cdn/profiles/endpoints"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('fullName')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "CoreAnalytics"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics     = []
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Cdn/profiles/endpoints/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/VirtualMachine-Backup-2000-14d-4w-12m-10y"
resource "azurerm_policy_definition" "virtualmachine_backup_2000_14d_4w_12m_10y" {
  description         = "This policy creates an Azure Recovery Services vault in the resource group when the first VM with supported OS is deployed. It creates a backup policy and assigns the VM to the backup policy schedule."
  display_name        = "Virtual Machine Backup Policy - Daily at 2000 - 14 days - 4 weeks - 12 months - 10 years"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:27:08.1736609Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "VirtualMachine-Backup-2000-14d-4w-12m-10y"
  parameters = jsonencode({
    dailyRetentionDurationCount = {
      defaultValue = 14
      metadata = {
        description = "daily: retention of daily backup points"
      }
      type = "Integer"
    }
    daysOfTheWeek = {
      defaultValue = ["Sunday"]
      metadata = {
        description = "daily: daily backup which should be kept as the weekly backup point"
      }
      type = "Array"
    }
    monthlyRetentionDurationCount = {
      defaultValue = 12
      metadata = {
        description = "monthly: Monthly backup retention"
      }
      type = "Integer"
    }
    monthsOfYear = {
      defaultValue = ["December"]
      metadata = {
        description = "yearly: monthly backup to keep as the yearly backup"
      }
      type = "Array"
    }
    policyName = {
      defaultValue = "vm-daily-2000-14d-4w-12m-10y"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy"
      }
      type = "String"
    }
    retentionScheduleDaily = {
      defaultValue = {
        daysOfTheMonth = [{
          date   = 0
          isLast = true
        }]
      }
      metadata = {
        description = "monthly: Default value keeps the last daily backup of the month. Only retentionScheduleDaily or retentionScheduleWeekly must be defined"
      }
      type = "Object"
    }
    scheduleRunTimes = {
      defaultValue = "20:00:00"
      metadata = {
        description = "runtime in format of hh:mm:ss"
      }
      type = "String"
    }
    timeZone = {
      defaultValue = "UTC"
      metadata = {
        description = "currently not used, replaced with timezoneselector-variable based on rg"
      }
      type = "String"
    }
    vaultSku = {
      defaultValue = "Standard"
      metadata = {
        description = "Standard or RS0 - currently only Standard (GRS) working, Microsoft limit"
      }
      type = "String"
    }
    vaultTags = {
      defaultValue = {
        description = "vault used by Azure policy af-dine-vm-backup-rg"
      }
      type = "Object"
    }
    vmBackupTagName = {
      defaultValue = "vm-backup-policy"
      metadata = {
        description = "the name of the tag key to filter virtual machines for"
      }
      type = "String"
    }
    weeklyRetentionDurationCount = {
      defaultValue = 4
      metadata = {
        description = "weekly: retention of the weekly backup point"
      }
      type = "Integer"
    }
    yearlyRetentionDurationCount = {
      defaultValue = 10
      metadata = {
        description = "yearly: Yearly backup retention"
      }
      type = "Integer"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        equals = "[parameters('policyName')]"
        field  = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
        }, {
        field   = "name"
        notLike = "*-test"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              dailyRetentionDurationCount = {
                value = "[parameters('dailyRetentionDurationCount')]"
              }
              daysOfTheWeek = {
                value = "[parameters('daysOfTheWeek')]"
              }
              monthlyRetentionDurationCount = {
                value = "[parameters('monthlyRetentionDurationCount')]"
              }
              monthsOfYear = {
                value = "[parameters('monthsOfYear')]"
              }
              policyName = {
                value = "[parameters('policyName')]"
              }
              retentionScheduleDaily = {
                value = "[parameters('retentionScheduleDaily')]"
              }
              scheduleRunTimes = {
                value = "[parameters('scheduleRunTimes')]"
              }
              timeZone = {
                value = "[parameters('timeZone')]"
              }
              vaultSku = {
                value = "[parameters('vaultSku')]"
              }
              vaultTags = {
                value = "[parameters('vaultTags')]"
              }
              vmName = {
                value = "[field('name')]"
              }
              vmResourceGroupLocation = {
                value = "[field('location')]"
              }
              vmResourceGroupName = {
                value = "[resourceGroup().name]"
              }
              weeklyRetentionDurationCount = {
                value = "[parameters('weeklyRetentionDurationCount')]"
              }
              yearlyRetentionDurationCount = {
                value = "[parameters('yearlyRetentionDurationCount')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                dailyRetentionDurationCount = {
                  type = "int"
                }
                daysOfTheWeek = {
                  type = "array"
                }
                monthlyRetentionDurationCount = {
                  type = "int"
                }
                monthsOfYear = {
                  type = "array"
                }
                policyName = {
                  type = "string"
                }
                retentionScheduleDaily = {
                  type = "object"
                }
                scheduleRunTimes = {
                  type = "string"
                }
                timeZone = {
                  type = "string"
                }
                vaultSku = {
                  type = "string"
                }
                vaultTags = {
                  type = "object"
                }
                vmName = {
                  type = "string"
                }
                vmResourceGroupLocation = {
                  type = "string"
                }
                vmResourceGroupName = {
                  type = "string"
                }
                weeklyRetentionDurationCount = {
                  type = "int"
                }
                yearlyRetentionDurationCount = {
                  type = "int"
                }
              }
              resources = [{
                apiVersion = "2023-07-01"
                name       = "[concat(parameters('vmName'), '-backupIntent')]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    resources = [{
                      apiVersion = "2023-06-01"
                      location   = "[parameters('vmResourceGroupLocation')]"
                      name       = "[variables('BackupVaultName')]"
                      properties = {
                        publicNetworkAccess = "Enabled"
                        restoreSettings = {
                          crossSubscriptionRestoreSettings = {
                            crossSubscriptionRestoreState = "Enabled"
                          }
                        }
                      }
                      sku = {
                        name = "[parameters('vaultSku')]"
                      }
                      tags = "[parameters('vaultTags')]"
                      type = "Microsoft.RecoveryServices/vaults"
                      }, {
                      apiVersion = "2023-04-01"
                      dependsOn  = ["[variables('BackupVaultName')]"]
                      location   = "[parameters('vmResourceGroupLocation')]"
                      name       = "[concat(variables('BackupVaultName'), '/', variables('BackupPolicyName'))]"
                      properties = {
                        backupManagementType          = "AzureIaasVM"
                        instantRPDetails              = {}
                        instantRpRetentionRangeInDays = 5
                        policyType                    = "V2"
                        retentionPolicy = {
                          dailySchedule = {
                            retentionDuration = {
                              count        = "[int(parameters('dailyRetentionDurationCount'))]"
                              durationType = "Days"
                            }
                            retentionTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          monthlySchedule = {
                            retentionDuration = {
                              count        = "[parameters('monthlyRetentionDurationCount')]"
                              durationType = "Months"
                            }
                            retentionScheduleDaily      = "[parameters('retentionScheduleDaily')]"
                            retentionScheduleFormatType = "Daily"
                            retentionTimes              = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          retentionPolicyType = "LongTermRetentionPolicy"
                          weeklySchedule = {
                            daysOfTheWeek = "[parameters('daysOfTheWeek')]"
                            retentionDuration = {
                              count        = "[parameters('weeklyRetentionDurationCount')]"
                              durationType = "Weeks"
                            }
                            retentionTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          yearlySchedule = {
                            monthsOfYear = "[parameters('monthsOfYear')]"
                            retentionDuration = {
                              count        = "[parameters('yearlyRetentionDurationCount')]"
                              durationType = "Years"
                            }
                            retentionScheduleDaily      = "[parameters('retentionScheduleDaily')]"
                            retentionScheduleFormatType = "Daily"
                            retentionTimes              = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                        }
                        schedulePolicy = {
                          dailySchedule = {
                            scheduleRunTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          schedulePolicyType   = "SimpleSchedulePolicyV2"
                          scheduleRunFrequency = "Daily"
                        }
                        timeZone = "[parameters('timeZone')]"
                      }
                      tags = {}
                      type = "Microsoft.RecoveryServices/vaults/backupPolicies"
                      }, {
                      apiVersion = "2023-06-01"
                      dependsOn  = ["[variables('BackupPolicyName')]"]
                      name       = "[concat(variables('BackupVaultName'), variables('BackupIntentConcat'))]"
                      properties = {
                        policyId                 = "[concat(resourceId('Microsoft.RecoveryServices/vaults/backuppolicies', variables('BackupVaultName'), variables('BackupPolicyName')))]"
                        protectionIntentItemType = "AzureResourceItem"
                        sourceResourceId         = "[concat(resourceId('Microsoft.Compute/virtualMachines', parameters('vmName')))]"
                      }
                      type = "Microsoft.RecoveryServices/vaults/backupFabrics/backupProtectionIntent"
                    }]
                  }
                }
                resourceGroup = "[parameters('vmResourceGroupName')]"
                type          = "Microsoft.Resources/deployments"
              }]
              variables = {
                BackupIntentConcat = "[concat('/Azure/vm;iaasvmcontainerv2;', parameters('vmResourceGroupName'), ';', parameters('vmName'))]"
                BackupPolicyName   = "[concat('policy-',parameters('vmResourceGroupName'), '-', parameters('policyName'))]"
                BackupVaultName    = "[concat('rsv-', parameters('vmResourceGroupName'))]"
                timezoneMap = {
                  centralus = {
                    timezone = "Eastern Standard Time"
                  }
                  eastus2 = {
                    timezone = "Eastern Standard Time"
                  }
                  northeurope = {
                    timezone = "W. Europe Standard Time"
                  }
                  westeurope = {
                    timezone = "W. Europe Standard Time"
                  }
                }
                timezoneSelector = "[variables('timezoneMap')[parameters('vmResourceGroupLocation')].timezone]"
              }
            }
          }
        }
        existenceCondition = {
          allOf = [{
            field = "name"
            like  = "*"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.RecoveryServices/backupprotecteditems"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AnalysisService"
resource "azurerm_policy_definition" "deploy_diagnostics_analysisservice" {
  description         = "Deploys the diagnostic settings for Analysis Services to stream to a Log Analytics workspace when any Analysis Services which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Analysis Services to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:39:58.5756799Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-AnalysisService"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.AnalysisServices/servers"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Engine"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Service"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.AnalysisServices/servers/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-VirtualMachine-Backup-Tag"
resource "azurerm_policy_definition" "append_virtualmachine_backup_tag" {
  description         = "This policy appends default tag value to vmBackupTagName if not set."
  display_name        = "Add default backup tag to VM"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:28:44.1331713Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Append-VirtualMachine-Backup-Tag"
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
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        not = {
          equals = "microsoft-aks"
          field  = "Microsoft.Compute/virtualMachines/storageProfile.imageReference.publisher"
        }
        }, {
        anyOf = [{
          exists = "false"
          field  = "tags"
          }, {
          exists = "false"
          field  = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
          }, {
          field = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
          notIn = "[parameters('allowedBackupTagValues')]"
        }]
      }]
    }
    then = {
      details = [{
        field = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
        value = "[parameters('defaultBackupTagValue')]"
      }]
      effect = "append"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-MachineLearning-PrivateEndpointId"
resource "azurerm_policy_definition" "audit_machinelearning_privateendpointid" {
  description         = "Audit private endpoints that are created in other subscriptions and/or tenants for Azure Machine Learning."
  display_name        = "Control private endpoint connections to Azure Machine Learning"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Machine Learning"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:39:23.4105094Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Audit-MachineLearning-PrivateEndpointId"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces/privateEndpointConnections"
        field  = "type"
        }, {
        equals = "Approved"
        field  = "Microsoft.MachineLearningServices/workspaces/privateEndpointConnections/privateLinkServiceConnectionState.status"
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.MachineLearningServices/workspaces/privateEndpointConnections/privateEndpoint.id"
          }, {
          notEquals = "[subscription().subscriptionId]"
          value     = "[split(concat(field('Microsoft.MachineLearningServices/workspaces/privateEndpointConnections/privateEndpoint.id'), '//'), '/')[2]]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WebServerFarm"
resource "azurerm_policy_definition" "deploy_diagnostics_webserverfarm" {
  description         = "Deploys the diagnostic settings for App Service Plan to stream to a Log Analytics workspace when any App Service Plan which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for App Service Plan to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:48:56.4340039Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-WebServerFarm"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Web/serverfarms"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = []
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Web/serverfarms/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SQLElasticPools"
resource "azurerm_policy_definition" "deploy_diagnostics_sqlelasticpools" {
  description         = "Deploys the diagnostic settings for SQL Elastic Pools to stream to a Log Analytics workspace when any SQL Elastic Pools which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for SQL Elastic Pools to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:36:06.5422528Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-SQLElasticPools"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Sql/servers/elasticPools"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('fullName')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = []
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Sql/servers/elasticPools/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-Redis-disableNonSslPort"
resource "azurerm_policy_definition" "append_redis_disablenonsslport" {
  description         = "Azure Cache for Redis Append and the enforcement that enableNonSslPort is disabled. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
  display_name        = "Azure Cache for Redis Append and the enforcement that enableNonSslPort is disabled."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Cache"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:46:19.3831577Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.1"
  })
  mode = "Indexed"
  name = "Append-Redis-disableNonSslPort"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Append", "Disabled"]
      defaultValue  = "Append"
      metadata = {
        description = "Enable or disable the execution of the policy minimum TLS version Azure Cache for Redis"
        displayName = "Effect Azure Cache for Redis"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Cache/redis"
        field  = "type"
        }, {
        anyOf = [{
          equals = "true"
          field  = "Microsoft.Cache/Redis/enableNonSslPort"
        }]
      }]
    }
    then = {
      details = [{
        field = "Microsoft.Cache/Redis/enableNonSslPort"
        value = false
      }]
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-AppService-httpsonly"
resource "azurerm_policy_definition" "append_appservice_httpsonly" {
  description         = "Appends the AppService sites object to ensure that  HTTPS only is enabled for  server/service authentication and protects data in transit from network layer eavesdropping attacks. Please note Append does not enforce compliance use then deny."
  display_name        = "AppService append enable https only setting to enforce https setting."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "App Service"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:33:32.1084527Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Append-AppService-httpsonly"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Modify", "Disabled"]
      defaultValue  = "Modify"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Web/sites"
        field  = "type"
        }, {
        field     = "Microsoft.Web/sites/httpsOnly"
        notequals = true
      }]
    }
    then = {
      details = {
        conflictEffect = "audit"
        operations = [{
          condition = "[greaterOrEquals(requestContext().apiVersion, '2019-08-01')]"
          field     = "Microsoft.Web/sites/httpsOnly"
          operation = "addOrReplace"
          value     = true
        }]
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/de139f84-1756-47ae-9be6-808fbbe84772"]
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceWebApp-http"
resource "azurerm_policy_definition" "deny_appservicewebapp_http" {
  description         = "Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks."
  display_name        = "Web Application should only be accessible over HTTPS"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "App Service"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:36:42.734015Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-AppServiceWebApp-http"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Web/sites"
        field  = "type"
        }, {
        field = "kind"
        like  = "app*"
        }, {
        equals = "false"
        field  = "Microsoft.Web/sites/httpsOnly"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-PublicIP"
resource "azurerm_policy_definition" "deny_publicip" {
  description         = "[Deprecated] This policy denies creation of Public IPs under the assigned scope. Superseded by https://www.azadvertizer.net/azpolicyadvertizer/6c112d4e-5bc7-47ae-a041-ea2d9dccd749.html using appropriate assignment parameters."
  display_name        = "[Deprecated] Deny the creation of public IP"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:38:21.6081446Z"
    deprecated           = true
    source               = "https://github.com/Azure/Enterprise-Scale/"
    supersededBy         = "6c112d4e-5bc7-47ae-a041-ea2d9dccd749"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:03:58.8669422Z"
    version              = "1.0.0-deprecated"
  })
  mode = "Indexed"
  name = "Deny-PublicIP"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/publicIPAddresses"
      field  = "type"
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-Redis-sslEnforcement"
resource "azurerm_policy_definition" "append_redis_sslenforcement" {
  description         = "Append a specific min TLS version requirement and enforce SSL on Azure Cache for Redis. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
  display_name        = "Azure Cache for Redis Append a specific min TLS version requirement and enforce TLS."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Cache"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:40:59.8711648Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Append-Redis-sslEnforcement"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Append", "Disabled"]
      defaultValue  = "Append"
      metadata = {
        description = "Enable or disable the execution of the policy minimum TLS version Azure Cache for Redis"
        displayName = "Effect Azure Cache for Redis"
      }
      type = "String"
    }
    minimumTlsVersion = {
      allowedValues = ["1.2", "1.1", "1.0"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version minimum TLS version Azure Cache for Redis to enforce"
        displayName = "Select version for Redis server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Cache/redis"
        field  = "type"
        }, {
        anyOf = [{
          field     = "Microsoft.Cache/Redis/minimumTlsVersion"
          notequals = "[parameters('minimumTlsVersion')]"
        }]
      }]
    }
    then = {
      details = [{
        field = "Microsoft.Cache/Redis/minimumTlsVersion"
        value = "[parameters('minimumTlsVersion')]"
      }]
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VirtualMachine-Update-Tag"
resource "azurerm_policy_definition" "deny_virtualmachine_update_tag" {
  description         = "This policy denies if vmUpdateTagName is set to something else than defined in allowedUpdateTagValues."
  display_name        = "Deny Virtual Machines without correct Update Tag value"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:49:34.5162884Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Deny-VirtualMachine-Update-Tag"
  parameters = jsonencode({
    allowedUpdateTagValues = {
      type = "Array"
    }
    vmUpdateTagName = {
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        not = {
          equals = "microsoft-aks"
          field  = "Microsoft.Compute/virtualMachines/storageProfile.imageReference.publisher"
        }
        }, {
        anyOf = [{
          exists = "false"
          field  = "tags"
          }, {
          exists = "false"
          field  = "[concat('tags[', parameters('vmUpdateTagName'), ']')]"
          }, {
          field = "[concat('tags[', parameters('vmUpdateTagName'), ']')]"
          notIn = "[parameters('allowedUpdateTagValues')]"
        }]
      }]
    }
    then = {
      effect = "deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VirtualNetwork"
resource "azurerm_policy_definition" "deploy_diagnostics_virtualnetwork" {
  description         = "Deploys the diagnostic settings for Virtual Network to stream to a Log Analytics workspace when any Virtual Network which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Virtual Network to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:28:44.1487366Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-VirtualNetwork"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/virtualNetworks"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "VMProtectionAlerts"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/virtualNetworks/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-PostgreSQL"
resource "azurerm_policy_definition" "deploy_diagnostics_postgresql" {
  description         = "Deploys the diagnostic settings for Database for PostgreSQL to stream to a Log Analytics workspace when any Database for PostgreSQL which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Database for PostgreSQL to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:38:21.8628951Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "2.0.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-PostgreSQL"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        equals = "Microsoft.DBforPostgreSQL/flexibleServers"
        field  = "type"
        }, {
        equals = "Microsoft.DBforPostgreSQL/servers"
        field  = "type"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
              resourceType = {
                value = "[field('type')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
                resourceType = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2021-05-01-preview"
                condition  = "[startsWith(parameters('resourceType'),'Microsoft.DBforPostgreSQL/flexibleServers')]"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "PostgreSQLLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DBforPostgreSQL/flexibleServers/providers/diagnosticSettings"
                }, {
                apiVersion = "2021-05-01-preview"
                condition  = "[startsWith(parameters('resourceType'),'Microsoft.DBforPostgreSQL/servers')]"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "PostgreSQLLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "QueryStoreRuntimeStatistics"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "QueryStoreWaitStatistics"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DBforPostgreSQL/servers/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-Subnet-Default-Route"
resource "azurerm_policy_definition" "require_subnet_default_route" {
  description         = "Deny subnets without default route pointing to firewall. Route Tables without default route pointing to firewall will be denied."
  display_name        = "Require default Route on Subnets"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Network"
    createdBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn = "2025-02-05T21:07:06.9763814Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Require-Subnet-Default-Route"
  parameters = jsonencode({
    firewallIpAddresses = {
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/routeTables/routes"
          field  = "type"
          }, {
          equals = "0.0.0.0/0"
          field  = "Microsoft.Network/routeTables/routes/addressPrefix"
          }, {
          anyOf = [{
            field     = "Microsoft.Network/routeTables/routes/nextHopType"
            notEquals = "VirtualAppliance"
            }, {
            field = "Microsoft.Network/routeTables/routes/nextHopIpAddress"
            notIn = "[parameters('firewallIpAddresses')]"
          }]
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/routeTables/routes"
          field  = "type"
          }, {
          field     = "Microsoft.Network/routeTables/routes/addressPrefix"
          notEquals = "0.0.0.0/0"
        }]
      }]
    }
    then = {
      effect = "deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-AzureHybridBenefit"
resource "azurerm_policy_definition" "audit_azurehybridbenefit" {
  description         = "Optimize cost by enabling Azure Hybrid Benefit. Leverage this Policy definition as a cost control to reveal Virtual Machines not using AHUB."
  display_name        = "Audit AHUB for eligible VMs"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Cost Optimization"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:08:40.1456485Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Audit-AzureHybridBenefit"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        field = "type"
        in    = ["Microsoft.Compute/virtualMachines", "Microsoft.Compute/virtualMachineScaleSets"]
        }, {
        equals = "MicrosoftWindowsServer"
        field  = "Microsoft.Compute/imagePublisher"
        }, {
        equals = "WindowsServer"
        field  = "Microsoft.Compute/imageOffer"
        }, {
        anyOf = [{
          field = "Microsoft.Compute/imageSKU"
          like  = "2008-R2-SP1*"
          }, {
          field = "Microsoft.Compute/imageSKU"
          like  = "2012-*"
          }, {
          field = "Microsoft.Compute/imageSKU"
          like  = "2016-*"
          }, {
          field = "Microsoft.Compute/imageSKU"
          like  = "2019-*"
          }, {
          field = "Microsoft.Compute/imageSKU"
          like  = "2022-*"
        }]
        }, {
        field     = "Microsoft.Compute/licenseType"
        notEquals = "Windows_Server"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-Route-Propagation"
resource "azurerm_policy_definition" "require_route_propagation" {
  description         = "Route tables which have gateway route propagation disabled are denied. Propagation should be enforced for virtual WAN implementations."
  display_name        = "Require route propagation on Route Tables"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Network"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:35:08.1838972Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Require-Route-Propagation"
  parameters = jsonencode({
    requireRoutePropagation = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Should BGP route propagation be enabled? Allowed values are Audit, Deny and Disabled."
        displayName = "Require Route Propagation effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/routeTables"
        field  = "type"
        }, {
        equals = true
        field  = "Microsoft.Network/routeTables/disableBgpRoutePropagation"
      }]
    }
    then = {
      effect = "[parameters('requireRoutePropagation')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-RDP-From-Internet"
resource "azurerm_policy_definition" "deny_rdp_from_internet" {
  description         = "This policy denies any network security rule that allows RDP access from Internet. This policy is superseded by https://www.azadvertizer.net/azpolicyadvertizer/Deny-MgmtPorts-From-Internet.html"
  display_name        = "[Deprecated] RDP access from the Internet should be blocked"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:23:55.9519538Z"
    deprecated           = true
    source               = "https://github.com/Azure/Enterprise-Scale/"
    supersededBy         = "Deny-MgmtPorts-From-Internet"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:08:39.9983861Z"
    version              = "1.0.1-deprecated"
  })
  mode = "All"
  name = "Deny-RDP-From-Internet"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/networkSecurityGroups/securityRules"
        field  = "type"
        }, {
        allOf = [{
          equals = "Allow"
          field  = "Microsoft.Network/networkSecurityGroups/securityRules/access"
          }, {
          equals = "Inbound"
          field  = "Microsoft.Network/networkSecurityGroups/securityRules/direction"
          }, {
          anyOf = [{
            equals = "*"
            field  = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange"
            }, {
            equals = "3389"
            field  = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange"
            }, {
            equals = "true"
            value  = "[if(and(not(empty(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'))), contains(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'),'-')), and(lessOrEquals(int(first(split(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'), '-'))),3389),greaterOrEquals(int(last(split(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'), '-'))),3389)), 'false')]"
            }, {
            count = {
              field = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]"
              where = {
                equals = "true"
                value  = "[if(and(not(empty(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')))), contains(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')),'-')), and(lessOrEquals(int(first(split(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')), '-'))),3389),greaterOrEquals(int(last(split(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')), '-'))),3389)) , 'false')]"
              }
            }
            greater = 0
            }, {
            not = {
              field     = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]"
              notEquals = "*"
            }
            }, {
            not = {
              field     = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]"
              notEquals = "3389"
            }
          }]
          }, {
          anyOf = [{
            equals = "*"
            field  = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix"
            }, {
            equals = "Internet"
            field  = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix"
            }, {
            not = {
              field     = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]"
              notEquals = "*"
            }
            }, {
            not = {
              field     = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]"
              notEquals = "Internet"
            }
          }]
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-AA-child-resources"
resource "azurerm_policy_definition" "deny_aa_child_resources" {
  description         = "This policy denies the creation of child resources on the Automation Account"
  display_name        = "No child resources in Automation Account"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureUSGovernment"]
    category             = "Automation"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.3599589Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-AA-child-resources"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        field = "type"
        in    = ["Microsoft.Automation/automationAccounts/runbooks", "Microsoft.Automation/automationAccounts/variables", "Microsoft.Automation/automationAccounts/modules", "Microsoft.Automation/automationAccounts/credentials", "Microsoft.Automation/automationAccounts/connections", "Microsoft.Automation/automationAccounts/certificates"]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MlWorkspace"
resource "azurerm_policy_definition" "deploy_diagnostics_mlworkspace" {
  description         = "Deploys the diagnostic settings for Machine Learning workspace to stream to a Log Analytics workspace when any Machine Learning workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Machine Learning workspace to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.5848741Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-MlWorkspace"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.MachineLearningServices/workspaces"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "AmlComputeClusterEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AmlComputeClusterNodeEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AmlComputeJobEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AmlComputeCpuGpuUtilization"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AmlRunStatusChangedEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ModelsChangeEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ModelsReadEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ModelsActionEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DeploymentReadEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DeploymentEventACI"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DeploymentEventAKS"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "InferencingOperationAKS"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "InferencingOperationACI"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DataLabelChangeEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DataLabelReadEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ComputeInstanceEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DataStoreChangeEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DataStoreReadEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DataSetChangeEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DataSetReadEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "PipelineChangeEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "PipelineReadEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "RunEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "RunReadEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "EnvironmentChangeEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "EnvironmentReadEvent"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.MachineLearningServices/workspaces/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-LogicAppsISE"
resource "azurerm_policy_definition" "deploy_diagnostics_logicappsise" {
  description         = "Deploys the diagnostic settings for Logic Apps integration service environment to stream to a Log Analytics workspace when any Logic Apps integration service environment which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Logic Apps integration service environment to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:44:11.3590105Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-LogicAppsISE"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Logic/integrationAccounts"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "IntegrationAccountTrackingEvents"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics     = []
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Logic/integrationAccounts/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridSub"
resource "azurerm_policy_definition" "deploy_diagnostics_eventgridsub" {
  description         = "Deploys the diagnostic settings for Event Grid subscriptions to stream to a Log Analytics workspace when any Event Grid subscriptions which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Event Grid subscriptions to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:28:44.0553619Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-EventGridSub"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.EventGrid/eventSubscriptions"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = []
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.EventGrid/eventSubscriptions/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MachineLearning-HbiWorkspace"
resource "azurerm_policy_definition" "deny_machinelearning_hbiworkspace" {
  description         = "Enforces high business impact Azure Machine Learning workspaces."
  display_name        = "Enforces high business impact Azure Machine Learning Workspaces"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Machine Learning"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:43:10.4070299Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-MachineLearning-HbiWorkspace"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces"
        field  = "type"
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.MachineLearningServices/workspaces/hbiWorkspace"
          }, {
          field     = "Microsoft.MachineLearningServices/workspaces/hbiWorkspace"
          notEquals = true
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/StorageAccount-Blob-Backup-short"
resource "azurerm_policy_definition" "storageaccount_blob_backup_short" {
  description         = "Enforce backup for blobs on all storage accounts that contain a given tag to a central backup vault. Doing this can help you manage backup of blobs contained across multiple storage accounts at scale. For more details, refer to https://aka.ms/AB-BlobBackupAzPolicies"
  display_name        = "Configure backup for blobs on storage accounts with a given tag to an existing backup vault in the same region"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:39:58.5090936Z"
    preview   = true
    updatedBy = null
    updatedOn = null
    version   = "2.0.0-preview"
  })
  mode = "Indexed"
  name = "StorageAccount-Blob-Backup-short"
  parameters = jsonencode({
    dailyRetentionDurationCount = {
      defaultValue = 14
      metadata = {
        description = "daily: retention of daily backup points"
      }
      type = "Integer"
    }
    policyName = {
      defaultValue = "storage-blob-14d"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy"
      }
      type = "String"
    }
    storageBackupTagName = {
      defaultValue = "storageaccount-backup-policy"
      metadata = {
        description = "the name of the tag key to filter virtual machines for"
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
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Storage/StorageAccounts"
        field  = "type"
        }, {
        contains = "[parameters('policyName')]"
        field    = "[concat('tags[', parameters('storageBackupTagName'), ']')]"
        }, {
        equals = "StorageV2"
        field  = "kind"
        }, {
        contains = "Standard"
        field    = "Microsoft.Storage/storageAccounts/sku.name"
        }, {
        field     = "Microsoft.Storage/storageAccounts/isHnsEnabled"
        notEquals = "true"
        }, {
        field     = "Microsoft.Storage/storageAccounts/isNfsV3Enabled"
        notEquals = "true"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              dailyRetentionDurationCount = {
                value = "[parameters('dailyRetentionDurationCount')]"
              }
              policyName = {
                value = "[parameters('policyName')]"
              }
              storageAccountResourceId = {
                value = "[field('id')]"
              }
              storageResourceGroupLocation = {
                value = "[field('location')]"
              }
              storageResourceGroupName = {
                value = "[resourceGroup().name]"
              }
              vaultRedundancy = {
                value = "[parameters('vaultRedundancy')]"
              }
              vaultTags = {
                value = "[parameters('vaultTags')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                dailyRetentionDurationCount = {
                  type = "int"
                }
                policyName = {
                  type = "string"
                }
                storageAccountResourceId = {
                  metadata = {
                    description = "ResourceId of the Storage Account"
                  }
                  type = "string"
                }
                storageResourceGroupLocation = {
                  type = "string"
                }
                storageResourceGroupName = {
                  type = "string"
                }
                vaultRedundancy = {
                  type = "string"
                }
                vaultTags = {
                  type = "object"
                }
              }
              resources = [{
                apiVersion = "2021-04-01"
                name       = "[concat('DeployProtection-',uniqueString(variables('storageAccountName')))]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    parameters     = {}
                    resources = [{
                      apiVersion = "2021-01-01"
                      identity = {
                        type = "systemAssigned"
                      }
                      location = "[parameters('storageResourceGroupLocation')]"
                      name     = "[variables('BackupVaultName')]"
                      properties = {
                        storageSettings = [{
                          datastoreType = "VaultStore"
                          type          = "[parameters('vaultRedundancy')]"
                        }]
                      }
                      type = "Microsoft.DataProtection/backupVaults"
                      }, {
                      apiVersion = "2021-01-01"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]"]
                      name       = "[format('{0}/{1}', variables('BackupVaultName'), variables('backupPolicyName'))]"
                      properties = {
                        datasourceTypes = ["[variables('dataSourceType')]"]
                        objectType      = "BackupPolicy"
                        policyRules = [{
                          isDefault = true
                          lifecycles = [{
                            deleteAfter = {
                              duration   = "[concat('P',parameters('dailyRetentionDurationCount'), 'D')]"
                              objectType = "AbsoluteDeleteOption"
                            }
                            sourceDataStore = {
                              dataStoreType = "OperationalStore"
                              objectType    = "DataStoreInfoBase"
                            }
                          }]
                          name       = "Default"
                          objectType = "AzureRetentionRule"
                          ruleType   = "Retention"
                        }]
                      }
                      type = "Microsoft.DataProtection/backupVaults/backupPolicies"
                      }, {
                      apiVersion = "2020-04-01-preview"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]"]
                      name       = "[guid(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), variables('roleDefinitionId'), resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName')))]"
                      properties = {
                        principalId      = "[reference(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), '2021-01-01', 'Full').identity.principalId]"
                        principalType    = "ServicePrincipal"
                        roleDefinitionId = "[variables('roleDefinitionId')]"
                      }
                      scope = "[format('Microsoft.Storage/storageAccounts/{0}', variables('storageAccountName'))]"
                      type  = "Microsoft.Authorization/roleAssignments"
                      }, {
                      apiVersion = "2021-01-01"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]", "[resourceId('Microsoft.DataProtection/backupVaults/backupPolicies', variables('BackupVaultName'), variables('backupPolicyName'))]", "[extensionResourceId(resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName')), 'Microsoft.Authorization/roleAssignments', guid(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), variables('roleDefinitionId'), resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))))]"]
                      name       = "[concat(variables('BackupVaultName'), '/', variables('storageAccountName'))]"
                      properties = {
                        dataSourceInfo = {
                          datasourceType   = "[variables('dataSourceType')]"
                          objectType       = "Datasource"
                          resourceID       = "[parameters('storageAccountResourceId')]"
                          resourceLocation = "[parameters('storageResourceGroupLocation')]"
                          resourceName     = "[variables('storageAccountName')]"
                          resourceType     = "[variables('resourceType')]"
                          resourceUri      = "[parameters('storageAccountResourceId')]"
                        }
                        objectType = "BackupInstance"
                        policyInfo = {
                          name     = "[variables('backupPolicyName')]"
                          policyId = "[resourceId('Microsoft.DataProtection/backupVaults/backupPolicies', variables('BackupVaultName'), variables('backupPolicyName'))]"
                        }
                      }
                      type = "Microsoft.DataProtection/backupvaults/backupInstances"
                    }]
                  }
                }
                resourceGroup  = "[variables('vaultResourceGroup')]"
                subscriptionId = "[variables('vaultSubscriptionId')]"
                type           = "Microsoft.Resources/deployments"
              }]
              variables = {
                BackupVaultName     = "[concat('rsv-', parameters('storageResourceGroupName'))]"
                backupPolicyName    = "[concat('policy-', parameters('policyName'))]"
                dataSourceType      = "Microsoft.Storage/storageAccounts/blobServices"
                resourceType        = "Microsoft.Storage/storageAccounts"
                roleDefinitionId    = "[subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e5e2a7ff-d759-4cd2-bb51-3152d37e2eb1')]"
                storageAccountName  = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 8))]"
                vaultResourceGroup  = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 4))]"
                vaultSubscriptionId = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 2))]"
              }
            }
          }
        }
        existenceCondition = {
          equals = true
          field  = "Microsoft.Storage/storageAccounts/blobServices/default.restorePolicy.enabled"
        }
        name              = "default"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635"]
        type              = "Microsoft.Storage/storageAccounts/blobServices"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MgmtPorts-From-Internet"
resource "azurerm_policy_definition" "deny_mgmtports_from_internet" {
  description         = "This policy denies any network security rule that allows management port access from the Internet"
  display_name        = "Management port access from the Internet should be blocked"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:39:58.6267086Z"
    replacesPolicy       = "Deny-RDP-From-Internet"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:07:06.3701804Z"
    version              = "2.1.0"
  })
  mode = "All"
  name = "Deny-MgmtPorts-From-Internet"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    ports = {
      defaultValue = ["22", "3389"]
      metadata = {
        description = "Ports to be blocked"
        displayName = "Ports"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/networkSecurityGroups/securityRules"
          field  = "type"
          }, {
          allOf = [{
            equals = "Allow"
            field  = "Microsoft.Network/networkSecurityGroups/securityRules/access"
            }, {
            equals = "Inbound"
            field  = "Microsoft.Network/networkSecurityGroups/securityRules/direction"
            }, {
            anyOf = [{
              equals = "*"
              field  = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange"
              }, {
              field = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange"
              in    = "[parameters('ports')]"
              }, {
              count = {
                value = "[parameters('ports')]"
                where = {
                  equals = "true"
                  value  = "[if(and(not(empty(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'))), contains(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'),'-')), and(lessOrEquals(int(first(split(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'), '-'))),int(current())),greaterOrEquals(int(last(split(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'), '-'))),int(current()))), 'false')]"
                }
              }
              greater = 0
              }, {
              count = {
                name  = "ports"
                value = "[parameters('ports')]"
                where = {
                  count = {
                    field = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]"
                    where = {
                      equals = "true"
                      value  = "[if(and(not(empty(current('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]'))), contains(current('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]'),'-')), and(lessOrEquals(int(first(split(current('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]'), '-'))),int(current('ports'))),greaterOrEquals(int(last(split(current('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]'), '-'))),int(current('ports')))) , 'false')]"
                    }
                  }
                  greater = 0
                }
              }
              greater = 0
              }, {
              not = {
                field     = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]"
                notEquals = "*"
              }
              }, {
              not = {
                field = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]"
                notIn = "[parameters('ports')]"
              }
            }]
            }, {
            anyOf = [{
              equals = "*"
              field  = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix"
              }, {
              equals = "Internet"
              field  = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix"
              }, {
              not = {
                field     = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]"
                notEquals = "*"
              }
              }, {
              not = {
                field     = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]"
                notEquals = "Internet"
              }
            }]
          }]
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/networkSecurityGroups"
          field  = "type"
          }, {
          count = {
            field = "Microsoft.Network/networkSecurityGroups/securityRules[*]"
            where = {
              allOf = [{
                equals = "Allow"
                field  = "Microsoft.Network/networkSecurityGroups/securityRules[*].access"
                }, {
                equals = "Inbound"
                field  = "Microsoft.Network/networkSecurityGroups/securityRules[*].direction"
                }, {
                anyOf = [{
                  equals = "*"
                  field  = "Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRange"
                  }, {
                  field = "Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRange"
                  in    = "[parameters('ports')]"
                  }, {
                  count = {
                    name  = "ports"
                    value = "[parameters('ports')]"
                    where = {
                      equals = "true"
                      value  = "[if(and(not(empty(current('Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRange'))), contains(current('Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRange'),'-')), and(lessOrEquals(int(first(split(current('Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRange'), '-'))),int(current('ports'))),greaterOrEquals(int(last(split(current('Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRange'), '-'))),int(current('ports')))), 'false')]"
                    }
                  }
                  greater = 0
                  }, {
                  count = {
                    name  = "ports"
                    value = "[parameters('ports')]"
                    where = {
                      count = {
                        field = "Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRanges[*]"
                        where = {
                          equals = "true"
                          value  = "[if(and(not(empty(current('Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRanges[*]'))), contains(current('Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRanges[*]'),'-')), and(lessOrEquals(int(first(split(current('Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRanges[*]'), '-'))),int(current('ports'))),greaterOrEquals(int(last(split(current('Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRanges[*]'), '-'))),int(current('ports')))) , 'false')]"
                        }
                      }
                      greater = 0
                    }
                  }
                  greater = 0
                  }, {
                  not = {
                    field     = "Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRanges[*]"
                    notEquals = "*"
                  }
                  }, {
                  not = {
                    field = "Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRanges[*]"
                    notIn = "[parameters('ports')]"
                  }
                }]
                }, {
                anyOf = [{
                  equals = "*"
                  field  = "Microsoft.Network/networkSecurityGroups/securityRules[*].sourceAddressPrefix"
                  }, {
                  equals = "Internet"
                  field  = "Microsoft.Network/networkSecurityGroups/securityRules[*].sourceAddressPrefix"
                  }, {
                  not = {
                    field     = "Microsoft.Network/networkSecurityGroups/securityRules[*].sourceAddressPrefixes[*]"
                    notEquals = "*"
                  }
                  }, {
                  not = {
                    field     = "Microsoft.Network/networkSecurityGroups/securityRules[*].sourceAddressPrefixes[*]"
                    notEquals = "Internet"
                  }
                }]
              }]
            }
          }
          greater = 0
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MachineLearning-PublicNetworkAccess"
resource "azurerm_policy_definition" "deny_machinelearning_publicnetworkaccess" {
  description         = "Denies public network access for Azure Machine Learning workspaces. Superseded by https://www.azadvertizer.net/azpolicyadvertizer/438c38d2-3772-465a-a9cc-7a6666a275ce.html"
  display_name        = "[Deprecated] Azure Machine Learning should have disabled public network access"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Machine Learning"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.48454Z"
    deprecated           = true
    source               = "https://github.com/Azure/Enterprise-Scale/"
    supersededBy         = "438c38d2-3772-465a-a9cc-7a6666a275ce"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:07:06.3546743Z"
    version              = "1.0.0-deprecated"
  })
  mode = "Indexed"
  name = "Deny-MachineLearning-PublicNetworkAccess"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces"
        field  = "type"
        }, {
        field     = "Microsoft.MachineLearningServices/workspaces/publicNetworkAccess"
        notEquals = "Disabled"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-Databricks-Browser"
resource "azurerm_policy_definition" "dine_private_dns_azure_databricks_browser" {
  description         = "Configure private DNS zone group to override the DNS resolution for a databricks browser auth groupID private endpoint."
  display_name        = "Configure a private DNS Zone ID for databricks browser auth groupID"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "DNS Private Endpoint"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:33:32.3971056Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "Indexed"
  name = "DINE-Private-DNS-Azure-Databricks-Browser"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    privateDnsZoneId = {
      metadata = {
        assignPermissions = true
        description       = "Configure private DNS zone group to override the DNS resolution for a databricks browser auth groupID private endpoint."
        displayName       = "Configure a private DNS Zone ID for databricks browser auth groupID"
        strongType        = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/privateEndpoints"
        field  = "type"
        }, {
        count = {
          field = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          where = {
            equals = "browser_authentication"
            field  = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          }
        }
        greaterOrEquals = 1
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              privateDnsZoneId = {
                value = "[parameters('privateDnsZoneId')]"
              }
              privateEndpointName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                location = {
                  type = "String"
                }
                privateDnsZoneId = {
                  type = "String"
                }
                privateEndpointName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2020-03-01"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]"
                properties = {
                  privateDnsZoneConfigs = [{
                    name = "databricks_browser_auth-privateDnsZone"
                    properties = {
                      privateDnsZoneId = "[parameters('privateDnsZoneId')]"
                    }
                  }]
                }
                type = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
              }]
            }
          }
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"]
        type              = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VirtualMachine-Backup-Tag"
resource "azurerm_policy_definition" "deny_virtualmachine_backup_tag" {
  description         = "This policy denies if vmBackupTagName is set to something else than defined in allowedBackupTagValues."
  display_name        = "Deny Virtual Machines without correct Backup Tag value"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:30:20.6960488Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Deny-VirtualMachine-Backup-Tag"
  parameters = jsonencode({
    allowedBackupTagValues = {
      type = "Array"
    }
    vmBackupTagName = {
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        not = {
          equals = "microsoft-aks"
          field  = "Microsoft.Compute/virtualMachines/storageProfile.imageReference.publisher"
        }
        }, {
        anyOf = [{
          exists = "false"
          field  = "tags"
          }, {
          exists = "false"
          field  = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
          }, {
          field = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
          notIn = "[parameters('allowedBackupTagValues')]"
        }]
      }]
    }
    then = {
      effect = "deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-MYSQL"
resource "azurerm_policy_definition" "dine_private_dns_azure_mysql" {
  description         = "Configure private DNS zone group to override the DNS resolution for a mysql groupID private endpoint."
  display_name        = "Configure a private DNS Zone ID for mysql groupID"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "DNS Private Endpoint"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:43:10.3096498Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "Indexed"
  name = "DINE-Private-DNS-Azure-MYSQL"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    privateDnsZoneId = {
      metadata = {
        assignPermissions = true
        description       = "Configure private DNS zone group to override the DNS resolution for a mysql groupID private endpoint."
        displayName       = "Configure a private DNS Zone ID for mysql groupID"
        strongType        = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/privateEndpoints"
        field  = "type"
        }, {
        count = {
          field = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          where = {
            equals = "mysqlServer"
            field  = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          }
        }
        greaterOrEquals = 1
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              privateDnsZoneId = {
                value = "[parameters('privateDnsZoneId')]"
              }
              privateEndpointName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                location = {
                  type = "String"
                }
                privateDnsZoneId = {
                  type = "String"
                }
                privateEndpointName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2020-03-01"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]"
                properties = {
                  privateDnsZoneConfigs = [{
                    name = "MySQL-privateDnsZone"
                    properties = {
                      privateDnsZoneId = "[parameters('privateDnsZoneId')]"
                    }
                  }]
                }
                type = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
              }]
            }
          }
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"]
        type              = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-NetworkSecurityGroup-Allow-Any"
resource "azurerm_policy_definition" "deny_networksecuritygroup_allow_any" {
  description         = "Denies the creation of network security group rules that allow all inbound traffic."
  display_name        = "Deny NSG rules allowing all traffic"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Network"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:23:55.9963219Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode       = "All"
  name       = "Deny-NetworkSecurityGroup-Allow-Any"
  parameters = null
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/networkSecurityGroups/securityRules"
        field  = "type"
        }, {
        allOf = [{
          equals = "Allow"
          field  = "Microsoft.Network/networkSecurityGroups/securityRules/access"
          }, {
          equals = "Inbound"
          field  = "Microsoft.Network/networkSecurityGroups/securityRules/direction"
          }, {
          anyOf = [{
            equals = "*"
            field  = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange"
            }, {
            not = {
              field     = "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]"
              notEquals = "*"
            }
          }]
          }, {
          anyOf = [{
            field = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix"
            in    = ["*", "Internet"]
            }, {
            not = {
              field = "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]"
              notIn = ["*", "Internet"]
            }
          }]
        }]
      }]
    }
    then = {
      effect = "deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-FirewallPolicy"
resource "azurerm_policy_definition" "deploy_firewallpolicy" {
  description         = "Deploys Azure Firewall Manager policy in subscription where the policy is assigned."
  display_name        = "Deploy Azure Firewall Manager policy in the subscription"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:35:08.232218Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Deploy-FirewallPolicy"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    fwPolicyRegion = {
      metadata = {
        description = "Select Azure region for Azure Firewall Policy"
        displayName = "fwPolicyRegion"
        strongType  = "location"
      }
      type = "String"
    }
    fwpolicy = {
      defaultValue = {}
      metadata = {
        description = "Object describing Azure Firewall Policy"
        displayName = "fwpolicy"
      }
      type = "Object"
    }
    rgName = {
      metadata = {
        description = "Provide name for resource group."
        displayName = "rgName"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions"
        field  = "type"
      }]
    }
    then = {
      details = {
        deployment = {
          location = "northeurope"
          properties = {
            mode = "Incremental"
            parameters = {
              fwPolicy = {
                value = "[parameters('fwPolicy')]"
              }
              fwPolicyRegion = {
                value = "[parameters('fwPolicyRegion')]"
              }
              rgName = {
                value = "[parameters('rgName')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                fwPolicy = {
                  type = "object"
                }
                fwPolicyRegion = {
                  type = "String"
                }
                rgName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2018-05-01"
                location   = "[deployment().location]"
                name       = "[parameters('rgName')]"
                properties = {}
                type       = "Microsoft.Resources/resourceGroups"
                }, {
                apiVersion = "2018-05-01"
                dependsOn  = ["[resourceId('Microsoft.Resources/resourceGroups/', parameters('rgName'))]"]
                name       = "fwpolicies"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json"
                    contentVersion = "1.0.0.0"
                    outputs        = {}
                    parameters     = {}
                    resources = [{
                      apiVersion = "2019-09-01"
                      dependsOn  = []
                      location   = "[parameters('fwpolicy').location]"
                      name       = "[parameters('fwpolicy').firewallPolicyName]"
                      properties = {}
                      resources = [{
                        apiVersion = "2019-09-01"
                        dependsOn  = ["[resourceId('Microsoft.Network/firewallPolicies',parameters('fwpolicy').firewallPolicyName)]"]
                        name       = "[parameters('fwpolicy').ruleGroups.name]"
                        properties = {
                          priority = "[parameters('fwpolicy').ruleGroups.properties.priority]"
                          rules    = "[parameters('fwpolicy').ruleGroups.properties.rules]"
                        }
                        type = "ruleGroups"
                      }]
                      tags = {}
                      type = "Microsoft.Network/firewallPolicies"
                    }]
                    variables = {}
                  }
                }
                resourceGroup = "[parameters('rgName')]"
                type          = "Microsoft.Resources/deployments"
              }]
            }
          }
        }
        deploymentScope   = "subscription"
        existenceScope    = "resourceGroup"
        resourceGroupName = "[parameters('rgName')]"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.Network/firewallPolicies"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-PublicIpAddresses-UnusedResourcesCostOptimization"
resource "azurerm_policy_definition" "audit_publicipaddresses_unusedresourcescostoptimization" {
  description         = "Optimize cost by detecting unused but chargeable resources. Leverage this Policy definition as a cost control to reveal orphaned Public IP addresses that are driving cost."
  display_name        = "Unused Public IP addresses driving cost should be avoided"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Cost Optimization"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:33:32.3349289Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Audit-PublicIpAddresses-UnusedResourcesCostOptimization"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "microsoft.network/publicIpAddresses"
        field  = "type"
        }, {
        field     = "Microsoft.Network/publicIPAddresses/sku.name"
        notEquals = "Basic"
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.Network/publicIPAddresses/natGateway"
          }, {
          equals = true
          value  = "[equals(length(field('Microsoft.Network/publicIPAddresses/natGateway')), 0)]"
        }]
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.Network/publicIPAddresses/ipConfiguration"
          }, {
          equals = true
          value  = "[equals(length(field('Microsoft.Network/publicIPAddresses/ipConfiguration')), 0)]"
        }]
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.Network/publicIPAddresses/publicIPPrefix"
          }, {
          equals = true
          value  = "[equals(length(field('Microsoft.Network/publicIPAddresses/publicIPPrefix')), 0)]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/VirtualMachine-Backup-2000-14d-4w-12m"
resource "azurerm_policy_definition" "virtualmachine_backup_2000_14d_4w_12m" {
  description         = "This policy creates an Azure Recovery Services vault in the resource group when the first VM with supported OS is deployed. It creates a backup policy and assigns the VM to the backup policy schedule."
  display_name        = "Virtual Machine Backup Policy - Daily at 2000 - 14 days - 4 weeks - 12 months"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:27:08.1165128Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "VirtualMachine-Backup-2000-14d-4w-12m"
  parameters = jsonencode({
    dailyRetentionDurationCount = {
      defaultValue = 14
      metadata = {
        description = "daily: retention of daily backup points"
      }
      type = "Integer"
    }
    daysOfTheWeek = {
      defaultValue = ["Sunday"]
      metadata = {
        description = "daily: daily backup which should be kept as the weekly backup point"
      }
      type = "Array"
    }
    monthlyRetentionDurationCount = {
      defaultValue = 12
      metadata = {
        description = "monthly: Monthly backup retention"
      }
      type = "Integer"
    }
    monthsOfYear = {
      defaultValue = ["December"]
      metadata = {
        description = "yearly: monthly backup to keep as the yearly backup"
      }
      type = "Array"
    }
    policyName = {
      defaultValue = "vm-daily-2000-14d-4w-12m"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy"
      }
      type = "String"
    }
    retentionScheduleDaily = {
      defaultValue = {
        daysOfTheMonth = [{
          date   = 0
          isLast = true
        }]
      }
      metadata = {
        description = "monthly: Default value keeps the last daily backup of the month. Only retentionScheduleDaily or retentionScheduleWeekly must be defined"
      }
      type = "Object"
    }
    scheduleRunTimes = {
      defaultValue = "20:00:00"
      metadata = {
        description = "runtime in format of hh:mm:ss"
      }
      type = "String"
    }
    timeZone = {
      defaultValue = "UTC"
      metadata = {
        description = "currently not used, replaced with timezoneselector-variable based on rg"
      }
      type = "String"
    }
    vaultSku = {
      defaultValue = "Standard"
      metadata = {
        description = "Standard or RS0 - currently only Standard (GRS) working, Microsoft limit"
      }
      type = "String"
    }
    vaultTags = {
      defaultValue = {
        description = "vault used by Azure policy af-dine-vm-backup-rg"
      }
      type = "Object"
    }
    vmBackupTagName = {
      defaultValue = "vm-backup-policy"
      metadata = {
        description = "the name of the tag key to filter virtual machines for"
      }
      type = "String"
    }
    weeklyRetentionDurationCount = {
      defaultValue = 4
      metadata = {
        description = "weekly: retention of the weekly backup point"
      }
      type = "Integer"
    }
    yearlyRetentionDurationCount = {
      defaultValue = 2
      metadata = {
        description = "yearly: Yearly backup retention"
      }
      type = "Integer"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        equals = "[parameters('policyName')]"
        field  = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
        }, {
        field   = "name"
        notLike = "*-test"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              dailyRetentionDurationCount = {
                value = "[parameters('dailyRetentionDurationCount')]"
              }
              daysOfTheWeek = {
                value = "[parameters('daysOfTheWeek')]"
              }
              monthlyRetentionDurationCount = {
                value = "[parameters('monthlyRetentionDurationCount')]"
              }
              monthsOfYear = {
                value = "[parameters('monthsOfYear')]"
              }
              policyName = {
                value = "[parameters('policyName')]"
              }
              retentionScheduleDaily = {
                value = "[parameters('retentionScheduleDaily')]"
              }
              scheduleRunTimes = {
                value = "[parameters('scheduleRunTimes')]"
              }
              timeZone = {
                value = "[parameters('timeZone')]"
              }
              vaultSku = {
                value = "[parameters('vaultSku')]"
              }
              vaultTags = {
                value = "[parameters('vaultTags')]"
              }
              vmName = {
                value = "[field('name')]"
              }
              vmResourceGroupLocation = {
                value = "[field('location')]"
              }
              vmResourceGroupName = {
                value = "[resourceGroup().name]"
              }
              weeklyRetentionDurationCount = {
                value = "[parameters('weeklyRetentionDurationCount')]"
              }
              yearlyRetentionDurationCount = {
                value = "[parameters('yearlyRetentionDurationCount')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                dailyRetentionDurationCount = {
                  type = "int"
                }
                daysOfTheWeek = {
                  type = "array"
                }
                monthlyRetentionDurationCount = {
                  type = "int"
                }
                monthsOfYear = {
                  type = "array"
                }
                policyName = {
                  type = "string"
                }
                retentionScheduleDaily = {
                  type = "object"
                }
                scheduleRunTimes = {
                  type = "string"
                }
                timeZone = {
                  type = "string"
                }
                vaultSku = {
                  type = "string"
                }
                vaultTags = {
                  type = "object"
                }
                vmName = {
                  type = "string"
                }
                vmResourceGroupLocation = {
                  type = "string"
                }
                vmResourceGroupName = {
                  type = "string"
                }
                weeklyRetentionDurationCount = {
                  type = "int"
                }
                yearlyRetentionDurationCount = {
                  type = "int"
                }
              }
              resources = [{
                apiVersion = "2023-07-01"
                name       = "[concat(parameters('vmName'), '-backupIntent')]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    resources = [{
                      apiVersion = "2023-06-01"
                      location   = "[parameters('vmResourceGroupLocation')]"
                      name       = "[variables('BackupVaultName')]"
                      properties = {
                        publicNetworkAccess = "Enabled"
                        restoreSettings = {
                          crossSubscriptionRestoreSettings = {
                            crossSubscriptionRestoreState = "Enabled"
                          }
                        }
                      }
                      sku = {
                        name = "[parameters('vaultSku')]"
                      }
                      tags = "[parameters('vaultTags')]"
                      type = "Microsoft.RecoveryServices/vaults"
                      }, {
                      apiVersion = "2023-04-01"
                      dependsOn  = ["[variables('BackupVaultName')]"]
                      location   = "[parameters('vmResourceGroupLocation')]"
                      name       = "[concat(variables('BackupVaultName'), '/', variables('BackupPolicyName'))]"
                      properties = {
                        backupManagementType          = "AzureIaasVM"
                        instantRPDetails              = {}
                        instantRpRetentionRangeInDays = 5
                        policyType                    = "V2"
                        retentionPolicy = {
                          dailySchedule = {
                            retentionDuration = {
                              count        = "[int(parameters('dailyRetentionDurationCount'))]"
                              durationType = "Days"
                            }
                            retentionTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          monthlySchedule = {
                            retentionDuration = {
                              count        = "[parameters('monthlyRetentionDurationCount')]"
                              durationType = "Months"
                            }
                            retentionScheduleDaily      = "[parameters('retentionScheduleDaily')]"
                            retentionScheduleFormatType = "Daily"
                            retentionTimes              = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          retentionPolicyType = "LongTermRetentionPolicy"
                          weeklySchedule = {
                            daysOfTheWeek = "[parameters('daysOfTheWeek')]"
                            retentionDuration = {
                              count        = "[parameters('weeklyRetentionDurationCount')]"
                              durationType = "Weeks"
                            }
                            retentionTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                        }
                        schedulePolicy = {
                          dailySchedule = {
                            scheduleRunTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          schedulePolicyType   = "SimpleSchedulePolicyV2"
                          scheduleRunFrequency = "Daily"
                        }
                        timeZone = "[parameters('timeZone')]"
                      }
                      tags = {}
                      type = "Microsoft.RecoveryServices/vaults/backupPolicies"
                      }, {
                      apiVersion = "2023-06-01"
                      dependsOn  = ["[variables('BackupPolicyName')]"]
                      name       = "[concat(variables('BackupVaultName'), variables('BackupIntentConcat'))]"
                      properties = {
                        policyId                 = "[concat(resourceId('Microsoft.RecoveryServices/vaults/backuppolicies', variables('BackupVaultName'), variables('BackupPolicyName')))]"
                        protectionIntentItemType = "AzureResourceItem"
                        sourceResourceId         = "[concat(resourceId('Microsoft.Compute/virtualMachines', parameters('vmName')))]"
                      }
                      type = "Microsoft.RecoveryServices/vaults/backupFabrics/backupProtectionIntent"
                    }]
                  }
                }
                resourceGroup = "[parameters('vmResourceGroupName')]"
                type          = "Microsoft.Resources/deployments"
              }]
              variables = {
                BackupIntentConcat = "[concat('/Azure/vm;iaasvmcontainerv2;', parameters('vmResourceGroupName'), ';', parameters('vmName'))]"
                BackupPolicyName   = "[concat('policy-',parameters('vmResourceGroupName'), '-', parameters('policyName'))]"
                BackupVaultName    = "[concat('rsv-', parameters('vmResourceGroupName'))]"
                timezoneMap = {
                  centralus = {
                    timezone = "Eastern Standard Time"
                  }
                  eastus2 = {
                    timezone = "Eastern Standard Time"
                  }
                  northeurope = {
                    timezone = "W. Europe Standard Time"
                  }
                  westeurope = {
                    timezone = "W. Europe Standard Time"
                  }
                }
                timezoneSelector = "[variables('timezoneMap')[parameters('vmResourceGroupLocation')].timezone]"
              }
            }
          }
        }
        existenceCondition = {
          allOf = [{
            field = "name"
            like  = "*"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.RecoveryServices/backupprotecteditems"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VNet-Peering"
resource "azurerm_policy_definition" "deny_vnet_peering" {
  description         = "This policy denies the creation of vNet Peerings under the assigned scope."
  display_name        = "Deny vNet peering "
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:25:33.7357255Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.1"
  })
  mode = "All"
  name = "Deny-VNet-Peering"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings"
      field  = "type"
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MachineLearning-PublicAccessWhenBehindVnet"
resource "azurerm_policy_definition" "deny_machinelearning_publicaccesswhenbehindvnet" {
  description         = "Deny public access behind vnet to Azure Machine Learning workspaces."
  display_name        = "Deny public access behind vnet to Azure Machine Learning workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Machine Learning"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:49:34.5084906Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.1"
  })
  mode = "Indexed"
  name = "Deny-MachineLearning-PublicAccessWhenBehindVnet"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces"
        field  = "type"
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.MachineLearningServices/workspaces/allowPublicAccessWhenBehindVnet"
          }, {
          field     = "Microsoft.MachineLearningServices/workspaces/allowPublicAccessWhenBehindVnet"
          notEquals = false
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Windows-DomainJoin"
resource "azurerm_policy_definition" "deploy_windows_domainjoin" {
  description         = "Deploy Windows Domain Join Extension with keyvault configuration when the extension does not exist on a given windows Virtual Machine"
  display_name        = "Deploy Windows Domain Join Extension with keyvault configuration"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Guest Configuration"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:44:45.4742034Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deploy-Windows-DomainJoin"
  parameters = jsonencode({
    domainFQDN = {
      metadata = {
        displayName = "domainFQDN"
      }
      type = "String"
    }
    domainOUPath = {
      metadata = {
        displayName = "domainOUPath"
      }
      type = "String"
    }
    domainPassword = {
      metadata = {
        displayName = "domainPassword"
      }
      type = "String"
    }
    domainUsername = {
      metadata = {
        displayName = "domainUsername"
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
    keyVaultResourceId = {
      metadata = {
        displayName = "keyVaultResourceId"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        equals = "MicrosoftWindowsServer"
        field  = "Microsoft.Compute/imagePublisher"
        }, {
        equals = "WindowsServer"
        field  = "Microsoft.Compute/imageOffer"
        }, {
        field = "Microsoft.Compute/imageSKU"
        in    = ["2008-R2-SP1", "2008-R2-SP1-smalldisk", "2008-R2-SP1-zhcn", "2012-Datacenter", "2012-datacenter-gensecond", "2012-Datacenter-smalldisk", "2012-datacenter-smalldisk-g2", "2012-Datacenter-zhcn", "2012-datacenter-zhcn-g2", "2012-R2-Datacenter", "2012-r2-datacenter-gensecond", "2012-R2-Datacenter-smalldisk", "2012-r2-datacenter-smalldisk-g2", "2012-R2-Datacenter-zhcn", "2012-r2-datacenter-zhcn-g2", "2016-Datacenter", "2016-datacenter-gensecond", "2016-datacenter-gs", "2016-Datacenter-Server-Core", "2016-datacenter-server-core-g2", "2016-Datacenter-Server-Core-smalldisk", "2016-datacenter-server-core-smalldisk-g2", "2016-Datacenter-smalldisk", "2016-datacenter-smalldisk-g2", "2016-Datacenter-with-Containers", "2016-datacenter-with-containers-g2", "2016-Datacenter-with-RDSH", "2016-Datacenter-zhcn", "2016-datacenter-zhcn-g2", "2019-Datacenter", "2019-Datacenter-Core", "2019-datacenter-core-g2", "2019-Datacenter-Core-smalldisk", "2019-datacenter-core-smalldisk-g2", "2019-Datacenter-Core-with-Containers", "2019-datacenter-core-with-containers-g2", "2019-Datacenter-Core-with-Containers-smalldisk", "2019-datacenter-core-with-containers-smalldisk-g2", "2019-datacenter-gensecond", "2019-datacenter-gs", "2019-Datacenter-smalldisk", "2019-datacenter-smalldisk-g2", "2019-Datacenter-with-Containers", "2019-datacenter-with-containers-g2", "2019-Datacenter-with-Containers-smalldisk", "2019-datacenter-with-containers-smalldisk-g2", "2019-Datacenter-zhcn", "2019-datacenter-zhcn-g2", "Datacenter-Core-1803-with-Containers-smalldisk", "datacenter-core-1803-with-containers-smalldisk-g2", "Datacenter-Core-1809-with-Containers-smalldisk", "datacenter-core-1809-with-containers-smalldisk-g2", "Datacenter-Core-1903-with-Containers-smalldisk", "datacenter-core-1903-with-containers-smalldisk-g2", "datacenter-core-1909-with-containers-smalldisk", "datacenter-core-1909-with-containers-smalldisk-g1", "datacenter-core-1909-with-containers-smalldisk-g2"]
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              domainFQDN = {
                value = "[parameters('domainFQDN')]"
              }
              domainOUPath = {
                value = "[parameters('domainOUPath')]"
              }
              domainPassword = {
                reference = {
                  keyVault = {
                    id = "[parameters('keyVaultResourceId')]"
                  }
                  secretName = "[parameters('domainPassword')]"
                }
              }
              domainUsername = {
                reference = {
                  keyVault = {
                    id = "[parameters('keyVaultResourceId')]"
                  }
                  secretName = "[parameters('domainUsername')]"
                }
              }
              keyVaultResourceId = {
                value = "[parameters('keyVaultResourceId')]"
              }
              location = {
                value = "[field('location')]"
              }
              vmName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                domainFQDN = {
                  type = "String"
                }
                domainOUPath = {
                  type = "String"
                }
                domainPassword = {
                  type = "securestring"
                }
                domainUsername = {
                  type = "String"
                }
                keyVaultResourceId = {
                  type = "String"
                }
                location = {
                  type = "String"
                }
                vmName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2015-06-15"
                location   = "[resourceGroup().location]"
                name       = "[concat(variables('vmName'),'/joindomain')]"
                properties = {
                  autoUpgradeMinorVersion = true
                  protectedSettings = {
                    Password = "[parameters('domainPassword')]"
                  }
                  publisher = "Microsoft.Compute"
                  settings = {
                    Name    = "[parameters('domainFQDN')]"
                    OUPath  = "[parameters('domainOUPath')]"
                    Options = "[variables('domainJoinOptions')]"
                    Restart = "true"
                    User    = "[parameters('domainUserName')]"
                  }
                  type               = "JsonADDomainExtension"
                  typeHandlerVersion = "1.3"
                }
                type = "Microsoft.Compute/virtualMachines/extensions"
              }]
              variables = {
                domainJoinOptions = 3
                vmName            = "[parameters('vmName')]"
              }
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "JsonADDomainExtension"
            field  = "Microsoft.Compute/virtualMachines/extensions/type"
            }, {
            equals = "Microsoft.Compute"
            field  = "Microsoft.Compute/virtualMachines/extensions/publisher"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c"]
        type              = "Microsoft.Compute/virtualMachines/extensions"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-Databricks-UIAPI"
resource "azurerm_policy_definition" "dine_private_dns_azure_databricks_uiapi" {
  description         = "Configure private DNS zone group to override the DNS resolution for a databricks ui api groupID private endpoint."
  display_name        = "Configure a private DNS Zone ID for databricks ui api groupID"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "DNS Private Endpoint"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:30:20.7641478Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "Indexed"
  name = "DINE-Private-DNS-Azure-Databricks-UIAPI"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    privateDnsZoneId = {
      metadata = {
        assignPermissions = true
        description       = "Configure private DNS zone group to override the DNS resolution for a databricks ui api groupID private endpoint."
        displayName       = "Configure a private DNS Zone ID for databricks ui api groupID"
        strongType        = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/privateEndpoints"
        field  = "type"
        }, {
        count = {
          field = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          where = {
            equals = "databricks_ui_api"
            field  = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          }
        }
        greaterOrEquals = 1
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              privateDnsZoneId = {
                value = "[parameters('privateDnsZoneId')]"
              }
              privateEndpointName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                location = {
                  type = "String"
                }
                privateDnsZoneId = {
                  type = "String"
                }
                privateEndpointName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2020-03-01"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]"
                properties = {
                  privateDnsZoneConfigs = [{
                    name = "databricks_ui_api-privateDnsZone"
                    properties = {
                      privateDnsZoneId = "[parameters('privateDnsZoneId')]"
                    }
                  }]
                }
                type = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
              }]
            }
          }
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"]
        type              = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-ResourceGroup-Tag-Content-require-pattern"
resource "azurerm_policy_definition" "require_resourcegroup_tag_content_require_pattern" {
  description         = "This policy required that the defined tag contains an exact pattern in its value. Deployment will be denied otherwise. ComparisonLogic 'matchInsensitively'."
  display_name        = "Allow Tag with (exact) predefined pattern in value"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn = "2025-02-05T21:05:33.3117806Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Require-ResourceGroup-Tag-Content-require-pattern"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the audit policy"
        displayName = "Effect"
      }
      type = "String"
    }
    requiredPattern = {
      defaultValue = "#####"
      metadata = {
        description = "Mattern to match, eg. 5 digits. provide # to match a digit, ? for a letter, . to match any character, and any other character to match that actual character"
        displayName = "Tag Values"
      }
      type = "String"
    }
    tagName = {
      metadata = {
        description = "Name of the tag, such as 'owner'"
        displayName = "Tag Name"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions/resourceGroups"
        field  = "type"
        }, {
        not = {
          field              = "[concat('tags[', parameters('tagName'), ']')]"
          matchInsensitively = "[parameters('requiredPattern')]"
        }
        }, {
        field   = "name"
        notLike = "AzureBackupRG_*"
        }, {
        field     = "name"
        notEquals = "NetworkWatcherRG"
        }, {
        field   = "name"
        notLike = "cloud-shell-storage-*"
        }, {
        field   = "name"
        notLike = "DefaultResourceGroup*"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-ServerFarms-UnusedResourcesCostOptimization"
resource "azurerm_policy_definition" "audit_serverfarms_unusedresourcescostoptimization" {
  description         = "Optimize cost by detecting unused but chargeable resources. Leverage this Policy definition as a cost control to reveal orphaned App Service plans that are driving cost."
  display_name        = "Unused App Service plans driving cost should be avoided"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Cost Optimization"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:49:34.5865358Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Audit-ServerFarms-UnusedResourcesCostOptimization"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Web/serverfarms"
        field  = "type"
        }, {
        field     = "Microsoft.Web/serverFarms/sku.tier"
        notEquals = "Free"
        }, {
        equals = 0
        field  = "Microsoft.Web/serverFarms/numberOfSites"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DenyAction-ActivityLogs"
resource "azurerm_policy_definition" "denyaction_activitylogs" {
  description         = "This is a DenyAction implementation policy on Activity Logs."
  display_name        = "DenyAction implementation on Activity Logs"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:05:33.6179871Z"
    deprecated           = false
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode       = "Indexed"
  name       = "DenyAction-ActivityLogs"
  parameters = null
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Resources/subscriptions/providers/diagnosticSettings"
      field  = "type"
    }
    then = {
      details = {
        actionNames = ["delete"]
      }
      effect = "denyAction"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VPN-Gateway"
resource "azurerm_policy_definition" "deny_vpn_gateway" {
  description         = "Deny use of Virtual Network Gateway SKU: VPN."
  display_name        = "Deny creation of VPN Gateways"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Network"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:23:56.1488382Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode       = "All"
  name       = "Deny-VPN-Gateway"
  parameters = null
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/virtualNetworkGateways"
        field  = "type"
        }, {
        equals = "Vpn"
        field  = "Microsoft.Network/virtualNetworkGateways/gatewayType"
      }]
    }
    then = {
      effect = "Deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-SqlMi-minTLS"
resource "azurerm_policy_definition" "deny_sqlmi_mintls" {
  description         = "Setting minimal TLS version to 1.2 improves security by ensuring your SQL Managed Instance can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not reccomended since they have well documented security vunerabilities."
  display_name        = "SQL Managed Instance should have the minimal TLS version set to the highest version"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:37:44.3240118Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-SqlMi-minTLS"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    minimalTlsVersion = {
      allowedValues = ["1.2", "1.1", "1.0"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version minimum TLS version SQL servers to enforce"
        displayName = "Select version for SQL server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Sql/managedInstances"
        field  = "type"
        }, {
        anyOf = [{
          exists = "false"
          field  = "Microsoft.Sql/managedInstances/minimalTlsVersion"
          }, {
          field     = "Microsoft.Sql/managedInstances/minimalTlsVersion"
          notequals = "[parameters('minimalTlsVersion')]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-ResourceGroup-General-Tags"
resource "azurerm_policy_definition" "require_resourcegroup_general_tags" {
  description         = "This policy requires resource groups to be equipped with the defined mandatory tags. It is possible to exclude certain resource group naming patterns via a parameter."
  display_name        = "Require mandatory Tags on resource groups"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:46:19.4891064Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Require-ResourceGroup-General-Tags"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    ignoredRgPatterns = {
      defaultValue = ["AzureBackupRG_*", "NetworkWatcherRG", "DefaultResourceGroup*"]
      metadata = {
        description = "List of resouce group name patterns, to which the policy will not be applied. Matching with notLike-operator, * as a wildcard can be used."
        displayName = "Ignored resource group name patterns"
      }
      type = "array"
    }
    mandatoryTags = {
      defaultValue = []
      metadata = {
        description = "The list of tags that must exist on resource groups"
        displayName = "Mandatory tags"
      }
      type = "array"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions/resourceGroups"
        field  = "type"
        }, {
        count = {
          name  = "tagList"
          value = "[parameters('mandatoryTags')]"
          where = {
            field          = "tags"
            notContainsKey = "[current('tagList')]"
          }
        }
        greater = 0
        }, {
        count = {
          name  = "ignoredRgList"
          value = "[parameters('ignoredRgPatterns')]"
          where = {
            field = "name"
            like  = "[current('ignoredRgList')]"
          }
        }
        equals = 0
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/VirtualMachine-Backup-2000-14d-4w"
resource "azurerm_policy_definition" "virtualmachine_backup_2000_14d_4w" {
  description         = "This policy creates an Azure Recovery Services vault in the resource group when the first VM with supported OS is deployed. It creates a backup policy and assigns the VM to the backup policy schedule."
  display_name        = "Virtual Machine Backup Policy - Daily at 2000 - 14 days - 4 weeks"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:41:34.5091643Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "VirtualMachine-Backup-2000-14d-4w"
  parameters = jsonencode({
    dailyRetentionDurationCount = {
      defaultValue = 14
      metadata = {
        description = "daily: retention of daily backup points"
      }
      type = "Integer"
    }
    daysOfTheWeek = {
      defaultValue = ["Sunday"]
      metadata = {
        description = "daily: daily backup which should be kept as the weekly backup point"
      }
      type = "Array"
    }
    monthlyRetentionDurationCount = {
      defaultValue = 12
      metadata = {
        description = "monthly: Monthly backup retention"
      }
      type = "Integer"
    }
    monthsOfYear = {
      defaultValue = ["December"]
      metadata = {
        description = "yearly: monthly backup to keep as the yearly backup"
      }
      type = "Array"
    }
    policyName = {
      defaultValue = "vm-daily-2000-14d-4w"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy"
      }
      type = "String"
    }
    retentionScheduleDaily = {
      defaultValue = {
        daysOfTheMonth = [{
          date   = 0
          isLast = true
        }]
      }
      metadata = {
        description = "monthly: Default value keeps the last daily backup of the month. Only retentionScheduleDaily or retentionScheduleWeekly must be defined"
      }
      type = "Object"
    }
    scheduleRunTimes = {
      defaultValue = "20:00:00"
      metadata = {
        description = "runtime in format of hh:mm:ss"
      }
      type = "String"
    }
    timeZone = {
      defaultValue = "UTC"
      metadata = {
        description = "currently not used, replaced with timezoneselector-variable based on rg"
      }
      type = "String"
    }
    vaultSku = {
      defaultValue = "Standard"
      metadata = {
        description = "Standard or RS0 - currently only Standard (GRS) working, Microsoft limit"
      }
      type = "String"
    }
    vaultTags = {
      defaultValue = {
        description = "vault used by Azure policy af-dine-vm-backup-rg"
      }
      type = "Object"
    }
    vmBackupTagName = {
      defaultValue = "vm-backup-policy"
      metadata = {
        description = "the name of the tag key to filter virtual machines for"
      }
      type = "String"
    }
    weeklyRetentionDurationCount = {
      defaultValue = 4
      metadata = {
        description = "weekly: retention of the weekly backup point"
      }
      type = "Integer"
    }
    yearlyRetentionDurationCount = {
      defaultValue = 2
      metadata = {
        description = "yearly: Yearly backup retention"
      }
      type = "Integer"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        equals = "[parameters('policyName')]"
        field  = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
        }, {
        field   = "name"
        notLike = "*-test"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              dailyRetentionDurationCount = {
                value = "[parameters('dailyRetentionDurationCount')]"
              }
              daysOfTheWeek = {
                value = "[parameters('daysOfTheWeek')]"
              }
              monthlyRetentionDurationCount = {
                value = "[parameters('monthlyRetentionDurationCount')]"
              }
              monthsOfYear = {
                value = "[parameters('monthsOfYear')]"
              }
              policyName = {
                value = "[parameters('policyName')]"
              }
              retentionScheduleDaily = {
                value = "[parameters('retentionScheduleDaily')]"
              }
              scheduleRunTimes = {
                value = "[parameters('scheduleRunTimes')]"
              }
              timeZone = {
                value = "[parameters('timeZone')]"
              }
              vaultSku = {
                value = "[parameters('vaultSku')]"
              }
              vaultTags = {
                value = "[parameters('vaultTags')]"
              }
              vmName = {
                value = "[field('name')]"
              }
              vmResourceGroupLocation = {
                value = "[field('location')]"
              }
              vmResourceGroupName = {
                value = "[resourceGroup().name]"
              }
              weeklyRetentionDurationCount = {
                value = "[parameters('weeklyRetentionDurationCount')]"
              }
              yearlyRetentionDurationCount = {
                value = "[parameters('yearlyRetentionDurationCount')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                dailyRetentionDurationCount = {
                  type = "int"
                }
                daysOfTheWeek = {
                  type = "array"
                }
                monthlyRetentionDurationCount = {
                  type = "int"
                }
                monthsOfYear = {
                  type = "array"
                }
                policyName = {
                  type = "string"
                }
                retentionScheduleDaily = {
                  type = "object"
                }
                scheduleRunTimes = {
                  type = "string"
                }
                timeZone = {
                  type = "string"
                }
                vaultSku = {
                  type = "string"
                }
                vaultTags = {
                  type = "object"
                }
                vmName = {
                  type = "string"
                }
                vmResourceGroupLocation = {
                  type = "string"
                }
                vmResourceGroupName = {
                  type = "string"
                }
                weeklyRetentionDurationCount = {
                  type = "int"
                }
                yearlyRetentionDurationCount = {
                  type = "int"
                }
              }
              resources = [{
                apiVersion = "2023-07-01"
                name       = "[concat(parameters('vmName'), '-backupIntent')]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    resources = [{
                      apiVersion = "2023-06-01"
                      location   = "[parameters('vmResourceGroupLocation')]"
                      name       = "[variables('BackupVaultName')]"
                      properties = {
                        publicNetworkAccess = "Enabled"
                        restoreSettings = {
                          crossSubscriptionRestoreSettings = {
                            crossSubscriptionRestoreState = "Enabled"
                          }
                        }
                      }
                      sku = {
                        name = "[parameters('vaultSku')]"
                      }
                      tags = "[parameters('vaultTags')]"
                      type = "Microsoft.RecoveryServices/vaults"
                      }, {
                      apiVersion = "2023-04-01"
                      dependsOn  = ["[variables('BackupVaultName')]"]
                      location   = "[parameters('vmResourceGroupLocation')]"
                      name       = "[concat(variables('BackupVaultName'), '/', variables('BackupPolicyName'))]"
                      properties = {
                        backupManagementType          = "AzureIaasVM"
                        instantRPDetails              = {}
                        instantRpRetentionRangeInDays = 5
                        policyType                    = "V2"
                        retentionPolicy = {
                          dailySchedule = {
                            retentionDuration = {
                              count        = "[int(parameters('dailyRetentionDurationCount'))]"
                              durationType = "Days"
                            }
                            retentionTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          retentionPolicyType = "LongTermRetentionPolicy"
                          weeklySchedule = {
                            daysOfTheWeek = "[parameters('daysOfTheWeek')]"
                            retentionDuration = {
                              count        = "[parameters('weeklyRetentionDurationCount')]"
                              durationType = "Weeks"
                            }
                            retentionTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                        }
                        schedulePolicy = {
                          dailySchedule = {
                            scheduleRunTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          schedulePolicyType   = "SimpleSchedulePolicyV2"
                          scheduleRunFrequency = "Daily"
                        }
                        timeZone = "[parameters('timeZone')]"
                      }
                      tags = {}
                      type = "Microsoft.RecoveryServices/vaults/backupPolicies"
                      }, {
                      apiVersion = "2023-06-01"
                      dependsOn  = ["[variables('BackupPolicyName')]"]
                      name       = "[concat(variables('BackupVaultName'), variables('BackupIntentConcat'))]"
                      properties = {
                        policyId                 = "[concat(resourceId('Microsoft.RecoveryServices/vaults/backuppolicies', variables('BackupVaultName'), variables('BackupPolicyName')))]"
                        protectionIntentItemType = "AzureResourceItem"
                        sourceResourceId         = "[concat(resourceId('Microsoft.Compute/virtualMachines', parameters('vmName')))]"
                      }
                      type = "Microsoft.RecoveryServices/vaults/backupFabrics/backupProtectionIntent"
                    }]
                  }
                }
                resourceGroup = "[parameters('vmResourceGroupName')]"
                type          = "Microsoft.Resources/deployments"
              }]
              variables = {
                BackupIntentConcat = "[concat('/Azure/vm;iaasvmcontainerv2;', parameters('vmResourceGroupName'), ';', parameters('vmName'))]"
                BackupPolicyName   = "[concat('policy-',parameters('vmResourceGroupName'), '-', parameters('policyName'))]"
                BackupVaultName    = "[concat('rsv-', parameters('vmResourceGroupName'))]"
                timezoneMap = {
                  centralus = {
                    timezone = "Eastern Standard Time"
                  }
                  eastus2 = {
                    timezone = "Eastern Standard Time"
                  }
                  northeurope = {
                    timezone = "W. Europe Standard Time"
                  }
                  westeurope = {
                    timezone = "W. Europe Standard Time"
                  }
                }
                timezoneSelector = "[variables('timezoneMap')[parameters('vmResourceGroupLocation')].timezone]"
              }
            }
          }
        }
        existenceCondition = {
          allOf = [{
            field = "name"
            like  = "*"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.RecoveryServices/backupprotecteditems"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-PostgreSQL-sslEnforcement"
resource "azurerm_policy_definition" "deploy_postgresql_sslenforcement" {
  description         = "Deploy a specific min TLS version requirement and enforce SSL on Azure Database for PostgreSQL server. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
  display_name        = "Azure Database for PostgreSQL server deploy a specific min TLS version requirement and enforce SSL "
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:27:08.0900408Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:05:33.0952053Z"
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-PostgreSQL-sslEnforcement"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy minimum TLS version Azure Database for PostgreSQL server"
        displayName = "Effect Azure Database for PostgreSQL server"
      }
      type = "String"
    }
    minimalTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_0", "TLS1_1", "TLSEnforcementDisabled"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "Select version minimum TLS version Azure Database for PostgreSQL server to enforce"
        displayName = "Select version for PostgreSQL server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.DBforPostgreSQL/servers"
        field  = "type"
        }, {
        anyOf = [{
          field     = "Microsoft.DBforPostgreSQL/servers/sslEnforcement"
          notEquals = "Enabled"
          }, {
          field     = "Microsoft.DBforPostgreSQL/servers/minimalTlsVersion"
          notEquals = "[parameters('minimalTlsVersion')]"
        }]
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              minimalTlsVersion = {
                value = "[parameters('minimalTlsVersion')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                minimalTlsVersion = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-12-01"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'))]"
                properties = {
                  minimalTlsVersion = "[parameters('minimalTlsVersion')]"
                  sslEnforcement    = "[if(equals(parameters('minimalTlsVersion'), 'TLSEnforcementDisabled'),'Disabled', 'Enabled')]"
                }
                type = "Microsoft.DBforPostgreSQL/servers"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "Enabled"
            field  = "Microsoft.DBforPostgreSQL/servers/sslEnforcement"
            }, {
            equals = "[parameters('minimalTlsVersion')]"
            field  = "Microsoft.DBforPostgreSQL/servers/minimalTlsVersion"
          }]
        }
        name              = "current"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.DBforPostgreSQL/servers"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-Tde"
resource "azurerm_policy_definition" "deploy_sql_tde" {
  description         = "Deploy the Transparent Data Encryption when it is not enabled in the deployment. Please use this policy instead https://www.azadvertizer.net/azpolicyadvertizer/86a912f6-9a06-4e26-b447-11b16ba8659f.html"
  display_name        = "[Deprecated] Deploy SQL Database Transparent Data Encryption"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:49:34.4594775Z"
    deprecated           = true
    source               = "https://github.com/Azure/Enterprise-Scale/"
    supersededBy         = "86a912f6-9a06-4e26-b447-11b16ba8659f"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:03:58.7803901Z"
    version              = "1.1.1-deprecated"
  })
  mode = "Indexed"
  name = "Deploy-Sql-Tde"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    excludedDatabases = {
      defaultValue = ["master", "model", "tempdb", "msdb", "resource"]
      metadata = {
        description = "Array of databases that are excluded from this policy"
        displayName = "Excluded Databases"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Sql/servers/databases"
        field  = "type"
        }, {
        field = "name"
        notIn = "[parameters('excludedDatabases')]"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              sqlServerDataBaseName = {
                value = "[field('name')]"
              }
              sqlServerName = {
                value = "[first(split(field('fullname'),'/'))]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                sqlServerDataBaseName = {
                  type = "String"
                }
                sqlServerName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2014-04-01"
                name       = "[concat( parameters('sqlServerName'),'/',parameters('sqlServerDataBaseName'),'/current')]"
                properties = {
                  status = "Enabled"
                }
                type = "Microsoft.Sql/servers/databases/transparentDataEncryption"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "Enabled"
            field  = "Microsoft.Sql/transparentDataEncryption.status"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/056cd41c-7e88-42e1-933e-88ba6a50c9c3"]
        type              = "Microsoft.Sql/servers/databases/transparentDataEncryption"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/StorageAccount-Blob-Backup-mid"
resource "azurerm_policy_definition" "storageaccount_blob_backup_mid" {
  description         = "Enforce backup for blobs on all storage accounts that contain a given tag to a central backup vault. Doing this can help you manage backup of blobs contained across multiple storage accounts at scale. For more details, refer to https://aka.ms/AB-BlobBackupAzPolicies"
  display_name        = "Configure backup for blobs on storage accounts with a given tag to an existing backup vault in the same region"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:23:55.8794649Z"
    preview   = true
    updatedBy = null
    updatedOn = null
    version   = "2.0.0-preview"
  })
  mode = "Indexed"
  name = "StorageAccount-Blob-Backup-mid"
  parameters = jsonencode({
    dailyRetentionDurationCount = {
      defaultValue = 30
      metadata = {
        description = "daily: retention of daily backup points"
      }
      type = "Integer"
    }
    policyName = {
      defaultValue = "storage-blob-30d"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy"
      }
      type = "String"
    }
    storageBackupTagName = {
      defaultValue = "storageaccount-backup-policy"
      metadata = {
        description = "the name of the tag key to filter virtual machines for"
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
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Storage/StorageAccounts"
        field  = "type"
        }, {
        contains = "[parameters('policyName')]"
        field    = "[concat('tags[', parameters('storageBackupTagName'), ']')]"
        }, {
        equals = "StorageV2"
        field  = "kind"
        }, {
        contains = "Standard"
        field    = "Microsoft.Storage/storageAccounts/sku.name"
        }, {
        field     = "Microsoft.Storage/storageAccounts/isHnsEnabled"
        notEquals = "true"
        }, {
        field     = "Microsoft.Storage/storageAccounts/isNfsV3Enabled"
        notEquals = "true"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              dailyRetentionDurationCount = {
                value = "[parameters('dailyRetentionDurationCount')]"
              }
              policyName = {
                value = "[parameters('policyName')]"
              }
              storageAccountResourceId = {
                value = "[field('id')]"
              }
              storageResourceGroupLocation = {
                value = "[field('location')]"
              }
              storageResourceGroupName = {
                value = "[resourceGroup().name]"
              }
              vaultRedundancy = {
                value = "[parameters('vaultRedundancy')]"
              }
              vaultTags = {
                value = "[parameters('vaultTags')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                dailyRetentionDurationCount = {
                  type = "int"
                }
                policyName = {
                  type = "string"
                }
                storageAccountResourceId = {
                  metadata = {
                    description = "ResourceId of the Storage Account"
                  }
                  type = "string"
                }
                storageResourceGroupLocation = {
                  type = "string"
                }
                storageResourceGroupName = {
                  type = "string"
                }
                vaultRedundancy = {
                  type = "string"
                }
                vaultTags = {
                  type = "object"
                }
              }
              resources = [{
                apiVersion = "2021-04-01"
                name       = "[concat('DeployProtection-',uniqueString(variables('storageAccountName')))]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    parameters     = {}
                    resources = [{
                      apiVersion = "2021-01-01"
                      identity = {
                        type = "systemAssigned"
                      }
                      location = "[parameters('storageResourceGroupLocation')]"
                      name     = "[variables('BackupVaultName')]"
                      properties = {
                        storageSettings = [{
                          datastoreType = "VaultStore"
                          type          = "[parameters('vaultRedundancy')]"
                        }]
                      }
                      type = "Microsoft.DataProtection/backupVaults"
                      }, {
                      apiVersion = "2021-01-01"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]"]
                      name       = "[format('{0}/{1}', variables('BackupVaultName'), variables('backupPolicyName'))]"
                      properties = {
                        datasourceTypes = ["[variables('dataSourceType')]"]
                        objectType      = "BackupPolicy"
                        policyRules = [{
                          isDefault = true
                          lifecycles = [{
                            deleteAfter = {
                              duration   = "[concat('P',parameters('dailyRetentionDurationCount'), 'D')]"
                              objectType = "AbsoluteDeleteOption"
                            }
                            sourceDataStore = {
                              dataStoreType = "OperationalStore"
                              objectType    = "DataStoreInfoBase"
                            }
                          }]
                          name       = "Default"
                          objectType = "AzureRetentionRule"
                          ruleType   = "Retention"
                        }]
                      }
                      type = "Microsoft.DataProtection/backupVaults/backupPolicies"
                      }, {
                      apiVersion = "2020-04-01-preview"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]"]
                      name       = "[guid(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), variables('roleDefinitionId'), resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName')))]"
                      properties = {
                        principalId      = "[reference(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), '2021-01-01', 'Full').identity.principalId]"
                        principalType    = "ServicePrincipal"
                        roleDefinitionId = "[variables('roleDefinitionId')]"
                      }
                      scope = "[format('Microsoft.Storage/storageAccounts/{0}', variables('storageAccountName'))]"
                      type  = "Microsoft.Authorization/roleAssignments"
                      }, {
                      apiVersion = "2021-01-01"
                      dependsOn  = ["[resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName'))]", "[resourceId('Microsoft.DataProtection/backupVaults/backupPolicies', variables('BackupVaultName'), variables('backupPolicyName'))]", "[extensionResourceId(resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName')), 'Microsoft.Authorization/roleAssignments', guid(resourceId('Microsoft.DataProtection/backupVaults', variables('BackupVaultName')), variables('roleDefinitionId'), resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))))]"]
                      name       = "[concat(variables('BackupVaultName'), '/', variables('storageAccountName'))]"
                      properties = {
                        dataSourceInfo = {
                          datasourceType   = "[variables('dataSourceType')]"
                          objectType       = "Datasource"
                          resourceID       = "[parameters('storageAccountResourceId')]"
                          resourceLocation = "[parameters('storageResourceGroupLocation')]"
                          resourceName     = "[variables('storageAccountName')]"
                          resourceType     = "[variables('resourceType')]"
                          resourceUri      = "[parameters('storageAccountResourceId')]"
                        }
                        objectType = "BackupInstance"
                        policyInfo = {
                          name     = "[variables('backupPolicyName')]"
                          policyId = "[resourceId('Microsoft.DataProtection/backupVaults/backupPolicies', variables('BackupVaultName'), variables('backupPolicyName'))]"
                        }
                      }
                      type = "Microsoft.DataProtection/backupvaults/backupInstances"
                    }]
                  }
                }
                resourceGroup  = "[variables('vaultResourceGroup')]"
                subscriptionId = "[variables('vaultSubscriptionId')]"
                type           = "Microsoft.Resources/deployments"
              }]
              variables = {
                BackupVaultName     = "[concat('rsv-', parameters('storageResourceGroupName'))]"
                backupPolicyName    = "[concat('policy-', parameters('policyName'))]"
                dataSourceType      = "Microsoft.Storage/storageAccounts/blobServices"
                resourceType        = "Microsoft.Storage/storageAccounts"
                roleDefinitionId    = "[subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e5e2a7ff-d759-4cd2-bb51-3152d37e2eb1')]"
                storageAccountName  = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 8))]"
                vaultResourceGroup  = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 4))]"
                vaultSubscriptionId = "[first(skip(split(parameters('storageAccountResourceId'), '/'), 2))]"
              }
            }
          }
        }
        existenceCondition = {
          equals = true
          field  = "Microsoft.Storage/storageAccounts/blobServices/default.restorePolicy.enabled"
        }
        name              = "default"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635"]
        type              = "Microsoft.Storage/storageAccounts/blobServices"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VirtualMachine-Unmanaged-Disk"
resource "azurerm_policy_definition" "deny_virtualmachine_unmanaged_disk" {
  description         = "This Policy prevents using unmanaged disks (VHDs) with Virtual Machines."
  display_name        = "Deny Virtual Machines using unmanaged disks"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Compute"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:41:34.6379323Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode       = "All"
  name       = "Deny-VirtualMachine-Unmanaged-Disk"
  parameters = null
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Compute/virtualMachines"
          field  = "type"
          }, {
          exists = true
          field  = "Microsoft.Compute/virtualMachines/osDisk.uri"
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Compute/VirtualMachineScaleSets"
          field  = "type"
          }, {
          anyOf = [{
            exists = true
            field  = "Microsoft.Compute/VirtualMachineScaleSets/osDisk.vhdContainers"
            }, {
            exists = true
            field  = "Microsoft.Compute/VirtualMachineScaleSets/osdisk.imageUrl"
          }]
        }]
      }]
    }
    then = {
      effect = "deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-POSTGRESQL"
resource "azurerm_policy_definition" "dine_private_dns_azure_postgresql" {
  description         = "Configure private DNS zone group to override the DNS resolution for a postgresql groupID private endpoint."
  display_name        = "Configure a private DNS Zone ID for postgresql groupID"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "DNS Private Endpoint"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:25:33.5432831Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "Indexed"
  name = "DINE-Private-DNS-Azure-POSTGRESQL"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    privateDnsZoneId = {
      metadata = {
        assignPermissions = true
        description       = "Configure private DNS zone group to override the DNS resolution for a postgresql groupID private endpoint."
        displayName       = "Configure a private DNS Zone ID for postgresql groupID"
        strongType        = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/privateEndpoints"
        field  = "type"
        }, {
        count = {
          field = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          where = {
            equals = "postgresqlServer"
            field  = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          }
        }
        greaterOrEquals = 1
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              privateDnsZoneId = {
                value = "[parameters('privateDnsZoneId')]"
              }
              privateEndpointName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                location = {
                  type = "String"
                }
                privateDnsZoneId = {
                  type = "String"
                }
                privateEndpointName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2020-03-01"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]"
                properties = {
                  privateDnsZoneConfigs = [{
                    name = "PostgreSQL-privateDnsZone"
                    properties = {
                      privateDnsZoneId = "[parameters('privateDnsZoneId')]"
                    }
                  }]
                }
                type = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
              }]
            }
          }
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"]
        type              = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-VirtualMachine-Update-Tag"
resource "azurerm_policy_definition" "append_virtualmachine_update_tag" {
  description         = "This policy appends default Tag value to vmUpdateTagName if not set on a Virtual Machine."
  display_name        = "Add default Update Tag to Virtual Machines"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:43:10.51491Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Append-VirtualMachine-Update-Tag"
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
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        not = {
          equals = "microsoft-aks"
          field  = "Microsoft.Compute/virtualMachines/storageProfile.imageReference.publisher"
        }
        }, {
        anyOf = [{
          exists = "false"
          field  = "tags"
          }, {
          exists = "false"
          field  = "[concat('tags[', parameters('vmUpdateTagName'), ']')]"
          }, {
          field = "[concat('tags[', parameters('vmUpdateTagName'), ']')]"
          notIn = "[parameters('allowedUpdateTagValues')]"
        }]
      }]
    }
    then = {
      details = [{
        field = "[concat('tags[', parameters('vmUpdateTagName'), ']')]"
        value = "[parameters('defaultUpdateTagValue')]"
      }]
      effect = "append"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-Address-Space-Preallocation"
resource "azurerm_policy_definition" "require_address_space_preallocation" {
  description         = "This policy ensures that the address space allocated to a VNET has been pre-allocated for use within Azure, preventing peerings being utilised as an attack vector for null-routing traffic on the platform."
  display_name        = "Address space must be pre-allocated for region"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category     = "Network"
    createdBy    = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn    = "2025-02-05T21:03:59.2296111Z"
    portalReview = "true"
    updatedBy    = null
    updatedOn    = null
    version      = "0.0.1-preview"
  })
  mode = "Indexed"
  name = "Require-Address-Space-Preallocation"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Deny", "Audit", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Deny, Audit or Disabled the execution of the Policy"
        displayName = "Effect"
      }
      type = "String"
    }
    spokeAllocations = {
      defaultValue = [{
        CIDR     = "10.2.0.0/16"
        location = "westeurope"
        }, {
        CIDR     = "10.1.0.0/16"
        location = "northeurope"
      }]
      metadata = {
        description = "An array of CIDR objects (location and CIDR), to be compared against CIDRs allocated to VNET resources."
        displayName = "Regional CIDR Allocations"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks"
          field  = "type"
          }, {
          exists = true
          field  = "Microsoft.Network/virtualNetworks/addressSpace"
          }, {
          greater = 0
          value   = "[length(field('Microsoft.Network/virtualNetworks/addressSpace'))]"
        }]
        }, {
        count = {
          name  = "spokeAllocation"
          value = "[parameters('spokeAllocations')]"
          where = {
            allOf = [{
              equals = "[current('spokeAllocation').location]"
              field  = "location"
              }, {
              equals = true
              value  = "[ipRangeContains(current('spokeAllocation').CIDR, first(field('Microsoft.Network/virtualNetworks/addressSpace.addressPrefixes[*]')))]"
            }]
          }
        }
        notequals = "[length(field('Microsoft.Network/virtualNetworks/addressSpace.addressPrefixes'))]"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VNET-Peering-To-Non-Approved-VNETs"
resource "azurerm_policy_definition" "deny_vnet_peering_to_non_approved_vnets" {
  description         = "This policy denies the creation of vNet Peerings to non-approved vNets under the assigned scope."
  display_name        = "Deny vNet peering to non-approved vNets"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:33:32.5318048Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Deny-VNET-Peering-To-Non-Approved-VNETs"
  parameters = jsonencode({
    allowedVnets = {
      defaultValue = []
      metadata = {
        description = "Array of allowed vNets that can be peered with. Must be entered using their resource ID. Example: /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}"
        displayName = "Allowed vNets to peer with"
      }
      type = "Array"
    }
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings"
          field  = "type"
          }, {
          not = {
            field = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/remoteVirtualNetwork.id"
            in    = "[parameters('allowedVnets')]"
          }
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks"
          field  = "type"
          }, {
          not = {
            field = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings[*].remoteVirtualNetwork.id"
            in    = "[parameters('allowedVnets')]"
          }
          }, {
          not = {
            exists = false
            field  = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings[*].remoteVirtualNetwork.id"
          }
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-Disks-UnusedResourcesCostOptimization"
resource "azurerm_policy_definition" "audit_disks_unusedresourcescostoptimization" {
  description         = "Optimize cost by detecting unused but chargeable resources. Leverage this Policy definition as a cost control to reveal orphaned Disks that are driving cost."
  display_name        = "Unused Disks driving cost should be avoided"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Cost Optimization"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:41:34.5423069Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Audit-Disks-UnusedResourcesCostOptimization"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/disks"
        field  = "type"
        }, {
        equals = "Unattached"
        field  = "Microsoft.Compute/disks/diskState"
        }, {
        allof = [{
          field   = "name"
          notlike = "*-ASRReplica"
          }, {
          field   = "name"
          notlike = "ms-asr-*"
          }, {
          field   = "name"
          notlike = "asrseeddisk-*"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-VNET-Peer-Cross-Sub"
resource "azurerm_policy_definition" "deny_vnet_peer_cross_sub" {
  description         = "This policy denies the creation of vNet Peerings outside of the same subscriptions under the assigned scope."
  display_name        = "Deny vNet peering cross subscription."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:27:08.1735105Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.1"
  })
  mode = "All"
  name = "Deny-VNET-Peer-Cross-Sub"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings"
        field  = "type"
        }, {
        field       = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/remoteVirtualNetwork.id"
        notcontains = "[subscription().id]"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ACR"
resource "azurerm_policy_definition" "deploy_diagnostics_acr" {
  description         = "Deploys the diagnostic settings for Container Registry to stream to a Log Analytics workspace when any ACR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics  enabled."
  display_name        = "Deploy Diagnostic Settings for Container Registry to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:43:10.3391841Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-ACR"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.ContainerRegistry/registries"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "ContainerRegistryLoginEvents"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ContainerRegistryRepositoryEvents"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.ContainerRegistry/registries/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/DINE-Private-DNS-Azure-SQLSERVER"
resource "azurerm_policy_definition" "dine_private_dns_azure_sqlserver" {
  description         = "Configure private DNS zone group to override the DNS resolution for a sqlserver groupID private endpoint."
  display_name        = "Configure a private DNS Zone ID for sqlserver groupID"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "DNS Private Endpoint"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:44:44.9830306Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "Indexed"
  name = "DINE-Private-DNS-Azure-SQLSERVER"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    privateDnsZoneId = {
      metadata = {
        assignPermissions = true
        description       = "Configure private DNS zone group to override the DNS resolution for a sqlserver groupID private endpoint."
        displayName       = "Configure a private DNS Zone ID for sqlserver groupID"
        strongType        = "Microsoft.Network/privateDnsZones"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/privateEndpoints"
        field  = "type"
        }, {
        count = {
          field = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          where = {
            equals = "sqlServer"
            field  = "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]"
          }
        }
        greaterOrEquals = 1
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              privateDnsZoneId = {
                value = "[parameters('privateDnsZoneId')]"
              }
              privateEndpointName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                location = {
                  type = "String"
                }
                privateDnsZoneId = {
                  type = "String"
                }
                privateEndpointName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2020-03-01"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]"
                properties = {
                  privateDnsZoneConfigs = [{
                    name = "sqlServer-privateDnsZone"
                    properties = {
                      privateDnsZoneId = "[parameters('privateDnsZoneId')]"
                    }
                  }]
                }
                type = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
              }]
            }
          }
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"]
        type              = "Microsoft.Network/privateEndpoints/privateDnsZoneGroups"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Budget"
resource "azurerm_policy_definition" "deploy_budget" {
  description         = "Deploy a default budget on all subscriptions under the assigned scope"
  display_name        = "Deploy a default budget on all subscriptions under the assigned scope"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureUSGovernment"]
    category             = "Budget"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:43:10.3863782Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "All"
  name = "Deploy-Budget"
  parameters = jsonencode({
    amount = {
      defaultValue = "1000"
      metadata = {
        description = "The total amount of cost or usage to track with the budget"
      }
      type = "String"
    }
    budgetName = {
      defaultValue = "budget-set-by-policy"
      metadata = {
        description = "The name for the budget to be created"
      }
      type = "String"
    }
    contactEmails = {
      defaultValue = []
      metadata = {
        description = "The list of email addresses, in an array, to send the budget notification to when the threshold is exceeded."
      }
      type = "Array"
    }
    contactGroups = {
      defaultValue = []
      metadata = {
        description = "The list of action groups, in an array, to send the budget notification to when the threshold is exceeded. It accepts array of strings."
      }
      type = "Array"
    }
    contactRoles = {
      defaultValue = ["Owner", "Contributor"]
      metadata = {
        description = "The list of contact RBAC roles, in an array, to send the budget notification to when the threshold is exceeded."
      }
      type = "Array"
    }
    effect = {
      allowedValues = ["DeployIfNotExists", "AuditIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
      }
      type = "String"
    }
    firstThreshold = {
      defaultValue = "90"
      metadata = {
        description = "Threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000."
      }
      type = "String"
    }
    secondThreshold = {
      defaultValue = "100"
      metadata = {
        description = "Threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000."
      }
      type = "String"
    }
    timeGrain = {
      allowedValues = ["Monthly", "Quarterly", "Annually", "BillingMonth", "BillingQuarter", "BillingAnnual"]
      defaultValue  = "Monthly"
      metadata = {
        description = "The time covered by a budget. Tracking of the amount will be reset based on the time grain."
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions"
        field  = "type"
      }]
    }
    then = {
      details = {
        deployment = {
          location = "northeurope"
          properties = {
            mode = "Incremental"
            parameters = {
              amount = {
                value = "[parameters('amount')]"
              }
              budgetName = {
                value = "[parameters('budgetName')]"
              }
              contactEmails = {
                value = "[parameters('contactEmails')]"
              }
              contactGroups = {
                value = "[parameters('contactGroups')]"
              }
              contactRoles = {
                value = "[parameters('contactRoles')]"
              }
              firstThreshold = {
                value = "[parameters('firstThreshold')]"
              }
              secondThreshold = {
                value = "[parameters('secondThreshold')]"
              }
              timeGrain = {
                value = "[parameters('timeGrain')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json"
              contentVersion = "1.0.0.0"
              parameters = {
                amount = {
                  type = "String"
                }
                budgetName = {
                  type = "String"
                }
                contactEmails = {
                  type = "Array"
                }
                contactGroups = {
                  type = "Array"
                }
                contactRoles = {
                  type = "Array"
                }
                firstThreshold = {
                  type = "String"
                }
                secondThreshold = {
                  type = "String"
                }
                startDate = {
                  defaultValue = "[concat(utcNow('MM'), '/01/', utcNow('yyyy'))]"
                  type         = "String"
                }
                timeGrain = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2019-10-01"
                name       = "[parameters('budgetName')]"
                properties = {
                  amount   = "[parameters('amount')]"
                  category = "Cost"
                  notifications = {
                    NotificationForExceededBudget1 = {
                      contactEmails = "[parameters('contactEmails')]"
                      contactGroups = "[parameters('contactGroups')]"
                      contactRoles  = "[parameters('contactRoles')]"
                      enabled       = true
                      operator      = "GreaterThan"
                      threshold     = "[parameters('firstThreshold')]"
                    }
                    NotificationForExceededBudget2 = {
                      contactEmails = "[parameters('contactEmails')]"
                      contactGroups = "[parameters('contactGroups')]"
                      contactRoles  = "[parameters('contactRoles')]"
                      enabled       = true
                      operator      = "GreaterThan"
                      threshold     = "[parameters('secondThreshold')]"
                    }
                  }
                  timeGrain = "[parameters('timeGrain')]"
                  timePeriod = {
                    startDate = "[parameters('startDate')]"
                  }
                }
                type = "Microsoft.Consumption/budgets"
              }]
            }
          }
        }
        deploymentScope = "subscription"
        existenceCondition = {
          allOf = [{
            equals = "[parameters('amount')]"
            field  = "Microsoft.Consumption/budgets/amount"
            }, {
            equals = "[parameters('timeGrain')]"
            field  = "Microsoft.Consumption/budgets/timeGrain"
            }, {
            equals = "Cost"
            field  = "Microsoft.Consumption/budgets/category"
          }]
        }
        existenceScope    = "subscription"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.Consumption/budgets"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VWanS2SVPNGW"
resource "azurerm_policy_definition" "deploy_diagnostics_vwans2svpngw" {
  description         = "Deploys the diagnostic settings for VWAN S2S VPN Gateway to stream to a Log Analytics workspace when any VWAN S2S VPN Gateway which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled."
  display_name        = "Deploy Diagnostic Settings for VWAN S2S VPN Gateway to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:28:07.8859293Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-VWanS2SVPNGW"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/vpnGateways"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "GatewayDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "IKEDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "RouteDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "TunnelDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/vpnGateways/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Nsg-FlowLogs"
resource "azurerm_policy_definition" "deploy_nsg_flowlogs" {
  description         = "[Deprecated] Deprecated by built-in policy. Deploys NSG flow logs and traffic analytics to a storageaccountid with a specified retention period. Superseded by https://www.azadvertizer.net/azpolicyadvertizer/e920df7f-9a64-4066-9b58-52684c02a091.html"
  display_name        = "[Deprecated] Deploys NSG flow logs and traffic analytics"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:46:19.4399519Z"
    deprecated           = true
    source               = "https://github.com/Azure/Enterprise-Scale/"
    supersededBy         = "e920df7f-9a64-4066-9b58-52684c02a091"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:08:39.9817428Z"
    version              = "1.0.0-deprecated"
  })
  mode = "Indexed"
  name = "Deploy-Nsg-FlowLogs"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    flowAnalyticsEnabled = {
      defaultValue = false
      metadata = {
        displayName = "Enable Traffic Analytics"
      }
      type = "Boolean"
    }
    logAnalytics = {
      defaultValue = ""
      metadata = {
        description = "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID."
        displayName = "Resource ID of Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    retention = {
      defaultValue = 5
      metadata = {
        displayName = "Retention"
      }
      type = "Integer"
    }
    storageAccountResourceId = {
      metadata = {
        displayName = "Storage Account Resource Id"
        strongType  = "Microsoft.Storage/storageAccounts"
      }
      type = "String"
    }
    trafficAnalyticsInterval = {
      defaultValue = 60
      metadata = {
        displayName = "Traffic Analytics processing interval mins (10/60)"
      }
      type = "Integer"
    }
  })
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/networkSecurityGroups"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              flowAnalyticsEnabled = {
                value = "[parameters('flowAnalyticsEnabled')]"
              }
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              networkSecurityGroupName = {
                value = "[field('name')]"
              }
              resourceGroupName = {
                value = "[resourceGroup().name]"
              }
              retention = {
                value = "[parameters('retention')]"
              }
              storageAccountResourceId = {
                value = "[parameters('storageAccountResourceId')]"
              }
              trafficAnalyticsInterval = {
                value = "[parameters('trafficAnalyticsInterval')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                flowAnalyticsEnabled = {
                  type = "bool"
                }
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                networkSecurityGroupName = {
                  type = "String"
                }
                resourceGroupName = {
                  type = "String"
                }
                retention = {
                  type = "int"
                }
                storageAccountResourceId = {
                  type = "String"
                }
                trafficAnalyticsInterval = {
                  type = "int"
                }
              }
              resources = [{
                apiVersion = "2020-05-01"
                location   = "[parameters('location')]"
                name       = "[take(concat('NetworkWatcher_', toLower(parameters('location')),  '/', parameters('networkSecurityGroupName'), '-', parameters('resourceGroupName'), '-flowlog' ), 80)]"
                properties = {
                  enabled = true
                  flowAnalyticsConfiguration = {
                    networkWatcherFlowAnalyticsConfiguration = {
                      enabled                  = "[bool(parameters('flowAnalyticsEnabled'))]"
                      trafficAnalyticsInterval = "[parameters('trafficAnalyticsInterval')]"
                      workspaceId              = "[if(not(empty(parameters('logAnalytics'))), reference(parameters('logAnalytics'), '2020-03-01-preview', 'Full').properties.customerId, json('null')) ]"
                      workspaceRegion          = "[if(not(empty(parameters('logAnalytics'))), reference(parameters('logAnalytics'), '2020-03-01-preview', 'Full').location, json('null')) ]"
                      workspaceResourceId      = "[if(not(empty(parameters('logAnalytics'))), parameters('logAnalytics'), json('null'))]"
                    }
                  }
                  format = {
                    type    = "JSON"
                    version = 2
                  }
                  retentionPolicy = {
                    days    = "[parameters('retention')]"
                    enabled = true
                  }
                  storageId        = "[parameters('storageAccountResourceId')]"
                  targetResourceId = "[resourceId(parameters('resourceGroupName'), 'Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroupName'))]"
                }
                type = "Microsoft.Network/networkWatchers/flowLogs"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Network/networkWatchers/flowLogs/enabled"
            }, {
            equals = "[parameters('flowAnalyticsEnabled')]"
            field  = "Microsoft.Network/networkWatchers/flowLogs/flowAnalyticsConfiguration.networkWatcherFlowAnalyticsConfiguration.enabled"
          }]
        }
        resourceGroupName = "NetworkWatcherRG"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Network/networkWatchers/flowLogs"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Databricks-Sku"
resource "azurerm_policy_definition" "deny_databricks_sku" {
  description         = "Enforces the use of Premium Databricks workspaces to make sure appropriate security features are available including Databricks Access Controls, Credential Passthrough and SCIM provisioning for Microsoft Entra ID."
  display_name        = "Deny non-premium Databricks sku"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Databricks"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:38:21.5248095Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:07:07.5264247Z"
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-Databricks-Sku"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Databricks/workspaces"
        field  = "type"
        }, {
        field     = "Microsoft.DataBricks/workspaces/sku.name"
        notEquals = "premium"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MariaDB"
resource "azurerm_policy_definition" "deploy_diagnostics_mariadb" {
  description         = "Deploys the diagnostic settings for MariaDB to stream to a Log Analytics workspace when any MariaDB  which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for MariaDB to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:35:08.0222364Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-MariaDB"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DBforMariaDB/servers"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "MySqlSlowLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "MySqlAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DBforMariaDB/servers/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-UDR-With-Specific-NextHop"
resource "azurerm_policy_definition" "deny_udr_with_specific_nexthop" {
  description         = "This policy denies the creation of a User Defined Route with 'Next Hop Type' set to 'Internet' or 'VirtualNetworkGateway'."
  display_name        = "User Defined Routes with 'Next Hop Type' set to 'Internet' or 'VirtualNetworkGateway' should be denied"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:04:00.7186241Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Deny-UDR-With-Specific-NextHop"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "The effect determines what happens when the policy rule is evaluated to match"
        displayName = "Effect"
      }
      type = "String"
    }
    excludedDestinations = {
      defaultValue = ["Internet", "VirtualNetworkGateway"]
      metadata = {
        description = "Array of route destinations that are to be denied"
        displayName = "Excluded Destinations"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/routeTables"
          field  = "type"
          }, {
          count = {
            field = "Microsoft.Network/routeTables/routes[*]"
            where = {
              field = "Microsoft.Network/routeTables/routes[*].nextHopType"
              in    = "[parameters('excludedDestinations')]"
            }
          }
          notEquals = 0
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/routeTables/routes"
          field  = "type"
          }, {
          field = "Microsoft.Network/routeTables/routes/nextHopType"
          in    = "[parameters('excludedDestinations')]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-ResourceGroup-Tag-Content-allow-list"
resource "azurerm_policy_definition" "require_resourcegroup_tag_content_allow_list" {
  description         = "This policy required that the defined tag contains a value from a given list. Deployment will be denied otherwise. ComparisonLogic 'in'"
  display_name        = "Allow Tag with predefined list of values"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn = "2025-02-05T21:07:07.9639381Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Require-ResourceGroup-Tag-Content-allow-list"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the audit policy"
        displayName = "Effect"
      }
      type = "String"
    }
    listofallowedtagValues = {
      defaultValue = ["defaultValue"]
      metadata = {
        description = "Value of the tag, such as 'production', 'development', ..."
        displayName = "Tag Values"
      }
      type = "Array"
    }
    tagName = {
      metadata = {
        description = "Name of the tag, such as 'environment'"
        displayName = "Tag Name"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions/resourceGroups"
        field  = "type"
        }, {
        not = {
          field = "[concat('tags[', parameters('tagName'), ']')]"
          in    = "[parameters('listofallowedtagValues')]"
        }
        }, {
        field   = "name"
        notLike = "AzureBackupRG_*"
        }, {
        field     = "name"
        notEquals = "NetworkWatcherRG"
        }, {
        field   = "name"
        notLike = "cloud-shell-storage-*"
        }, {
        field   = "name"
        notLike = "DefaultResourceGroup*"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SQLMI"
resource "azurerm_policy_definition" "deploy_diagnostics_sqlmi" {
  description         = "Deploys the diagnostic settings for SQL Managed Instances to stream to a Log Analytics workspace when any SQL Managed Instances which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for SQL Managed Instances to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:28:44.0333611Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-SQLMI"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Sql/managedInstances"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "ResourceUsageStats"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SQLSecurityAuditEvents"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DevOpsOperationsAudit"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Sql/managedInstances/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-ExpressRoute-Gateway"
resource "azurerm_policy_definition" "deny_expressroute_gateway" {
  description         = "Deny use of Virtual Network Gateway SKU: ExpressRoute."
  display_name        = "Deny creation of ExpressRoute Gateways"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Network"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:39:58.5622564Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode       = "All"
  name       = "Deny-ExpressRoute-Gateway"
  parameters = null
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/virtualNetworkGateways"
        field  = "type"
        }, {
        equals = "ExpressRoute"
        field  = "Microsoft.Network/virtualNetworkGateways/gatewayType"
      }]
    }
    then = {
      effect = "Deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Lighthouse-Reader-Delegation-To-Subscription"
resource "azurerm_policy_definition" "deploy_lighthouse_reader_delegation_to_subscription" {
  description         = "Policy deploys the GKGAB Azure Lighthouse delegation with permission READER to the subscriptions in scope."
  display_name        = "Deploy Lighthouse Reader delegation To Subscription"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Lighthouse"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:35:08.298974Z"
    updatedBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn = "2025-02-05T21:05:32.7187066Z"
    version   = "1.0.0"
  })
  mode = "All"
  name = "Deploy-Lighthouse-Reader-Delegation-To-Subscription"
  parameters = jsonencode({
    ReaderPrincipalID = {
      defaultValue = "196ae378-c291-4665-be0d-28702a0ddca9"
      metadata = {
        description = "Object ID of Reader Group provided by GKGAB"
      }
      type = "string"
    }
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the Policy."
        displayName = "Effects"
      }
      type = "String"
    }
    managedByTenantId = {
      defaultValue = "a53834b7-42bc-46a3-b004-369735c3acf9"
      metadata = {
        description = "Tenant ID provided by GKGAB"
      }
      type = "string"
    }
    mspOfferDescription = {
      defaultValue = "The solution will grant glueckkanja-gab AG following RBAC role to your subscribtion: Reader - GKGAB Azure Lighthouse Reader"
      metadata = {
        description = "Name of the Managed Service Provider offering"
      }
      type = "string"
    }
    mspOfferName = {
      defaultValue = "GKGAB Azure Managed Service - Access privileges - reader"
      metadata = {
        description = "Specify a unique name for your offer"
      }
      type = "string"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions"
        field  = "type"
      }]
    }
    then = {
      details = {
        ExistenceScope = "Subscription"
        deployment = {
          location = "westeurope"
          properties = {
            mode = "incremental"
            parameters = {
              ReaderPrincipalID = {
                value = "[parameters('ReaderPrincipalID')]"
              }
              managedByTenantId = {
                value = "[parameters('managedByTenantId')]"
              }
              mspOfferDescription = {
                value = "[parameters('mspOfferDescription')]"
              }
              mspOfferName = {
                value = "[parameters('mspOfferName')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                ReaderPrincipalID = {
                  type = "string"
                }
                managedByTenantId = {
                  type = "String"
                }
                mspOfferDescription = {
                  type = "String"
                }
                mspOfferName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2019-09-01"
                name       = "[variables('mspRegistrationName')]"
                properties = {
                  authorizations             = "[variables('authorizations')]"
                  description                = "[parameters('mspOfferDescription')]"
                  managedByTenantId          = "[parameters('managedByTenantId')]"
                  registrationDefinitionName = "[parameters('mspOfferName')]"
                }
                type = "Microsoft.ManagedServices/registrationDefinitions"
                }, {
                apiVersion = "2019-09-01"
                dependsOn  = ["[resourceId('Microsoft.ManagedServices/registrationDefinitions/', variables('mspRegistrationName'))]"]
                name       = "[variables('mspAssignmentName')]"
                properties = {
                  registrationDefinitionId = "[resourceId('Microsoft.ManagedServices/registrationDefinitions/', variables('mspRegistrationName'))]"
                }
                type = "Microsoft.ManagedServices/registrationAssignments"
              }]
              variables = {
                authorizations = [{
                  principalId            = "[parameters('ReaderPrincipalID')]"
                  principalIdDisplayName = "GKGAB Azure Lighthouse Reader"
                  roleDefinitionId       = "acdd72a7-3385-48ef-bd42-f606fba81ae7"
                  }, {
                  principalId            = "[parameters('ReaderPrincipalID')]"
                  principalIdDisplayName = "Remove GKGAB Azure Lighthouse Delegation"
                  roleDefinitionId       = "91c1777a-f3dc-4fae-b103-61d183457e46"
                }]
                mspAssignmentName   = "[guid(parameters('mspOfferName'))]"
                mspRegistrationName = "[guid(parameters('mspOfferName'))]"
              }
            }
          }
        }
        deploymentScope = "Subscription"
        existenceCondition = {
          allOf = [{
            equals = "[guid(parameters('mspOfferName'))]"
            field  = "name"
          }]
        }
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635"]
        type              = "Microsoft.ManagedServices/registrationAssignments"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceFunctionApp-http"
resource "azurerm_policy_definition" "deny_appservicefunctionapp_http" {
  description         = "Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks."
  display_name        = "Function App should only be accessible over HTTPS"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "App Service"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:44:44.9601896Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-AppServiceFunctionApp-http"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Web/sites"
        field  = "type"
        }, {
        field = "kind"
        like  = "functionapp*"
        }, {
        equals = "false"
        field  = "Microsoft.Web/sites/httpsOnly"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ApplicationGateway"
resource "azurerm_policy_definition" "deploy_diagnostics_applicationgateway" {
  description         = "Deploys the diagnostic settings for Application Gateway to stream to a Log Analytics workspace when any Application Gateway which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Application Gateway to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:49:34.252657Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-ApplicationGateway"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/applicationGateways"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "ApplicationGatewayAccessLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ApplicationGatewayPerformanceLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ApplicationGatewayFirewallLog"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/applicationGateways/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-DDoSProtection"
resource "azurerm_policy_definition" "deploy_ddosprotection" {
  description         = "Deploys an Azure DDoS Network Protection"
  display_name        = "Deploy an Azure DDoS Network Protection"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:27:08.171286Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.1"
  })
  mode = "All"
  name = "Deploy-DDoSProtection"
  parameters = jsonencode({
    ddosName = {
      metadata = {
        description = "DDoSVnet"
        displayName = "ddosName"
      }
      type = "String"
    }
    ddosRegion = {
      metadata = {
        description = "DDoSVnet location"
        displayName = "ddosRegion"
        strongType  = "location"
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
    rgName = {
      metadata = {
        description = "Provide name for resource group."
        displayName = "rgName"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions"
        field  = "type"
      }]
    }
    then = {
      details = {
        deployment = {
          location = "northeurope"
          properties = {
            mode = "Incremental"
            parameters = {
              ddosname = {
                value = "[parameters('ddosname')]"
              }
              ddosregion = {
                value = "[parameters('ddosRegion')]"
              }
              rgName = {
                value = "[parameters('rgName')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                ddosRegion = {
                  type = "String"
                }
                ddosname = {
                  type = "String"
                }
                rgName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2018-05-01"
                location   = "[deployment().location]"
                name       = "[parameters('rgName')]"
                properties = {}
                type       = "Microsoft.Resources/resourceGroups"
                }, {
                apiVersion = "2018-05-01"
                dependsOn  = ["[resourceId('Microsoft.Resources/resourceGroups/', parameters('rgName'))]"]
                name       = "ddosprotection"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json"
                    contentVersion = "1.0.0.0"
                    outputs        = {}
                    parameters     = {}
                    resources = [{
                      apiVersion = "2019-12-01"
                      location   = "[parameters('ddosRegion')]"
                      name       = "[parameters('ddosName')]"
                      properties = {}
                      type       = "Microsoft.Network/ddosProtectionPlans"
                    }]
                  }
                }
                resourceGroup = "[parameters('rgName')]"
                type          = "Microsoft.Resources/deployments"
              }]
            }
          }
        }
        deploymentScope   = "subscription"
        existenceScope    = "resourceGroup"
        name              = "[parameters('ddosName')]"
        resourceGroupName = "[parameters('rgName')]"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"]
        type              = "Microsoft.Network/ddosProtectionPlans"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Subnet-Without-Penp"
resource "azurerm_policy_definition" "deny_subnet_without_penp" {
  description         = "This policy denies the creation of a subnet without Private Endpoint Netwotk Policies enabled. This policy is intended for 'workload' subnets, not 'central infrastructure' (aka, 'hub') subnets."
  display_name        = "Subnets without Private Endpoint Network Policies enabled should be denied"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:08:40.5497863Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Deny-Subnet-Without-Penp"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "The effect determines what happens when the policy rule is evaluated to match"
        displayName = "Effect"
      }
      type = "String"
    }
    excludedSubnets = {
      defaultValue = ["GatewaySubnet", "AzureFirewallSubnet", "AzureFirewallManagementSubnet", "AzureBastionSubnet"]
      metadata = {
        description = "Array of subnet names that are excluded from this policy"
        displayName = "Excluded Subnets"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks"
          field  = "type"
          }, {
          count = {
            field = "Microsoft.Network/virtualNetworks/subnets[*]"
            where = {
              allOf = [{
                field     = "Microsoft.Network/virtualNetworks/subnets[*].privateEndpointNetworkPolicies"
                notEquals = "Enabled"
                }, {
                field = "Microsoft.Network/virtualNetworks/subnets[*].name"
                notIn = "[parameters('excludedSubnets')]"
              }]
            }
          }
          notEquals = 0
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks/subnets"
          field  = "type"
          }, {
          field = "name"
          notIn = "[parameters('excludedSubnets')]"
          }, {
          field     = "Microsoft.Network/virtualNetworks/subnets/privateEndpointNetworkPolicies"
          notEquals = "Enabled"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-All-ComputeImages-Except"
resource "azurerm_policy_definition" "deny_all_computeimages_except" {
  description         = "This policy only allows the creation of VMs with images defined in the parameters."
  display_name        = "Deny creation of VMs with undefined images"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Compute"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:38:21.7200894Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Deny-All-ComputeImages-Except"
  parameters = jsonencode({
    imageOffer = {
      defaultValue = ["WindowsServer"]
      metadata = {
        description = "List of allowed image offer"
        displayName = "Allowed image offers"
      }
      type = "Array"
    }
    imagePublisher = {
      defaultValue = ["MicrosoftWindowsServer"]
      metadata = {
        description = "List of allowed image publisher"
        displayName = "Allowed image publisher"
      }
      type = "Array"
    }
    imageSku = {
      defaultValue = ["2012-R2-Datacenter"]
      metadata = {
        description = "List of allowed image SKUs"
        displayName = "Allowed image SKUs"
      }
      type = "Array"
    }
    imageVersion = {
      defaultValue = ["latest"]
      metadata = {
        description = "List of allowed image versions"
        displayName = "Allowed image versions"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        field = "type"
        in    = ["Microsoft.Compute/virtualMachines", "Microsoft.Compute/VirtualMachineScaleSets"]
        }, {
        not = {
          allOf = [{
            field = "Microsoft.Compute/imagePublisher"
            in    = "[parameters('imagePublisher')]"
            }, {
            field = "Microsoft.Compute/imageOffer"
            in    = "[parameters('imageOffer')]"
            }, {
            field = "Microsoft.Compute/imageSku"
            in    = "[parameters('imageSku')]"
            }, {
            field = "Microsoft.Compute/imageVersion"
            in    = "[parameters('imageVersion')]"
          }]
        }
      }]
    }
    then = {
      effect = "deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-ResourceGroup-Tag-Content-deny-list"
resource "azurerm_policy_definition" "require_resourcegroup_tag_content_deny_list" {
  description         = "This policy required that the defined tag does NOT contain a value from a given list. Deployment will be denied otherwise. This is used to prevent empty or blank values of some kind. ComparisonLogic 'notin'"
  display_name        = "Allow Tag with predefined list of values"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn = "2025-02-05T21:03:59.5411204Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Require-ResourceGroup-Tag-Content-deny-list"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the audit policy"
        displayName = "Effect"
      }
      type = "String"
    }
    listofdeniedtagValues = {
      defaultValue = ["", " ", "-", "0"]
      metadata = {
        description = "not allowed vaule(s) of tag"
        displayName = "denied Tag Values"
      }
      type = "Array"
    }
    tagName = {
      metadata = {
        description = "Name of the tag, such as 'environment'"
        displayName = "Tag Name"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions/resourceGroups"
        field  = "type"
        }, {
        not = {
          field = "[concat('tags[', parameters('tagName'), ']')]"
          notin = "[parameters('listofdeniedtagValues')]"
        }
        }, {
        field   = "name"
        notLike = "AzureBackupRG_*"
        }, {
        field     = "name"
        notEquals = "NetworkWatcherRG"
        }, {
        field   = "name"
        notLike = "cloud-shell-storage-*"
        }, {
        field   = "name"
        notLike = "DefaultResourceGroup*"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-PowerBIEmbedded"
resource "azurerm_policy_definition" "deploy_diagnostics_powerbiembedded" {
  description         = "Deploys the diagnostic settings for Power BI Embedded to stream to a Log Analytics workspace when any Power BI Embedded which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Power BI Embedded to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:39:58.5285218Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-PowerBIEmbedded"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.PowerBIDedicated/capacities"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Engine"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.PowerBIDedicated/capacities/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ACI"
resource "azurerm_policy_definition" "deploy_diagnostics_aci" {
  description         = "Deploys the diagnostic settings for Container Instances to stream to a Log Analytics workspace when any ACR which is missing this diagnostic settings is created or updated. The Policy willset the diagnostic with all metrics enabled."
  display_name        = "Deploy Diagnostic Settings for Container Instances to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:23:56.1633561Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-ACI"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.ContainerInstance/containerGroups"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = []
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.ContainerInstance/containerGroups/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-HDInsight"
resource "azurerm_policy_definition" "deploy_diagnostics_hdinsight" {
  description         = "Deploys the diagnostic settings for HDInsight to stream to a Log Analytics workspace when any HDInsight which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for HDInsight to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:29:43.6945602Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-HDInsight"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.HDInsight/clusters"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = []
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.HDInsight/clusters/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-RedisCache"
resource "azurerm_policy_definition" "deploy_diagnostics_rediscache" {
  description         = "Deploys the diagnostic settings for Redis Cache to stream to a Log Analytics workspace when any Redis Cache which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Redis Cache to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:38:21.8698595Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-RedisCache"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Cache/redis"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = []
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Cache/redis/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DataFactory"
resource "azurerm_policy_definition" "deploy_diagnostics_datafactory" {
  description         = "Deploys the diagnostic settings for Data Factory to stream to a Log Analytics workspace when any Data Factory which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Data Factory to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:34:32.1841625Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-DataFactory"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DataFactory/factories"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "ActivityRuns"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "PipelineRuns"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "TriggerRuns"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SSISPackageEventMessages"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SSISPackageExecutableStatistics"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SSISPackageEventMessageContext"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SSISPackageExecutionComponentPhases"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SSISPackageExecutionDataStatistics"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SSISIntegrationRuntimeLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SandboxPipelineRuns"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SandboxActivityRuns"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DataFactory/factories/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Nsg-FlowLogs-to-LA"
resource "azurerm_policy_definition" "deploy_nsg_flowlogs_to_la" {
  description         = "[Deprecated] Deprecated by built-in policy. Deploys NSG flow logs and traffic analytics to Log Analytics with a specified retention period. Superseded by https://www.azadvertizer.net/azpolicyadvertizer/e920df7f-9a64-4066-9b58-52684c02a091.html"
  display_name        = "[Deprecated] Deploys NSG flow logs and traffic analytics to Log Analytics"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:46:19.4193419Z"
    deprecated           = true
    source               = "https://github.com/Azure/Enterprise-Scale/"
    supersededBy         = "e920df7f-9a64-4066-9b58-52684c02a091"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:08:40.6225945Z"
    version              = "1.1.0-deprecated"
  })
  mode = "Indexed"
  name = "Deploy-Nsg-FlowLogs-to-LA"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    interval = {
      defaultValue = 60
      metadata = {
        displayName = "Traffic Analytics processing interval mins (10/60)"
      }
      type = "Integer"
    }
    retention = {
      defaultValue = 5
      metadata = {
        displayName = "Retention"
      }
      type = "Integer"
    }
    workspace = {
      defaultValue = "<workspace resource ID>"
      metadata = {
        description = "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID."
        displayName = "Resource ID of Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/networkSecurityGroups"
        field  = "type"
      }]
    }
    then = {
      details = {
        deployment = {
          location = "northeurope"
          properties = {
            mode = "Incremental"
            parameters = {
              interval = {
                value = "[parameters('interval')]"
              }
              location = {
                value = "[field('location')]"
              }
              networkSecurityGroup = {
                value = "[field('id')]"
              }
              retention = {
                value = "[parameters('retention')]"
              }
              workspace = {
                value = "[parameters('workspace')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                interval = {
                  type = "int"
                }
                location = {
                  type = "String"
                }
                networkSecurityGroup = {
                  type = "String"
                }
                retention = {
                  type = "int"
                }
                time = {
                  defaultValue = "[utcNow()]"
                  type         = "String"
                }
                workspace = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2019-10-01"
                name       = "[concat(variables('resourceGroupName'), '.', variables('securityGroupName'))]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    resources = [{
                      apiVersion = "2019-06-01"
                      kind       = "StorageV2"
                      location   = "[parameters('location')]"
                      name       = "[variables('storageAccountName')]"
                      properties = {}
                      sku = {
                        name = "Standard_LRS"
                        tier = "Standard"
                      }
                      type = "Microsoft.Storage/storageAccounts"
                    }]
                  }
                }
                resourceGroup = "[variables('resourceGroupName')]"
                type          = "Microsoft.Resources/deployments"
                }, {
                apiVersion = "2019-10-01"
                dependsOn  = ["[concat(variables('resourceGroupName'), '.', variables('securityGroupName'))]"]
                name       = "[concat('NetworkWatcherRG', '.', variables('securityGroupName'))]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    resources = [{
                      apiVersion = "2020-05-01"
                      location   = "[parameters('location')]"
                      name       = "[concat('NetworkWatcher_', toLower(parameters('location')))]"
                      properties = {}
                      resources = [{
                        apiVersion = "2019-11-01"
                        dependsOn  = ["[concat('NetworkWatcher_', toLower(parameters('location')))]"]
                        location   = "[parameters('location')]"
                        name       = "[concat(variables('securityGroupName'), '-Network-flowlog')]"
                        properties = {
                          enabled = true
                          flowAnalyticsConfiguration = {
                            networkWatcherFlowAnalyticsConfiguration = {
                              enabled                  = true
                              trafficAnalyticsInterval = "[parameters('interval')]"
                              workspaceResourceId      = "[parameters('workspace')]"
                            }
                          }
                          format = {
                            type    = "JSON"
                            version = 2
                          }
                          retentionPolicy = {
                            days    = "[parameters('retention')]"
                            enabled = true
                          }
                          storageId        = "[concat(subscription().id, '/resourceGroups/', variables('resourceGroupName'), '/providers/Microsoft.Storage/storageAccounts/', variables('storageAccountName'))]"
                          targetResourceId = "[parameters('networkSecurityGroup')]"
                        }
                        type = "flowLogs"
                      }]
                      type = "Microsoft.Network/networkWatchers"
                    }]
                  }
                }
                resourceGroup = "NetworkWatcherRG"
                type          = "Microsoft.Resources/deployments"
              }]
              variables = {
                resourceGroupName  = "[split(parameters('networkSecurityGroup'), '/')[4]]"
                securityGroupName  = "[split(parameters('networkSecurityGroup'), '/')[8]]"
                storageAccountName = "[concat('es', uniqueString(variables('securityGroupName'), parameters('time')))]"
              }
            }
          }
        }
        deploymentScope = "subscription"
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Network/networkWatchers/flowLogs/enabled"
          }]
        }
        existenceScope    = "resourceGroup"
        name              = "[if(empty(coalesce(field('Microsoft.Network/networkSecurityGroups/flowLogs[*].id'))), 'null/null', concat(split(first(field('Microsoft.Network/networkSecurityGroups/flowLogs[*].id')), '/')[8], '/', split(first(field('Microsoft.Network/networkSecurityGroups/flowLogs[*].id')), '/')[10]))]"
        resourceGroupName = "[if(empty(coalesce(field('Microsoft.Network/networkSecurityGroups/flowLogs'))), 'NetworkWatcherRG', split(first(field('Microsoft.Network/networkSecurityGroups/flowLogs[*].id')), '/')[4])]"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7", "/providers/Microsoft.Authorization/roleDefinitions/81a9662b-bebf-436f-a333-f67b29880f12", "/providers/Microsoft.Authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293", "/providers/Microsoft.Authorization/roleDefinitions/17d1049b-9a84-46fb-8f53-869881c3d3ab", "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.Network/networkWatchers/flowlogs"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridTopic"
resource "azurerm_policy_definition" "deploy_diagnostics_eventgridtopic" {
  description         = "Deploys the diagnostic settings for Event Grid Topic to stream to a Log Analytics workspace when any Event Grid Topic which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Event Grid Topic to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:44:45.0847279Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-EventGridTopic"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.EventGrid/topics"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "DeliveryFailures"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "PublishFailures"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DataPlaneRequests"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.EventGrid/topics/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Routes-NextHop-Internet"
resource "azurerm_policy_definition" "deny_routes_nexthop_internet" {
  description         = "Deny route with next hop type internet to ensure data loss prevention. Both creating routes as a standalone resource or nested within their parent resource route table are considered."
  display_name        = "Deny routes on route-tables with next hop internet"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:25:33.754597Z"
    updatedBy = null
    updatedOn = null
  })
  mode = "All"
  name = "Deny-Routes-NextHop-Internet"
  parameters = jsonencode({
    denyInternetRoute = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Should a direct route to Internet be denied? Allowed values are Audit, Deny and Disabled."
        displayName = "Deny Direct Internet Route"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/routeTables"
          field  = "type"
          }, {
          count = {
            field = "Microsoft.Network/routeTables/routes[*]"
            where = {
              equals = "Internet"
              field  = "Microsoft.Network/routeTables/routes[*].nextHopType"
            }
          }
          greater = 0
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/routeTables/routes"
          field  = "type"
          }, {
          equals = "Internet"
          field  = "Microsoft.Network/routeTables/routes/nextHopType"
        }]
      }]
    }
    then = {
      effect = "[parameters('denyInternetRoute')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-vulnerabilityAssessments_20230706"
resource "azurerm_policy_definition" "deploy_sql_vulnerabilityassessments_20230706" {
  description         = "Deploy SQL Database Vulnerability Assessments when it does not exist in the deployment, and save results to the storage account specified in the parameters."
  display_name        = "Deploy SQL Database Vulnerability Assessments"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:03:59.3377155Z"
    replacesPolicy       = "Deploy-Sql-vulnerabilityAssessments"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deploy-Sql-vulnerabilityAssessments_20230706"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    vulnerabilityAssessmentsEmail = {
      metadata = {
        description = "The email address(es) to send alerts."
        displayName = "The email address(es) to send alerts."
      }
      type = "Array"
    }
    vulnerabilityAssessmentsStorageID = {
      metadata = {
        description = "The storage account ID to store assessments"
        displayName = "The storage account ID to store assessments"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Sql/servers/databases"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              sqlServerDataBaseName = {
                value = "[field('name')]"
              }
              sqlServerName = {
                value = "[first(split(field('fullname'),'/'))]"
              }
              vulnerabilityAssessmentsEmail = {
                value = "[parameters('vulnerabilityAssessmentsEmail')]"
              }
              vulnerabilityAssessmentsStorageID = {
                value = "[parameters('vulnerabilityAssessmentsStorageID')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                sqlServerDataBaseName = {
                  type = "String"
                }
                sqlServerName = {
                  type = "String"
                }
                vulnerabilityAssessmentsEmail = {
                  type = "Array"
                }
                vulnerabilityAssessmentsStorageID = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-03-01-preview"
                name       = "[concat(parameters('sqlServerName'),'/',parameters('sqlServerDataBaseName'),'/default')]"
                properties = {
                  recurringScans = {
                    emailSubscriptionAdmins = false
                    emails                  = "[parameters('vulnerabilityAssessmentsEmail')]"
                    isEnabled               = true
                  }
                  storageAccountAccessKey = "[listkeys(parameters('vulnerabilityAssessmentsStorageID'), providers('Microsoft.Storage', 'storageAccounts').apiVersions[0]).keys[0].value]"
                  storageContainerPath    = "[concat('https://', last( split(parameters('vulnerabilityAssessmentsStorageID') ,  '/') ) , '.blob.core.windows.net/vulneraabilitylogs')]"
                }
                type = "Microsoft.Sql/servers/databases/vulnerabilityAssessments"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            count = {
              field = "Microsoft.Sql/servers/databases/vulnerabilityAssessments/recurringScans.emails[*]"
              where = {
                notIn = "[parameters('vulnerabilityAssessmentsEmail')]"
                value = "current(Microsoft.Sql/servers/databases/vulnerabilityAssessments/recurringScans.emails[*])"
              }
            }
            greater = 0
            }, {
            equals = true
            field  = "Microsoft.Sql/servers/databases/vulnerabilityAssessments/recurringScans.isEnabled"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/056cd41c-7e88-42e1-933e-88ba6a50c9c3", "/providers/Microsoft.Authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/Microsoft.Authorization/roleDefinitions/17d1049b-9a84-46fb-8f53-869881c3d3ab"]
        type              = "Microsoft.Sql/servers/databases/vulnerabilityAssessments"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ApiForFHIR"
resource "azurerm_policy_definition" "deploy_diagnostics_apiforfhir" {
  description         = "Deploys the diagnostic settings for Azure API for FHIR to stream to a Log Analytics workspace when any Azure API for FHIR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Azure API for FHIR to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:30:20.8188559Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-ApiForFHIR"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.HealthcareApis/services"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "AuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.HealthcareApis/services/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CognitiveServices"
resource "azurerm_policy_definition" "deploy_diagnostics_cognitiveservices" {
  description         = "Deploys the diagnostic settings for Cognitive Services to stream to a Log Analytics workspace when any Cognitive Services which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Cognitive Services to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:47:54.7985133Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-CognitiveServices"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.CognitiveServices/accounts"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Audit"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "RequestResponse"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Trace"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.CognitiveServices/accounts/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Website"
resource "azurerm_policy_definition" "deploy_diagnostics_website" {
  description         = "Deploys the diagnostic settings for Web App to stream to a Log Analytics workspace when any Web App which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for App Service to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.4535585Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-Website"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Web/sites"
        field  = "type"
        }, {
        notContains = "functionapp"
        value       = "[field('kind')]"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
              serverFarmId = {
                value = "[field('Microsoft.Web/sites/serverFarmId')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs = {
                policy = {
                  type  = "string"
                  value = "[concat(parameters('logAnalytics'), 'configured for diagnostic logs for ', ': ', parameters('resourceName'))]"
                }
              }
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
                serverFarmId = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = "[if(startsWith(reference(parameters('serverFarmId'), '2021-03-01', 'Full').sku.tier, 'Premium'), variables('logs').premiumTierLogs, variables('logs').otherTierLogs)]"
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Web/sites/providers/diagnosticSettings"
              }]
              variables = {
                logs = {
                  otherTierLogs = [{
                    category = "AppServiceHTTPLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceConsoleLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceAppLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceIPSecAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServicePlatformLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  premiumTierLogs = [{
                    category = "AppServiceAntivirusScanAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceHTTPLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceConsoleLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceAppLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceFileAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServiceIPSecAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AppServicePlatformLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                }
              }
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "[parameters('logsEnabled')]"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('metricsEnabled')]"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-TrafficManager"
resource "azurerm_policy_definition" "deploy_diagnostics_trafficmanager" {
  description         = "Deploys the diagnostic settings for Traffic Manager to stream to a Log Analytics workspace when any Traffic Manager which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Traffic Manager to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:30:20.8330699Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-TrafficManager"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/trafficManagerProfiles"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "ProbeHealthStatusEvents"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/trafficManagerProfiles/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Require-ResourceGroup-Tag-Content-require-string"
resource "azurerm_policy_definition" "require_resourcegroup_tag_content_require_string" {
  description         = "This policy required that the defined tag contains a string (can contain wildcards e.g. validate email address) in its value. Deployment will be denied otherwise. ComparisonLogic 'like'."
  display_name        = "Allow Tag with predefined string in value"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn = "2025-02-05T21:05:33.7860976Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Require-ResourceGroup-Tag-Content-require-string"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the audit policy"
        displayName = "Effect"
      }
      type = "String"
    }
    searchstring = {
      defaultValue = "*@domain.com"
      metadata = {
        description = "string to search in tag value"
        displayName = "Tag Values"
      }
      type = "String"
    }
    tagName = {
      metadata = {
        description = "Name of the tag, such as 'environment'"
        displayName = "Tag Name"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions/resourceGroups"
        field  = "type"
        }, {
        not = {
          field = "[concat('tags[', parameters('tagName'), ']')]"
          like  = "[parameters('searchstring')]"
        }
        }, {
        field   = "name"
        notLike = "AzureBackupRG_*"
        }, {
        field     = "name"
        notEquals = "NetworkWatcherRG"
        }, {
        field   = "name"
        notLike = "cloud-shell-storage-*"
        }, {
        field   = "name"
        notLike = "DefaultResourceGroup*"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ExpressRoute"
resource "azurerm_policy_definition" "deploy_diagnostics_expressroute" {
  description         = "Deploys the diagnostic settings for ExpressRoute to stream to a Log Analytics workspace when any ExpressRoute which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for ExpressRoute to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:46:19.3106064Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-ExpressRoute"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/expressRouteCircuits"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "PeeringRouteLog"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/expressRouteCircuits/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Databricks"
resource "azurerm_policy_definition" "deploy_diagnostics_databricks" {
  description         = "Deploys the diagnostic settings for Databricks to stream to a Log Analytics workspace when any Databricks which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Databricks to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:33:32.1291218Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.3.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-Databricks"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Databricks/workspaces"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "dbfs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "clusters"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "accounts"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "jobs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "notebook"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ssh"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "workspace"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "secrets"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "sqlPermissions"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "instancePools"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "sqlanalytics"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "genie"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "globalInitScripts"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "iamRole"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "mlflowExperiment"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "featureStore"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "RemoteHistoryService"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "mlflowAcledArtifact"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "databrickssql"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "deltaPipelines"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "modelRegistry"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "repos"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "unityCatalog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "gitCredentials"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "webTerminal"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "serverlessRealTimeInference"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "clusterLibraries"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "partnerHub"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "clamAVScan"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "capsule8Dataplane"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Databricks/workspaces/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SignalR"
resource "azurerm_policy_definition" "deploy_diagnostics_signalr" {
  description         = "Deploys the diagnostic settings for SignalR to stream to a Log Analytics workspace when any SignalR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for SignalR to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:36:42.7096129Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-SignalR"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.SignalRService/SignalR"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "AllLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.SignalRService/SignalR/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Append-AppService-latestTLS"
resource "azurerm_policy_definition" "append_appservice_latesttls" {
  description         = "Append the AppService sites object to ensure that min Tls version is set to required minimum TLS version. Please note Append does not enforce compliance use then deny."
  display_name        = "AppService append sites with minimum TLS version to enforce."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "App Service"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:35:08.1519213Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "All"
  name = "Append-AppService-latestTLS"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Append", "Disabled"]
      defaultValue  = "Append"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    minTlsVersion = {
      allowedValues = ["1.2", "1.0", "1.1"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version  minimum TLS version for a  Web App config to enforce"
        displayName = "Select version minimum TLS Web App config"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        exists = "true"
        field  = "Microsoft.Web/sites/config/minTlsVersion"
        }, {
        field     = "Microsoft.Web/sites/config/minTlsVersion"
        notEquals = "[parameters('minTlsVersion')]"
      }]
    }
    then = {
      details = [{
        field = "Microsoft.Web/sites/config/minTlsVersion"
        value = "[parameters('minTlsVersion')]"
      }]
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MachineLearning-Compute-VmSize"
resource "azurerm_policy_definition" "deny_machinelearning_compute_vmsize" {
  description         = "Limit allowed vm sizes for Azure Machine Learning compute clusters and compute instances."
  display_name        = "Limit allowed vm sizes for Azure Machine Learning compute clusters and compute instances"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Budget"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:35:08.2005282Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-MachineLearning-Compute-VmSize"
  parameters = jsonencode({
    allowedVmSizes = {
      defaultValue = ["Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2", "Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2", "Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2", "Standard_M8-2ms", "Standard_M8-4ms", "Standard_M8ms", "Standard_M16-4ms", "Standard_M16-8ms", "Standard_M16ms", "Standard_M32-8ms", "Standard_M32-16ms", "Standard_M32ls", "Standard_M32ms", "Standard_M32ts", "Standard_M64-16ms", "Standard_M64-32ms", "Standard_M64ls", "Standard_M64ms", "Standard_M64s", "Standard_M128-32ms", "Standard_M128-64ms", "Standard_M128ms", "Standard_M128s", "Standard_M64", "Standard_M64m", "Standard_M128", "Standard_M128m", "Standard_D1", "Standard_D2", "Standard_D3", "Standard_D4", "Standard_D11", "Standard_D12", "Standard_D13", "Standard_D14", "Standard_DS15_v2", "Standard_NV6", "Standard_NV12", "Standard_NV24", "Standard_F2s_v2", "Standard_F4s_v2", "Standard_F8s_v2", "Standard_F16s_v2", "Standard_F32s_v2", "Standard_F64s_v2", "Standard_F72s_v2", "Standard_NC6s_v3", "Standard_NC12s_v3", "Standard_NC24rs_v3", "Standard_NC24s_v3", "Standard_NC6", "Standard_NC12", "Standard_NC24", "Standard_NC24r", "Standard_ND6s", "Standard_ND12s", "Standard_ND24rs", "Standard_ND24s", "Standard_NC6s_v2", "Standard_NC12s_v2", "Standard_NC24rs_v2", "Standard_NC24s_v2", "Standard_ND40rs_v2", "Standard_NV12s_v3", "Standard_NV24s_v3", "Standard_NV48s_v3"]
      metadata = {
        description = "Specifies the allowed VM Sizes for Aml Compute Clusters and Instances"
        displayName = "Allowed VM Sizes for Aml Compute Clusters and Instances"
      }
      type = "Array"
    }
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces/computes"
        field  = "type"
        }, {
        field = "Microsoft.MachineLearningServices/workspaces/computes/computeType"
        in    = ["AmlCompute", "ComputeInstance"]
        }, {
        field = "Microsoft.MachineLearningServices/workspaces/computes/vmSize"
        notIn = "[parameters('allowedVmSizes')]"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Relay"
resource "azurerm_policy_definition" "deploy_diagnostics_relay" {
  description         = "Deploys the diagnostic settings for Relay to stream to a Log Analytics workspace when any Relay which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Relay to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:36:42.7048377Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-Relay"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Relay/namespaces"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "HybridConnectionsEvent"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Relay/namespaces/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDHostPools"
resource "azurerm_policy_definition" "deploy_diagnostics_wvdhostpools" {
  description         = "Deploys the diagnostic settings for AVD Host Pools to stream to a Log Analytics workspace when any Host Pools which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all and categorys enabled."
  display_name        = "Deploy Diagnostic Settings for AVD Host Pools to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:49:34.5533689Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.3.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-WVDHostPools"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DesktopVirtualization/hostpools"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Checkpoint"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Error"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Management"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Connection"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "HostRegistration"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AgentHealthStatus"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "NetworkData"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "SessionHostManagement"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ConnectionGraphicsData"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DesktopVirtualization/hostpools/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Modify-Routetable-Nexthop-VirtualAppliance"
resource "azurerm_policy_definition" "modify_routetable_nexthop_virtualappliance" {
  description         = "Adds route with address prefix 0.0.0.0/0 pointing to the virtual appliance in case there is none. Best combined with policy deny-route-nexthopvirtualappliance to ensure the correct IP address of the virtual appliance."
  display_name        = "Adds route with address prefix 0.0.0.0/0 pointing to the virtual appliance in case there is none."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Network"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:43:10.4227159Z"
    updatedBy = null
    updatedOn = null
  })
  mode = "All"
  name = "Modify-Routetable-Nexthop-VirtualAppliance"
  parameters = jsonencode({
    appendDefaultRoute = {
      allowedValues = ["Modify", "Disabled"]
      metadata = {
        description = "Enforce creation of the default route? Should be set to false for seured-vhub vWAN, true for any other setup."
        displayName = "Append Default Route"
      }
      type = "String"
    }
    routeTableSettings = {
      metadata = {
        description = "Location-specific settings for route tables."
        displayName = "Route Table Settings"
      }
      type = "Object"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/routeTables"
        field  = "type"
        }, {
        count = {
          field = "Microsoft.Network/routeTables/routes[*]"
          where = {
            equals = "0.0.0.0/0"
            field  = "Microsoft.Network/routeTables/routes[*].addressPrefix"
          }
        }
        equals = 0
      }]
    }
    then = {
      details = {
        conflictEffect = "audit"
        operations = [{
          field     = "Microsoft.Network/routeTables/routes[*]"
          operation = "add"
          value = {
            name = "default"
            properties = {
              addressPrefix    = "0.0.0.0/0"
              nextHopIpAddress = "[parameters('routeTableSettings')[field('location')].virtualApplianceIpAddress]"
              nextHopType      = "VirtualAppliance"
            }
          }
        }]
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"]
      }
      effect = "[parameters('appendDefaultRoute')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-SQL-minTLS"
resource "azurerm_policy_definition" "deploy_sql_mintls" {
  description         = "Deploys a specific min TLS version requirement and enforce SSL on SQL servers. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
  display_name        = "SQL servers deploys a specific min TLS version requirement."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:25:33.7922091Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:04:00.1273577Z"
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-SQL-minTLS"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy minimum TLS version SQL servers"
        displayName = "Effect SQL servers"
      }
      type = "String"
    }
    minimalTlsVersion = {
      allowedValues = ["1.2", "1.1", "1.0"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version minimum TLS version SQL servers to enforce"
        displayName = "Select version for SQL server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Sql/servers"
        field  = "type"
        }, {
        field     = "Microsoft.Sql/servers/minimalTlsVersion"
        notequals = "[parameters('minimalTlsVersion')]"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              minimalTlsVersion = {
                value = "[parameters('minimalTlsVersion')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                minimalTlsVersion = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2019-06-01-preview"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'))]"
                properties = {
                  minimalTlsVersion = "[parameters('minimalTlsVersion')]"
                }
                type = "Microsoft.Sql/servers"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "[parameters('minimalTlsVersion')]"
            field  = "Microsoft.Sql/servers/minimalTlsVersion"
          }]
        }
        name              = "current"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/6d8ee4ec-f05a-4a1d-8b00-a9b17e38b437"]
        type              = "Microsoft.Sql/servers"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Custom-Route-Table"
resource "azurerm_policy_definition" "deploy_custom_route_table" {
  description         = "Deploys a route table with specific user defined routes when one does not exist. The route table deployed by the policy must be manually associated to subnet(s)"
  display_name        = "Deploy a route table with specific user defined routes"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:28:44.3385917Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deploy-Custom-Route-Table"
  parameters = jsonencode({
    disableBgpPropagation = {
      defaultValue = false
      metadata = {
        description = "Disable BGP Propagation"
        displayName = "DisableBgpPropagation"
      }
      type = "Boolean"
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
    requiredRoutes = {
      metadata = {
        description = "Routes that must exist in compliant route tables deployed by this policy"
        displayName = "requiredRoutes"
      }
      type = "Array"
    }
    routeTableName = {
      metadata = {
        description = "Name of the route table automatically deployed by this policy"
        displayName = "routeTableName"
      }
      type = "String"
    }
    vnetRegion = {
      metadata = {
        description = "Only VNets in this region will be evaluated against this policy"
        displayName = "vnetRegion"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/virtualNetworks"
        field  = "type"
        }, {
        equals = "[parameters('vnetRegion')]"
        field  = "location"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              disableBgpPropagation = {
                value = "[parameters('disableBgpPropagation')]"
              }
              requiredRoutes = {
                value = "[parameters('requiredRoutes')]"
              }
              routeTableName = {
                value = "[parameters('routeTableName')]"
              }
              vnetRegion = {
                value = "[parameters('vnetRegion')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                disableBgpPropagation = {
                  type = "bool"
                }
                requiredRoutes = {
                  type = "array"
                }
                routeTableName = {
                  type = "string"
                }
                vnetRegion = {
                  type = "string"
                }
              }
              resources = [{
                apiVersion = "2021-04-01"
                name       = "routeTableDepl"
                properties = {
                  mode = "Incremental"
                  parameters = {
                    disableBgpPropagation = {
                      value = "[parameters('disableBgpPropagation')]"
                    }
                    requiredRoutes = {
                      value = "[parameters('requiredRoutes')]"
                    }
                    routeTableName = {
                      value = "[parameters('routeTableName')]"
                    }
                    vnetRegion = {
                      value = "[parameters('vnetRegion')]"
                    }
                  }
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    parameters = {
                      disableBgpPropagation = {
                        type = "bool"
                      }
                      requiredRoutes = {
                        type = "array"
                      }
                      routeTableName = {
                        type = "string"
                      }
                      vnetRegion = {
                        type = "string"
                      }
                    }
                    resources = [{
                      apiVersion = "2021-02-01"
                      location   = "[[parameters('vnetRegion')]"
                      name       = "[[parameters('routeTableName')]"
                      properties = {
                        copy                       = "[variables('copyLoop')]"
                        disableBgpRoutePropagation = "[[parameters('disableBgpPropagation')]"
                      }
                      type = "Microsoft.Network/routeTables"
                    }]
                  }
                }
                type = "Microsoft.Resources/deployments"
              }]
              variables = {
                copyLoop = [{
                  count = "[[length(parameters('requiredRoutes'))]"
                  input = {
                    name = "[[concat('route-',copyIndex('routes'))]"
                    properties = {
                      addressPrefix    = "[[split(parameters('requiredRoutes')[copyIndex('routes')], ';')[0]]"
                      nextHopIpAddress = "[[if(equals(toLower(split(parameters('requiredRoutes')[copyIndex('routes')], ';')[1]),'virtualappliance'),split(parameters('requiredRoutes')[copyIndex('routes')], ';')[2], null())]"
                      nextHopType      = "[[split(parameters('requiredRoutes')[copyIndex('routes')], ';')[1]]"
                    }
                  }
                  name = "routes"
                }]
              }
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "[parameters('routeTableName')]"
            field  = "name"
            }, {
            count = {
              field = "Microsoft.Network/routeTables/routes[*]"
              where = {
                in    = "[parameters('requiredRoutes')]"
                value = "[concat(current('Microsoft.Network/routeTables/routes[*].addressPrefix'), ';', current('Microsoft.Network/routeTables/routes[*].nextHopType'), if(equals(toLower(current('Microsoft.Network/routeTables/routes[*].nextHopType')),'virtualappliance'), concat(';', current('Microsoft.Network/routeTables/routes[*].nextHopIpAddress')), ''))]"
              }
            }
            equals = "[length(parameters('requiredRoutes'))]"
          }]
        }
        roleDefinitionIds = ["/subscriptions/e867a45d-e513-44ac-931e-4741cef80b24/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"]
        type              = "Microsoft.Network/routeTables"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/VirtualMachine-Backup-2000-14d"
resource "azurerm_policy_definition" "virtualmachine_backup_2000_14d" {
  description         = "This policy creates an Azure Recovery Services vault in the resource group when the first VM with supported OS is deployed. It creates a backup policy and assigns the VM to the backup policy schedule."
  display_name        = "Virtual Machine Backup Policy - Daily at 2000 - 14 days"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Backup"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:44:45.079881Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "VirtualMachine-Backup-2000-14d"
  parameters = jsonencode({
    dailyRetentionDurationCount = {
      defaultValue = 14
      metadata = {
        description = "daily: retention of daily backup points"
      }
      type = "Integer"
    }
    daysOfTheWeek = {
      defaultValue = ["Sunday"]
      metadata = {
        description = "daily: daily backup which should be kept as the weekly backup point"
      }
      type = "Array"
    }
    monthlyRetentionDurationCount = {
      defaultValue = 12
      metadata = {
        description = "monthly: Monthly backup retention"
      }
      type = "Integer"
    }
    monthsOfYear = {
      defaultValue = ["December"]
      metadata = {
        description = "yearly: monthly backup to keep as the yearly backup"
      }
      type = "Array"
    }
    policyName = {
      defaultValue = "vm-daily-2000-14d"
      metadata = {
        description = "name of the tag value to filter for, also name of the backup policy to deploy"
      }
      type = "String"
    }
    retentionScheduleDaily = {
      defaultValue = {
        daysOfTheMonth = [{
          date   = 0
          isLast = true
        }]
      }
      metadata = {
        description = "monthly: Default value keeps the last daily backup of the month. Only retentionScheduleDaily or retentionScheduleWeekly must be defined"
      }
      type = "Object"
    }
    scheduleRunTimes = {
      defaultValue = "20:00:00"
      metadata = {
        description = "runtime in format of hh:mm:ss"
      }
      type = "String"
    }
    timeZone = {
      defaultValue = "UTC"
      metadata = {
        description = "currently not used, replaced with timezoneselector-variable based on rg"
      }
      type = "String"
    }
    vaultSku = {
      defaultValue = "Standard"
      metadata = {
        description = "Standard or RS0 - currently only Standard (GRS) working, Microsoft limit"
      }
      type = "String"
    }
    vaultTags = {
      defaultValue = {
        description = "vault used by Azure policy af-dine-vm-backup-rg"
      }
      type = "Object"
    }
    vmBackupTagName = {
      defaultValue = "vm-backup-policy"
      metadata = {
        description = "the name of the tag key to filter virtual machines for"
      }
      type = "String"
    }
    weeklyRetentionDurationCount = {
      defaultValue = 4
      metadata = {
        description = "weekly: retention of the weekly backup point"
      }
      type = "Integer"
    }
    yearlyRetentionDurationCount = {
      defaultValue = 2
      metadata = {
        description = "yearly: Yearly backup retention"
      }
      type = "Integer"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Compute/virtualMachines"
        field  = "type"
        }, {
        equals = "[parameters('policyName')]"
        field  = "[concat('tags[', parameters('vmBackupTagName'), ']')]"
        }, {
        field   = "name"
        notLike = "*-test"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              dailyRetentionDurationCount = {
                value = "[parameters('dailyRetentionDurationCount')]"
              }
              daysOfTheWeek = {
                value = "[parameters('daysOfTheWeek')]"
              }
              monthlyRetentionDurationCount = {
                value = "[parameters('monthlyRetentionDurationCount')]"
              }
              monthsOfYear = {
                value = "[parameters('monthsOfYear')]"
              }
              policyName = {
                value = "[parameters('policyName')]"
              }
              retentionScheduleDaily = {
                value = "[parameters('retentionScheduleDaily')]"
              }
              scheduleRunTimes = {
                value = "[parameters('scheduleRunTimes')]"
              }
              timeZone = {
                value = "[parameters('timeZone')]"
              }
              vaultSku = {
                value = "[parameters('vaultSku')]"
              }
              vaultTags = {
                value = "[parameters('vaultTags')]"
              }
              vmName = {
                value = "[field('name')]"
              }
              vmResourceGroupLocation = {
                value = "[field('location')]"
              }
              vmResourceGroupName = {
                value = "[resourceGroup().name]"
              }
              weeklyRetentionDurationCount = {
                value = "[parameters('weeklyRetentionDurationCount')]"
              }
              yearlyRetentionDurationCount = {
                value = "[parameters('yearlyRetentionDurationCount')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              parameters = {
                dailyRetentionDurationCount = {
                  type = "int"
                }
                daysOfTheWeek = {
                  type = "array"
                }
                monthlyRetentionDurationCount = {
                  type = "int"
                }
                monthsOfYear = {
                  type = "array"
                }
                policyName = {
                  type = "string"
                }
                retentionScheduleDaily = {
                  type = "object"
                }
                scheduleRunTimes = {
                  type = "string"
                }
                timeZone = {
                  type = "string"
                }
                vaultSku = {
                  type = "string"
                }
                vaultTags = {
                  type = "object"
                }
                vmName = {
                  type = "string"
                }
                vmResourceGroupLocation = {
                  type = "string"
                }
                vmResourceGroupName = {
                  type = "string"
                }
                weeklyRetentionDurationCount = {
                  type = "int"
                }
                yearlyRetentionDurationCount = {
                  type = "int"
                }
              }
              resources = [{
                apiVersion = "2023-07-01"
                name       = "[concat(parameters('vmName'), '-backupIntent')]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    resources = [{
                      apiVersion = "2023-06-01"
                      location   = "[parameters('vmResourceGroupLocation')]"
                      name       = "[variables('BackupVaultName')]"
                      properties = {
                        publicNetworkAccess = "Enabled"
                        restoreSettings = {
                          crossSubscriptionRestoreSettings = {
                            crossSubscriptionRestoreState = "Enabled"
                          }
                        }
                      }
                      sku = {
                        name = "[parameters('vaultSku')]"
                      }
                      tags = "[parameters('vaultTags')]"
                      type = "Microsoft.RecoveryServices/vaults"
                      }, {
                      apiVersion = "2023-04-01"
                      dependsOn  = ["[variables('BackupVaultName')]"]
                      location   = "[parameters('vmResourceGroupLocation')]"
                      name       = "[concat(variables('BackupVaultName'), '/', variables('BackupPolicyName'))]"
                      properties = {
                        backupManagementType          = "AzureIaasVM"
                        instantRPDetails              = {}
                        instantRpRetentionRangeInDays = 5
                        policyType                    = "V2"
                        retentionPolicy = {
                          dailySchedule = {
                            retentionDuration = {
                              count        = "[int(parameters('dailyRetentionDurationCount'))]"
                              durationType = "Days"
                            }
                            retentionTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          retentionPolicyType = "LongTermRetentionPolicy"
                        }
                        schedulePolicy = {
                          dailySchedule = {
                            scheduleRunTimes = ["[concat('2021-01-01T', parameters('scheduleRunTimes'), 'Z')]"]
                          }
                          schedulePolicyType   = "SimpleSchedulePolicyV2"
                          scheduleRunFrequency = "Daily"
                        }
                        timeZone = "[parameters('timeZone')]"
                      }
                      tags = {}
                      type = "Microsoft.RecoveryServices/vaults/backupPolicies"
                      }, {
                      apiVersion = "2023-06-01"
                      dependsOn  = ["[variables('BackupPolicyName')]"]
                      name       = "[concat(variables('BackupVaultName'), variables('BackupIntentConcat'))]"
                      properties = {
                        policyId                 = "[concat(resourceId('Microsoft.RecoveryServices/vaults/backuppolicies', variables('BackupVaultName'), variables('BackupPolicyName')))]"
                        protectionIntentItemType = "AzureResourceItem"
                        sourceResourceId         = "[concat(resourceId('Microsoft.Compute/virtualMachines', parameters('vmName')))]"
                      }
                      type = "Microsoft.RecoveryServices/vaults/backupFabrics/backupProtectionIntent"
                    }]
                  }
                }
                resourceGroup = "[parameters('vmResourceGroupName')]"
                type          = "Microsoft.Resources/deployments"
              }]
              variables = {
                BackupIntentConcat = "[concat('/Azure/vm;iaasvmcontainerv2;', parameters('vmResourceGroupName'), ';', parameters('vmName'))]"
                BackupPolicyName   = "[concat('policy-',parameters('vmResourceGroupName'), '-', parameters('policyName'))]"
                BackupVaultName    = "[concat('rsv-', parameters('vmResourceGroupName'))]"
                timezoneMap = {
                  centralus = {
                    timezone = "Eastern Standard Time"
                  }
                  eastus2 = {
                    timezone = "Eastern Standard Time"
                  }
                  northeurope = {
                    timezone = "W. Europe Standard Time"
                  }
                  westeurope = {
                    timezone = "W. Europe Standard Time"
                  }
                }
                timezoneSelector = "[variables('timezoneMap')[parameters('vmResourceGroupLocation')].timezone]"
              }
            }
          }
        }
        existenceCondition = {
          allOf = [{
            field = "name"
            like  = "*"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.RecoveryServices/backupprotecteditems"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-StorageAccount-CustomDomain"
resource "azurerm_policy_definition" "deny_storageaccount_customdomain" {
  description         = "This policy denies the creation of Storage Accounts with custom domains assigned as communication cannot be encrypted, and always uses HTTP."
  display_name        = "Storage Accounts with custom domains assigned should be denied"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Storage"
    createdBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    createdOn            = "2025-02-05T21:05:33.4650675Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "All"
  name = "Deny-StorageAccount-CustomDomain"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "The effect determines what happens when the policy rule is evaluated to match"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Storage/storageAccounts"
        field  = "type"
        }, {
        anyOf = [{
          exists = "true"
          field  = "Microsoft.Storage/storageAccounts/customDomain"
          }, {
          equals = "true"
          field  = "Microsoft.Storage/storageAccounts/customDomain.useSubDomainName"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-AppGW-Without-WAF"
resource "azurerm_policy_definition" "deny_appgw_without_waf" {
  description         = "This policy enables you to restrict that Application Gateways is always deployed with WAF enabled"
  display_name        = "Application Gateway should be deployed with WAF enabled"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:47:19.7991865Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-AppGW-Without-WAF"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/applicationGateways"
        field  = "type"
        }, {
        field     = "Microsoft.Network/applicationGateways/sku.name"
        notequals = "WAF_v2"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-FrontDoor"
resource "azurerm_policy_definition" "deploy_diagnostics_frontdoor" {
  description         = "Deploys the diagnostic settings for Front Door to stream to a Log Analytics workspace when any Front Door which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Front Door to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:51:11.0936747Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-FrontDoor"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/frontDoors"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "FrontdoorAccessLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "FrontdoorWebApplicationFirewallLog"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/frontDoors/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-PostgreSql-http"
resource "azurerm_policy_definition" "deny_postgresql_http" {
  description         = "Azure Database for PostgreSQL supports connecting your Azure Database for PostgreSQL server to client applications using Secure Sockets Layer (SSL). Enforcing SSL connections between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
  display_name        = "PostgreSQL database servers enforce SSL connection."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:39:58.590619Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:07:06.2799297Z"
    version              = "1.0.1"
  })
  mode = "Indexed"
  name = "Deny-PostgreSql-http"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    minimalTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_0", "TLS1_1", "TLSEnforcementDisabled"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "Select version  minimum TLS version Azure Database for PostgreSQL server to enforce"
        displayName = "Select version minimum TLS for PostgreSQL server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.DBforPostgreSQL/servers"
        field  = "type"
        }, {
        anyOf = [{
          exists = "false"
          field  = "Microsoft.DBforPostgreSQL/servers/sslEnforcement"
          }, {
          field     = "Microsoft.DBforPostgreSQL/servers/sslEnforcement"
          notEquals = "Enabled"
          }, {
          field     = "Microsoft.DBforPostgreSQL/servers/minimalTlsVersion"
          notequals = "[parameters('minimalTlsVersion')]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AVDScalingPlans"
resource "azurerm_policy_definition" "deploy_diagnostics_avdscalingplans" {
  description         = "Deploys the diagnostic settings for AVD Scaling Plans to stream to a Log Analytics workspace when any Scaling Plan which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all and categorys enabled."
  display_name        = "Deploy Diagnostic Settings for AVD Scaling Plans to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:47:54.8897777Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-AVDScalingPlans"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DesktopVirtualization/scalingplans"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Autoscale"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DesktopVirtualization/scalingplans/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VNetGW"
resource "azurerm_policy_definition" "deploy_diagnostics_vnetgw" {
  description         = "Deploys the diagnostic settings for VPN Gateway to stream to a Log Analytics workspace when any VPN Gateway which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled."
  display_name        = "Deploy Diagnostic Settings for VPN Gateway to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:36:42.8000292Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.1"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-VNetGW"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/virtualNetworkGateways"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "GatewayDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "IKEDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "P2SDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "RouteDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "TunnelDiagnosticLog"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/virtualNetworkGateways/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VMSS"
resource "azurerm_policy_definition" "deploy_diagnostics_vmss" {
  description         = "Deploys the diagnostic settings for Virtual Machine Scale Sets  to stream to a Log Analytics workspace when any Virtual Machine Scale Sets  which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Virtual Machine Scale Sets to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:36:42.6518297Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-VMSS"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Compute/virtualMachineScaleSets"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = []
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Compute/virtualMachineScaleSets/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDAppGroup"
resource "azurerm_policy_definition" "deploy_diagnostics_wvdappgroup" {
  description         = "Deploys the diagnostic settings for AVD Application group to stream to a Log Analytics workspace when any application group which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all and categorys enabled."
  display_name        = "Deploy Diagnostic Settings for AVD Application group to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:49:34.3758458Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.1"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-WVDAppGroup"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DesktopVirtualization/applicationGroups"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Checkpoint"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Error"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Management"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DesktopVirtualization/applicationGroups/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-LogAnalytics"
resource "azurerm_policy_definition" "deploy_diagnostics_loganalytics" {
  description         = "Deploys the diagnostic settings for Log Analytics workspaces to stream to a Log Analytics workspace when any Log Analytics workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Log Analytics to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:28:44.1785207Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-LogAnalytics"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "microsoft.operationalinsights/workspaces"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Audit"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "microsoft.operationalinsights/workspaces/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AA"
resource "azurerm_policy_definition" "deploy_diagnostics_aa" {
  description         = "Deploys the diagnostic settings for Automation to stream to a Log Analytics workspace when any Automation which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Automation to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:50:34.4601303Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-AA"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Automation/automationAccounts"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "JobLogs"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "JobStreams"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "DscNodeStatus"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AuditEvent"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Automation/automationAccounts/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Bastion"
resource "azurerm_policy_definition" "deploy_diagnostics_bastion" {
  description         = "Deploys the diagnostic settings for Azure Bastion to stream to a Log Analytics workspace when any Azure Bastion which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Azure Bastion to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:46:19.4075473Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-Bastion"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/bastionHosts"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "BastionAuditLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/bastionHosts/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-ASC-SecurityContacts"
resource "azurerm_policy_definition" "deploy_asc_securitycontacts" {
  description         = "Deploy Microsoft Defender for Cloud Security Contacts"
  display_name        = "Deploy Microsoft Defender for Cloud Security Contacts"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Security Center"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:42:36.1122176Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "All"
  name = "Deploy-ASC-SecurityContacts"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "string"
    }
    emailSecurityContact = {
      metadata = {
        description = "Provide email address for Azure Security Center contact details"
        displayName = "Security contacts email address"
      }
      type = "string"
    }
    minimalSeverity = {
      allowedValues = ["High", "Medium", "Low"]
      defaultValue  = "High"
      metadata = {
        description = "Defines the minimal alert severity which will be sent as email notifications"
        displayName = "Minimal severity"
      }
      type = "string"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions"
        field  = "type"
      }]
    }
    then = {
      details = {
        deployment = {
          location = "northeurope"
          properties = {
            mode = "incremental"
            parameters = {
              emailSecurityContact = {
                value = "[parameters('emailSecurityContact')]"
              }
              minimalSeverity = {
                value = "[parameters('minimalSeverity')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                emailSecurityContact = {
                  metadata = {
                    description = "Security contacts email address"
                  }
                  type = "string"
                }
                minimalSeverity = {
                  metadata = {
                    description = "Minimal severity level reported"
                  }
                  type = "string"
                }
              }
              resources = [{
                apiVersion = "2020-01-01-preview"
                name       = "default"
                properties = {
                  alertNotifications = {
                    minimalSeverity = "[parameters('minimalSeverity')]"
                    state           = "On"
                  }
                  emails = "[parameters('emailSecurityContact')]"
                  notificationsByRole = {
                    roles = ["Owner"]
                    state = "On"
                  }
                }
                type = "Microsoft.Security/securityContacts"
              }]
              variables = {}
            }
          }
        }
        deploymentScope = "subscription"
        existenceCondition = {
          allOf = [{
            contains = "[parameters('emailSecurityContact')]"
            field    = "Microsoft.Security/securityContacts/email"
            }, {
            contains = "[parameters('minimalSeverity')]"
            field    = "Microsoft.Security/securityContacts/alertNotifications.minimalSeverity"
            }, {
            equals = "Microsoft.Security/securityContacts"
            field  = "type"
            }, {
            equals = "On"
            field  = "Microsoft.Security/securityContacts/alertNotifications"
            }, {
            equals = "On"
            field  = "Microsoft.Security/securityContacts/alertsToAdmins"
          }]
        }
        existenceScope    = "subscription"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/fb1c8493-542b-48eb-b624-b4c8fea62acd"]
        type              = "Microsoft.Security/securityContacts"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-vulnerabilityAssessments"
resource "azurerm_policy_definition" "deploy_sql_vulnerabilityassessments" {
  description         = "Deploy SQL Database vulnerability Assessments when it not exist in the deployment. Superseded by https://www.azadvertizer.net/azpolicyadvertizer/Deploy-Sql-vulnerabilityAssessments_20230706.html"
  display_name        = "[Deprecated]: Deploy SQL Database vulnerability Assessments"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.5565452Z"
    deprecated           = true
    source               = "https://github.com/Azure/Enterprise-Scale/"
    supersededBy         = "Deploy-Sql-vulnerabilityAssessments_20230706"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:07:06.2902181Z"
    version              = "1.0.1-deprecated"
  })
  mode = "Indexed"
  name = "Deploy-Sql-vulnerabilityAssessments"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    vulnerabilityAssessmentsEmail = {
      metadata = {
        description = "The email address to send alerts. For multiple emails, format in the following 'email1@contoso.com;email2@contoso.com'"
        displayName = "The email address to send alerts. For multiple emails, format in the following 'email1@contoso.com;email2@contoso.com'"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Sql/servers/databases"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              sqlServerDataBaseName = {
                value = "[field('name')]"
              }
              sqlServerName = {
                value = "[first(split(field('fullname'),'/'))]"
              }
              vulnerabilityAssessmentsEmail = {
                value = "[parameters('vulnerabilityAssessmentsEmail')]"
              }
              vulnerabilityAssessmentsStorageID = {
                value = "[parameters('vulnerabilityAssessmentsStorageID')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                sqlServerDataBaseName = {
                  type = "String"
                }
                sqlServerName = {
                  type = "String"
                }
                vulnerabilityAssessmentsEmail = {
                  type = "String"
                }
                vulnerabilityAssessmentsStorageID = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-03-01-preview"
                name       = "[concat(parameters('sqlServerName'),'/',parameters('sqlServerDataBaseName'),'/default')]"
                properties = {
                  recurringScans = {
                    emailSubscriptionAdmins = false
                    emails                  = ["[parameters('vulnerabilityAssessmentsEmail')]"]
                    isEnabled               = true
                  }
                  storageAccountAccessKey = "[listkeys(parameters('vulnerabilityAssessmentsStorageID'), providers('Microsoft.Storage', 'storageAccounts').apiVersions[0]).keys[0].value]"
                  storageContainerPath    = "[concat('https://', last( split(parameters('vulnerabilityAssessmentsStorageID') ,  '/') ) , '.blob.core.windows.net/vulneraabilitylogs')]"
                }
                type = "Microsoft.Sql/servers/databases/vulnerabilityAssessments"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "[parameters('vulnerabilityAssessmentsEmail')]"
            field  = "Microsoft.Sql/servers/databases/vulnerabilityAssessments/recurringScans.emails"
            }, {
            equals = true
            field  = "Microsoft.Sql/servers/databases/vulnerabilityAssessments/recurringScans.isEnabled"
          }]
        }
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/056cd41c-7e88-42e1-933e-88ba6a50c9c3", "/providers/Microsoft.Authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/Microsoft.Authorization/roleDefinitions/17d1049b-9a84-46fb-8f53-869881c3d3ab"]
        type              = "Microsoft.Sql/servers/databases/vulnerabilityAssessments"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Modify-ResourceGroup-Tags"
resource "azurerm_policy_definition" "modify_resourcegroup_tags" {
  description         = "Adds or replaces the specified tag and value from the parent resource group when any resource is created or updated. Existing resources can be remediated by triggering a remediation task."
  display_name        = "Inherit Resource Tags from Resource Group"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Tags"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:41:34.5298685Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "Indexed"
  name = "Modify-ResourceGroup-Tags"
  parameters = jsonencode({
    tagName = {
      metadata = {
        description = "Name of the tag, such as 'environment'"
        displayName = "Tag Name"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        field     = "[concat('tags[', parameters('tagName'), ']')]"
        notEquals = "[resourceGroup().tags[parameters('tagName')]]"
        }, {
        notEquals = ""
        value     = "[resourceGroup().tags[parameters('tagName')]]"
      }]
    }
    then = {
      details = {
        operations = [{
          field     = "[concat('tags[', parameters('tagName'), ']')]"
          operation = "addOrReplace"
          value     = "[resourceGroup().tags[parameters('tagName')]]"
        }]
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/4a9ae827-6dc8-4573-8ac7-8239d42aa03f"]
      }
      effect = "modify"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Vm-autoShutdown"
resource "azurerm_policy_definition" "deploy_vm_autoshutdown" {
  description         = "Deploys an auto shutdown schedule to a virtual machine"
  display_name        = "Deploy Virtual Machine Auto Shutdown Schedule"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Compute"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:49:34.4155126Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deploy-Vm-autoShutdown"
  parameters = jsonencode({
    EnableNotification = {
      allowedValues = ["Disabled", "Enabled"]
      defaultValue  = "Disabled"
      metadata = {
        description = "If notifications are enabled for this schedule (i.e. Enabled, Disabled)."
        displayName = "Send Notification before auto-shutdown"
      }
      type = "string"
    }
    NotificationEmailRecipient = {
      defaultValue = ""
      metadata = {
        description = "Email address to be used for notification"
        displayName = "Email Address"
      }
      type = "string"
    }
    NotificationWebhookUrl = {
      defaultValue = ""
      metadata = {
        description = "A notification will be posted to the specified webhook endpoint when the auto-shutdown is about to happen."
        displayName = "Webhook URL"
      }
      type = "string"
    }
    time = {
      defaultValue = "0000"
      metadata = {
        description = "Daily Scheduled shutdown time. i.e. 2300 = 11:00 PM"
        displayName = "Scheduled Shutdown Time"
      }
      type = "String"
    }
    timeZoneId = {
      defaultValue = "UTC"
      metadata = {
        description = "The time zone ID (e.g. Pacific Standard time)."
        displayName = "Time zone"
      }
      type = "string"
    }
  })
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Compute/virtualMachines"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "incremental"
            parameters = {
              EnableNotification = {
                value = "[parameters('EnableNotification')]"
              }
              NotificationEmailRecipient = {
                value = "[parameters('NotificationEmailRecipient')]"
              }
              NotificationWebhookUrl = {
                value = "[parameters('NotificationWebhookUrl')]"
              }
              location = {
                value = "[field('location')]"
              }
              time = {
                value = "[parameters('time')]"
              }
              timeZoneId = {
                value = "[parameters('timeZoneId')]"
              }
              vmName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                EnableNotification = {
                  defaultValue = ""
                  metadata = {
                    description = "If notifications are enabled for this schedule (i.e. Enabled, Disabled)."
                  }
                  type = "string"
                }
                NotificationEmailRecipient = {
                  defaultValue = ""
                  metadata = {
                    description = "Email address to be used for notification"
                  }
                  type = "string"
                }
                NotificationWebhookUrl = {
                  defaultValue = ""
                  metadata = {
                    description = "A notification will be posted to the specified webhook endpoint when the auto-shutdown is about to happen."
                  }
                  type = "string"
                }
                location = {
                  type = "string"
                }
                time = {
                  defaultValue = ""
                  metadata = {
                    description = "Daily Scheduled shutdown time. i.e. 2300 = 11:00 PM"
                  }
                  type = "string"
                }
                timeZoneId = {
                  defaultValue = ""
                  metadata = {
                    description = "The time zone ID (e.g. Pacific Standard time)."
                  }
                  type = "string"
                }
                vmName = {
                  type = "string"
                }
              }
              resources = [{
                apiVersion = "2018-09-15"
                location   = "[parameters('location')]"
                name       = "[concat('shutdown-computevm-',parameters('vmName'))]"
                properties = {
                  dailyRecurrence = {
                    time = "[parameters('time')]"
                  }
                  notificationSettings = {
                    emailRecipient     = "[parameters('NotificationEmailRecipient')]"
                    notificationLocale = "en"
                    status             = "[parameters('EnableNotification')]"
                    timeInMinutes      = 30
                    webhookUrl         = "[parameters('NotificationWebhookUrl')]"
                  }
                  status           = "Enabled"
                  targetResourceId = "[resourceId('Microsoft.Compute/virtualMachines', parameters('vmName'))]"
                  taskType         = "ComputeVmShutdownTask"
                  timeZoneId       = "[parameters('timeZoneId')]"
                }
                type = "Microsoft.DevTestLab/schedules"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "ComputeVmShutdownTask"
            field  = "Microsoft.DevTestLab/schedules/taskType"
            }, {
            equals = "[concat(resourceGroup().id,'/providers/Microsoft.Compute/virtualMachines/',field('name'))]"
            field  = "Microsoft.DevTestLab/schedules/targetResourceId"
          }]
        }
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c"]
        type              = "Microsoft.DevTestLab/schedules"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MediaService"
resource "azurerm_policy_definition" "deploy_diagnostics_mediaservice" {
  description         = "Deploys the diagnostic settings for Azure Media Service to stream to a Log Analytics workspace when any Azure Media Service which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Azure Media Service to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:25:33.7526182Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-MediaService"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Media/mediaServices"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "KeyDeliveryRequests"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Media/mediaServices/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Privilege-Elevation"
resource "azurerm_policy_definition" "deny_privilege_elevation" {
  description         = "This policy denies the possibility to creating Role Assignment using Owner or User Access Administrator privileges."
  display_name        = "Deny Privileged Permission Assignments"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "General"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:43:10.1479647Z"
    updatedBy = null
    updatedOn = null
    version   = "1.0.0"
  })
  mode = "All"
  name = "Deny-Privilege-Elevation"
  parameters = jsonencode({
    deniedRoleIds = {
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Authorization/roleAssignments"
        field  = "type"
        }, {
        field = "Microsoft.Authorization/roleAssignments/roleDefinitionId"
        in    = "[parameters('deniedRoleIds')]"
      }]
    }
    then = {
      effect = "Deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Subnet-Without-Udr"
resource "azurerm_policy_definition" "deny_subnet_without_udr" {
  description         = "This policy denies the creation of a subnet without a User Defined Route (UDR)."
  display_name        = "Subnets should have a User Defined Route"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:23:56.0226726Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "2.0.0"
  })
  mode = "All"
  name = "Deny-Subnet-Without-Udr"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    excludedSubnets = {
      defaultValue = ["AzureBastionSubnet"]
      metadata = {
        description = "Array of subnet names that are excluded from this policy"
        displayName = "Excluded Subnets"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks"
          field  = "type"
          }, {
          count = {
            field = "Microsoft.Network/virtualNetworks/subnets[*]"
            where = {
              allOf = [{
                exists = "false"
                field  = "Microsoft.Network/virtualNetworks/subnets[*].routeTable.id"
                }, {
                field = "Microsoft.Network/virtualNetworks/subnets[*].name"
                notIn = "[parameters('excludedSubnets')]"
              }]
            }
          }
          notEquals = 0
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/virtualNetworks/subnets"
          field  = "type"
          }, {
          field = "name"
          notIn = "[parameters('excludedSubnets')]"
          }, {
          exists = "false"
          field  = "Microsoft.Network/virtualNetworks/subnets/routeTable.id"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Firewall"
resource "azurerm_policy_definition" "deploy_diagnostics_firewall" {
  description         = "Deploys the diagnostic settings for Firewall to stream to a Log Analytics workspace when any Firewall which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Firewall to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:45:45.5122625Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-Firewall"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logAnalyticsDestinationType = {
      allowedValues = ["AzureDiagnostics", "Dedicated"]
      defaultValue  = "AzureDiagnostics"
      metadata = {
        description = "Select destination type for Log Analytics. Allowed values are 'Dedicated' (resource specific) and 'AzureDiagnostics'. Default is 'AzureDiagnostics'"
        displayName = "Log Analytics destination type"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/azureFirewalls"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logAnalyticsDestinationType = {
                value = "[parameters('logAnalyticsDestinationType')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logAnalyticsDestinationType = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logAnalyticsDestinationType = "[parameters('logAnalyticsDestinationType')]"
                  logs = [{
                    category = "AzureFirewallApplicationRule"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AzureFirewallNetworkRule"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AzureFirewallDnsProxy"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWNetworkRule"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWApplicationRule"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWNatRule"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWThreatIntel"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWIdpsSignature"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWDnsQuery"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWFqdnResolveFailure"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWApplicationRuleAggregation"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWNetworkRuleAggregation"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWNatRuleAggregation"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWFatFlow"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "AZFWFlowTrace"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/azureFirewalls/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MySql-http"
resource "azurerm_policy_definition" "deny_mysql_http" {
  description         = "Azure Database for MySQL supports connecting your Azure Database for MySQL server to client applications using Secure Sockets Layer (SSL). Enforcing SSL connections between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
  display_name        = "MySQL database servers enforce SSL connections."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:44:45.1066984Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-MySql-http"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    minimalTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_0", "TLS1_1", "TLSEnforcementDisabled"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "Select version  minimum TLS version Azure Database for MySQL server to enforce"
        displayName = "Select version minimum TLS for MySQL server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.DBforMySQL/servers"
        field  = "type"
        }, {
        anyOf = [{
          exists = "false"
          field  = "Microsoft.DBforMySQL/servers/sslEnforcement"
          }, {
          field     = "Microsoft.DBforMySQL/servers/sslEnforcement"
          notEquals = "Enabled"
          }, {
          field     = "Microsoft.DBforMySQL/servers/minimalTlsVersion"
          notequals = "[parameters('minimalTlsVersion')]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Audit-PrivateLinkDnsZones"
resource "azurerm_policy_definition" "audit_privatelinkdnszones" {
  description         = "This policy audits the creation of a Private Link Private DNS Zones in the current scope, used in combination with policies that create centralized private DNS in connectivity subscription"
  display_name        = "Audit the creation of Private Link Private DNS Zones"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:39:58.5397111Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:07:06.3004201Z"
    version              = "1.0.1"
  })
  mode = "Indexed"
  name = "Audit-PrivateLinkDnsZones"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    privateLinkDnsZones = {
      defaultValue = ["privatelink.adf.azure.com", "privatelink.afs.azure.net", "privatelink.agentsvc.azure-automation.net", "privatelink.analysis.windows.net", "privatelink.api.azureml.ms", "privatelink.azconfig.io", "privatelink.azure-api.net", "privatelink.azure-automation.net", "privatelink.azurecr.io", "privatelink.azure-devices.net", "privatelink.azure-devices-provisioning.net", "privatelink.azuredatabricks.net", "privatelink.azurehdinsight.net", "privatelink.azurehealthcareapis.com", "privatelink.azurestaticapps.net", "privatelink.azuresynapse.net", "privatelink.azurewebsites.net", "privatelink.batch.azure.com", "privatelink.blob.core.windows.net", "privatelink.cassandra.cosmos.azure.com", "privatelink.cognitiveservices.azure.com", "privatelink.database.windows.net", "privatelink.datafactory.azure.net", "privatelink.dev.azuresynapse.net", "privatelink.dfs.core.windows.net", "privatelink.dicom.azurehealthcareapis.com", "privatelink.digitaltwins.azure.net", "privatelink.directline.botframework.com", "privatelink.documents.azure.com", "privatelink.eventgrid.azure.net", "privatelink.file.core.windows.net", "privatelink.gremlin.cosmos.azure.com", "privatelink.guestconfiguration.azure.com", "privatelink.his.arc.azure.com", "privatelink.kubernetesconfiguration.azure.com", "privatelink.managedhsm.azure.net", "privatelink.mariadb.database.azure.com", "privatelink.media.azure.net", "privatelink.mongo.cosmos.azure.com", "privatelink.monitor.azure.com", "privatelink.mysql.database.azure.com", "privatelink.notebooks.azure.net", "privatelink.ods.opinsights.azure.com", "privatelink.oms.opinsights.azure.com", "privatelink.pbidedicated.windows.net", "privatelink.postgres.database.azure.com", "privatelink.prod.migration.windowsazure.com", "privatelink.purview.azure.com", "privatelink.purviewstudio.azure.com", "privatelink.queue.core.windows.net", "privatelink.redis.cache.windows.net", "privatelink.redisenterprise.cache.azure.net", "privatelink.search.windows.net", "privatelink.service.signalr.net", "privatelink.servicebus.windows.net", "privatelink.siterecovery.windowsazure.com", "privatelink.sql.azuresynapse.net", "privatelink.table.core.windows.net", "privatelink.table.cosmos.azure.com", "privatelink.tip1.powerquery.microsoft.com", "privatelink.token.botframework.com", "privatelink.vaultcore.azure.net", "privatelink.web.core.windows.net", "privatelink.webpubsub.azure.com"]
      metadata = {
        description = "An array of Private Link Private DNS Zones to check for the existence of in the assigned scope."
        displayName = "Private Link Private DNS Zones"
      }
      type = "Array"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Network/privateDnsZones"
        field  = "type"
        }, {
        field = "name"
        in    = "[parameters('privateLinkDnsZones')]"
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-NIC"
resource "azurerm_policy_definition" "deploy_diagnostics_nic" {
  description         = "Deploys the diagnostic settings for Network Interfaces to stream to a Log Analytics workspace when any Network Interfaces which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Network Interfaces to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:47:54.5506283Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-NIC"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/networkInterfaces"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/networkInterfaces/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DataExplorerCluster"
resource "azurerm_policy_definition" "deploy_diagnostics_dataexplorercluster" {
  description         = "Deploys the diagnostic settings for Azure Data Explorer Cluster to stream to a Log Analytics workspace when any Azure Data Explorer Cluster which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Azure Data Explorer Cluster to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:26:33.3439217Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-DataExplorerCluster"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Kusto/Clusters"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "SucceededIngestion"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "FailedIngestion"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "IngestionBatching"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Command"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Query"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "TableUsageStatistics"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "TableDetails"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Kusto/Clusters/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-LoadBalancer"
resource "azurerm_policy_definition" "deploy_diagnostics_loadbalancer" {
  description         = "Deploys the diagnostic settings for Load Balancer to stream to a Log Analytics workspace when any Load Balancer which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Load Balancer to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:38:21.8988276Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-LoadBalancer"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/loadBalancers"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "LoadBalancerAlertEvent"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "LoadBalancerProbeHealthStatus"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Network/loadBalancers/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MachineLearning-Aks"
resource "azurerm_policy_definition" "deny_machinelearning_aks" {
  description         = "Deny AKS cluster creation in Azure Machine Learning and enforce connecting to existing clusters."
  display_name        = "Deny AKS cluster creation in Azure Machine Learning"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Machine Learning"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:35:08.2750788Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-MachineLearning-Aks"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces/computes"
        field  = "type"
        }, {
        equals = "AKS"
        field  = "Microsoft.MachineLearningServices/workspaces/computes/computeType"
        }, {
        anyOf = [{
          exists = false
          field  = "Microsoft.MachineLearningServices/workspaces/computes/resourceId"
          }, {
          equals = true
          value  = "[empty(field('Microsoft.MachineLearningServices/workspaces/computes/resourceId'))]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Storage-minTLS"
resource "azurerm_policy_definition" "deny_storage_mintls" {
  description         = "Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking"
  display_name        = "Storage Account set to minimum TLS and Secure transfer should be enabled"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Storage"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:46:19.4041106Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-Storage-minTLS"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "The effect determines what happens when the policy rule is evaluated to match"
        displayName = "Effect"
      }
      type = "String"
    }
    minimumTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_1", "TLS1_0"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "Select version  minimum TLS version on Azure Storage Account to enforce"
        displayName = "Storage Account select minimum TLS version"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Storage/storageAccounts"
        field  = "type"
        }, {
        anyOf = [{
          allOf = [{
            less  = "2019-04-01"
            value = "[requestContext().apiVersion]"
            }, {
            exists = "false"
            field  = "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly"
          }]
          }, {
          equals = "false"
          field  = "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly"
          }, {
          field     = "Microsoft.Storage/storageAccounts/minimumTlsVersion"
          notequals = "[parameters('minimumTlsVersion')]"
          }, {
          exists = "false"
          field  = "Microsoft.Storage/storageAccounts/minimumTlsVersion"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-SqlMi-minTLS"
resource "azurerm_policy_definition" "deploy_sqlmi_mintls" {
  description         = "Deploy a specific min TLS version requirement and enforce SSL on SQL managed instances. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
  display_name        = "SQL managed instances deploy a specific min TLS version requirement."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:33:32.3722545Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:03:59.4230675Z"
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-SqlMi-minTLS"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy minimum TLS version SQL servers"
        displayName = "Effect SQL servers"
      }
      type = "String"
    }
    minimalTlsVersion = {
      allowedValues = ["1.2", "1.1", "1.0"]
      defaultValue  = "1.2"
      metadata = {
        description = "Select version minimum TLS version SQL servers to enforce"
        displayName = "Select version for SQL server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Sql/managedInstances"
        field  = "type"
        }, {
        field     = "Microsoft.Sql/managedInstances/minimalTlsVersion"
        notequals = "[parameters('minimalTlsVersion')]"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              minimalTlsVersion = {
                value = "[parameters('minimalTlsVersion')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                minimalTlsVersion = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2020-02-02-preview"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'))]"
                properties = {
                  minimalTlsVersion = "[parameters('minimalTlsVersion')]"
                }
                type = "Microsoft.Sql/managedInstances"
              }]
              variables = {}
            }
          }
        }
        evaluationDelay = "AfterProvisioningSuccess"
        existenceCondition = {
          allOf = [{
            equals = "[parameters('minimalTlsVersion')]"
            field  = "Microsoft.Sql/managedInstances/minimalTlsVersion"
          }]
        }
        name              = "current"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/4939a1f6-9ae0-4e48-a1e0-f2cbe897382d"]
        type              = "Microsoft.Sql/managedInstances"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-MySQL-sslEnforcement"
resource "azurerm_policy_definition" "deploy_mysql_sslenforcement" {
  description         = "Deploy a specific min TLS version requirement and enforce SSL on Azure Database for MySQL server. Enforce the Server to client applications using minimum version of Tls to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server."
  display_name        = "Azure Database for MySQL server deploy a specific min TLS version and enforce SSL."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "SQL"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:27:08.0669055Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:07:06.2138717Z"
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-MySQL-sslEnforcement"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy minimum TLS version Azure Database for MySQL server"
        displayName = "Effect minimum TLS version Azure Database for MySQL server"
      }
      type = "String"
    }
    minimalTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_0", "TLS1_1", "TLSEnforcementDisabled"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "Select version  minimum TLS version Azure Database for MySQL server to enforce"
        displayName = "Select version minimum TLS for MySQL server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.DBforMySQL/servers"
        field  = "type"
        }, {
        anyOf = [{
          field     = "Microsoft.DBforMySQL/servers/sslEnforcement"
          notEquals = "Enabled"
          }, {
          field     = "Microsoft.DBforMySQL/servers/minimalTlsVersion"
          notequals = "[parameters('minimalTlsVersion')]"
        }]
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              minimalTlsVersion = {
                value = "[parameters('minimalTlsVersion')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                minimalTlsVersion = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-12-01"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'))]"
                properties = {
                  minimalTlsVersion = "[parameters('minimalTlsVersion')]"
                  sslEnforcement    = "[if(equals(parameters('minimalTlsVersion'), 'TLSEnforcementDisabled'),'Disabled', 'Enabled')]"
                }
                type = "Microsoft.DBforMySQL/servers"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "Enabled"
            field  = "Microsoft.DBforMySQL/servers/sslEnforcement"
            }, {
            equals = "[parameters('minimalTlsVersion')]"
            field  = "Microsoft.DBforMySQL/servers/minimalTlsVersion"
          }]
        }
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.DBforMySQL/servers"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-VNET-HubSpoke"
resource "azurerm_policy_definition" "deploy_vnet_hubspoke" {
  description         = "This policy deploys virtual network and peer to the hub"
  display_name        = "Deploy Virtual Network with peering to the hub"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.4232928Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "All"
  name = "Deploy-VNET-HubSpoke"
  parameters = jsonencode({
    dnsServers = {
      defaultValue = []
      metadata = {
        description = "Default domain servers for the vNET."
        displayName = "DNSServers"
      }
      type = "Array"
    }
    hubResourceId = {
      metadata = {
        description = "Resource ID for the HUB vNet"
        displayName = "hubResourceId"
      }
      type = "String"
    }
    vNetCidrRange = {
      metadata = {
        description = "CIDR Range for the vNet"
        displayName = "vNetCidrRange"
      }
      type = "String"
    }
    vNetLocation = {
      metadata = {
        description = "Location for the vNet"
        displayName = "vNetLocation"
      }
      type = "String"
    }
    vNetName = {
      metadata = {
        description = "Name of the landing zone vNet"
        displayName = "vNetName"
      }
      type = "String"
    }
    vNetPeerUseRemoteGateway = {
      defaultValue = false
      metadata = {
        description = "Enable gateway transit for the LZ network"
        displayName = "vNetPeerUseRemoteGateway"
      }
      type = "Boolean"
    }
    vNetRgName = {
      metadata = {
        description = "Name of the landing zone vNet RG"
        displayName = "vNetRgName"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Resources/subscriptions"
        field  = "type"
      }]
    }
    then = {
      details = {
        ResourceGroupName = "[parameters('vNetRgName')]"
        deployment = {
          location = "northeurope"
          properties = {
            mode = "Incremental"
            parameters = {
              dnsServers = {
                value = "[parameters('dnsServers')]"
              }
              hubResourceId = {
                value = "[parameters('hubResourceId')]"
              }
              vNetCidrRange = {
                value = "[parameters('vNetCidrRange')]"
              }
              vNetLocation = {
                value = "[parameters('vNetLocation')]"
              }
              vNetName = {
                value = "[parameters('vNetName')]"
              }
              vNetPeerUseRemoteGateway = {
                value = "[parameters('vNetPeerUseRemoteGateway')]"
              }
              vNetRgName = {
                value = "[parameters('vNetRgName')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                dnsServers = {
                  defaultValue = []
                  type         = "Array"
                }
                hubResourceId = {
                  type = "String"
                }
                vNetCidrRange = {
                  type = "String"
                }
                vNetLocation = {
                  type = "String"
                }
                vNetName = {
                  type = "String"
                }
                vNetPeerUseRemoteGateway = {
                  defaultValue = false
                  type         = "bool"
                }
                vNetRgName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2021-04-01"
                dependsOn  = []
                location   = "[parameters('vNetLocation')]"
                name       = "[concat('alz-vnet-rg-', parameters('vNetLocation'), '-', substring(uniqueString(subscription().id),0,6))]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    outputs        = {}
                    parameters     = {}
                    resources = [{
                      apiVersion = "2021-04-01"
                      location   = "[parameters('vNetLocation')]"
                      name       = "[parameters('vNetRgName')]"
                      properties = {}
                      type       = "Microsoft.Resources/resourceGroups"
                    }]
                    variables = {}
                  }
                }
                type = "Microsoft.Resources/deployments"
                }, {
                apiVersion = "2021-04-01"
                dependsOn  = ["[concat('alz-vnet-rg-', parameters('vNetLocation'), '-', substring(uniqueString(subscription().id),0,6))]"]
                name       = "[concat('alz-vnet-', parameters('vNetLocation'), '-', substring(uniqueString(subscription().id),0,6))]"
                properties = {
                  mode = "Incremental"
                  template = {
                    "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
                    contentVersion = "1.0.0.0"
                    outputs        = {}
                    parameters     = {}
                    resources = [{
                      apiVersion = "2021-02-01"
                      dependsOn  = []
                      location   = "[parameters('vNetLocation')]"
                      name       = "[parameters('vNetName')]"
                      properties = {
                        addressSpace = {
                          addressPrefixes = ["[parameters('vNetCidrRange')]"]
                        }
                        dhcpOptions = {
                          dnsServers = "[parameters('dnsServers')]"
                        }
                      }
                      type = "Microsoft.Network/virtualNetworks"
                      }, {
                      apiVersion = "2021-02-01"
                      dependsOn  = ["[parameters('vNetName')]"]
                      name       = "[concat(parameters('vNetName'), '/peerToHub')]"
                      properties = {
                        allowForwardedTraffic     = true
                        allowGatewayTransit       = false
                        allowVirtualNetworkAccess = true
                        remoteVirtualNetwork = {
                          id = "[parameters('hubResourceId')]"
                        }
                        useRemoteGateways = "[parameters('vNetPeerUseRemoteGateway')]"
                      }
                      type = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings"
                      }, {
                      apiVersion = "2021-04-01"
                      dependsOn  = ["[parameters('vNetName')]"]
                      name       = "[concat('alz-hub-peering-', parameters('vNetLocation'), '-', substring(uniqueString(subscription().id),0,6))]"
                      properties = {
                        expressionEvaluationOptions = {
                          scope = "inner"
                        }
                        mode = "Incremental"
                        parameters = {
                          hubName = {
                            value = "[split(parameters('hubResourceId'),'/')[8]]"
                          }
                          remoteVirtualNetwork = {
                            value = "[concat(subscription().id,'/resourceGroups/',parameters('vNetRgName'), '/providers/','Microsoft.Network/virtualNetworks/', parameters('vNetName'))]"
                          }
                        }
                        template = {
                          "$schema"      = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
                          contentVersion = "1.0.0.0"
                          outputs        = {}
                          parameters = {
                            hubName = {
                              defaultValue = false
                              type         = "String"
                            }
                            remoteVirtualNetwork = {
                              defaultValue = false
                              type         = "String"
                            }
                          }
                          resources = [{
                            apiVersion = "2021-02-01"
                            name       = "[[concat(parameters('hubName'),'/',last(split(parameters('remoteVirtualNetwork'),'/')))]"
                            properties = {
                              allowForwardedTraffic     = true
                              allowGatewayTransit       = true
                              allowVirtualNetworkAccess = true
                              remoteVirtualNetwork = {
                                id = "[[parameters('remoteVirtualNetwork')]"
                              }
                              useRemoteGateways = false
                            }
                            type = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings"
                          }]
                          variables = {}
                        }
                      }
                      resourceGroup  = "[split(parameters('hubResourceId'),'/')[4]]"
                      subscriptionId = "[split(parameters('hubResourceId'),'/')[2]]"
                      type           = "Microsoft.Resources/deployments"
                    }]
                    variables = {}
                  }
                }
                resourceGroup = "[parameters('vNetRgName')]"
                type          = "Microsoft.Resources/deployments"
              }]
              variables = {}
            }
          }
        }
        deploymentScope = "subscription"
        existenceCondition = {
          allOf = [{
            field = "name"
            like  = "[parameters('vNetName')]"
            }, {
            equals = "[parameters('vNetLocation')]"
            field  = "location"
          }]
        }
        existenceScope    = "resourceGroup"
        name              = "[parameters('vNetName')]"
        roleDefinitionIds = ["/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"]
        type              = "Microsoft.Network/virtualNetworks"
      }
      effect = "deployIfNotExists"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Function"
resource "azurerm_policy_definition" "deploy_diagnostics_function" {
  description         = "Deploys the diagnostic settings for Azure Function App to stream to a Log Analytics workspace when any function app which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Azure Function App to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:33:32.1810817Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-Function"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Web/sites"
        field  = "type"
        }, {
        contains = "functionapp"
        value    = "[field('kind')]"
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "FunctionAppLogs"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Web/sites/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Storage-sslEnforcement"
resource "azurerm_policy_definition" "deploy_storage_sslenforcement" {
  description         = "Deploy a specific min TLS version requirement and enforce SSL on Azure Storage. Enables secure server to client by enforce minimal Tls Version to secure the connection between your database server and your client applications helps protect against 'man in the middle' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your Azure Storage."
  display_name        = "Azure Storage deploy a specific min TLS version requirement and enforce SSL/HTTPS "
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Storage"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:25:33.701564Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:05:34.0579138Z"
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-Storage-sslEnforcement"
  parameters = jsonencode({
    effect = {
      allowedValues = ["DeployIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "Enable or disable the execution of the policy minimum TLS version Azure STorage"
        displayName = "Effect Azure Storage"
      }
      type = "String"
    }
    minimumTlsVersion = {
      allowedValues = ["TLS1_2", "TLS1_1", "TLS1_0"]
      defaultValue  = "TLS1_2"
      metadata = {
        description = "Select version minimum TLS version Azure STorage to enforce"
        displayName = "Select TLS version for Azure Storage server"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Storage/storageAccounts"
        field  = "type"
        }, {
        anyOf = [{
          field     = "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly"
          notEquals = "true"
          }, {
          field     = "Microsoft.Storage/storageAccounts/minimumTlsVersion"
          notEquals = "[parameters('minimumTlsVersion')]"
        }]
      }]
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              minimumTlsVersion = {
                value = "[parameters('minimumTlsVersion')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                minimumTlsVersion = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2019-06-01"
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'))]"
                properties = {
                  minimumTlsVersion        = "[parameters('minimumTlsVersion')]"
                  supportsHttpsTrafficOnly = true
                }
                type = "Microsoft.Storage/storageAccounts"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly"
            }, {
            equals = "[parameters('minimumTlsVersion')]"
            field  = "Microsoft.Storage/storageAccounts/minimumTlsVersion"
          }]
        }
        name              = "current"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/17d1049b-9a84-46fb-8f53-869881c3d3ab"]
        type              = "Microsoft.Storage/storageAccounts"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-MachineLearning-ComputeCluster-Scale"
resource "azurerm_policy_definition" "deny_machinelearning_computecluster_scale" {
  description         = "Enforce scale settings for Azure Machine Learning compute clusters."
  display_name        = "Enforce scale settings for Azure Machine Learning compute clusters"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Budget"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:38:21.7513151Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-MachineLearning-ComputeCluster-Scale"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
    maxNodeCount = {
      defaultValue = 10
      metadata = {
        description = "Specifies the maximum node count of AML Clusters"
        displayName = "Maximum Node Count"
      }
      type = "Integer"
    }
    maxNodeIdleTimeInSecondsBeforeScaleDown = {
      defaultValue = 900
      metadata = {
        description = "Specifies the maximum node idle time in seconds before scaledown"
        displayName = "Maximum Node Idle Time in Seconds Before Scaledown"
      }
      type = "Integer"
    }
    minNodeCount = {
      defaultValue = 0
      metadata = {
        description = "Specifies the minimum node count of AML Clusters"
        displayName = "Minimum Node Count"
      }
      type = "Integer"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.MachineLearningServices/workspaces/computes"
        field  = "type"
        }, {
        equals = "AmlCompute"
        field  = "Microsoft.MachineLearningServices/workspaces/computes/computeType"
        }, {
        anyOf = [{
          field   = "Microsoft.MachineLearningServices/workspaces/computes/scaleSettings.maxNodeCount"
          greater = "[parameters('maxNodeCount')]"
          }, {
          field   = "Microsoft.MachineLearningServices/workspaces/computes/scaleSettings.minNodeCount"
          greater = "[parameters('minNodeCount')]"
          }, {
          greater = "[parameters('maxNodeIdleTimeInSecondsBeforeScaleDown')]"
          value   = "[int(last(split(replace(replace(replace(replace(replace(replace(replace(field('Microsoft.MachineLearningServices/workspaces/computes/scaleSettings.nodeIdleTimeBeforeScaleDown'), 'P', '/'), 'Y', '/'), 'M', '/'), 'D', '/'), 'T', '/'), 'H', '/'), 'S', ''), '/')))]"
        }]
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Private-DNS-Zones"
resource "azurerm_policy_definition" "deny_private_dns_zones" {
  description         = "This policy denies the creation of a private DNS in the current scope, used in combination with policies that create centralized private DNS in connectivity subscription"
  display_name        = "Deny the creation of private DNS"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Network"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:36:42.6187194Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-Private-DNS-Zones"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Network/privateDnsZones"
      field  = "type"
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CosmosDB"
resource "azurerm_policy_definition" "deploy_diagnostics_cosmosdb" {
  description         = "Deploys the diagnostic settings for Cosmos DB to stream to a Log Analytics workspace when any Cosmos DB which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Cosmos DB to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:36:42.4538527Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = "25ce83e9-0299-4203-af5b-fd21e167c4f0"
    updatedOn            = "2025-02-05T21:05:32.5808186Z"
    version              = "1.2.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-CosmosDB"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DocumentDB/databaseAccounts"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "DataPlaneRequests"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "MongoRequests"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "QueryRuntimeStatistics"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "PartitionKeyStatistics"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "PartitionKeyRUConsumption"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "ControlPlaneRequests"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "CassandraRequests"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "GremlinRequests"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "TableApiRequests"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "Requests"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DocumentDB/databaseAccounts/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DLAnalytics"
resource "azurerm_policy_definition" "deploy_diagnostics_dlanalytics" {
  description         = "Deploys the diagnostic settings for Data Lake Analytics to stream to a Log Analytics workspace when any Data Lake Analytics which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Data Lake Analytics to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:41:34.5766556Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-DLAnalytics"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.DataLakeAnalytics/accounts"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "Audit"
                    enabled  = "[parameters('logsEnabled')]"
                    }, {
                    category = "Requests"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.DataLakeAnalytics/accounts/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Routetable-Nexthop-VirtualAppliance"
resource "azurerm_policy_definition" "deny_routetable_nexthop_virtualappliance" {
  description         = "Deny route with address prefix 0.0.0.0/0 not pointing to the virtual appliance. Both creating routes as a standalone resource or nested within their parent resource route table are considered."
  display_name        = "Deny route with address prefix 0.0.0.0/0 not pointing to the virtual appliance"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    category  = "Network"
    createdBy = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn = "2024-05-02T20:36:42.5569778Z"
    updatedBy = null
    updatedOn = null
  })
  mode = "All"
  name = "Deny-Routetable-Nexthop-VirtualAppliance"
  parameters = jsonencode({
    routeTableSettings = {
      metadata = {
        description = "Location-specific settings for route tables."
        displayName = "Route Table Settings"
      }
      type = "Object"
    }
  })
  policy_rule = jsonencode({
    if = {
      anyOf = [{
        allOf = [{
          equals = "Microsoft.Network/routeTables"
          field  = "type"
          }, {
          count = {
            field = "Microsoft.Network/routeTables/routes[*]"
            where = {
              allOf = [{
                equals = "0.0.0.0/0"
                field  = "Microsoft.Network/routeTables/routes[*].addressPrefix"
                }, {
                anyOf = [{
                  field     = "Microsoft.Network/routeTables/routes[*].nextHopType"
                  notEquals = "VirtualAppliance"
                  }, {
                  field     = "Microsoft.Network/routeTables/routes[*].nextHopIpAddress"
                  notEquals = "[parameters('routeTableSettings')[field('location')].virtualApplianceIpAddress]"
                }]
              }]
            }
          }
          greater = 0
        }]
        }, {
        allOf = [{
          equals = "Microsoft.Network/routeTables/routes"
          field  = "type"
          }, {
          equals = "0.0.0.0/0"
          field  = "Microsoft.Network/routeTables/routes/addressPrefix"
          }, {
          anyOf = [{
            field     = "Microsoft.Network/routeTables/routes/nextHopType"
            notEquals = "VirtualAppliance"
            }, {
            field     = "Microsoft.Network/routeTables/routes/nextHopIpAddress"
            notEquals = "[parameters('routeTableSettings')[field('location')].virtualApplianceIpAddress]"
          }]
        }]
      }]
    }
    then = {
      effect = "deny"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridSystemTopic"
resource "azurerm_policy_definition" "deploy_diagnostics_eventgridsystemtopic" {
  description         = "Deploys the diagnostic settings for Event Grid System Topic to stream to a Log Analytics workspace when any Event Grid System Topic which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Event Grid System Topic to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:31:56.263257Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-EventGridSystemTopic"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    logsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable logs stream to the Log Analytics workspace - True or False"
        displayName = "Enable logs"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.EventGrid/systemTopics"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              logsEnabled = {
                value = "[parameters('logsEnabled')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                logsEnabled = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = [{
                    category = "DeliveryFailures"
                    enabled  = "[parameters('logsEnabled')]"
                  }]
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                    timeGrain = null
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.EventGrid/systemTopics/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/logs.enabled"
            }, {
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deny-Databricks-NoPublicIp"
resource "azurerm_policy_definition" "deny_databricks_nopublicip" {
  description         = "Denies the deployment of workspaces that do not use the noPublicIp feature to host Databricks clusters without public IPs."
  display_name        = "Deny public IPs for Databricks cluster"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud"]
    category             = "Databricks"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:38:21.8064493Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.0.0"
  })
  mode = "Indexed"
  name = "Deny-Databricks-NoPublicIp"
  parameters = jsonencode({
    effect = {
      allowedValues = ["Audit", "Disabled", "Deny"]
      defaultValue  = "Deny"
      metadata = {
        description = "Enable or disable the execution of the policy"
        displayName = "Effect"
      }
      type = "String"
    }
  })
  policy_rule = jsonencode({
    if = {
      allOf = [{
        equals = "Microsoft.Databricks/workspaces"
        field  = "type"
        }, {
        field     = "Microsoft.DataBricks/workspaces/parameters.enableNoPublicIp.value"
        notEquals = true
      }]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}

# __generated__ by Terraform from "/providers/Microsoft.Management/managementGroups/mg-aixtron/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VM"
resource "azurerm_policy_definition" "deploy_diagnostics_vm" {
  description         = "Deploys the diagnostic settings for Virtual Machines to stream to a Log Analytics workspace when any Virtual Machines which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled"
  display_name        = "Deploy Diagnostic Settings for Virtual Machines to Log Analytics workspace"
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-aixtron"
  metadata = jsonencode({
    alzCloudEnvironments = ["AzureCloud", "AzureChinaCloud", "AzureUSGovernment"]
    category             = "Monitoring"
    createdBy            = "89d71710-9ee0-44b0-8bf7-15873134ce6e"
    createdOn            = "2024-05-02T20:41:34.6702261Z"
    source               = "https://github.com/Azure/Enterprise-Scale/"
    updatedBy            = null
    updatedOn            = null
    version              = "1.1.0"
  })
  mode = "Indexed"
  name = "Deploy-Diagnostics-VM"
  parameters = jsonencode({
    effect = {
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
        displayName = "Log Analytics workspace"
        strongType  = "omsWorkspace"
      }
      type = "String"
    }
    metricsEnabled = {
      allowedValues = ["True", "False"]
      defaultValue  = "True"
      metadata = {
        description = "Whether to enable metrics stream to the Log Analytics workspace - True or False"
        displayName = "Enable metrics"
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
  policy_rule = jsonencode({
    if = {
      equals = "Microsoft.Compute/virtualMachines"
      field  = "type"
    }
    then = {
      details = {
        deployment = {
          properties = {
            mode = "Incremental"
            parameters = {
              location = {
                value = "[field('location')]"
              }
              logAnalytics = {
                value = "[parameters('logAnalytics')]"
              }
              metricsEnabled = {
                value = "[parameters('metricsEnabled')]"
              }
              profileName = {
                value = "[parameters('profileName')]"
              }
              resourceName = {
                value = "[field('name')]"
              }
            }
            template = {
              "$schema"      = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion = "1.0.0.0"
              outputs        = {}
              parameters = {
                location = {
                  type = "String"
                }
                logAnalytics = {
                  type = "String"
                }
                metricsEnabled = {
                  type = "String"
                }
                profileName = {
                  type = "String"
                }
                resourceName = {
                  type = "String"
                }
              }
              resources = [{
                apiVersion = "2017-05-01-preview"
                dependsOn  = []
                location   = "[parameters('location')]"
                name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                properties = {
                  logs = []
                  metrics = [{
                    category = "AllMetrics"
                    enabled  = "[parameters('metricsEnabled')]"
                    retentionPolicy = {
                      days    = 0
                      enabled = false
                    }
                  }]
                  workspaceId = "[parameters('logAnalytics')]"
                }
                type = "Microsoft.Compute/virtualMachines/providers/diagnosticSettings"
              }]
              variables = {}
            }
          }
        }
        existenceCondition = {
          allOf = [{
            equals = "true"
            field  = "Microsoft.Insights/diagnosticSettings/metrics.enabled"
            }, {
            equals = "[parameters('logAnalytics')]"
            field  = "Microsoft.Insights/diagnosticSettings/workspaceId"
          }]
        }
        name              = "[parameters('profileName')]"
        roleDefinitionIds = ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
        type              = "Microsoft.Insights/diagnosticSettings"
      }
      effect = "[parameters('effect')]"
    }
  })
  policy_type = "Custom"
}
