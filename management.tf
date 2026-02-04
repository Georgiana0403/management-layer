### Resources in the subscription af6bb952-3026-4b50-9aaa-f925d0d0ca4f:
resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "rg-alerting-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_resource_group" "res-1" {
  location = "westeurope"
  name     = "rg-monitoring-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_monitor_action_group" "res-2" {
  name                = "acg-GKSupport-prd-weu"
  resource_group_name = azurerm_resource_group.res-1.name
  short_name          = "gk-aix-ti"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    hidden-af-key    = "gk-aix-ti"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  email_receiver {
    email_address           = "m.hoffmann@aixtron.com"
    name                    = "m.hoffmann@aixtron.com"
    use_common_alert_schema = true
  }
  email_receiver {
    email_address           = "l.willms@aixtron.com"
    name                    = "l.willms@aixtron.com"
    use_common_alert_schema = true
  }
}
resource "azurerm_monitor_action_group" "res-4" {
  name                = "acg-GKSupportPD-prd-weu"
  resource_group_name = azurerm_resource_group.res-1.name
  short_name          = "gk-aix-pd"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    hidden-af-key    = "gk-aix-pd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  email_receiver {
    email_address           = "m.hoffmann@aixtron.com"
    name                    = "m.hoffmann@aixtron.com"
    use_common_alert_schema = true
  }
  email_receiver {
    email_address           = "l.willms@aixtron.com"
    name                    = "l.willms@aixtron.com"
    use_common_alert_schema = true
  }
}
resource "azurerm_monitor_data_collection_rule" "res-6" {
  description         = "Linux vm performance and logs"
  location            = "westeurope"
  name                = "dcr-linux-standalone"
  resource_group_name = azurerm_resource_group.res-1.name
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  data_flow {
    destinations = ["linux-vm-log"]
    streams      = ["Microsoft-Perf", "Microsoft-Syslog"]
  }
  data_sources {
    performance_counter {
      counter_specifiers            = ["Processor(*)\\% Processor Time", "Processor(*)\\% Privileged Time", "Memory(*)\\Available MBytes Memory", "Memory(*)\\% Available Memory", "Memory(*)\\Used Memory MBytes", "Memory(*)\\% Used Memory", "Memory(*)\\% Used Swap Space", "Logical Disk(*)\\% Used Inodes", "Logical Disk(*)\\Free Megabytes", "Logical Disk(*)\\% Free Space", "Logical Disk(*)\\% Used Space", "Logical Disk(*)\\Disk Transfers/sec", "Logical Disk(*)\\Disk Reads/sec", "Logical Disk(*)\\Disk Writes/sec", "Network(*)\\Total Bytes Transmitted", "Network(*)\\Total Bytes Received"]
      name                          = "LinuxCoreCounters60"
      sampling_frequency_in_seconds = 60
      streams                       = ["Microsoft-Perf"]
    }
    syslog {
      facility_names = ["auth", "authpriv", "daemon", "kern", "mail", "syslog", "user"]
      log_levels     = ["Warning", "Error", "Critical", "Alert", "Emergency"]
      name           = "LinuxLogDatasourceAllLevels"
      streams        = ["Microsoft-Syslog"]
    }
  }
  destinations {
    log_analytics {
      name                  = "linux-vm-log"
      workspace_resource_id = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourceGroups/rg-monitoring-prd-weu/providers/Microsoft.OperationalInsights/workspaces/log-operationallogs-prd-weu"
    }
  }
}
resource "azurerm_monitor_data_collection_rule" "res-7" {
  description         = "Windows vm performance and logs"
  location            = "westeurope"
  name                = "dcr-windows-standalone"
  resource_group_name = azurerm_resource_group.res-1.name
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  data_flow {
    destinations = ["windows-vm-log"]
    streams      = ["Microsoft-Perf", "Microsoft-Event"]
  }
  data_sources {
    performance_counter {
      counter_specifiers            = ["\\LogicalDisk(*)\\Current Disk Queue Length", "\\LogicalDisk(*)\\Disk Reads/sec", "\\LogicalDisk(*)\\Disk Transfers/sec", "\\LogicalDisk(*)\\Disk Writes/sec", "\\Memory\\% Committed Bytes In Use", "\\Memory\\Available Mbytes", "\\Network Adapter(*)\\Bytes Received/sec", "\\Network Adapter(*)\\Bytes Sent/sec", "\\Network Adapter(*)\\Bytes Total/sec", "\\Processor(*)\\% Processor Time", "\\System(*)\\Processor Queue Length"]
      name                          = "WinCoreCounters30"
      sampling_frequency_in_seconds = 30
      streams                       = ["Microsoft-Perf"]
    }
    performance_counter {
      counter_specifiers            = ["\\LogicalDisk(*)\\% Free Space", "\\LogicalDisk(*)\\Avg. Disk sec/Read", "\\LogicalDisk(*)\\Avg. Disk sec/Write", "\\LogicalDisk(*)\\Free Megabytes"]
      name                          = "WinCoreCounters60"
      sampling_frequency_in_seconds = 60
      streams                       = ["Microsoft-Perf"]
    }
    windows_event_log {
      name           = "WinEvents"
      streams        = ["Microsoft-Event"]
      x_path_queries = ["System!*[System[(Level=1 or Level=2 or Level=3)]]", "Application!*[System[(Level=1 or Level=2 or Level=3)]]"]
    }
  }
  destinations {
    log_analytics {
      name                  = "windows-vm-log"
      workspace_resource_id = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourceGroups/rg-monitoring-prd-weu/providers/Microsoft.OperationalInsights/workspaces/log-operationallogs-prd-weu"
    }
  }
}
resource "azurerm_application_insights_workbook" "res-8" {
  data_json = jsonencode({
    "$schema"           = "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
    fallbackResourceIds = ["azure monitor"]
    items = [{
      content = {
        crossComponentResources = ["value::all"]
        parameters = [{
          crossComponentResources = ["value::all"]
          delimiter               = ","
          id                      = "f7b258f8-b504-4628-9349-6cc13494fbde"
          isRequired              = true
          label                   = "Virtual WAN"
          multiSelect             = true
          name                    = "virtualWAN"
          query                   = "resources\r\n| where type contains \"wan\""
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = []
            resourceTypeFilter = {
              "microsoft.network/virtualwans"            = true
              "microsoft.operationalinsights/workspaces" = true
            }
            showDefault = false
          }
          value   = ["/subscriptions/f8d5c999-ad8b-4e1c-b41b-5cd718b6d5fd/resourceGroups/rg-vwan-prd-weu/providers/Microsoft.Network/virtualWans/vwan-instone-prd-weu"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::all"]
          delimiter               = ","
          id                      = "a32fb2e3-81f6-4a93-b6ce-11a571cf0e35"
          isHiddenWhenLocked      = true
          label                   = "VPN Gateways"
          multiSelect             = true
          name                    = "vpnGateway"
          query                   = "resources\r\n| where type =~ \"microsoft.network/virtualwans\"\r\n| mv-expand virtualHub = properties.virtualHubs\r\n| project hubId = tolower(virtualHub.id)\r\n| join kind=inner (\r\nresources\r\n| where type =~ \"microsoft.network/virtualhubs\"\r\n| where isnotempty(properties.vpnGateway.id)\r\n| project hubId = tolower(id), vpnGateway = tolower(properties.vpnGateway.id)\r\n) on hubId\r\n| project vpnGateway, selected = 1"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::all"]
          delimiter               = ","
          id                      = "f352a667-6fe1-49ba-8b36-db25c13cccad"
          isHiddenWhenLocked      = true
          label                   = "Express Route Gateways"
          multiSelect             = true
          name                    = "expressRouteGateway"
          query                   = "resources\r\n| where type =~ \"microsoft.network/virtualwans\"\r\n| mv-expand virtualHub = properties.virtualHubs\r\n| project hubId = tolower(virtualHub.id)\r\n| join kind=inner (\r\nresources\r\n| where type =~ \"microsoft.network/virtualhubs\"\r\n| where isnotempty(properties.expressRouteGateway.id)\r\n| project hubId = tolower(id), erGateway = tolower(properties.expressRouteGateway.id)\r\n) on hubId\r\n| project erGateway, selected = 1"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::all"]
          delimiter               = ","
          id                      = "096613e4-3ff4-465c-bbb5-eabe86bfb15e"
          isHiddenWhenLocked      = true
          label                   = "P2S VPN Gateways"
          multiSelect             = true
          name                    = "p2SVpnGateway"
          query                   = "resources\r\n| where type =~ \"microsoft.network/virtualwans\"\r\n| mv-expand virtualHub = properties.virtualHubs\r\n| project hubId = tolower(virtualHub.id)\r\n| join kind=inner (\r\nresources\r\n| where type =~ \"microsoft.network/virtualhubs\"\r\n| where isnotempty(properties.p2SVpnGateway.id)\r\n| project hubId = tolower(id), p2sVpnGateway = tolower(properties.p2SVpnGateway.id)\r\n) on hubId\r\n| project p2sVpnGateway, selected = 1"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::all"]
          delimiter               = ","
          id                      = "6719e1c0-1bdb-42d0-911c-aa77e3da2d14"
          isHiddenWhenLocked      = true
          label                   = "Azure Firewall"
          multiSelect             = true
          name                    = "azureFirewall"
          query                   = "resources\r\n| where type =~ \"microsoft.network/virtualwans\"\r\n| mv-expand virtualHub = properties.virtualHubs\r\n| project hubId = tolower(virtualHub.id)\r\n| join kind=inner (\r\nresources\r\n| where type =~ \"microsoft.network/virtualhubs\"\r\n| where isnotempty(properties.azureFirewall.id)\r\n| project hubId = tolower(id), firewall = tolower(properties.azureFirewall.id)\r\n) on hubId\r\n| project firewall, selected = 1"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::all"]
          delimiter               = ","
          id                      = "7febaca6-d287-4b9a-9033-31b74cac40cb"
          isHiddenWhenLocked      = true
          label                   = "Express Route Circuits"
          multiSelect             = true
          name                    = "erCircuits"
          query                   = "resources\r\n| where type =~ \"microsoft.network/virtualwans\"\r\n| mv-expand virtualHub = properties.virtualHubs\r\n| project hubId = tolower(virtualHub.id)\r\n| join kind=inner (\r\nresources\r\n| where type =~ \"microsoft.network/virtualhubs\"\r\n| where isnotempty(properties.expressRouteGateway.id)\r\n| project hubId = tolower(id), erGateway = tolower(properties.expressRouteGateway.id)\r\n) on hubId\r\n| project erGateway\r\n| join kind=inner (\r\nresources\r\n| where type =~ \"microsoft.network/expressroutegateways\"\r\n| mv-expand connectionDetails = properties.expressRouteConnections\r\n| extend peeringId = connectionDetails.properties.expressRouteCircuitPeering.id\r\n| project erGateway = tolower(id), erCircuit = tolower(split(peeringId, '/peerings/')[0])\r\n| distinct erGateway, erCircuit\r\n) on erGateway\r\n| distinct erCircuit\r\n| project erCircuit, selected = 1"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
          }, {
          id         = "51cc9691-04f1-477f-864a-d49c72e38ee6"
          isRequired = true
          label      = "Time Range"
          name       = "TimeRange"
          timeContext = {
            durationMs = 86400000
          }
          type = 4
          typeSettings = {
            allowCustom = true
            selectableValues = [{
              durationMs = 1800000
              }, {
              durationMs = 3600000
              }, {
              durationMs = 43200000
              }, {
              durationMs = 86400000
              }, {
              durationMs = 172800000
              }, {
              durationMs = 259200000
              }, {
              durationMs = 604800000
              }, {
              durationMs = 7776000000
            }]
          }
          value = {
            durationMs = 86400000
          }
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - Filters 3"
      type = 9
      }, {
      content = {
        crossComponentResources = ["value::all"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "hubId"
            formatOptions = {
              bladeOpenContext = {
                bladeName = "VirtualHubManagementViewModel"
                bladeParameters = [{
                  name   = "virtualHubId"
                  source = "cell"
                  value  = ""
                }]
                extensionName = "Microsoft_Azure_HybridNetworking"
              }
              linkTarget = "OpenBlade"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "hubStatus"
            formatter   = 1
            }, {
            columnMatch = "vpnGWStatus"
            formatter   = 1
            numberFormat = {
              emptyValCustomText = "-"
              options = {
                style = "decimal"
              }
              unit = 0
            }
            }, {
            columnMatch = "vpnGWScaleUnit"
            formatter   = 1
            numberFormat = {
              emptyValCustomText = "-"
              options = {
                style = "decimal"
              }
              unit = 0
            }
            }, {
            columnMatch = "p2sGWStatus"
            formatter   = 1
            numberFormat = {
              emptyValCustomText = "-"
              options = {
                style = "decimal"
              }
              unit = 0
            }
            }, {
            columnMatch = "p2sGWScaleUnit"
            formatter   = 1
            numberFormat = {
              emptyValCustomText = "-"
              options = {
                style = "decimal"
              }
              unit = 0
            }
            }, {
            columnMatch = "erGWStatus"
            formatter   = 1
            numberFormat = {
              emptyValCustomText = "-"
              options = {
                style = "decimal"
              }
              unit = 0
            }
            }, {
            columnMatch = "erGWMinScaleUnit"
            formatter   = 1
            numberFormat = {
              emptyValCustomText = "-"
              options = {
                style = "decimal"
              }
              unit = 0
            }
            }, {
            columnMatch = "totalHubCapacityInGbps"
            formatter   = 1
            numberFormat = {
              emptyValCustomText = "0"
              options = {
                style = "decimal"
              }
              unit = 0
            }
          }]
          labelSettings = [{
            columnId = "hubId"
            label    = "Virtual Hub"
            }, {
            columnId = "vpnGWScaleUnit"
            label    = "VPN Gateway Scale Units"
            }, {
            columnId = "p2sGWScaleUnit"
            label    = "P2S Gateway Scale Units"
            }, {
            columnId = "erGWMinScaleUnit"
            label    = "ER Gateway Scale Units"
            }, {
            columnId = "totalHubCapacityInGbps"
            label    = "Total Hub Capacity (Gbps)"
          }]
          sortBy = [{
            itemKey   = "$gen_number_totalHubCapacityInGbps_4"
            sortOrder = 1
          }]
        }
        noDataMessage     = "No virtual hubs found"
        query             = "resources\r\n| where type =~ \"microsoft.network/virtualhubs\"\r\n| project hubId = tolower(id)\r\n| join kind=leftouter (\r\nresources\r\n| where type =~ \"microsoft.network/vpngateways\"\r\n| project hubId = tolower(properties.virtualHub.id), vpnGWScaleUnit = properties.vpnGatewayScaleUnit\r\n) on hubId\r\n| join kind=leftouter (\r\nresources\r\n| where type =~ \"microsoft.network/p2svpngateways\"\r\n| project hubId = tolower(properties.virtualHub.id), p2sGWScaleUnit = properties.vpnGatewayScaleUnit\r\n) on hubId\r\n| join kind=leftouter (\r\nresources\r\n| where type =~ \"microsoft.network/expressroutegateways\"\r\n| project hubId = tolower(properties.virtualHub.id), erGWMinScaleUnit = properties.autoScaleConfiguration.bounds.min\r\n) on hubId\r\n| extend totalHubCapacityInGbps = iff(isnotempty(vpnGWScaleUnit), vpnGWScaleUnit, 0) + iff(isnotempty(p2sGWScaleUnit), p2sGWScaleUnit, 0) + iff(isnotempty(erGWMinScaleUnit), 2 * erGWMinScaleUnit, 0)\r\n| project hubId, vpnGWScaleUnit, p2sGWScaleUnit, erGWMinScaleUnit, totalHubCapacityInGbps"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 1
        sortBy = [{
          itemKey   = "$gen_number_totalHubCapacityInGbps_4"
          sortOrder = 1
        }]
        title         = "Virtual WAN Hub Capacities"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "Virtual WAN Hub Capacities"
      type = 3
      }, {
      content = {
        chartId        = "workbookfab00c1e-9879-4ac8-a6bd-921ec030e971"
        chartType      = 2
        gridFormatType = 1
        gridSettings = {
          formatters = [{
            columnMatch = "Subscription"
            formatter   = 5
            }, {
            columnMatch = "Name"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 13
            }, {
            columnMatch = "microsoft.network/vpngateways--AverageBandwidth Timeline"
            formatter   = 5
            }, {
            columnMatch = "microsoft.network/vpngateways--AverageBandwidth"
            formatter   = 1
            numberFormat = {
              options = null
              unit    = 11
            }
            }, {
            columnMatch = "Metric"
            formatter   = 1
            }, {
            columnMatch = "Aggregation"
            formatter   = 5
            }, {
            columnMatch = "Value"
            formatter   = 1
            }, {
            columnMatch = "Timeline"
            formatter   = 9
          }]
          labelSettings = [{
            columnId = "Name"
            label    = "VPN Gateway"
            }, {
            columnId = "Segment Field"
            label    = "Dimension"
            }, {
            columnId = "Segment"
            label    = "Connected Site"
          }]
          rowLimit = 10000
        }
        metricScope = 0
        metrics = [{
          aggregation = 4
          columnName  = ""
          metric      = "microsoft.network/vpngateways--AverageBandwidth"
          namespace   = "microsoft.network/vpngateways"
          splitBy     = null
        }]
        resourceIds       = ["{vpnGateway}"]
        resourceParameter = "vpnGateway"
        resourceType      = "microsoft.network/vpngateways"
        size              = 1
        tileSettings = {
          leftContent = {
            columnMatch = "Value"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = false
          titleContent = {
            columnMatch = "Name"
            formatter   = 13
          }
        }
        timeContext = {
          durationMs = 86400000
        }
        timeContextFromParameter = "TimeRange"
        title                    = "S2S Gateway Average Bandwidth"
        version                  = "MetricsItem/2.0"
      }
      name = "S2S Gateway Average Bandwidth"
      type = 10
      }, {
      content = {
        chartId   = "workbook38465d76-17f3-4aea-97a0-d40632360f8a"
        chartType = 2
        gridSettings = {
          rowLimit = 10000
        }
        metricScope = 0
        metrics = [{
          aggregation = 4
          metric      = "microsoft.network/p2svpngateways--P2SBandwidth"
          namespace   = "microsoft.network/p2svpngateways"
          splitBy     = null
        }]
        resourceIds       = ["{p2SVpnGateway}"]
        resourceParameter = "p2SVpnGateway"
        resourceType      = "microsoft.network/p2svpngateways"
        size              = 1
        timeContext = {
          durationMs = 86400000
        }
        timeContextFromParameter = "TimeRange"
        title                    = "P2S Gateway Average Bandwidth"
        version                  = "MetricsItem/2.0"
      }
      name = "P2S Gateway Average Bandwidth"
      type = 10
      }, {
      content = {
        chartId   = "workbook3c4076dd-62ef-4563-8fec-3bd9f96075ab"
        chartType = 2
        gridSettings = {
          rowLimit = 10000
        }
        metricScope = 0
        metrics = [{
          aggregation = 4
          metric      = "microsoft.network/expressroutegateways-Traffic-ErGatewayConnectionBitsInPerSecond"
          namespace   = "microsoft.network/expressroutegateways"
          splitBy     = null
        }]
        resourceIds       = ["{expressRouteGateway}"]
        resourceParameter = "expressRouteGateway"
        resourceType      = "microsoft.network/expressroutegateways"
        size              = 1
        timeContext = {
          durationMs = 86400000
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Express Route Gateway BitsInPerSecond"
        version                  = "MetricsItem/2.0"
      }
      name = "Express Route Gateway BitsInPerSecond"
      type = 10
    }]
    version = "Notebook/1.0"
  })
  display_name        = "af-workbook_azure-vwan-overview"
  location            = "westeurope"
  name                = "13c11ba3-3a8b-80da-e649-48d90b458f2d"
  resource_group_name = azurerm_resource_group.res-1.name
  source_id           = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourcegroups/rg-monitoring-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_application_insights_workbook" "res-9" {
  data_json = jsonencode({
    "$schema"          = "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
    defaultResourceIds = ["/subscriptions/651dc44c-5d8e-48da-8cd3-cd79224ac290/resourceGroups/appgw-waf-triage/providers/Microsoft.OperationalInsights/workspaces/la-appgw-waf-triage"]
    items = [{
      content = {
        crossComponentResources = ["value::all"]
        parameters = [{
          crossComponentResources = ["value::all"]
          delimiter               = ","
          id                      = "12476248-81b7-46af-a9b4-790f93306442"
          isRequired              = true
          label                   = "Workspace"
          multiSelect             = true
          name                    = "workspace"
          query                   = "resources\r\n| where type =~ 'microsoft.operationalinsights/workspaces'"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 5
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
          }, {
          id         = "f451ddc5-00e3-4fe7-908e-22d0be9ab59c"
          isRequired = true
          label      = "Detection Time"
          name       = "detectionTime"
          timeContext = {
            durationMs = 86400000
          }
          type = 4
          typeSettings = {
            selectableValues = [{
              durationMs = 300000
              }, {
              durationMs = 900000
              }, {
              durationMs = 1800000
              }, {
              durationMs = 3600000
              }, {
              durationMs = 14400000
              }, {
              durationMs = 43200000
              }, {
              durationMs = 86400000
              }, {
              durationMs = 172800000
              }, {
              durationMs = 259200000
              }, {
              durationMs = 604800000
              }, {
              durationMs = 1209600000
              }, {
              durationMs = 2419200000
              }, {
              durationMs = 2592000000
              }, {
              durationMs = 5184000000
              }, {
              durationMs = 7776000000
            }]
          }
          value = {
            durationMs = 86400000
          }
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - 2"
      type = 9
      }, {
      content = {
        crossComponentResources = ["{workspace}"]
        exportedParameters = [{
          fieldName     = "policyScopeName_s"
          parameterName = "PolicyScope"
          parameterType = 1
          }, {
          fieldName     = "ResourceId"
          parameterName = "ResourceId"
          parameterType = 1
        }]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "ResourceId"
            formatter   = 5
            }, {
            columnMatch = "Matched"
            formatOptions = {
              palette = "greenRed"
            }
            formatter = 8
            }, {
            columnMatch = "Blocked"
            formatOptions = {
              palette = "greenRed"
            }
            formatter = 8
          }]
          hierarchySettings = {
            groupBy  = ["ResourceId"]
            treeType = 1
          }
          labelSettings = [{
            columnId = "ResourceId"
            label    = "App Gateway"
            }, {
            columnId = "policyScopeName_s"
            label    = "Policy Scope"
          }]
          rowLimit = 500
        }
        query        = "AzureDiagnostics \n| where Category == \"ApplicationGatewayFirewallLog\"\n| where TimeGenerated {detectionTime}\n| extend Id = new_guid()\n| project-reorder Id, ResourceId, policyScopeName_s, action_s\n//| summarize count() by ResourceId, policyScopeName_s, action_s\n| evaluate pivot(action_s, count(), ResourceId, policyScopeName_s)"
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        size         = 1
        tileSettings = {
          showBorder = false
        }
        title         = "Select the scope of the WAF policy"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query-app-gateway-resources"
      type = 3
      }, {
      content = {
        links = [{
          cellValue  = "SelectedTabPage"
          id         = "14e61d36-d59a-405d-8363-ac1aa8a2f491"
          linkLabel  = "Triage by Rule"
          linkTarget = "parameter"
          preText    = "Triage by Rule"
          style      = "link"
          subTarget  = "triage-by-rule"
          }, {
          cellValue  = "SelectedTabPage"
          id         = "93464fc4-d183-4d74-9e06-111c6de081a9"
          linkLabel  = "Triage by URL"
          linkTarget = "parameter"
          preText    = "Triage "
          style      = "link"
          subTarget  = "triage-by-url"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "TabNavigation"
      type = 11
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "SelectedTabPage"
        value         = "triage-by-rule"
      }
      content = {
        exportParameters = true
        groupType        = "editable"
        items = [{
          content = {
            crossComponentResources = ["{workspace}"]
            exportedParameters = [{
              fieldName     = "ruleId_s"
              parameterName = "RuleId"
              }, {
              fieldName     = "Url"
              parameterName = "SpiderLabsUrl"
              parameterType = 1
              }, {
              fieldName     = "ruleSetVersion_s"
              parameterName = "RuleSetVersion"
              parameterType = 1
            }]
            gridSettings = {
              formatters = [{
                columnMatch = "Count"
                formatOptions = {
                  palette = "greenRed"
                }
                formatter = 8
                }, {
                columnMatch = "ruleSetType_s"
                formatter   = 5
                }, {
                columnMatch = "ruleId_s"
                formatter   = 5
                }, {
                columnMatch = "Url"
                formatOptions = {
                  linkLabel  = "Go to Core Rule Set Project GitHub for this rule"
                  linkTarget = "Url"
                }
                formatter = 7
                }, {
                columnMatch = "Trend"
                formatOptions = {
                  palette = "yellowOrangeRed"
                }
                formatter = 10
                }, {
                columnMatch = "TimeGenerated"
                formatter   = 5
                }, {
                columnMatch = "Id"
                formatter   = 5
              }]
              labelSettings = [{
                columnId = "ruleSetVersion_s"
                label    = "Ruleset Version"
                }, {
                columnId = "ruleId_s"
                label    = "Rule Id"
              }]
              sortBy = [{
                itemKey   = "$gen_heatmap_Count_0"
                sortOrder = 2
              }]
            }
            query         = "AzureDiagnostics \r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n| where TimeGenerated {detectionTime}\r\n| where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}'\r\n| summarize Count = count() by ruleSetType_s, ruleSetVersion_s, ruleId_s, details_file_s, details_line_s, action_s\r\n| order by Count desc\r\n| project-reorder Count\r\n//| extend ruleidentif = ruleId_s\r\n//| extend ruleSetVersionss = ruleSetVersion_s, ruleSetTypess = ruleSetType_s\r\n| extend normalizedRuleSetVersion = case(isempty(ruleSetVersion_s), \"\",\r\n                                         // old engine: rulesetVersion_s looks like \"3.1.0\" while type is \"OWASP_CRS\" => leave untouched, can use this as-is\r\n                                         //             final url to GH is like: https://github.com/coreruleset/coreruleset/blob/v3.1.0/rules/REQUEST-913-SCANNER-DETECTION.conf#L56\r\n                                         ruleSetVersion_s matches regex \"[0-9]+.[0-9]+.[0-9]+\", ruleSetVersion_s,\r\n                                         // new engine: rulesetVersion_s looks like \"3.2\" while type is \"OWASP CRS\" => need a version that looks like \"3.2.0\"\r\n                                         //             final url to GH is like: https://github.com/coreruleset/coreruleset/blob/v3.2.0/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf#L56\r\n                                         ruleSetVersion_s matches regex \"[0-9]+.[0-9]+\", strcat(ruleSetVersion_s, \".0\"),\r\n                                         \"\")\r\n| extend normalizedDetailsFile = case(  ruleSetType_s == \"OWASP_CRS\", replace(@'rules/', '', details_file_s),   // old engine: details_files_s looks like \"rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\" while type is \"OWASP_CRS\"\r\n                                        ruleSetType_s == \"OWASP CRS\", details_file_s,                           // new engine: details_files_s looks like \"REQUEST-920-PROTOCOL-ENFORCEMENT.conf\" while type is \"OWASP CRS\"\r\n                                        details_file_s)\r\n| extend Url = iif(isnotempty(ruleSetVersion_s), strcat('https://github.com/coreruleset/coreruleset/blob/', 'v', normalizedRuleSetVersion, '/rules/', normalizedDetailsFile, '#L', details_line_s), '')\r\n// add sparklines\r\n| join kind=inner (AzureDiagnostics | where Category == \"ApplicationGatewayFirewallLog\" | where TimeGenerated {detectionTime} | where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}'\r\n                                    | make-series Trend = count() on TimeGenerated from {detectionTime:start} to {detectionTime:end} step (time({detectionTime:seconds} seconds) / 20)  by ruleId_s\r\n    ) on ruleId_s\r\n| extend Id = new_guid()"
            queryType     = 0
            resourceType  = "microsoft.operationalinsights/workspaces"
            showAnalytics = true
            size          = 0
            sortBy = [{
              itemKey   = "$gen_heatmap_Count_0"
              sortOrder = 2
            }]
            title   = "Rules that got triggered"
            version = "KqlItem/1.0"
          }
          customWidth = "100"
          name        = "query - violated rules"
          type        = 3
          }, {
          content = {
            crossComponentResources = ["{workspace}"]
            exportedParameters = [{
              fieldName     = "hostname_s"
              parameterName = "HostName"
              }, {
              fieldName     = "hostname_s_noport"
              parameterName = "HostNameNoPort"
              parameterType = 1
            }]
            gridSettings = {
              formatters = [{
                columnMatch = "hostname_s_noport"
                formatter   = 5
              }]
            }
            query         = "AzureDiagnostics\r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n| where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}' and ruleId_s == '{RuleId}' and ruleSetVersion_s == '{RuleSetVersion}'\r\n| where TimeGenerated {detectionTime}\r\n// at this point hostname_s can still contain both hostname and port; for example: www.myhost.com:80 -> we need to split this up to match on just the host later\r\n| extend splittedhost = split(hostname_s, ':')\r\n| extend hostname_s_noport = tostring(splittedhost[0]) //override hostname_s to just contain host; drop the port section\r\n| extend port =  tostring(splittedhost[1])\r\n| distinct hostname_s, hostname_s_noport"
            queryType     = 0
            resourceType  = "microsoft.operationalinsights/workspaces"
            size          = 0
            title         = "Hosts Affected"
            version       = "KqlItem/1.0"
            visualization = "table"
          }
          customWidth = "15"
          name        = "Affected Hosts"
          showPin     = true
          type        = 3
          }, {
          content = {
            crossComponentResources = ["{workspace}"]
            exportedParameters = [{
              fieldName     = "httpMethod_s1"
              parameterName = "Method"
              parameterType = 1
              }, {
              fieldName     = "originalRequestUriWithArgs_s1"
              parameterName = "FullUri"
              parameterType = 1
              }, {
              fieldName     = "requestUri_s1"
              parameterName = "RequestUri"
              parameterType = 1
            }]
            gridSettings = {
              formatters = [{
                columnMatch = "requestUri_s"
                formatter   = 5
                }, {
                columnMatch = "encodedRequestUri"
                formatter   = 5
                }, {
                columnMatch = "id"
                formatter   = 5
              }]
              hierarchySettings = {
                expandTopLevel = true
                finalBy        = "requestUri_s"
                groupBy        = ["requestUri_s1"]
                treeType       = 1
              }
              rowLimit = 1000
            }
            query         = "AzureDiagnostics\r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n| where TimeGenerated {detectionTime}\r\n| where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}' and ruleId_s == '{RuleId}'\r\n| where hostname_s == '{HostName}'\r\n| project-reorder hostname_s, transactionId_g\r\n| join kind=inner (AzureDiagnostics | where Category == \"ApplicationGatewayAccessLog\" | where TimeGenerated {detectionTime}) on transactionId_g\r\n| distinct host_s1, httpMethod_s1, requestUri_s1, originalRequestUriWithArgs_s1\r\n| order by host_s1, requestUri_s1, httpMethod_s1, originalRequestUriWithArgs_s1\r\n| extend id = new_guid()"
            queryType     = 0
            resourceType  = "microsoft.operationalinsights/workspaces"
            showAnalytics = true
            size          = 0
            title         = "Hosts and urls impacted by selected rule"
            version       = "KqlItem/1.0"
            visualization = "table"
          }
          customWidth = "60"
          name        = "affected urls"
          type        = 3
          }, {
          content = {
            crossComponentResources = ["{workspace}"]
            exportFieldName         = "transactionId_g"
            exportParameterName     = "TransactionId"
            gridSettings = {
              formatters = [{
                columnMatch = "transactionId_g"
                formatOptions = {
                  customColumnWidthSetting = "40%"
                }
                formatter = 0
                }, {
                columnMatch = "access_log"
                formatOptions = {
                  bladeOpenContext = {
                    bladeName = "LogsBlade"
                    bladeParameters = [{
                      name   = "resourceId"
                      source = "parameter"
                      value  = "workspace"
                      }, {
                      name   = "query"
                      source = "cell"
                      value  = ""
                    }]
                    extensionName = "Microsoft_Azure_Monitoring_Logs"
                  }
                  linkIsContextBlade = true
                  linkLabel          = "Find in Access Log"
                  linkTarget         = "OpenBlade"
                }
                formatter = 7
                }, {
                columnMatch = "firewall_log"
                formatOptions = {
                  bladeOpenContext = {
                    bladeName = "LogsBlade"
                    bladeParameters = [{
                      name   = "resourceId"
                      source = "parameter"
                      value  = "workspace"
                      }, {
                      name   = "query"
                      source = "cell"
                      value  = ""
                    }]
                    extensionName = "Microsoft_Azure_Monitoring_Logs"
                  }
                  linkIsContextBlade = true
                  linkLabel          = "Find in Firewall Log"
                  linkTarget         = "OpenBlade"
                }
                formatter = 7
              }]
            }
            query        = "AzureDiagnostics\r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n| where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}'\r\n| where TimeGenerated {detectionTime}\r\n| distinct transactionId_g\r\n| join kind=inner (AzureDiagnostics | where Category == \"ApplicationGatewayAccessLog\" | where TimeGenerated {detectionTime}) \r\n  on transactionId_g\r\n| where originalHost_s == '{HostNameNoPort}' and httpMethod_s == '{Method}' and requestUri_s == ```{RequestUri}``` and originalRequestUriWithArgs_s == ```{FullUri}```\r\n| project transactionId_g\r\n| extend access_log = strcat(\"AzureDiagnostics | where Category == \\\"ApplicationGatewayAccessLog\\\" | where TimeGenerated {detectionTime} | where transactionId_g == \\\"\", transactionId_g, \"\\\"\")\r\n| extend firewall_log = strcat(\"AzureDiagnostics | where Category == \\\"ApplicationGatewayFirewallLog\\\" | where TimeGenerated {detectionTime} | where transactionId_g == \\\"\", transactionId_g, \"\\\"\")\r\n//let transIdsWithFirewallLog = AzureDiagnostics\r\n//| where Category == \"ApplicationGatewayFirewallLog\"\r\n//| where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}'\r\n//| where TimeGenerated {detectionTime}\r\n//| distinct transactionId_g;\r\n//AzureDiagnostics\r\n//| where Category == \"ApplicationGatewayAccessLog\"\r\n//| where TimeGenerated {detectionTime}\r\n//| where host_s == '{HostName}' and httpMethod_s == '{Method}' and requestUri_s == '{RequestUri}' and originalRequestUriWithArgs_s == '{FullUri}'\r\n//| distinct transactionId_g\r\n//| where transactionId_g in (transIdsWithFirewallLog) // TODO: how to get tenant id in here?\r\n//| extend access_log = strcat(\"AzureDiagnostics | where Category == \\\"ApplicationGatewayAccessLog\\\" | where TimeGenerated {detectionTime} | where transactionId_g == \\\"\", transactionId_g, \"\\\"\")\r\n//| extend firewall_log = strcat(\"AzureDiagnostics | where Category == \\\"ApplicationGatewayFirewallLog\\\" | where TimeGenerated {detectionTime} | where transactionId_g == \\\"\", transactionId_g, \"\\\"\")"
            queryType    = 0
            resourceType = "microsoft.operationalinsights/workspaces"
            size         = 0
            title        = "Requests on selected host and url"
            version      = "KqlItem/1.0"
          }
          customWidth = "25"
          name        = "ImpactedRequestsFromSelectedUri"
          type        = 3
          }, {
          content = {
            crossComponentResources = ["{workspace}"]
            exportedParameters = [{
              fieldName     = "transactionId_g"
              parameterName = "TransactionId"
              }, {
              fieldName     = "Message"
              parameterName = "message"
              parameterType = 1
              }, {
              fieldName     = "details_message_s"
              parameterName = "details"
              parameterType = 1
              }, {
              fieldName     = "details_data_s"
              parameterName = "matcheddata"
              parameterType = 1
            }]
            gridSettings = {
              formatters = [{
                columnMatch = "action_s"
                formatOptions = {
                  thresholdsGrid = [{
                    operator       = "=="
                    representation = "2"
                    text           = "{0}{1}"
                    thresholdValue = "Matched"
                    }, {
                    operator       = "=="
                    representation = "4"
                    text           = "{0}{1}"
                    thresholdValue = "Blocked"
                    }, {
                    operator       = "Default"
                    representation = "more"
                    text           = "{0}{1}"
                    thresholdValue = null
                  }]
                  thresholdsOptions = "icons"
                }
                formatter = 18
                }, {
                columnMatch = "ruleId_s"
                formatOptions = {
                  thresholdsGrid = [{
                    operator       = "=="
                    representation = "yellow"
                    text           = "{0}{1}"
                    thresholdValue = "{RuleId}"
                    }, {
                    operator       = "Default"
                    text           = "{0}{1}"
                    thresholdValue = null
                  }]
                  thresholdsOptions = "colors"
                }
                formatter = 18
                }, {
                columnMatch = "Url"
                formatOptions = {
                  linkLabel  = "Go to Core Rule Set Project GitHub for this rule"
                  linkTarget = "Url"
                }
                formatter = 7
                }, {
                columnMatch = "statusFromAction"
                formatter   = 5
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 0
                }
              }]
              labelSettings = [{
                columnId = "action_s"
                label    = "action"
                }, {
                columnId = "ruleId_s"
                label    = "rule id"
                }, {
                columnId = "Message"
                label    = "message"
                }, {
                columnId = "details_message_s"
                label    = "details"
                }, {
                columnId = "details_data_s"
                label    = "matched data"
                }, {
                columnId = "TimeGenerated"
                label    = "time generated"
              }]
            }
            query         = "AzureDiagnostics \r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n| where transactionId_g == '{TransactionId}'\r\n| extend Id = new_guid()\r\n| project-reorder Id, action_s, ruleSetType_s, ruleSetVersion_s, ruleId_s, Message, hostname_s, requestUri_s, details_message_s, details_data_s, details_file_s, details_line_s, transactionId_g\r\n| extend normalizedRuleSetVersion = case(isempty(ruleSetVersion_s), \"\",\r\n                                         // old engine: rulesetVersion_s looks like \"3.1.0\" while type is \"OWASP_CRS\" => leave untouched, can use this as-is\r\n                                         //             final url to GH is like: https://github.com/coreruleset/coreruleset/blob/v3.1.0/rules/REQUEST-913-SCANNER-DETECTION.conf#L56\r\n                                         ruleSetVersion_s matches regex \"[0-9]+.[0-9]+.[0-9]+\", ruleSetVersion_s,\r\n                                         // new engine: rulesetVersion_s looks like \"3.2\" while type is \"OWASP CRS\" => need a version that looks like \"3.2.0\"\r\n                                         //             final url to GH is like: https://github.com/coreruleset/coreruleset/blob/v3.2.0/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf#L56\r\n                                         ruleSetVersion_s matches regex \"[0-9]+.[0-9]+\", strcat(ruleSetVersion_s, \".0\"),\r\n                                         \"\")\r\n| extend normalizedDetailsFile = case(  ruleSetType_s == \"OWASP_CRS\", replace(@'rules/', '', details_file_s),   // old engine: details_files_s looks like \"rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\" while type is \"OWASP_CRS\"\r\n                                        ruleSetType_s == \"OWASP CRS\", details_file_s,                           // new engine: details_files_s looks like \"REQUEST-920-PROTOCOL-ENFORCEMENT.conf\" while type is \"OWASP CRS\"\r\n                                        details_file_s)\r\n| extend Url = iif(isnotempty(ruleSetVersion_s), strcat('https://github.com/coreruleset/coreruleset/blob/', 'v', normalizedRuleSetVersion, '/rules/', normalizedDetailsFile, '#L', details_line_s), '')\r\n| project action_s, ruleId_s, Message, details_message_s, details_data_s, Url, TimeGenerated\r\n"
            queryType     = 0
            resourceType  = "microsoft.operationalinsights/workspaces"
            size          = 0
            title         = "Rules that got triggered for selected request"
            version       = "KqlItem/1.0"
            visualization = "table"
          }
          name = "TriggeredRules"
          type = 3
          }, {
          content = {
            json = "## Selection Summary:\r\n\r\nYou were looking for example requests which were impacted by WAF rule with id: **{RuleId}**.  \r\n\r\nMore information on the selected rule which impacted this url, can be found on the [Core Rule Set Project](https://coreruleset.org/) GitHub page, here:, here: {SpiderLabsUrl}\r\n\r\nOn the host with name \"*{HostName}*\" and url \"*{FullUri}*\" you have found an HTTP request, impacted by this rule, with transaction id equal to *{TransactionId}*.  \r\n\r\nMore info on this request and the selected rule:\r\n- Message: {message}\r\n- Details: {details}\r\n- Matched Data: {matcheddata}"
          }
          name = "text - 7"
          type = 1
        }]
        version = "NotebookGroup/1.0"
      }
      name = "Triage by rule"
      type = 12
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "SelectedTabPage"
        value         = "triage-by-url"
      }
      content = {
        exportParameters = true
        groupType        = "editable"
        items = [{
          content = {
            crossComponentResources = ["{workspace}"]
            exportFieldName         = "hostname_s"
            exportParameterName     = "HostName"
            gridSettings = {
              formatters = [{
                columnMatch = "hostname_s"
                formatOptions = {
                  customColumnWidthSetting = "100%"
                }
                formatter = 0
              }]
              sortBy = [{
                itemKey   = "hostname_s"
                sortOrder = 1
              }]
            }
            query        = "AzureDiagnostics \r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n| where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}'\r\n| where TimeGenerated {detectionTime}\r\n| distinct hostname_s"
            queryType    = 0
            resourceType = "microsoft.operationalinsights/workspaces"
            size         = 0
            sortBy = [{
              itemKey   = "hostname_s"
              sortOrder = 1
            }]
            title   = "Hostnames with entries in Firewall Log"
            version = "KqlItem/1.0"
          }
          customWidth = "10"
          name        = "Hostnames with entries in Firewall Log"
          type        = 3
          }, {
          content = {
            crossComponentResources = ["{workspace}"]
            exportedParameters = [{
              fieldName     = "requestUri_s"
              parameterName = "RequestUri"
              }, {
              fieldName     = "originalRequestUriWithArgs_s1"
              parameterName = "RequestUriWithArgs"
              parameterType = 1
              }, {
              fieldName     = "httpMethod_s1"
              parameterName = "HttpMethod"
              parameterType = 1
              }, {
              fieldName     = "httpStatus_d1"
              parameterName = "HttpStatus"
              parameterType = 1
              }, {
              parameterType = 1
            }]
            gridSettings = {
              filter = true
              formatters = [{
                columnMatch = "encodedRequestUriWithArgs"
                formatter   = 5
                }, {
                columnMatch = "Id"
                formatter   = 5
              }]
              hierarchySettings = {
                finalBy  = "httpStatus_d1"
                groupBy  = ["requestUri_s", "httpMethod_s1"]
                treeType = 1
              }
              sortBy = [{
                itemKey   = "httpStatus_d1"
                sortOrder = 1
              }]
            }
            query        = "AzureDiagnostics\r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n| where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}'\r\n| where hostname_s == '{HostName}'\r\n| where TimeGenerated {detectionTime}\r\n| join kind=inner (AzureDiagnostics | where Category == \"ApplicationGatewayAccessLog\" | where ResourceId == '{ResourceId}')\r\n  on transactionId_g\r\n| distinct  requestUri_s, httpMethod_s1, originalRequestUriWithArgs_s1, httpStatus_d1\r\n| extend Id = new_guid()\r\n"
            queryType    = 0
            resourceType = "microsoft.operationalinsights/workspaces"
            size         = 0
            sortBy = [{
              itemKey   = "httpStatus_d1"
              sortOrder = 1
            }]
            title   = "Paths which have triggered firewall rules"
            version = "KqlItem/1.0"
          }
          customWidth = "60"
          name        = "Paths which have triggered firewall rules"
          type        = 3
          }, {
          content = {
            crossComponentResources = ["{workspace}"]
            exportFieldName         = "transactionId_g"
            exportParameterName     = "TransactionId"
            gridSettings = {
              formatters = [{
                columnMatch = "transactionId_g"
                formatOptions = {
                  customColumnWidthSetting = "40%"
                }
                formatter = 0
                }, {
                columnMatch = "access_log"
                formatOptions = {
                  bladeOpenContext = {
                    bladeName = "LogsBlade"
                    bladeParameters = [{
                      name   = "resourceId"
                      source = "parameter"
                      value  = "workspace"
                      }, {
                      name   = "query"
                      source = "cell"
                      value  = ""
                    }]
                    extensionName = "Microsoft_Azure_Monitoring_Logs"
                  }
                  linkIsContextBlade = true
                  linkLabel          = "Find in Access Log"
                  linkTarget         = "OpenBlade"
                }
                formatter = 7
                }, {
                columnMatch = "firewall_log"
                formatOptions = {
                  bladeOpenContext = {
                    bladeName = "LogsBlade"
                    bladeParameters = [{
                      name   = "resourceId"
                      source = "parameter"
                      value  = "workspace"
                      }, {
                      name   = "query"
                      source = "cell"
                      value  = ""
                    }]
                    extensionName = "Microsoft_Azure_Monitoring_Logs"
                  }
                  linkIsContextBlade = true
                  linkLabel          = "Find in Firewall Log"
                  linkTarget         = "OpenBlade"
                }
                formatter = 7
              }]
            }
            query        = "AzureDiagnostics\r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n| where ResourceId == '{ResourceId}' and policyScopeName_s == '{PolicyScope}'\r\n| where hostname_s == '{HostName}'\r\n| where TimeGenerated {detectionTime}\r\n| join kind=inner (AzureDiagnostics | where Category == \"ApplicationGatewayAccessLog\" | where ResourceId == '{ResourceId}')\r\n  on transactionId_g\r\n| where originalRequestUriWithArgs_s1 == ```{RequestUriWithArgs}``` and httpMethod_s1 == '{HttpMethod}' and httpStatus_d1 == '{HttpStatus}'\r\n| distinct transactionId_g\r\n| extend access_log = strcat(\"AzureDiagnostics | where Category == \\\"ApplicationGatewayAccessLog\\\" | where TimeGenerated {detectionTime} | where transactionId_g == \\\"\", transactionId_g, \"\\\"\")\r\n| extend firewall_log = strcat(\"AzureDiagnostics | where Category == \\\"ApplicationGatewayFirewallLog\\\" | where TimeGenerated {detectionTime} | where transactionId_g == \\\"\", transactionId_g, \"\\\"\")"
            queryType    = 0
            resourceType = "microsoft.operationalinsights/workspaces"
            size         = 0
            title        = "Requests on selected host and url"
            version      = "KqlItem/1.0"
          }
          customWidth = "25"
          name        = "query - 3"
          type        = 3
          }, {
          content = {
            crossComponentResources = ["{workspace}"]
            exportedParameters = [{
              fieldName     = "transactionId_g"
              parameterName = "TransactionId"
              }, {
              fieldName     = "Message"
              parameterName = "message"
              parameterType = 1
              }, {
              fieldName     = "details_message_s"
              parameterName = "details"
              parameterType = 1
              }, {
              fieldName     = "details_data_s"
              parameterName = "matcheddata"
              parameterType = 1
              }, {
              fieldName     = "Url"
              parameterName = "SpiderLabsUrl"
              parameterType = 1
            }]
            gridSettings = {
              formatters = [{
                columnMatch = "action_s"
                formatOptions = {
                  thresholdsGrid = [{
                    operator       = "=="
                    representation = "2"
                    text           = "{0}{1}"
                    thresholdValue = "Matched"
                    }, {
                    operator       = "=="
                    representation = "4"
                    text           = "{0}{1}"
                    thresholdValue = "Blocked"
                    }, {
                    operator       = "Default"
                    representation = "more"
                    text           = "{0}{1}"
                    thresholdValue = null
                  }]
                  thresholdsOptions = "icons"
                }
                formatter = 18
                }, {
                columnMatch = "ruleId_s"
                formatOptions = {
                  thresholdsGrid = [{
                    operator       = "=="
                    representation = "yellow"
                    text           = "{0}{1}"
                    thresholdValue = "{RuleId}"
                    }, {
                    operator       = "Default"
                    text           = "{0}{1}"
                    thresholdValue = null
                  }]
                  thresholdsOptions = "colors"
                }
                formatter = 18
                }, {
                columnMatch = "Url"
                formatOptions = {
                  linkLabel  = "Go to Core Rule Set Project GitHub for this rule"
                  linkTarget = "Url"
                }
                formatter = 7
                }, {
                columnMatch = "statusFromAction"
                formatter   = 5
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 0
                }
              }]
              labelSettings = [{
                columnId = "action_s"
                label    = "action"
                }, {
                columnId = "ruleId_s"
                label    = "rule id"
                }, {
                columnId = "Message"
                label    = "message"
                }, {
                columnId = "details_message_s"
                label    = "details"
                }, {
                columnId = "details_data_s"
                label    = "matched data"
                }, {
                columnId = "TimeGenerated"
                label    = "time generated"
              }]
            }
            query         = "AzureDiagnostics \r\n| where Category == \"ApplicationGatewayFirewallLog\"\r\n//| where TimeGenerated {detectionTime}\r\n| where transactionId_g == '{TransactionId}'\r\n| extend Id = new_guid()\r\n| project-reorder Id, action_s, ruleSetType_s, ruleSetVersion_s, ruleId_s, Message, hostname_s, requestUri_s, details_message_s, details_data_s, details_file_s, details_line_s, transactionId_g\r\n| extend normalizedRuleSetVersion = case(isempty(ruleSetVersion_s), \"\",\r\n                                         // old engine: rulesetVersion_s looks like \"3.1.0\" while type is \"OWASP_CRS\" => leave untouched, can use this as-is\r\n                                         //             final url to GH is like: https://github.com/coreruleset/coreruleset/blob/v3.1.0/rules/REQUEST-913-SCANNER-DETECTION.conf#L56\r\n                                         ruleSetVersion_s matches regex \"[0-9]+.[0-9]+.[0-9]+\", ruleSetVersion_s,\r\n                                         // new engine: rulesetVersion_s looks like \"3.2\" while type is \"OWASP CRS\" => need a version that looks like \"3.2.0\"\r\n                                         //             final url to GH is like: https://github.com/coreruleset/coreruleset/blob/v3.2.0/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf#L56\r\n                                         ruleSetVersion_s matches regex \"[0-9]+.[0-9]+\", strcat(ruleSetVersion_s, \".0\"),\r\n                                         \"\")\r\n| extend normalizedDetailsFile = case(  ruleSetType_s == \"OWASP_CRS\", replace(@'rules/', '', details_file_s),   // old engine: details_files_s looks like \"rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\" while type is \"OWASP_CRS\"\r\n                                        ruleSetType_s == \"OWASP CRS\", details_file_s,                           // new engine: details_files_s looks like \"REQUEST-920-PROTOCOL-ENFORCEMENT.conf\" while type is \"OWASP CRS\"\r\n                                        details_file_s)\r\n| extend Url = iif(isnotempty(ruleSetVersion_s), strcat('https://github.com/coreruleset/coreruleset/blob/', 'v', normalizedRuleSetVersion, '/rules/', normalizedDetailsFile, '#L', details_line_s), '')\r\n| project action_s, ruleId_s, Message, details_message_s, details_data_s, Url, TimeGenerated, ruleSetType_s, normalizedRuleSetVersion\r\n"
            queryType     = 0
            resourceType  = "microsoft.operationalinsights/workspaces"
            size          = 0
            title         = "Rules that got triggered for selected request"
            version       = "KqlItem/1.0"
            visualization = "table"
          }
          name = "TriggeredRules - By Url"
          type = 3
          }, {
          content = {
            json = "## Selection Summary:\r\n\r\nYou were looking for requests which triggered a WAF rule on url: _{RequestUri}_.  \r\nYou have found an HTTP request, impacted by this rule, with transaction id equal to *{TransactionId}*.  \r\n\r\nMore information on the selected rule which impacted this url, can be found on the [Core Rule Set Project](https://coreruleset.org) GitHub page, here: {SpiderLabsUrl}\r\n\r\n\r\n\r\nMore info on this request and the selected rule:\r\n- Message: {message}\r\n- Details: {details}\r\n- Matched Data: {matcheddata}"
          }
          name = "text - 7 - Copy"
          type = 1
        }]
        version = "NotebookGroup/1.0"
      }
      name = "Triage by URL"
      type = 12
    }]
    version = "Notebook/1.0"
  })
  display_name        = "af-workbook_application-gateway-waf-triage"
  location            = "westeurope"
  name                = "208a024d-8b86-998a-f23d-d88d88914e4c"
  resource_group_name = azurerm_resource_group.res-1.name
  source_id           = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourcegroups/rg-monitoring-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_application_insights_workbook" "res-10" {
  data_json = jsonencode({
    "$schema"           = "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
    fallbackResourceIds = ["azure monitor"]
    fromTemplateId      = "sentinel-UserWorkbook"
    items = [{
      content = {
        json = "## Azure Firewall Workbook\r\n---\r\n"
      }
      name = "text - 23"
      type = 1
      }, {
      content = {
        links = [{
          cellValue  = "selectedTab"
          id         = "20847ce8-91bc-4d8b-b878-a5a41c95c31c"
          linkLabel  = "Azure Firewall Overview"
          linkTarget = "parameter"
          preText    = "Azure Firewall Overview"
          style      = "link"
          subTarget  = "AFOverview"
          }, {
          cellValue  = "selectedTab"
          id         = "f564709d-1658-46a1-8b44-892210e13017"
          linkLabel  = "Azure Firewall - Application rule log statistics"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "AFAppRule"
          }, {
          cellValue  = "selectedTab"
          id         = "1f6661e2-f873-4d56-879d-4d085d8cf1d4"
          linkLabel  = "Azure Firewall - Network rule log statistics"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "AFNetRule"
          }, {
          cellValue  = "selectedTab"
          id         = "ef1548c5-ef55-4eaa-8a81-b049cb93b56c"
          linkLabel  = "Azure Firewall - DNS Proxy"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "AFDNSProxy"
          }, {
          cellValue  = "selectedTab"
          id         = "18a4a585-2176-4d9f-907c-8e8d5f984efa"
          linkLabel  = "Azure Firewall Premium - IDPS"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "AFIDSIPS"
          }, {
          cellValue  = "selectedTab"
          id         = "97dc7364-961d-4c19-a730-7b9024f46b91"
          linkLabel  = "Azure Firewall - Investigation"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "AFInvestigate"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "links - 24"
      type = 11
      }, {
      content = {
        parameters = [{
          id         = "ab7d6c51-d7df-436c-96a2-429163aa50ec"
          isGlobal   = true
          isRequired = true
          name       = "TimeRange"
          type       = 4
          typeSettings = {
            allowCustom = false
            selectableValues = [{
              durationMs = 300000
              }, {
              durationMs = 900000
              }, {
              durationMs = 1800000
              }, {
              durationMs = 3600000
              }, {
              durationMs = 14400000
              }, {
              durationMs = 43200000
              }, {
              durationMs = 86400000
              }, {
              durationMs = 172800000
              }, {
              durationMs = 259200000
              }, {
              durationMs = 604800000
              }, {
              durationMs = 1209600000
              }, {
              durationMs = 2419200000
              }, {
              durationMs = 2592000000
              }, {
              durationMs = 5184000000
              }, {
              durationMs = 7776000000
            }]
          }
          value = {
            durationMs = 1209600000
          }
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::selected"]
          delimiter               = ","
          id                      = "add90eb3-ff5f-4b19-9658-ff15c8043af5"
          isRequired              = true
          multiSelect             = true
          name                    = "Workspaces"
          query                   = "where type =~ 'microsoft.operationalinsights/workspaces'\r\n| project id, name\r\n| order by name desc"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 5
          typeSettings = {
            additionalResourceOptions = ["value::100"]
          }
          value   = ["value::100"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::selected"]
          delimiter               = ","
          id                      = "5084e141-6c56-4d7f-bd8a-09f7ef9af1bc"
          isRequired              = true
          label                   = "Azure Firewalls"
          multiSelect             = true
          name                    = "Resource"
          query                   = "where type =~ 'Microsoft.Network/azureFirewalls'\r\n| project id, name"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 5
          typeSettings = {
            additionalResourceOptions = ["value::all"]
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          description = "This will show some help information to help you understand the page you are on"
          id          = "13d9f6e9-9290-4b1e-b0d0-a7c0ebdc1aed"
          isRequired  = true
          jsonData    = "[\r\n { \"value\": \"Yes\", \"label\": \"Yes\"},\r\n {\"value\": \"No\", \"label\": \"No\", \"selected\":true },\r\n { \"value\": \"Change Log\", \"label\": \"Change Log\"}\r\n]"
          label       = "Show Help"
          name        = "Help"
          type        = 10
          typeSettings = {
            additionalResourceOptions = []
          }
          version = "KqlParameterItem/1.0"
          }, {
          description = "The is only used on the Overview page."
          id          = "68f2cb32-03d4-4307-8eb5-1f66dfc09a85"
          jsonData    = "[\r\n { \"value\": \"Yes\", \"label\": \"Yes\", \"selected\":true},\r\n {\"value\": \"No\", \"label\": \"No\" }\r\n]"
          label       = "Show Resources"
          name        = "FirewallResources"
          type        = 2
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          value   = "No"
          version = "KqlParameterItem/1.0"
          }, {
          description = "Supplied as a value for GeoLocation lookup on queries: Read more here - https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/ipv4-lookup-plugin#ipv4-lookup---matching-rows-only"
          id          = "53aa8daf-29de-40a1-9147-c0970e32fac4"
          jsonData    = "\r\n[\r\n{\r\n\"value\": \"https://raw.githubusercontent.com/datasets/geoip2-ipv4/master/data/geoip2-ipv4.csv\", \"label\": \"GeoLocationDefault\", \"selected\": \"true\"  \r\n}\r\n]\r\n\r\n"
          label       = "GeoLocationCSV"
          name        = "GeoLocation"
          type        = 2
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - 1"
      type = 9
      }, {
      content = {
        groupType = "editable"
        items = [{
          conditionalVisibilities = [{
            comparison    = "isEqualTo"
            parameterName = "Help"
            value         = "Change Log"
            }, {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFOverview"
          }]
          content = {
            json = "### Overview - Change Log\r\n|Version|Description|\r\n|---|---|\r\n|v1.0\t|Initial Version|\r\n|V1.1.0\t|Split up the data sets, Overview, Application Rule Logs, Network Rule Logs, DNS Proxy Logs. Added in Investigation visibility with Azure Firewall + Azure Graph. Added in visibility to multiple workspaces and filtering to Firewall resources. |\r\n|V1.2.0 | Added new filteres, \"Show Help\", \"Show Resources\", \"GeoLocationCSV\", Updated query parsing to the Overview queries. Improved overall performance in large data scale performance with new parsing requirements."
          }
          name = "text - 40"
          type = 1
          }, {
          conditionalVisibilities = [{
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFAppRule"
            }, {
            comparison    = "isEqualTo"
            parameterName = "Help"
            value         = "Change Log"
          }]
          content = {
            json = "### Azure Firewall - App Rules - Change Log\r\n|Version|Description|\r\n|---|---|\r\n|v1.0.0 | Initial Version\r\n|V1.2.0 | Added in new Querires for Azure Firewall features, parsing is now used differently. Added Web Category."
          }
          name = "text - 63"
          type = 1
          }, {
          conditionalVisibilities = [{
            comparison    = "isEqualTo"
            parameterName = "Help"
            value         = "Change Log"
            }, {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFNetRule"
          }]
          content = {
            json = "### Azure Firewall - Network Rule - Change Log\r\n|Version|Description|\r\n|---|---|\r\n|V1.0.0 | Initial Version\r\n|V1.2.0 | Added in new Querires for Azure Firewall features, parsing is now used differently. Added in GeoLocation queries, updated main query to use GeoLocation data."
          }
          name = "text - 64"
          type = 1
          }, {
          conditionalVisibilities = [{
            comparison    = "isEqualTo"
            parameterName = "Help"
            value         = "Change Log"
            }, {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFDNSProxy"
          }]
          content = {
            json = "### Azure Firewall - DNSProxy - Change Log\r\n|Version|Description|\r\n|---|---|\r\n|V1.1.0 | Initial Version\r\n|V1.2.0 | No modifications were made"
          }
          name = "text - 65"
          type = 1
          }, {
          conditionalVisibilities = [{
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFIDSIPS"
            }, {
            comparison    = "isEqualTo"
            parameterName = "Help"
            value         = "Change Log"
          }]
          content = {
            json = "### Azure Firewall Prem - IDPS - Change Log\r\n|Version|Description|\r\n|---|---|\r\n|V1.2.0 | Initial Version"
          }
          name = "text - 66"
          type = 1
          }, {
          conditionalVisibilities = [{
            comparison    = "isEqualTo"
            parameterName = "Help"
            value         = "Change Log"
            }, {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFInvestigate"
          }]
          content = {
            json = "### Azure Firewall Prem - IDPS - Change Log\r\n|Version|Description|\r\n|---|---|\r\n|V1.0.0 | Initial Version\r\n|V1.2.0 | Added IDPS Logs to the investgation experience, Added in GeoLocation infromation. Updated the KQL logic to be faster for large data volume."
          }
          name = "text - 67"
          type = 1
        }]
        version = "NotebookGroup/1.0"
      }
      name = "ChangeLogGroup"
      type = 12
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "Help"
        value         = "Yes"
      }
      content = {
        groupType = "editable"
        items = [{
          conditionalVisibility = {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFOverview"
          }
          content = {
            json = "##### What's on this page?\r\n\r\nThe Azure Firewall - Overview page has the following features.\r\n\r\n- All Firewall Data Log Analytics Volume (Total)\r\n- All Firewall Data Log Analytics Volume (Per Firewall)\r\n- All Firewall Event Categories\r\n- All Firewall Event Categories over time\r\n- Azure Firewall Metrics data\r\n  - Traffic\r\n  - SNAT Port\r\n  - Network Rule Count\r\n  - Application Rule Count\r\n\r\n##### How to use this page?\r\n\r\nStart by looking at the workbook filters, examples would be TimeRange, Workspace, Azure Firewall. Note these are filtered based on your azure portal settings of \"Default subscription filter\". Selecting more resources or more workspaces has an impact on speed of results depending on the data volume of your workspaces. Why TimeRange is a large factor when looking at looking at extremely large data sets of volume(example over 1 Billion logs) so multiple filters have been offered to finetune the results without having to build your own queries.\r\n\r\nIf this is your first time looking at this workbook, my suggestion is to use 14 days(this is the fastest cached data in Log Analytics), a single workspace, a single firewall, if you're wanting to see the results of one firewall. Best to know where your firewall is sending it's logs too to confirm you didn't select a workspace that doesn't have that firewalls data. How to check, go to the Azure Firewall, click Diagnostic settings, see what Log Analytics workspace is currently configured.\r\n\r\n##### What's required for this workbook to function?\r\n\r\n- Azure Firewall Diagnostic settings enabled, and sending to workspace your azure ad user had RBAC permissions to. You need a minimum of read rights to the AzureDiagnostics table within the Log Analytics workspace.\r\n- Azure Metrics requires resource permissions of the Firewall you're wanting data on. "
          }
          name = "text - 59"
          type = 1
          }, {
          conditionalVisibility = {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFAppRule"
          }
          content = {
            json = "##### What's on this page?\r\n\r\nThe Azure Firewall - Application rule log statistics page has the following features.\r\n\r\nAnything that can be used as a filter within the workbook, you'll see a * next to it. If it's filterable, this mean you can click on something within the data set that will be pushed down the workbook for more additional filtering.\r\n\r\n- Unique Source IP Address*\r\n- Application Rule Usage\r\n- Denied/Allowed FQDN over time\r\n- Denied/Allowed FQDN count\r\n- Denied/Allowed Web Categories over time\r\n- Denied/Allowed Web Categories count\r\n- Pre-parsed Azure Firewall Application Rule Logs with a search feature.\r\n\r\n##### How to use this page?\r\n\r\nIf  you're not comfortable with the filters on this workbook, my suggestion is to use the get-help on the overview page to get started.\r\n\r\nStarting out you'll see the unique source of IP addresses based on the global filters you have in place, this is showing only the top 10 IPAddresses, you can modify the KQL query to show more if needed if you click the \"Edit\" button. We added in the logic to show the volume over time, under the IP address/count information. If you click on the highest count (my example is 415,786 count, 10.0.24.4 ipaddress) it'll filter everything on the Application rule log statistic page to this IP address specifically. (Only Exception is the Rule Usage). Note this could cause other data sets to become blank as a result, sometimes you only have Approved or Denied access based on the configuration of the firewall.\r\n\r\nIf you're wanting to search for something a little more specific other than IPAddress filter, you can use the \"Search\" bar under the \"All IP Address events\" query to create a custom filter to the parsed logs. Example could be an FQDN \"wdcp.microsoft.com\" to pull up those logs specifically with that name in it.\r\n\r\n##### What's required for this workbook to function?\r\n\r\n- Azure Firewall Diagnostic settings enabled, specifically requires Application Diagnostic logs to be enabled for the workspace. You need a minimum of read rights to the AzureDiagnostics table within the Log Analytics workspace."
          }
          name = "text - 1"
          type = 1
          }, {
          conditionalVisibility = {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFNetRule"
          }
          content = {
            json = "##### What's on this page?\r\n\r\nThe Azure Firewall - Network rule log statistics page has the following features.\r\n\r\nAnything that can be used as a filter within the workbook, you'll see a * next to it. If it's filterable, this mean you can click on something within the data set that will be pushed down the workbook for more additional filtering.\r\n\r\n- Rule Actions*\r\n\r\n- Target Ports*\r\n\r\n- DNAT Actions*\r\n\r\n- GeoLocation\r\n\r\n- Actions over time(Time scrub enabled)\r\n\r\n- Pre-parsed Network Rule data with GeoLocation added\r\n\r\n  *Note: GeoLocation is using an public file, you have to modify your GeoLocation Global Filter tab to add your own data.*\r\n\r\n##### How to use this page?\r\n\r\nIf  you're not comfortable with the filters on this workbook, my suggestion is to use the get-help on the overview page to get started.\r\n\r\nStarting out you'll get see pie charts on the screen, each of these can be clicked on to filter the data below. You'll have to click on the color of the wheel in order to use the filter feature. Downfall of this, if it's an extremely small data set, its hard to click on that color due to the challenge of even seeing it. These filters are a top down approach, meaning what clicked on top, filters below. If you'd like, feel free to test this out now. Under \"Target Ports, filterable by Target Port\" find port 53 ( pretty common port). Click on the wheel with the color that's associated to port 53. You'll see everything change below only showing data that has port 53 associated to it. If you'd like to remove this filter you have a few options. \r\n\r\n1. Click the \"Go back\" at the top right of the wheel\r\n2. Refresh the whole workbook\r\n3. Refresh the whole browser window\r\n\r\n*A note about the new feature added \"GeoLocation\", this is public data shared through the Log Analytics developer team to show the feature to associate IP addresses with a GeoLocation file. This had been added to the workbook to show you what's possible, it's encouraged for you to use your own data which could be further enriched. If you had Lat/Long data, you could even add in a map feature into this workbook to show you where the traffic is mostly.*\r\n\r\nMid-way down the page you'll see the \"Actions, by time\", if we saw a large spike and wanted to lower the window of traffic, select on the left side(where you're wanting to start, before the event occurred) drag, and move it over to the right. Example March 24th - March 27th. When i was looking over 14 days of time. This will filter the \"All IP Addresses events\" down to this new time window.\r\n\r\n##### What's required for this workbook to function?\r\n\r\n- Azure Firewall Diagnostic settings enabled, specifically requires Network Diagnostic logs to be enabled for the workspace. You need a minimum of read rights to the AzureDiagnostics table within the Log Analytics workspace."
          }
          name = "text - 2"
          type = 1
          }, {
          conditionalVisibility = {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFDNSProxy"
          }
          content = {
            json = "##### What's on this page?\r\n\r\nThe Azure Firewall - DNS Proxy page has the following features.\r\n\r\nAnything that can be used as a filter within the workbook, you'll see a * next to it. If it's filterable, this mean you can click on something within the data set that will be pushed down the workbook for more additional filtering.\r\n\r\n- DNS Traffic by count (Time scrub enabled)\r\n- DNS Proxy by Request Name, by Count*\r\n- DNS Proxy Request by ClientIP, by Count*\r\n- Count over time of Proxy Requests by ClientIP\r\n- Pre-parsed DNS Proxy data\r\n\r\n##### How to use this page?\r\n\r\nIf  you're not comfortable with the filters on this workbook, my suggestion is to use the get-help on the overview page to get started.\r\n\r\nStarting out you'll see the DNS Proxy traffic count, this is a great way to start to narrow down the proxy traffic over a period of time. Example we're looking at the 14 day window, but there was an odd spike or dip in proxy traffic, why? use the time scrub feature to select on the left side(where you're wanting to start, before the event occurred) drag, and move it over to the right. Example March 24th - March 27th.\r\n\r\nAfter adding our second time filter to the page, move forward to looking at the DNS requests. You might see a large spike in a specific DNS request, could be something you're not even familiar with. Using an example, i see a DNS request for \"md-fpp31tsvhx4s.blob.core.windows.net\" for 300K times in my current filters. By selecting this Request Name, it'll filter on the right showing me which clients are requesting this DNS traffic. Which after clicking on my request, i see 2 different IP addresses now. Oddly though, one is much smaller than the other. Lets select that Ip address to add an additional filter to the logs. Now we can see the logs related to that machine client ip, specifically around that DNS request name. This might help you narrow down if there are any actions that need to be taken on your firewall.\r\n\r\n##### What's required for this workbook to function?\r\n\r\n- Azure Firewall Diagnostic settings enabled, specifically requires DNS Proxy Diagnostic logs to be enabled for the workspace. You need a minimum of read rights to the AzureDiagnostics table within the Log Analytics workspace."
          }
          name = "text - 3"
          type = 1
          }, {
          conditionalVisibility = {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFIDSIPS"
          }
          content = {
            json = "##### What's on this page?\r\n\r\nThe Azure Firewall Premium- IDPS page has the following features.\r\n\r\n*As noted on the title, these logs are only created on the Azure Firewall Premium sku*\r\n\r\nAnything that can be used as a filter within the workbook, you'll see a * next to it. If it's filterable, this mean you can click on something within the data set that will be pushed down the workbook for more additional filtering.\r\n\r\n- IDPS Actions Count*\r\n- IDPS Protocol Count*\r\n- IDPS SignatureID Count*\r\n- IDPS SourceIP Count*\r\n- Azure Firewall IDPS count over time (Time Scrub Enabled)\r\n- Azure Firewall IDPS logs with GeoLocation\r\n\r\n##### How to use this page?\r\n\r\nIf  you're not comfortable with the filters on this workbook, my suggestion is to use the get-help on the overview page to get started.\r\n\r\nStarting out you'll see Pie Charts offering multiple filtering options to your IDPS logs, showing Alerts, Protocols, SignatureIDs and Sources of the logs. Lets start by selecting an ClientIP address(SourceIP) under the \"IDPS SourceIP Count, filterable by SourceIP\". I clicked on the largest one, you might of noticed most of the traffic under the IDPS logs are alerts, Mostly TCP to this ClientIP address and there could be some specific SignatureID's are being triggered. Looking further into the logs, you should expand the Source IP to see the different IP Addresses this client has talked to within the past 14 days(current global filter). The majority of the traffic is going to XX.XX.XX.XX, which is something to remember.\r\n\r\nGoing further down, you might noticed a spike in traffic, lets use the time scrub feature to narrow down the time window to that spike. Start by selecting on the left side(where you're wanting to start time to be, before the event occurred) drag, and move it over to the right(the end time). Example March 24th - March 27th.\r\n\r\n*Note; The GeoLocation + Data can take a long time to refresh.*\r\n\r\nYou should now be able to see data we filtered down to, with it based on  GeoLocation/Signature ID's\r\n\r\n##### What's required for this workbook to function?\r\n\r\n- Azure Firewall Premium Diagnostic settings enabled, specifically requires IDPS Diagnostic logs to be enabled for the workspace. You need a minimum of read rights to the AzureDiagnostics table within the Log Analytics workspace."
          }
          name = "text - 4"
          type = 1
          }, {
          conditionalVisibility = {
            comparison    = "isEqualTo"
            parameterName = "selectedTab"
            value         = "AFInvestigate"
          }
          content = {
            json = "##### What's on this page?\r\n\r\nThe Azure Firewall - Investigation page has the following features.\r\n\r\n*Note, this is a combination of all the logs within the Azure Firewall workbook. Some logs are from the Azure Firewall Premium sku*\r\n\r\nAnything that can be used as a filter within the workbook, you'll see a * next to it. If it's filterable, this mean you can click on something within the data set that will be pushed down the workbook for more additional filtering.\r\n\r\n- IFQDN Traffic by Count*\r\n- SourceIP Address*\r\n- SourceIPAddress Resource Lookup (Azure Resource Graph)\r\n- FQDN Lookup logs\r\n- Azure Firewall Threat Intel\r\n- Azure Firewall Premium with GeoLocation- IDPS\r\n\r\n##### How to use this page?\r\n\r\nIf  you're not comfortable with the filters on this workbook, my suggestion is to use the get-help on the overview page to get started.\r\n\r\nThis is the page where we narrow down everything, You should considering adding your own twist based on your own investigations to this page. Leverage this as a template of where to start and how to move forward.\r\n\r\nStarting out we see FQDN and IP Address are the page's first filters offered.\r\n\r\nLooking at source count, you might see something that has a large count. Like the following example \"watson.telemetry.microsoft.com\".  Click on the \"Deny\"/'Count' line to use the filter feature for the whole page.\r\n\r\nThis narrowed down our large list of client (SourceIP) address to a smaller list, which could be used to find out which client is being the loudest or maybe something that sneaked in that wasn't suppose to be talking to this FQDN in the first place. Click on an IPAddress(SourceIP). \r\n\r\nAzure Resource Graph is then used to find which machine this is, which Azure Resource NIC, Public IP address, Subnet, etc.\r\n\r\nUse the other data sets to help see the logs you've filtered based on the FQDN + IPAddress above. \r\n\r\n*Note, FQDN isn't required for the Azure Resource Graph lookup.*\r\n\r\nSome log sources might be blank, that's perfectly acceptable in this scenario as we're filtering down to alerts and events.\r\n\r\n##### What's required for this workbook to function?\r\n\r\n- All Azure Firewall Diagnostic Logs\r\n- RBAC Permissions for Azure Resource Graph lookup."
          }
          name = "text - 5"
          type = 1
        }]
        version = "NotebookGroup/1.0"
      }
      name = "Get-Help"
      type = 12
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        json = "# Azure Firewall - overview"
      }
      name = "Main title"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "FirewallResources"
        value         = "Yes"
      }
      content = {
        crossComponentResources = ["value::selected"]
        gridSettings = {
          formatters = [{
            columnMatch = "Premium"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "green"
                text           = "{0}{1}"
                thresholdValue = "Yes"
                }, {
                operator       = "=="
                representation = "grayBlue"
                text           = "{0}{1}"
                thresholdValue = "No"
                }, {
                operator       = "Default"
                representation = null
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "colors"
            }
            formatter = 18
            }, {
            columnMatch = "Standard"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "green"
                text           = "{0}{1}"
                thresholdValue = "Yes"
                }, {
                operator       = "=="
                representation = "grayBlue"
                text           = "{0}{1}"
                thresholdValue = "No"
                }, {
                operator       = "Default"
                representation = null
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "colors"
            }
            formatter = 18
            }, {
            columnMatch = "ProvisionedState"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "green"
                text           = "{0}{1}"
                thresholdValue = "Running"
                }, {
                operator       = "=="
                representation = "grayBlue"
                text           = "{0}{1}"
                thresholdValue = "Not Running"
                }, {
                operator       = "Default"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "colors"
            }
            formatter = 18
            }, {
            columnMatch = "ApplicationRuleClassic"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "gray"
                text           = "{0}{1}"
                thresholdValue = "N/A"
                }, {
                operator       = "Default"
                representation = "green"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "colors"
            }
            formatter = 18
            }, {
            columnMatch = "NetworkRuleClassic"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "gray"
                text           = "{0}{1}"
                thresholdValue = "N/A"
                }, {
                operator       = "Default"
                representation = "green"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "colors"
            }
            formatter = 18
          }]
        }
        query        = "where type =~ 'Microsoft.Network/azureFirewalls'\r\n| extend Tier = trim(' ', tostring(properties.sku.tier))\r\n| extend Status = trim(' ', tostring(iif(isempty(properties.ipConfigurations.[0].properties.provisioningState),properties.provisioningState,properties.ipConfigurations.[0].properties.provisioningState)))\r\n| extend Premium = iff(Tier == \"Premium\", \"Yes\", \"No\")\r\n| extend Standard = iff(Tier == \"Standard\", \"Yes\", \"No\")\r\n| extend ProvisionedState = iff(Status == \"Succeeded\", \"Running\", \"Not Running\")\r\n| extend Policy = trim(' ', tostring(properties.firewallPolicy.id))\r\n| extend ApplicationRule1 = trim(' ', tostring(properties.applicationRuleCollections.[0].id))\r\n| extend ApplicationRule2 = trim(' ', tostring(properties.applicationRuleCollections.[0].id))\r\n| extend ApplicationRule3 = iff(ApplicationRule1 == \"\", \"N/A\", \"\")\r\n| extend ApplicationRule4 = iff(ApplicationRule2 contains \"subscription\", \"Configured\", \"\")\r\n| extend ApplicationRuleClassic = strcat(ApplicationRule3, ApplicationRule4)\r\n| extend NetworkRule1 = trim(' ', tostring(properties.networkRuleCollections.[0].id))\r\n| extend NetworkRule2 = trim(' ', tostring(properties.networkRuleCollections.[0].id))\r\n| extend NetworkRule3 = iff(NetworkRule1 == \"\", \"N/A\", \"\")\r\n| extend NetworkRule4 = iff(NetworkRule1 contains \"subscription\", \"Configured\", \"\")\r\n| extend NetworkRuleClassic = strcat(NetworkRule3, NetworkRule4)\r\n| project Firewall=id, Premium, Standard, ProvisionedState,FirewallPolicy= Policy, ApplicationRuleClassic, NetworkRuleClassic, location, resourceGroup, subscriptionId, tenantId"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 1
        title        = "Azure Firewall Resource List"
        version      = "KqlItem/1.0"
      }
      customWidth = "100"
      name        = "query - 60"
      styleSettings = {
        margin = "0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no firewall events being feed within the selected workspaces. If you believe the selection is correct, confirm logging has been enabled for the Azure Firewall and feeding into the selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 4
        query                    = "AzureDiagnostics \r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where ResourceType == \"AZUREFIREWALLS\" \r\n| summarize Volume=count() by bin(TimeGenerated, {TimeRange:grain})"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Events, by time: Query Time({$queryTime})"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      customWidth = "25"
      name        = "query - 16"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportDefaultValue      = "{\"Resource\":\"*\",\"ResourceGroup\":\"*\"}"
        exportParameterName     = "TopEvent"
        noDataMessage           = "There are no firewall events being feed within the selected workspaces. If you believe the selection is correct, confirm logging has been enabled for the Azure Firewall and feeding into the selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle      = 4
        query                   = "AzureDiagnostics\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where ResourceType == \"AZUREFIREWALLS\" \r\n| summarize Volume=count() by Resource, bin(TimeGenerated, {TimeRange:grain})"
        queryType               = 0
        resourceType            = "microsoft.operationalinsights/workspaces"
        size                    = 0
        tileSettings = {
          leftContent = {
            columnMatch = "amount"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "Resource"
            formatter   = 1
          }
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Events, by firewall over time: Query Time({$queryTime})"
        version                  = "KqlItem/1.0"
        visualization            = "linechart"
      }
      customWidth = "25"
      name        = "Firewall per Resource Group"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportDefaultValue      = "*"
        exportFieldName         = "Category"
        exportParameterName     = "SelectedCategory"
        noDataMessage           = "There are no firewall events being feed within the selected workspaces. If you believe the selection is correct, confirm logging has been enabled for the Azure Firewall and feeding into the selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle      = 4
        query                   = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| project Category, ResourceType, OperationName);\r\nunion\r\n(\r\nmaterializedData\r\n    | where OperationName == \"AzureFirewallIDSLog\"\r\n    | summarize Volume=count() by OperationName\r\n    | project Category=OperationName, Volume\r\n),\r\n(\r\nmaterializedData\r\n    | where OperationName == \"AzureFirewallThreatIntelLog\"\r\n    | summarize Volume=count() by OperationName\r\n    | project Category=OperationName, Volume\r\n),\r\n(\r\nmaterializedData\r\n    | where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n    | where OperationName <> \"AzureFirewallIDSLog\"\r\n    | summarize Volume=count() by Category\r\n)\r\n| sort by Volume desc"
        queryType               = 0
        resourceType            = "microsoft.operationalinsights/workspaces"
        size                    = 0
        tileSettings = {
          leftContent = {
            columnMatch = "Volume"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = false
          titleContent = {
            columnMatch = "Category"
            formatter   = 1
          }
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Events, by category: Query Time({$queryTime})"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "Events by category"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no firewall events being feed within the selected workspaces. If you believe the selection is correct, confirm logging has been enabled for the Azure Firewall and feeding into the selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 4
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| project Category, ResourceType, OperationName, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n    | where OperationName == \"AzureFirewallIDSLog\"\r\n    | summarize Volume=count() by OperationName, bin(TimeGenerated, {TimeRange:grain})\r\n    | project Category=OperationName, Volume, TimeGenerated\r\n),\r\n(\r\nmaterializedData\r\n    | where OperationName == \"AzureFirewallThreatIntelLog\"\r\n    | summarize Volume=count() by OperationName, bin(TimeGenerated, {TimeRange:grain})\r\n    | project Category=OperationName, Volume, TimeGenerated\r\n),\r\n(\r\nmaterializedData\r\n    | where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n    | where OperationName <> \"AzureFirewallIDSLog\"\r\n    | summarize Volume=count() by Category, bin(TimeGenerated, {TimeRange:grain})\r\n)\r\n| sort by Volume desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Events categories, by time: Query Time({$queryTime})"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      customWidth = "25"
      name        = "Events categories by time"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        json  = "### Firewall Metrics\r\nThe data below dosen't read from the Log Analytics workpsace, it's reading directly from the resources which requires resource visibility. \r\nClick [here for more information on Azure Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-metrics)\r\n"
        style = "info"
      }
      name = "text - 39"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        chartId   = "workbook76864ed5-dd34-42d0-ae35-f3db9f9e8f15"
        chartType = 2
        gridSettings = {
          rowLimit = 10000
        }
        metricScope = 0
        metrics = [{
          aggregation = 4
          columnName  = "All Firewall Throughput Average"
          metric      = "microsoft.network/azurefirewalls--Throughput"
          namespace   = "microsoft.network/azurefirewalls"
          splitBy     = null
        }]
        resourceIds       = ["{Resource}"]
        resourceParameter = "Resource"
        resourceType      = "microsoft.network/azurefirewalls"
        size              = 0
        timeContext = {
          durationMs = 1209600000
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Average Throughput of Firewall Traffic"
        version                  = "MetricsItem/2.0"
      }
      customWidth = "50"
      name        = "metric - 25"
      type        = 10
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        chartId   = "workbook76864ed5-dd34-42d0-ae35-f3db9f9e8f15"
        chartType = 2
        gridSettings = {
          rowLimit = 10000
        }
        metricScope = 0
        metrics = [{
          aggregation = 4
          metric      = "microsoft.network/azurefirewalls--SNATPortUtilization"
          namespace   = "microsoft.network/azurefirewalls"
          splitBy     = null
        }]
        resourceIds       = ["{Resource}"]
        resourceParameter = "Resource"
        resourceType      = "microsoft.network/azurefirewalls"
        size              = 0
        timeContext = {
          durationMs = 1209600000
        }
        timeContextFromParameter = "TimeRange"
        title                    = "SNAT Port Utilization"
        version                  = "MetricsItem/2.0"
      }
      customWidth = "50"
      name        = "metric - 25 - Copy"
      type        = 10
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        chartId   = "workbook76864ed5-dd34-42d0-ae35-f3db9f9e8f15"
        chartType = 2
        gridSettings = {
          rowLimit = 10000
        }
        metricScope = 0
        metrics = [{
          aggregation = 1
          metric      = "microsoft.network/azurefirewalls--NetworkRuleHit"
          namespace   = "microsoft.network/azurefirewalls"
          splitBy     = null
        }]
        resourceIds       = ["{Resource}"]
        resourceParameter = "Resource"
        resourceType      = "microsoft.network/azurefirewalls"
        size              = 0
        timeContext = {
          durationMs = 1209600000
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Network Rule Hitcount (SUM)"
        version                  = "MetricsItem/2.0"
      }
      customWidth = "50"
      name        = "metric - 25 - Copy - Copy"
      type        = 10
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFOverview"
      }
      content = {
        chartId   = "workbook76864ed5-dd34-42d0-ae35-f3db9f9e8f15"
        chartType = 2
        gridSettings = {
          rowLimit = 10000
        }
        metricScope = 0
        metrics = [{
          aggregation = 1
          metric      = "microsoft.network/azurefirewalls--ApplicationRuleHit"
          namespace   = "microsoft.network/azurefirewalls"
          splitBy     = null
        }]
        resourceIds       = ["{Resource}"]
        resourceParameter = "Resource"
        resourceType      = "microsoft.network/azurefirewalls"
        size              = 0
        timeContext = {
          durationMs = 1209600000
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Application Rule Hitcount (SUM)"
        version                  = "MetricsItem/2.0"
      }
      customWidth = "50"
      name        = "metric - 25 - Copy - Copy - Copy"
      type        = 10
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        json = "---\r\n# Azure Firewall - Application rule log statistics"
      }
      name = "text - 14"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportDefaultValue      = "*"
        exportFieldName         = "SourceIP"
        exportParameterName     = "SelectedSourceIP"
        noDataMessage           = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle      = 2
        query                   = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project ResourceId,ResourceGroup,SubscriptionId, msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| summarize Amount=count() by SourceIP\r\n| join kind = inner\r\n( union (\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n    | make-series Trend = count() default = 0 on bin(TimeGenerated, 1d) from {TimeRange:start} to {TimeRange:end} step {TimeRange:grain} by SourceIP) on SourceIP\r\n    | project-away SourceIP1, TimeGenerated\r\n    | top 10 by Amount\r\n    | sort by Amount\r\n"
        queryType               = 0
        resourceType            = "microsoft.operationalinsights/workspaces"
        size                    = 1
        tileSettings = {
          secondaryContent = {
            columnMatch = "Trend"
            formatOptions = {
              showIcon = true
            }
            formatter = 9
          }
          showBorder = false
          subtitleContent = {
            columnMatch = "SourceIP"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
          titleContent = {
            columnMatch = "Amount"
            formatOptions = {
              showIcon = true
            }
            formatter = 12
          }
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Unique Source IP addresses, filterable by SelectedSourceIP: Query Time ({$queryTime})"
        version                  = "KqlItem/1.0"
        visualization            = "tiles"
      }
      customWidth = "50"
      name        = "query - 4"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "Count"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
            }, {
            columnMatch = "last_log"
            formatOptions = {
              palette = "greenRed"
            }
            formatter = 8
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 24
            }
          }]
          sortBy = [{
            itemKey   = "$gen_heatmap_last_log_4"
            sortOrder = 1
          }]
        }
        noDataMessage      = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle = 2
        query              = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| summarize Count = count(), last_log = datetime_diff(\"second\", now(), max(TimeGenerated)) by RuleCollection, Rule, WebCategory"
        queryType          = 0
        resourceType       = "microsoft.operationalinsights/workspaces"
        size               = 1
        sortBy = [{
          itemKey   = "$gen_heatmap_last_log_4"
          sortOrder = 1
        }]
        timeContextFromParameter = "TimeRange"
        title                    = "Application Rule Usage : Query Time ({$queryTime})"
        version                  = "KqlItem/1.0"
      }
      customWidth = "50"
      name        = "query - 36"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        noDataMessage           = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle      = 2
        query                   = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where Action == \"Deny\"\r\n| where '{SelectedSourceIP}' == SourceIP or '{SelectedSourceIP}' == \"*\"  \r\n| summarize count() by FQDN, bin(TimeGenerated,{TimeRange:grain})"
        queryType               = 0
        resourceType            = "microsoft.operationalinsights/workspaces"
        size                    = 0
        tileSettings = {
          showBorder = false
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Denied FQDN's over time"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      customWidth = "50"
      name        = "query - 3"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
          sortBy = [{
            itemKey   = "$gen_heatmap_count__1"
            sortOrder = 2
          }]
        }
        noDataMessage      = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle = 2
        query              = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where Action == \"Deny\"\r\n| where '{SelectedSourceIP}' == SourceIP or '{SelectedSourceIP}' == \"*\"  \r\n| summarize count() by FQDN\r\n| sort by count_ desc\r\n"
        queryType          = 0
        resourceType       = "microsoft.operationalinsights/workspaces"
        showAnalytics      = true
        showExportToExcel  = true
        size               = 0
        sortBy = [{
          itemKey   = "$gen_heatmap_count__1"
          sortOrder = 2
        }]
        timeContextFromParameter = "TimeRange"
        title                    = "Denied FQDN's by count"
        version                  = "KqlItem/1.0"
        visualization            = "table"
      }
      customWidth = "50"
      name        = "query - 7"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n) \r\n| where Action == \"Allow\"\r\n| summarize count() by FQDN, bin(TimeGenerated,{TimeRange:grain})\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Allowed FQDN's over time"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      customWidth = "50"
      name        = "query - 5"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
        }
        noDataMessage            = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where Action == \"Allow\"\r\n| where '{SelectedSourceIP}' == SourceIP or '{SelectedSourceIP}' == \"*\"   \r\n| summarize count() by FQDN\r\n| sort by count_ desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showAnalytics            = true
        showExportToExcel        = true
        size                     = 0
        sortBy                   = []
        timeContextFromParameter = "TimeRange"
        title                    = "Allowed FQDN's by count"
        version                  = "KqlItem/1.0"
        visualization            = "table"
      }
      customWidth = "50"
      name        = "query - 2"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        chartSettings = {
          showLegend = true
        }
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where isnotempty(WebCategory)\r\n| where Action == \"Allow\"\r\n| where '{SelectedSourceIP}' == SourceIP or '{SelectedSourceIP}' == \"*\"  \r\n| summarize count() by WebCategory, bin(TimeGenerated,{TimeRange:grain})\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Allowed Web Categories over time"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      customWidth = "50"
      name        = "query - 5 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        chartSettings = {
          showLegend = true
        }
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
        }
        noDataMessage            = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where isnotempty(WebCategory)\r\n| where Action == \"Allow\"\r\n| where '{SelectedSourceIP}' == SourceIP or '{SelectedSourceIP}' == \"*\"\r\n| summarize count() by WebCategory\r\n| sort by count_ desc\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Allowed Web Categories by count"
        version                  = "KqlItem/1.0"
      }
      customWidth = "50"
      name        = "query - 5 - Copy - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        chartSettings = {
          showLegend = true
        }
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where isnotempty(WebCategory)\r\n| where Action == \"Deny\"\r\n| where '{SelectedSourceIP}' == SourceIP or '{SelectedSourceIP}' == \"*\"  \r\n| summarize count() by WebCategory, bin(TimeGenerated,{TimeRange:grain})\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Denied Web Categories over time"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      customWidth = "50"
      name        = "query - 5 - Copy - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
        }
        noDataMessage            = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where isnotempty(WebCategory)\r\n| where Action == \"Deny\"\r\n| where '{SelectedSourceIP}' == SourceIP or '{SelectedSourceIP}' == \"*\"\r\n| summarize count() by WebCategory\r\n| sort by count_ desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showAnalytics            = true
        showExportToExcel        = true
        size                     = 0
        sortBy                   = []
        timeContextFromParameter = "TimeRange"
        title                    = "Denied Web Catgories by count"
        version                  = "KqlItem/1.0"
        visualization            = "table"
      }
      customWidth = "50"
      name        = "query - 2 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFAppRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          filter   = true
          rowLimit = 2000
        }
        noDataMessage            = "There are no Application Rule logs within the selected workspaces. If you believe the selection is correct, confirm Application Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project ResourceId,ResourceGroup,SubscriptionId, msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where '{SelectedSourceIP}' == SourceIP or '{SelectedSourceIP}' == \"*\"  \r\n| summarize by TimeGenerated, FQDN, Protocol, Action, SourceIP, SourcePort, DestinationPort , ResourceId , ResourceGroup , RuleCollection, Rule, WebCategory, SubscriptionId\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showAnalytics            = true
        showExportToExcel        = true
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "All IP addresses events: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
      }
      name = "query - 9"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        json = "---\r\n# Azure Firewall - Network rule log statistics"
      }
      name = "text - 14"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        exportDefaultValue       = "*"
        exportFieldName          = "series"
        exportParameterName      = "RuleAction"
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| summarize count() by Action"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 3
        timeContextFromParameter = "TimeRange"
        title                    = "Rule actions, filterable by RuleAction"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "query - 7"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        exportDefaultValue       = "*"
        exportFieldName          = "series"
        exportParameterName      = "DestinationPort"
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| summarize Count=count() by DestinationPort"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 3
        timeContextFromParameter = "TimeRange"
        title                    = "Target ports, filterable by TargetPort"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "query - 10"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        exportDefaultValue       = "*"
        exportFieldName          = "series"
        exportParameterName      = "NatDestination"
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| where Action == \"DNAT'ed\"\r\n| summarize Amount=count() by NatDestination\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 3
        timeContextFromParameter = "TimeRange"
        title                    = "DNAT actions, filterable by NatDestination"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "query - 12"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        exportDefaultValue       = "*"
        exportFieldName          = "series"
        exportParameterName      = "netcontinent"
        query                    = "//reference list posted here : https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/ipv4-lookup-plugin\r\nlet geoData = externaldata\r\n(network:string,geoname_id:string,continent_code:string,continent_name:string,\r\ncountry_iso_code:string,country_name:string,is_anonymous_proxy:string,is_satellite_provider:string)\r\n[@\"{GeoLocation}\"] with (ignoreFirstRecord=true, format=\"csv\");\r\nlet materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| project DestinationIP\r\n| evaluate ipv4_lookup (geoData, DestinationIP,  network, false)\r\n| summarize count() by continent_name\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showRefreshButton        = true
        size                     = 2
        timeContextFromParameter = "TimeRange"
        title                    = "GeoLocation"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "query - 61"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "Action"
            formatter   = 5
            }, {
            columnMatch = "amount"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 3
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
              }
              unit = 17
            }
            }, {
            columnMatch = "eventCount"
            formatOptions = {
              min     = 0
              palette = "blue"
            }
            formatter = 3
          }]
          hierarchySettings = {
            expandTopLevel = false
            finalBy        = "Action"
            groupBy        = ["Action"]
            treeType       = 1
          }
          rowLimit = 2000
        }
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| where '{DestinationPort}' == DestinationPort or '{DestinationPort}' == \"*\"\r\n| where \"{RuleAction}\" == Action or \"{RuleAction}\" == \"*\"\r\n| where '{NatDestination}' == NatDestination or '{NatDestination}' == \"*\"\r\n| summarize amount = count() by Action , SourceIP\r\n| sort by amount desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Rule actions, by IP addresses"
        version                  = "KqlItem/1.0"
        visualization            = "table"
      }
      customWidth = "25"
      name        = "query - 8"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "DestinationPort"
            formatter   = 5
            }, {
            columnMatch = "AMOUNT"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 3
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
          hierarchySettings = {
            expandTopLevel = false
            groupBy        = ["DestinationPort"]
            treeType       = 1
          }
          rowLimit = 2000
        }
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| where '{DestinationPort}' == DestinationPort or '{DestinationPort}' == \"*\"\r\n| where \"{RuleAction}\" == Action or \"{RuleAction}\" == \"*\"\r\n| where '{NatDestination}' == NatDestination or '{NatDestination}' == \"*\"   \r\n| summarize AMOUNT=count() by DestinationPort, SourceIP\r\n| sort by AMOUNT desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Target ports, by Source IP: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
        visualization            = "table"
      }
      customWidth = "25"
      name        = "query - 11"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| where Action == \"DNAT'ed\"\r\n| where '{DestinationPort}' == DestinationPort or '{DestinationPort}' == \"*\"\r\n| where \"{RuleAction}\" == Action or \"{RuleAction}\" == \"*\"\r\n| where '{NatDestination}' == NatDestination or '{NatDestination}' == \"*\"\r\n| summarize Amount=count() by NatDestination, bin(TimeGenerated, {TimeRange:grain})\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "DNAT'ed over time"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      customWidth = "25"
      name        = "query - 13"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "//reference list posted here : https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/ipv4-lookup-plugin\r\nlet geoData = externaldata\r\n(network:string,geoname_id:string,continent_code:string,continent_name:string,\r\ncountry_iso_code:string,country_name:string,is_anonymous_proxy:string,is_satellite_provider:string)\r\n[@\"{GeoLocation}\"] with (ignoreFirstRecord=true, format=\"csv\");\r\nlet materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| where '{DestinationPort}' == DestinationPort or '{DestinationPort}' == \"*\"\r\n| where \"{RuleAction}\" == Action or \"{RuleAction}\" == \"*\"\r\n| where '{NatDestination}' == NatDestination or '{NatDestination}' == \"*\"\r\n| project DestinationIP, TimeGenerated\r\n| evaluate ipv4_lookup (geoData, DestinationIP,  network, false)\r\n| summarize Amount=count() by continent_name, bin(TimeGenerated, {TimeRange:grain})\r\n\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "GeoLocation over time"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      customWidth = "25"
      name        = "query - 13 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| where '{DestinationPort}' == DestinationPort or '{DestinationPort}' == \"*\"\r\n| where \"{RuleAction}\" == Action or \"{RuleAction}\" == \"*\"\r\n| where '{NatDestination}' == NatDestination or '{NatDestination}' == \"*\"\r\n| summarize count() by Action, bin(TimeGenerated, {TimeRange:grain})\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeBrushParameterName   = "ActionsByTimeBrush"
        timeContextFromParameter = "TimeRange"
        title                    = "Actions, by time"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      name = "query - 15"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFNetRule"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          filter   = true
          rowLimit = 2000
        }
        noDataMessage            = "There are no Network Rule logs within the selected workspaces. If you believe the selection is correct, confirm Network Rule logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "//reference list posted here : https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/ipv4-lookup-plugin\r\nlet geoData = externaldata\r\n(network:string,geoname_id:string,continent_code:string,continent_name:string,\r\ncountry_iso_code:string,country_name:string,is_anonymous_proxy:string,is_satellite_provider:string)\r\n[@\"{GeoLocation}\"] with (ignoreFirstRecord=true, format=\"csv\");\r\nlet materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName <> \"AzureFirewallThreatIntelLog\"\r\n| where OperationName <> \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\n// Azure Firewall Networking - Standard Log\r\nmaterializedData\r\n| where msg_s !has \"Type=\" and msg_s !has \"DNAT'ed\" and msg_s !has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking with ICMP\r\nmaterializedData\r\n| where msg_s has \"Type=\"\r\n| parse msg_s with Protocol \" Type=\" ICMPType \" request from \" SourceIP \" to \" DestinationIP \". Action: \" Action\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule - Standard\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s !has \". Rule Collection:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Networking DNAT rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"DNAT'ed\" and msg_s has \". Rule Collection:\" and msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \" was \" Action \" to \" NatDestination \". Policy: \" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall not using policy)\r\nmaterializedData\r\n| where msg_s has \"Rule Collection:\" and msg_s !has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n),\r\n(\r\n// Azure Firewall Network rule (firewall using policy)\r\nmaterializedData\r\n| where msg_s has \"Policy:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestinationIP \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule Name: \" Rule\r\n)\r\n| where '{DestinationPort}' == DestinationPort or '{DestinationPort}' == \"*\"\r\n| where \"{RuleAction}\" == Action or \"{RuleAction}\" == \"*\"\r\n| where '{NatDestination}' == NatDestination or '{NatDestination}' == \"*\"\r\n| summarize by TimeGenerated,Protocol, ICMPType, Action,SourceIP, SourcePort, DestinationIP , DestinationPort , NatDestination, ResourceId , ResourceGroup , SubscriptionId\r\n| evaluate ipv4_lookup (geoData, DestinationIP,  network, false)\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showAnalytics            = true
        showExportToExcel        = true
        size                     = 0
        timeContextFromParameter = "ActionsByTimeBrush"
        title                    = "All IP addresses events with GeoLocation: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
      }
      name = "query - 22"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFDNSProxy"
      }
      content = {
        json = "# Azure Firewall -DNS Proxy"
      }
      name = "text - 41"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFDNSProxy"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
        }
        noDataMessage            = "There are no DNS Proxy logs within the selected workspaces. If you believe the selection is correct, confirm DNS Proxy logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "AzureDiagnostics\r\n| where Category == \"AzureFirewallDnsProxy\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| parse msg_s with \"DNS Request: \" ClientIP \":\" ClientPort \" - \" QueryID \" \" Request_Type \" \" Request_Class \" \" Request_Name \". \" Request_Protocol \" \" Request_Size \" \" EDNSO_DO \" \" EDNS0_Buffersize \" \" Responce_Code \" \" Responce_Flags \" \" Responce_Size \" \" Response_Duration\r\n| project Resource, TimeGenerated\r\n| summarize count() by Resource, bin(TimeGenerated,{TimeRange:grain})\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeBrushParameterName   = "DNSTimeBrush"
        timeContextFromParameter = "TimeRange"
        title                    = "DNSProxy Traffic by count per Firewall: Query Time({$queryTime}) "
        version                  = "KqlItem/1.0"
        visualization            = "linechart"
      }
      name = "query - 30 - Copy - Copy"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFDNSProxy"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportDefaultValue      = "*"
        exportFieldName         = "Request_Name"
        exportParameterName     = "DNSRequestName"
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
        }
        noDataMessage            = "There are no DNS Proxy logs within the selected workspaces. If you believe the selection is correct, confirm DNS Proxy logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "AzureDiagnostics\r\n| where Category == \"AzureFirewallDnsProxy\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| parse msg_s with \"DNS Request: \" ClientIP \":\" ClientPort \" - \" QueryID \" \" Request_Type \" \" Request_Class \" \" Request_Name \". \" Request_Protocol \" \" Request_Size \" \" EDNSO_DO \" \" EDNS0_Buffersize \" \" Responce_Code \" \" Responce_Flags \" \" Responce_Size \" \" Response_Duration\r\n| project-away msg_s\r\n| summarize count() by Request_Name\r\n| sort by count_ desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "DNSTimeBrush"
        title                    = "DNSProxy count by Request Name, filterable by Request_Name"
        version                  = "KqlItem/1.0"
      }
      customWidth = "25"
      name        = "query - 30 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFDNSProxy"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportDefaultValue      = "*"
        exportFieldName         = "ClientIP"
        exportParameterName     = "DNSClientIP"
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
        }
        noDataMessage            = "There are no DNS Proxy logs within the selected workspaces. If you believe the selection is correct, confirm DNS Proxy logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "AzureDiagnostics\r\n| where Category == \"AzureFirewallDnsProxy\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| parse msg_s with \"DNS Request: \" ClientIP \":\" ClientPort \" - \" QueryID \" \" Request_Type \" \" Request_Class \" \" Request_Name \". \" Request_Protocol \" \" Request_Size \" \" EDNSO_DO \" \" EDNS0_Buffersize \" \" Responce_Code \" \" Responce_Flags \" \" Responce_Size \" \" Response_Duration\r\n| project-away msg_s\r\n| where '{DNSRequestName}' == Request_Name or '{DNSRequestName}' == \"*\"\r\n| summarize count() by ClientIP\r\n| sort by count_ desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "DNSTimeBrush"
        title                    = "DNSProxy Request count by ClientIP, filterable by ClientIP"
        version                  = "KqlItem/1.0"
      }
      customWidth = "25"
      name        = "query - 30 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFDNSProxy"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        noDataMessage            = "There are no DNS Proxy logs within the selected workspaces. If you believe the selection is correct, confirm DNS Proxy logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "AzureDiagnostics\r\n| where Category == \"AzureFirewallDnsProxy\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| parse msg_s with \"DNS Request: \" ClientIP \":\" ClientPort \" - \" QueryID \" \" Request_Type \" \" Request_Class \" \" Request_Name \". \" Request_Protocol \" \" Request_Size \" \" EDNSO_DO \" \" EDNS0_Buffersize \" \" Responce_Code \" \" Responce_Flags \" \" Responce_Size \" \" Response_Duration\r\n| project-away msg_s\r\n| where '{DNSClientIP}' == ClientIP or '{DNSClientIP}' == \"*\"\r\n| where '{DNSRequestName}' == Request_Name or '{DNSRequestName}' == \"*\"\r\n| summarize count() by ClientIP, bin(TimeGenerated, {TimeRange:grain})\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "DNSTimeBrush"
        title                    = "DNS Proxy Request over time by ClientIP"
        version                  = "KqlItem/1.0"
        visualization            = "linechart"
      }
      customWidth = "50"
      name        = "query - 30 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFDNSProxy"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          filter   = true
          rowLimit = 2000
        }
        noDataMessage            = "There are no DNS Proxy logs within the selected workspaces. If you believe the selection is correct, confirm DNS Proxy logs are enabled for the Azure Firewall and feeding into this selected workspace. Reference Docs: https://docs.microsoft.com/en-us/azure/firewall/"
        noDataMessageStyle       = 2
        query                    = "AzureDiagnostics\r\n| where Category == \"AzureFirewallDnsProxy\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| parse msg_s with \"DNS Request: \" ClientIP \":\" ClientPort \" - \" QueryID \" \" Request_Type \" \" Request_Class \" \" Request_Name \". \" Request_Protocol \" \" Request_Size \" \" EDNSO_DO \" \" EDNS0_Buffersize \" \" Responce_Code \" \" Responce_Flags \" \" Responce_Size \" \" Response_Duration\r\n| project-away msg_s\r\n| where '{DNSClientIP}' == ClientIP or '{DNSClientIP}' == \"*\"\r\n| where '{DNSRequestName}' == Request_Name or '{DNSRequestName}' == \"*\"\r\n| summarize by TimeGenerated, ResourceId, ClientIP, ClientPort, QueryID, Request_Type, Request_Class, Request_Name, Request_Protocol, Request_Size, EDNSO_DO, EDNS0_Buffersize, Responce_Code, Responce_Flags, Responce_Size, Response_Duration, SubscriptionId"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showAnalytics            = true
        size                     = 0
        timeContextFromParameter = "DNSTimeBrush"
        title                    = "DNS Proxy Information: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
      }
      name = "query - 30"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        json = "# Azure Firewall Premium - IDPS"
      }
      name = "text - 42"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        exportDefaultValue       = "*"
        exportFieldName          = "series"
        exportParameterName      = "IDSIPSAction"
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        noDataMessageStyle       = 2
        query                    = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message\r\n| summarize count() by Action"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 2
        timeContextFromParameter = "TimeRange"
        title                    = "IDPS Actions Count, filterable by Action"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "query - 44"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        exportDefaultValue       = "*"
        exportFieldName          = "series"
        exportParameterName      = "IDSIPSProtocol"
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query                    = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| summarize count() by Protocol"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 2
        timeContextFromParameter = "TimeRange"
        title                    = "IDPS Protocol Count, filterable by Protocol"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "query - 45"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources  = ["{Workspaces}"]
        exportDefaultValue       = "*"
        exportFieldName          = "series"
        exportParameterName      = "IDSIPSSignatureID"
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query                    = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| where '{IDSIPSProtocol}' == Protocol or '{IDSIPSProtocol}' == \"*\"\r\n| summarize count() by SignatureID\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 2
        timeContextFromParameter = "TimeRange"
        title                    = "IDPS SignatureID Count, filterable by SignatureID"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "query - 45 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportDefaultValue      = "*"
        exportFieldName         = "series"
        exportParameterName     = "IDSIPSSourceIP"
        gridSettings = {
          formatters = [{
            columnMatch = "SourceIP"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = false
            groupBy        = ["SourceIP"]
            treeType       = 1
          }
        }
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query                    = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| where '{IDSIPSProtocol}' == Protocol or '{IDSIPSProtocol}' == \"*\"\r\n| where '{IDSIPSSignatureID}' == SignatureID or '{IDSIPSSignatureID}' == \"*\"\r\n| summarize count() by SourceIP, DestIP\r\n| sort by count_ desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 2
        timeContextFromParameter = "TimeRange"
        title                    = "IDPS SourceIP Count, filterable by SourceIP"
        version                  = "KqlItem/1.0"
        visualization            = "piechart"
      }
      customWidth = "25"
      name        = "query - 45 - Copy - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
          }]
        }
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query                    = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n//| project-away Category, ResourceId, msg_s, SubscriptionId, ResourceProvider, ResourceType, OperationName, Type\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| where '{IDSIPSProtocol}' == Protocol or '{IDSIPSProtocol}' == \"*\"\r\n| where '{IDSIPSSignatureID}' == SignatureID or '{IDSIPSSignatureID}' == \"*\"\r\n| where '{IDSIPSSourceIP}' == SourceIP or '{IDSIPSSourceIP}' == \"*\"\r\n| summarize count() by Action"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Filtered IDPS Actions by Count"
        version                  = "KqlItem/1.0"
      }
      customWidth = "25"
      name        = "query - 44 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
          }]
        }
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query                    = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n//| project-away Category, ResourceId, msg_s, SubscriptionId, ResourceProvider, ResourceType, OperationName, Type\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| where '{IDSIPSProtocol}' == Protocol or '{IDSIPSProtocol}' == \"*\"\r\n| where '{IDSIPSSignatureID}' == SignatureID or '{IDSIPSSignatureID}' == \"*\"\r\n| where '{IDSIPSSourceIP}' == SourceIP or '{IDSIPSSourceIP}' == \"*\"\r\n| summarize count() by Protocol"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Filtered IDPS Protocols by Count"
        version                  = "KqlItem/1.0"
      }
      customWidth = "25"
      name        = "query - 45 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
          }]
        }
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query                    = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n//| project-away Category, ResourceId, msg_s, SubscriptionId, ResourceProvider, ResourceType, OperationName, Type\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| where '{IDSIPSProtocol}' == Protocol or '{IDSIPSProtocol}' == \"*\"\r\n| where '{IDSIPSSignatureID}' == SignatureID or '{IDSIPSSignatureID}' == \"*\"\r\n| where '{IDSIPSSourceIP}' == SourceIP or '{IDSIPSSourceIP}' == \"*\"\r\n| summarize count() by SignatureID"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Filtered IDPS SignatureIDs by Count"
        version                  = "KqlItem/1.0"
      }
      customWidth = "25"
      name        = "query - 45 - Copy - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportDefaultValue      = "*"
        exportFieldName         = "DestIP"
        exportParameterName     = "IDSIPSDestIP"
        graphSettings = {
          centerContent = {
            columnMatch = "Volume"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "SourceIP"
            formatter   = 1
          }
          type = 0
        }
        gridSettings = {
          formatters = [{
            columnMatch = "SourceIP"
            formatter   = 5
            }, {
            columnMatch = "Volume"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
          }]
          hierarchySettings = {
            expandTopLevel = false
            groupBy        = ["SourceIP"]
            treeType       = 1
          }
        }
        noDataMessage = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query         = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| where '{IDSIPSProtocol}' == Protocol or '{IDSIPSProtocol}' == \"*\"\r\n| where '{IDSIPSSignatureID}' == SignatureID or '{IDSIPSSignatureID}' == \"*\"\r\n| where '{IDSIPSSourceIP}' == SourceIP or '{IDSIPSSourceIP}' == \"*\"\r\n| summarize Volume=count() by DestIP, SourceIP\r\n| sort by Volume desc"
        queryType     = 0
        resourceType  = "microsoft.operationalinsights/workspaces"
        size          = 0
        tileSettings = {
          leftContent = {
            columnMatch = "Volume"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = false
          titleContent = {
            columnMatch = "SourceIP"
            formatter   = 1
          }
        }
        timeContextFromParameter = "TimeRange"
        title                    = "Filtered SourceIP, filterable by DestIP"
        version                  = "KqlItem/1.0"
        visualization            = "table"
      }
      customWidth = "25"
      name        = "query - 45 - Copy - Copy - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "SourceIP"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = false
            groupBy        = ["SourceIP"]
            treeType       = 1
          }
        }
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query                    = "AzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n| project TimeGenerated, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, SignatureID, Message, Resource\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| where '{IDSIPSProtocol}' == Protocol or '{IDSIPSProtocol}' == \"*\"\r\n| where '{IDSIPSSignatureID}' == SignatureID or '{IDSIPSSignatureID}' == \"*\"\r\n| where '{IDSIPSSourceIP}' == SourceIP or '{IDSIPSSourceIP}' == \"*\"\r\n| where '{IDSIPSDestIP}' == DestIP or '{IDSIPSDestIP}' == \"*\"\r\n| summarize count() by Resource, bin(TimeGenerated,{TimeRange:grain})"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeBrushParameterName   = "AFIDSIPSBrush"
        timeContextFromParameter = "TimeRange"
        title                    = "Azure Firewall IDPS count over time"
        version                  = "KqlItem/1.0"
        visualization            = "timechart"
      }
      name = "query - 45"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFIDSIPS"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          hierarchySettings = {
            expandTopLevel = true
            groupBy        = ["Message", "country_name"]
            treeType       = 1
          }
        }
        noDataMessage            = "This feature is in Azure Firewall Premium; For more information go to https://docs.microsoft.com/en-us/azure/firewall/premium-features"
        query                    = "//reference list posted here : https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/ipv4-lookup-plugin\r\nlet geoData = externaldata\r\n(network:string,geoname_id:string,continent_code:string,continent_name:string,\r\ncountry_iso_code:string,country_name:string,is_anonymous_proxy:string,is_satellite_provider:string)\r\n[@\"{GeoLocation}\"] with (ignoreFirstRecord=true, format=\"csv\");\r\nAzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n| project TimeGenerated, SignatureID, Message, Priority, Classification, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, Resource\r\n| where '{IDSIPSAction}' == Action or '{IDSIPSAction}' == \"*\"\r\n| where '{IDSIPSProtocol}' == Protocol or '{IDSIPSProtocol}' == \"*\"\r\n| where '{IDSIPSSignatureID}' == SignatureID or '{IDSIPSSignatureID}' == \"*\"\r\n| where '{IDSIPSSourceIP}' == SourceIP or '{IDSIPSSourceIP}' == \"*\"\r\n| where '{IDSIPSDestIP}' == DestIP or '{IDSIPSDestIP}' == \"*\"\r\n| evaluate ipv4_lookup (geoData, DestIP,  network, false)"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showAnalytics            = true
        showExportToExcel        = true
        size                     = 0
        timeBrushParameterName   = "AFIDSIPSBrush"
        timeContextFromParameter = "AFIDSIPSBrush"
        title                    = "Azure Firewall IDPS logs with GeoLocation: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
      }
      name = "query - 45 - Copy"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFInvestigate"
      }
      content = {
        json = "# Azure Firewall - Investigation"
      }
      name = "text - 43"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFInvestigate"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportDefaultValue      = "*"
        exportFieldName         = "FQDN"
        exportParameterName     = "FullName"
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "FQDN"
            formatter   = 5
            }, {
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumFractionDigits    = 1
                maximumSignificantDigits = 4
                minimumIntegerDigits     = 1
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
          hierarchySettings = {
            expandTopLevel = true
            groupBy        = ["FQDN"]
            treeType       = 1
          }
          rowLimit = 2000
        }
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project ResourceId,ResourceGroup,SubscriptionId, msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| summarize count() by FQDN, Action\r\n| sort by count_ desc"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showExportToExcel        = true
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "FQDN Traffic by Count, filterable by FQDN: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
      }
      customWidth = "35"
      name        = "query - 29 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFInvestigate"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        exportedParameters = [{
          defaultValue  = "privateIPAddress"
          fieldName     = "SourceIP"
          parameterName = "InvestigateIP"
          parameterType = 1
          }, {
          defaultValue  = "*"
          fieldName     = "SourceIP"
          parameterName = "InvestigateIPWC"
          parameterType = 1
          }, {
          defaultValue  = "-"
          fieldName     = "SubscriptionId"
          parameterName = "SelectedSubscriptionId"
          parameterType = 1
        }]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "SubscriptionId"
            formatter   = 5
            }, {
            columnMatch = "count_"
            formatOptions = {
              palette = "whiteBlack"
            }
            formatter = 8
            numberFormat = {
              options = {
                maximumSignificantDigits = 4
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }]
        }
        query        = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project ResourceId,ResourceGroup,SubscriptionId, msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where SourceIP <> \"\"\r\n| where FQDN == \"{FullName:label}\" or '{FullName}' == \"*\"\r\n| summarize count() by SourceIP, SubscriptionId\r\n| sort by count_"
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        size         = 0
        tileSettings = {
          showBorder = true
          size       = "auto"
          titleContent = {
            columnMatch = "SourceIP"
            formatOptions = {
              palette = "orange"
            }
            formatter = 4
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
          }
        }
        timeContextFromParameter = "TimeRange"
        title                    = "SourceIP Address, filterable: Query Time({$queryTime})"
        version                  = "KqlItem/1.0"
      }
      customWidth = "15"
      name        = "query - 33"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFInvestigate"
      }
      content = {
        crossComponentResources = ["value::selected"]
        exportDefaultValue      = "*"
        exportFieldName         = "id"
        exportParameterName     = "Testid"
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "properties"
            formatter   = 5
          }]
        }
        query        = "Resources\r\n| where type =~ 'microsoft.network/networkinterfaces'\r\n| where properties contains \"{InvestigateIP}\"\r\n| extend NSG = properties['networkSecurityGroup']['id']\r\n| parse NSG with \"/subscriptions/\" NetworkSecurityGroup_Sub \"/resourceGroups/\" NetworkSecurityGroup_rg \"/providers/Microsoft.Network/networkSecurityGroups/\" NetworkSecurityGroup_Name\r\n| project id, PrivateIPAddress = tostring(properties['ipConfigurations'][0]['properties']['privateIPAddress']),  PublicIPAddress = tostring(properties['ipConfigurations'][0]['properties']['publicIPAddress']['id']), VirtualMachine = tostring(properties['virtualMachine']['id']), subnet = tostring(properties['ipConfigurations'][0]['properties']['subnet']['id']), NetworkSecurityGroup = NetworkSecurityGroup_Name, properties, subscriptionId, tenantId"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 0
        tileSettings = {
          showBorder = true
          size       = "auto"
          titleContent = {
            columnMatch = "SourceIP"
            formatOptions = {
              palette = "orange"
            }
            formatter = 4
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
          }
        }
        title   = "SourceIPAddress Resource Lookup: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version = "KqlItem/1.0"
      }
      customWidth = "50"
      name        = "query - 33 - Copy"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFInvestigate"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          filter   = true
          rowLimit = 2000
        }
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| project ResourceId,ResourceGroup,SubscriptionId, msg_s, Resource, TimeGenerated);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url:\" Url \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and msg_s !has \". Url\" and msg_s has \". No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". No rule matched\" *\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s has \"Web Category:\" and msg_s !has \". Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection:\" RuleCollection \". Rule:\" Rule \". Web Category:\" WebCategory\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". \" RuleCollection \". \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \"TLS extension was missing\"\r\n| where msg_s has \" Reason:\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \". Action: \" Action \". Reason: \" Rule \".\"\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has  \"TLS extension was missing\" and msg_s !has \"No rule matched\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Web Category:\" and  msg_s !has \". Url\" and msg_s !has \"Rule Collection\" and msg_s !has \" Reason: \"\r\n| where msg_s has \"Rule Collection Group\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". Policy:\" Policy \". Rule Collection Group:\" RuleCollectionGroup \". Rule Collection: \" RuleCollection \". Rule: \" Rule\r\n)\r\n| where SourceIP == \"{InvestigateIPWC:label}\" or '{InvestigateIPWC}' == \"*\"\r\n| where FQDN == \"{FullName:label}\" or '{FullName}' == \"*\"\r\n| summarize by TimeGenerated, FQDN, Protocol, Action, SourceIP, SourcePort, DestinationPort , ResourceId , ResourceGroup , RuleCollection, Rule, WebCategory, SubscriptionId\r\n\r\n\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "FQDN Lookup logs: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
      }
      customWidth = "100"
      name        = "query - 33"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFInvestigate"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          filter   = true
          rowLimit = 2000
        }
        noDataMessage            = "There is no Azure Firewall Threat Intel for your filtered results"
        query                    = "let materializedData =\r\nmaterialize(\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| where OperationName == \"AzureFirewallThreatIntelLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where msg_s contains \"{InvestigateIPWC:label}\" or '{InvestigateIPWC}' == \"*\"\r\n| where msg_s <> \" request from  to . Action: . ThreatIntel: \"\r\n| project msg_s, Resource, TimeGenerated,ResourceId , ResourceGroup , SubscriptionId);\r\nunion\r\n(\r\nmaterializedData\r\n| where msg_s has \"Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Url: \" Url \". Action: \" Action \". ThreatIntel: \" ThreatIntelMsg\r\n),\r\n(\r\nmaterializedData\r\n| where msg_s !has \"Url\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" FQDN \":\" DestinationPort \". Action: \" Action \". ThreatIntel: \" ThreatIntelMsg\r\n)\r\n| summarize by TimeGenerated, Protocol, SourceIP, SourcePort, FQDN, DestinationPort, Url, Action, ThreatIntelMsg"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        showExportToExcel        = true
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Azure Firewall Threat Intel: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
      }
      name = "query - 29"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "AFInvestigate"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              customColumnWidthSetting = "60ch"
            }
            formatter = 0
            }, {
            columnMatch = "Message"
            formatter   = 5
            }, {
            columnMatch = "country_name"
            formatter   = 5
            }, {
            columnMatch = "$gen_group"
            formatOptions = {
              customColumnWidthSetting = "60ch"
            }
            formatter = 0
          }]
          hierarchySettings = {
            expandTopLevel = true
            groupBy        = ["Message", "country_name"]
            treeType       = 1
          }
        }
        query                    = "//reference list posted here : https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/ipv4-lookup-plugin\r\nlet geoData = externaldata\r\n(network:string,geoname_id:string,continent_code:string,continent_name:string,\r\ncountry_iso_code:string,country_name:string,is_anonymous_proxy:string,is_satellite_provider:string)\r\n[@\"{GeoLocation}\"] with (ignoreFirstRecord=true, format=\"csv\");\r\nAzureDiagnostics\r\n| where ResourceType == \"AZUREFIREWALLS\"\r\n| where OperationName == \"AzureFirewallIDSLog\"\r\n| where Resource in~ (split(\"{Resource:label}\", \", \"))\r\n| where msg_s contains \"{InvestigateIPWC:label}\" or '{InvestigateIPWC}' == \"*\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePort \" to \" DestIP \":\" DestPort \". Action: \" Action \". Signature: \" SignatureID \". IDS:\" Message \". Priority:\" Priority \". Classification:\" Classification\r\n| summarize by TimeGenerated, SignatureID, Message, Priority, Classification, Protocol, SourceIP, SourcePort, DestIP, DestPort, Action, Resource\r\n| evaluate ipv4_lookup (geoData, DestIP,  network, false)\r\n"
        queryType                = 0
        resourceType             = "microsoft.operationalinsights/workspaces"
        size                     = 0
        timeContextFromParameter = "TimeRange"
        title                    = "Azure Firewall Premium with GeoLocation- IDPS: Query Time({$queryTime}) : Total Rows({$rowCount})"
        version                  = "KqlItem/1.0"
      }
      name = "query - 58"
      type = 3
    }]
    version = "Notebook/1.0"
  })
  display_name        = "af-workbook_azure-firewall-overview"
  location            = "westeurope"
  name                = "419fe7cd-7dc6-d49b-6b76-379b43f586fd"
  resource_group_name = azurerm_resource_group.res-1.name
  source_id           = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourcegroups/rg-monitoring-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_application_insights_workbook" "res-11" {
  data_json = jsonencode({
    "$schema"           = "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
    fallbackResourceIds = ["azure monitor"]
    fromTemplateId      = "community-Workbooks/Azure Monitor - Getting Started/Resource Picker"
    items = [{
      content = {
        crossComponentResources = ["value::all"]
        parameters = [{
          delimiter          = ","
          id                 = "0e85e0e4-a7e8-4ea8-b291-e444c317843a"
          isHiddenWhenLocked = true
          isRequired         = true
          label              = "Resource types"
          multiSelect        = true
          name               = "ResourceTypes"
          quote              = "'"
          type               = 7
          typeSettings = {
            additionalResourceOptions = []
            includeAll                = true
          }
          value   = ["microsoft.network/networksecuritygroups"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::selected"]
          delimiter               = ","
          description             = "All subscriptions"
          id                      = "1f74ed9a-e3ed-498d-bd5b-f68f3836a117"
          isRequired              = true
          label                   = "Subscriptions"
          multiSelect             = true
          name                    = "Subscription"
          query                   = "Resources\r\n| where type in~ ({ResourceTypes})\r\n| summarize Count = count() by subscriptionId\r\n| order by Count desc\r\n| extend Rank = row_number()\r\n| project value = subscriptionId, label = subscriptionId, selected = Rank == 1"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 6
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            showDefault               = false
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Subscription}"]
          delimiter               = ","
          id                      = "b616a3a3-4271-4208-b1a9-a92a78efed08"
          isRequired              = true
          label                   = "Resource groups"
          multiSelect             = true
          name                    = "ResourceGroups"
          query                   = "Resources\r\n| where type in~ ({ResourceTypes})\r\n| summarize Count = count() by subscriptionId, resourceGroup\r\n| order by Count desc\r\n| extend Rank = row_number()\r\n| project value = strcat('/subscriptions/', subscriptionId, '/resourceGroups/', resourceGroup), label = resourceGroup, selected = false"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 2
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            selectAllValue            = "*"
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Subscription}"]
          delimiter               = ","
          id                      = "f60ea0a0-3703-44ca-a59b-df0246423f41"
          isRequired              = true
          label                   = "Network security groups"
          multiSelect             = true
          name                    = "Resources"
          query                   = "Resources\r\n| where type in~({ResourceTypes})\r\n| extend resourceGroupId = strcat('/subscriptions/', subscriptionId, '/resourceGroups/', resourceGroup)\r\n| where resourceGroupId in~({ResourceGroups}) or '*' in~({ResourceGroups})\r\n| order by name asc\r\n| extend Rank = row_number()\r\n| project value = id, label = name, selected = Rank <= 10, group = resourceGroup"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 5
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            showDefault               = false
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          id         = "2c8553c2-19c7-45f8-b7ae-52eb5bb76e8a"
          isRequired = true
          label      = ""
          name       = "TimeRange"
          type       = 4
          typeSettings = {
            selectableValues = [{
              durationMs = 300000
              }, {
              durationMs = 900000
              }, {
              durationMs = 3600000
              }, {
              durationMs = 14400000
              }, {
              durationMs = 86400000
              }, {
              durationMs = 259200000
              }, {
              durationMs = 604800000
              }, {
              durationMs = 2592000000
              }, {
              durationMs = 7776000000
            }]
          }
          value = {
            durationMs = 900000
          }
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::all"]
          delimiter               = ","
          id                      = "5061f372-019f-43f6-80f1-2af25f23f4c4"
          isHiddenWhenLocked      = true
          multiSelect             = true
          name                    = "logWorkspaceWithFlowLogs"
          query                   = "Resources\n| where type =~ 'Microsoft.Network/networkWatchers/flowlogs'\n| order by name asc\n| extend Rank = row_number()\n| extend provisioningState = parse_json(properties).provisioningState \n| extend workspaceResourceId = tostring(parse_json(parse_json(parse_json(properties).flowAnalyticsConfiguration).networkWatcherFlowAnalyticsConfiguration).workspaceResourceId)\n| where workspaceResourceId != \"\" and provisioningState == \"Succeeded\"\n| project value = tostring(parse_json(properties).targetResourceId), label = tostring(parse_json(properties).targetResourceId), workspaceResourceId, provisioningState\n| distinct workspaceResourceId"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 5
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            showDefault               = false
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::all"]
          id                      = "76e9b4c9-7e59-41de-ab5f-bbf68ebda1fd"
          isHiddenWhenLocked      = true
          label                   = "NSG With Traffic Analytics"
          name                    = "nsgWithTrafficAnalytics"
          query                   = "Resources\n| where type =~ 'Microsoft.Network/networkWatchers/flowlogs'\n| extend provisioningState = parse_json(properties).provisioningState \n| extend workspaceResourceId = tostring(parse_json(parse_json(parse_json(properties).flowAnalyticsConfiguration).networkWatcherFlowAnalyticsConfiguration).workspaceResourceId)\n| extend targetResourceId = iff(notempty(workspaceResourceId) and provisioningState == \"Succeeded\", tostring(parse_json(properties).targetResourceId), \"null\" ) \n| distinct targetResourceId"
          queryType               = 1
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::all"]
          id                      = "9f522ebc-54ff-472c-b78f-20d3f13c8ecf"
          isHiddenWhenLocked      = true
          label                   = "NSG With Flow Logs"
          name                    = "nsgWithFlowLogs"
          query                   = "Resources\n| where type =~ 'Microsoft.Network/networkWatchers/flowlogs'\n| extend provisioningState = parse_json(properties).provisioningState \n| extend targetResourceId = iff(provisioningState == \"Succeeded\", tostring(parse_json(properties).targetResourceId), \"null\" ) \n| distinct targetResourceId"
          queryType               = 1
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
        }]
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        style        = "above"
        version      = "KqlParameterItem/1.0"
      }
      name = "Core parameters"
      type = 9
      }, {
      content = {
        crossComponentResources = ["{Subscription}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 15
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "success"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          rowLimit = 1000
        }
        query         = "Resources\r\n| where type =~ 'microsoft.network/networksecuritygroups'\r\n| extend flowLogs = \"{nsgWithFlowLogs}\" has id\r\n| extend trafficAnalytics = \"{nsgWithTrafficAnalytics}\" has id\r\n| project Subscription = subscriptionId, ['Resource group'] = strcat('/subscriptions/', subscriptionId, '/resourceGroups/', resourceGroup), ['Network Security Group'] = id, [\"Location\"]=location, [\"Flow Logs\"]=flowLogs, [\"Traffic Analytics\"]=trafficAnalytics"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        sortBy        = []
        title         = "Network Security Groups"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name    = "Network Security Groups"
      showPin = true
      styleSettings = {
        showBorder = true
      }
      type = 3
      }, {
      content = {
        crossComponentResources = ["{logWorkspaceWithFlowLogs}"]
        query                   = "AzureNetworkAnalytics_CL \n| where FlowStartTime_t {TimeRange} \n| extend SourceIP=SrcIP_s\n| extend DestinationIP=DestIP_s\n| extend NSGRuleAction=split(NSGRules_s,'|',3)[0]\n| extend NSGRuleName=tostring(split(NSGRules_s,'|',1)[0])\n| extend NSGName=tostring(split(NSGList_s,'/',2)[0])\n| where Subscription1_g in~ ({Subscription:subid}) or Subscription2_g in~ ({Subscription:subid})\n| summarize Count=count() by [\"Flow Type\"]=FlowType_s\n| render barchart"
        queryType               = 0
        resourceType            = "microsoft.operationalinsights/workspaces"
        size                    = 1
        sortBy                  = []
        title                   = "Flow Type"
        version                 = "KqlItem/1.0"
      }
      name = "Flow Type"
      styleSettings = {
        showBorder = true
      }
      type = 3
      }, {
      content = {
        parameters = [{
          id      = "7f3ed1ec-b914-4edf-a41d-54180537197d"
          label   = "Source IP to filter on"
          name    = "mySourceIP"
          type    = 1
          value   = ""
          version = "KqlParameterItem/1.0"
          }, {
          id      = "03650dfc-ac9a-4817-9798-a1e7c494b598"
          label   = "Destination IP to filter on"
          name    = "myTargetIP"
          type    = 1
          value   = ""
          version = "KqlParameterItem/1.0"
          }, {
          defaultValue = "value::all"
          delimiter    = ","
          id           = "e10e4ef9-57ea-4d8e-a1fc-43314ac679af"
          label        = "Action to filter on"
          multiSelect  = true
          name         = "action"
          query        = "{\"version\":\"1.0.0\",\"content\":\"[{\\\"value\\\":\\\"A\\\",\\\"label\\\": \\\"Allow\\\"},{\\\"value\\\":\\\"D\\\",\\\"label\\\": \\\"Deny\\\"}]\",\"transformers\":null}"
          queryType    = 8
          quote        = "'"
          type         = 2
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          value   = ["D", "A"]
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "above"
        version      = "KqlParameterItem/1.0"
      }
      name = "Search parameters"
      type = 9
      }, {
      content = {
        crossComponentResources = ["{logWorkspaceWithFlowLogs}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "RuleAction"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "Deny"
                thresholdValue = "D"
                }, {
                operator       = "=="
                representation = "success"
                text           = "Allow"
                thresholdValue = "A"
                }, {
                operator       = "Default"
                representation = "question"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
          }]
          rowLimit = 100
        }
        query             = "AzureNetworkAnalytics_CL \n| where FlowStartTime_t {TimeRange} \n| extend SourceIP=SrcIP_s\n| extend DestinationIP=DestIP_s\n| extend NSGRuleAction =tostring(split(NSGRules_s,'|',3)[0])\n| extend NSGRuleName=tostring(split(NSGRules_s,'|',1)[0])\n| extend NSGName=tostring(split(NSGList_s,'/',2)[0])\n| where \"{action}\" has NSGRuleAction\n| where SourceIP has \"{mySourceIP}\"\n| where DestinationIP has \"{myTargetIP}\"\n| where Subscription1_g in~ ({Subscription:subid}) or Subscription2_g in~ ({Subscription:subid})\n| project SourceIP, DestinationIP, DestinationPort=DestPort_d, Protocol=L7Protocol_s, [\"RuleAction\"]=NSGRuleAction, FlowStartTime_t, NSGName, NSGRuleName, SourceSubnet=Subnet1_s, DestinationSubnet=Subnet2_s\n| sort by FlowStartTime_t desc\n\n"
        queryType         = 0
        resourceType      = "microsoft.operationalinsights/workspaces"
        showAnalytics     = true
        showExportToExcel = true
        size              = 0
        sortBy            = []
        title             = "Filter for specific IP"
        version           = "KqlItem/1.0"
      }
      name = "Filter for specific IP"
      styleSettings = {
        showBorder = true
      }
      type = 3
    }]
    version = "Notebook/1.0"
  })
  display_name        = "af-workbook_azure-nsg-overview-and-logs"
  location            = "westeurope"
  name                = "75743a15-141b-cada-42dd-1b65328d670a"
  resource_group_name = azurerm_resource_group.res-1.name
  source_id           = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourcegroups/rg-monitoring-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_application_insights_workbook" "res-12" {
  data_json = jsonencode({
    "$schema"           = "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
    fallbackResourceIds = ["azure monitor"]
    items = [{
      content = {
        parameters = [{
          delimiter   = ","
          id          = "a36f0b3d-8826-4bec-95a9-70ec6cb77713"
          isRequired  = true
          multiSelect = true
          name        = "Subscriptions"
          quote       = "'"
          type        = 6
          typeSettings = {
            additionalResourceOptions = ["value::1", "value::all"]
            includeAll                = true
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          id         = "7b9badee-0be3-4b38-b532-b2657d0f5b87"
          isRequired = true
          jsonData   = "[\r\n { \"value\": \"Yes\", \"label\": \"Yes\"},\r\n { \"value\": \"No\", \"label\": \"No\", \"selected\":true },\r\n { \"value\": \"Change Log\", \"label\": \"Change Log\"}\r\n]"
          label      = "Show Help"
          name       = "Help"
          type       = 10
          typeSettings = {
            additionalResourceOptions = []
          }
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - 8"
      type = 9
      }, {
      content = {
        links = [{
          cellValue  = "selectedTab"
          id         = "f321b3dd-4d96-4aa7-ac57-5ad8ce236a48"
          linkLabel  = "Overview"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "overview"
          }, {
          cellValue  = "selectedTab"
          id         = "e79a9ba1-8aca-4e4a-9df7-83123cae1627"
          linkLabel  = "Compute"
          linkTarget = "parameter"
          preText    = "IaaS"
          style      = "link"
          subTarget  = "compute"
          }, {
          cellValue  = "selectedTab"
          id         = "ed3b708b-7054-424d-b32b-49451e04d36b"
          linkLabel  = "PaaS"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "paas"
          }, {
          cellValue  = "selectedTab"
          id         = "9bd4447c-8cac-4e8a-9f9b-bbcc99209b13"
          linkLabel  = "Networking"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "network"
          }, {
          cellValue  = "selectedTab"
          id         = "8192cd42-be72-4d18-b234-9e9fef4418dd"
          linkLabel  = "Monitoring & Security"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "monitor"
          }, {
          cellValue  = "selectedTab"
          id         = "1c2b6655-5c72-47bf-b4c6-9ea2665c07ef"
          linkLabel  = "Tagged Resources"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "tags"
          }, {
          cellValue  = "selectedTab"
          id         = "284d9e1f-d3f9-477e-8fac-0fad54c0b392"
          linkLabel  = "Untagged Resources"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "notag"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "links - 6"
      styleSettings = {
        padding = "0 0 20px 0"
      }
      type = 11
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "## NoShow - Begin Overview"
      }
      name = "text - NoShow Overview"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "overview"
      }
      content = {
        json = "# Overview Azure Resources"
      }
      name = "text - Title"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "overview"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        query                   = "Resources | summarize count(type)"
        queryType               = 1
        resourceType            = "microsoft.resourcegraph/resources"
        size                    = 4
        sortBy                  = []
        tileSettings = {
          leftContent = {
            columnMatch = "count_type"
            formatOptions = {
              showIcon = true
            }
            formatter = 12
          }
          showBorder     = true
          sortOrderField = 2
          titleContent = {
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        title         = "Count of All Resources"
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - Overview Count"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "overview"
      }
      content = {
        json = "## Subscriptions and Resource Groups"
      }
      name = "text - Subscriptions text"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "overview"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "type"
            formatOptions = {
              showIcon = true
            }
            formatter = 16
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        query        = "resourcecontainers \r\n| where type has \"microsoft.resources/subscriptions/resourcegroups\"\r\n| summarize Count=count(type) by type, subscriptionId | extend type = replace(@\"microsoft.resources/subscriptions/resourcegroups\", @\"Resource Groups\", type)"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 0
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = false
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version = "KqlItem/1.0"
      }
      name = "query - Subscription Overview"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "overview"
      }
      content = {
        json = "## Resource Counts"
      }
      name = "text - Overview Resource text"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "overview"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        query                   = "Resources \r\n| extend type = case(\r\ntype contains 'microsoft.netapp/netappaccounts', 'NetApp Accounts',\r\ntype contains \"microsoft.compute\", \"Azure Compute\",\r\ntype contains \"microsoft.logic\", \"LogicApps\",\r\ntype contains 'microsoft.keyvault/vaults', \"Key Vaults\",\r\ntype contains 'microsoft.storage/storageaccounts', \"Storage Accounts\",\r\ntype contains 'microsoft.compute/availabilitysets', 'Availability Sets',\r\ntype contains 'microsoft.operationalinsights/workspaces', 'Azure Monitor Resources',\r\ntype contains 'microsoft.operationsmanagement', 'Operations Management Resources',\r\ntype contains 'microsoft.insights', 'Azure Monitor Resources',\r\ntype contains 'microsoft.desktopvirtualization/applicationgroups', 'WVD Application Groups',\r\ntype contains 'microsoft.desktopvirtualization/workspaces', 'WVD Workspaces',\r\ntype contains 'microsoft.desktopvirtualization/hostpools', 'WVD Hostpools',\r\ntype contains 'microsoft.recoveryservices/vaults', 'Backup Vaults',\r\ntype contains 'microsoft.web', 'App Services',\r\ntype contains 'microsoft.managedidentity/userassignedidentities','Managed Identities',\r\ntype contains 'microsoft.storagesync/storagesyncservices', 'Azure File Sync',\r\ntype contains 'microsoft.hybridcompute/machines', 'ARC Machines',\r\ntype contains 'Microsoft.EventHub', 'Event Hub',\r\ntype contains 'Microsoft.EventGrid', 'Event Grid',\r\ntype contains 'Microsoft.Sql', 'SQL Resources',\r\ntype contains 'Microsoft.HDInsight/clusters', 'HDInsight Clusters',\r\ntype contains 'microsoft.devtestlab', 'DevTest Labs Resources',\r\ntype contains 'microsoft.containerinstance', 'Container Instances Resources',\r\ntype contains 'microsoft.portal/dashboards', 'Azure Dashboards',\r\ntype contains 'microsoft.containerregistry/registries', 'Container Registry',\r\ntype contains 'microsoft.automation', 'Automation Resources',\r\ntype contains 'sendgrid.email/accounts', 'SendGrid Accounts',\r\ntype contains 'microsoft.datafactory/factories', 'Data Factory',\r\ntype contains 'microsoft.databricks/workspaces', 'Databricks Workspaces',\r\ntype contains 'microsoft.machinelearningservices/workspaces', 'Machine Learnings Workspaces',\r\ntype contains 'microsoft.alertsmanagement/smartdetectoralertrules', 'Azure Monitor Resources',\r\ntype contains 'microsoft.apimanagement/service', 'API Management Services',\r\ntype contains 'microsoft.dbforpostgresql', 'PostgreSQL Resources',\r\ntype contains 'microsoft.scheduler/jobcollections', 'Scheduler Job Collections',\r\ntype contains 'microsoft.visualstudio/account', 'Azure DevOps Organization',\r\ntype contains 'microsoft.network/', 'Network Resources',\r\ntype contains 'microsoft.migrate/' or type contains 'microsoft.offazure', 'Azure Migrate Resources',\r\ntype contains 'microsoft.servicebus/namespaces', 'Service Bus Namespaces',\r\ntype contains 'microsoft.classic', 'ASM Obsolete Resources',\r\ntype contains 'microsoft.resources/templatespecs', 'Template Spec Resources',\r\ntype contains 'microsoft.virtualmachineimages', 'VM Image Templates',\r\ntype contains 'microsoft.documentdb', 'CosmosDB DB Resources',\r\ntype contains 'microsoft.alertsmanagement/actionrules', 'Azure Monitor Resources',\r\ntype contains 'microsoft.kubernetes/connectedclusters', 'ARC Kubernetes Clusters',\r\ntype contains 'microsoft.purview', 'Purview Resources',\r\ntype contains 'microsoft.security', 'Security Resources',\r\ntype contains 'microsoft.cdn', 'CDN Resources',\r\ntype contains 'microsoft.devices','IoT Resources',\r\ntype contains 'microsoft.datamigration', 'Data Migraiton Services',\r\ntype contains 'microsoft.cognitiveservices', 'Congitive Services',\r\ntype contains 'microsoft.customproviders', 'Custom Providers',\r\ntype contains 'microsoft.appconfiguration', 'App Services',\r\ntype contains 'microsoft.search', 'Search Services',\r\ntype contains 'microsoft.maps', 'Maps',\r\ntype contains 'microsoft.containerservice/managedclusters', 'AKS',\r\ntype contains 'microsoft.signalrservice', 'SignalR',\r\ntype contains 'microsoft.resourcegraph/queries', 'Resource Graph Queries',\r\ntype contains 'microsoft.batch', 'MS Batch',\r\ntype contains 'microsoft.analysisservices', 'Analysis Services',\r\ntype contains 'microsoft.synapse/workspaces', 'Synapse Workspaces',\r\ntype contains 'microsoft.synapse/workspaces/sqlpools', 'Synapse SQL Pools',\r\ntype contains 'microsoft.kusto/clusters', 'ADX Clusters',\r\ntype contains 'microsoft.resources/deploymentscripts', 'Deployment Scripts',\r\nstrcat(\"Not Translated: \", type))\r\n| summarize count() by type"
        queryType               = 1
        resourceType            = "microsoft.resourcegraph/resources"
        size                    = 2
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "count_"
          sortOrderField    = 2
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        title         = "Resource Count by Type"
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - Overview Resource Counts by type"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "## NoShow - End Overview\r\n\r\n\r\n## NoShow - Begin Compute"
      }
      name = "text - NoShow Begin Compute"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
      }
      content = {
        links = [{
          cellValue  = "compute"
          id         = "a5b84469-ab4c-4b30-9983-22c454d61468"
          linkLabel  = "Azure Compute"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "azure"
          }, {
          cellValue  = "compute"
          id         = "d44b3ab8-d86b-4c5c-939f-273554437a4e"
          linkLabel  = "Hybrid Compute"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "arc"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "tabs -  Compute"
      type = 11
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
      }]
      content = {
        json = "## Current VM Status"
      }
      name = "text - Azure Compute"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        query        = "Resources | where type == \"microsoft.compute/virtualmachines\"\r\n| extend vmState = tostring(properties.extended.instanceView.powerState.displayStatus)\r\n| extend vmState = iif(isempty(vmState), \"VM State Unknown\", (vmState))\r\n| summarize count() by vmState"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 4
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
                style                    = "decimal"
                useGrouping              = false
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmState"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - Azure Compute Summary - Copy"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
      }]
      content = {
        json = "## Count of VMs by VM Size."
      }
      name = "text - Azure Compute - Copy"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        query        = "Resources | where type =~ \"microsoft.compute/virtualmachines\"\r\nor type =~ 'microsoft.compute/virtualmachinescalesets'\r\n| extend Size = case(\r\ntype contains 'microsoft.compute/virtualmachinescalesets', strcat(\"VMSS \", sku.name),\r\ntype contains 'microsoft.compute/virtualmachines', properties.hardwareProfile.vmSize,\r\n\"Size not found\")\r\n| summarize Count=count(Size) by vmSize=tostring(Size)"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 0
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette  = "auto"
              showIcon = true
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmSize"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - Azure Compute Summary"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
      }]
      content = {
        json = "## VMs by Storage and Networking\r\n\r\n💡 Select tab to see corresponding breakdown"
      }
      name = "text - Azure Compute - Copy"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
      }]
      content = {
        links = [{
          cellValue  = "hardware"
          id         = "d99f06e7-b625-4b75-b01c-c6cae7661d2f"
          linkLabel  = "VM Scale Sets"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "vmss"
          }, {
          cellValue  = "hardware"
          id         = "2c1dc7ff-d1c2-4214-9289-6ec960f405b8"
          linkLabel  = "VM Overview"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "overview"
          }, {
          cellValue  = "hardware"
          id         = "9ba284c0-ba39-460c-9f74-b9ae8845245c"
          linkLabel  = "VM Storage"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "storage"
          }, {
          cellValue  = "hardware"
          id         = "ac392a07-01a6-4727-b82b-117c529867c7"
          linkLabel  = "VM Networking"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "network"
          }, {
          cellValue  = "hardware"
          id         = "74bab549-0028-4018-8bf3-065b6c6fa28e"
          linkLabel  = "Orphaned Disks"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "orphaneddisks"
          }, {
          cellValue  = "hardware"
          id         = "a45a3005-c5b6-46a7-8873-ac1e471c51b4"
          linkLabel  = "Orphaned NICs"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "orphanednics"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "links - Azure Compute Storage Networking Breakdown"
      type = 11
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
        }, {
        comparison    = "isEqualTo"
        parameterName = "hardware"
        value         = "vmss"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "VMSS"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Size"
            formatter   = 1
            }, {
            columnMatch = "Capacity"
            formatter   = 1
            }, {
            columnMatch = "OSType"
            formatter   = 1
            }, {
            columnMatch = "UpgradeMode"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "2"
                text           = "{0}{1}"
                thresholdValue = "Manual"
                }, {
                operator       = "Default"
                representation = "success"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "OverProvision"
            formatter   = 1
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "vmId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "VMSS"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No VM Scale Sets found"
        query             = "resources \r\n| where type has 'microsoft.compute/virtualmachinescalesets'\r\n| extend Size = sku.name\r\n| extend Capacity = sku.capacity\r\n| extend UpgradeMode = properties.upgradePolicy.mode\r\n| extend OSType = properties.virtualMachineProfile.storageProfile.osDisk.osType\r\n| extend OS = properties.virtualMachineProfile.storageProfile.imageReference.offer\r\n| extend OSVersion = properties.virtualMachineProfile.storageProfile.imageReference.sku\r\n| extend OverProvision = properties.overprovision\r\n| extend ZoneBalance = properties.zoneBalance\r\n| extend Details = pack_all()\r\n| project VMSS = id, location, resourceGroup, subscriptionId, Size, Capacity, OSType, UpgradeMode, OverProvision, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette  = "auto"
              showIcon = true
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmSize"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - Azure Compute VMSS"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
        }, {
        comparison    = "isEqualTo"
        parameterName = "hardware"
        value         = "overview"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "vmID"
            formatter   = 5
            }, {
            columnMatch = "SQLId"
            formatOptions = {
              customColumnWidthSetting = "20ch"
              linkTarget               = null
              showIcon                 = true
            }
            formatter = 13
            }, {
            columnMatch = "resourceGroup"
            formatter   = 5
            }, {
            columnMatch = "location"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "SQLLicense"
            formatter   = 1
            }, {
            columnMatch = "SQLImage"
            formatter   = 1
            }, {
            columnMatch = "SQLSku"
            formatter   = 1
            }, {
            columnMatch = "SQLManagement"
            formatter   = 1
            }, {
            columnMatch = "FaultDomainCount"
            formatter   = 1
            }, {
            columnMatch = "UpdateDomainCount"
            formatter   = 1
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "vmId"
            formatter   = 5
            }, {
            columnMatch = "timeCreated"
            formatter   = 6
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "vmID"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No VMs found"
        query             = "Resources \r\n| where type == \"microsoft.compute/virtualmachines\"\r\n| extend vmID = tolower(id)\r\n| extend osDiskId= tolower(tostring(properties.storageProfile.osDisk.managedDisk.id))\r\n        | join kind=leftouter(resources\r\n            | where type =~ 'microsoft.compute/disks'\r\n            | where properties !has 'Unattached'\r\n            | where properties has 'osType'\r\n            | project timeCreated = tostring(properties.timeCreated), OS = tostring(properties.osType), osSku = tostring(sku.name), osDiskSizeGB = toint(properties.diskSizeGB), osDiskId=tolower(tostring(id))) on osDiskId\r\n        | join kind=leftouter(resources\r\n\t\t\t| where type =~ 'microsoft.compute/availabilitysets'\r\n\t\t\t| extend VirtualMachines = array_length(properties.virtualMachines)\r\n\t\t\t| mv-expand VirtualMachine=properties.virtualMachines\r\n\t\t\t| extend FaultDomainCount = properties.platformFaultDomainCount\r\n\t\t\t| extend UpdateDomainCount = properties.platformUpdateDomainCount\r\n\t\t\t| extend vmID = tolower(VirtualMachine.id)\r\n\t\t\t| project AvailabilitySetID = id, vmID, FaultDomainCount, UpdateDomainCount ) on vmID\r\n\t\t| join kind=leftouter(resources\r\n\t\t\t| where type =~ 'microsoft.sqlvirtualmachine/sqlvirtualmachines'\r\n\t\t\t| extend SQLLicense = properties.sqlServerLicenseType\r\n\t\t\t| extend SQLImage = properties.sqlImageOffer\r\n\t\t\t| extend SQLSku = properties.sqlImageSku\r\n\t\t\t| extend SQLManagement = properties.sqlManagement\r\n\t\t\t| extend vmID = tostring(tolower(properties.virtualMachineResourceId))\r\n\t\t\t| project SQLId=id, SQLLicense, SQLImage, SQLSku, SQLManagement, vmID ) on vmID\r\n| project-away vmID1, vmID2, osDiskId1\r\n| extend Details = pack_all()\r\n| project vmID, SQLId, AvailabilitySetID, OS, resourceGroup, location, subscriptionId, SQLLicense, SQLImage,SQLSku, SQLManagement, FaultDomainCount, UpdateDomainCount, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette  = "auto"
              showIcon = true
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmSize"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - Azure Compute Overview"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
        }, {
        comparison    = "isEqualTo"
        parameterName = "hardware"
        value         = "storage"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "vmId"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "timeCreated"
            formatter   = 6
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "vmId"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No VMs found"
        query             = "Resources \r\n| where type == \"microsoft.compute/virtualmachines\"\r\n| extend osDiskId= tolower(tostring(properties.storageProfile.osDisk.managedDisk.id))\r\n        | join kind=leftouter(resources\r\n            | where type =~ 'microsoft.compute/disks'\r\n            | where properties !has 'Unattached'\r\n            | where properties has 'osType'\r\n            | project timeCreated = tostring(properties.timeCreated), OS = tostring(properties.osType), osSku = tostring(sku.name), osDiskSizeGB = toint(properties.diskSizeGB), osDiskId=tolower(tostring(id))) on osDiskId\r\n        | join kind=leftouter(Resources\r\n            | where type =~ 'microsoft.compute/disks'\r\n            | where properties !has \"osType\"\r\n            | where properties !has 'Unattached'\r\n            | project sku = tostring(sku.name), diskSizeGB = toint(properties.diskSizeGB), id = managedBy\r\n            | summarize sum(diskSizeGB), count(sku) by id, sku) on id\r\n| project vmId=id, OS, location, resourceGroup, timeCreated,subscriptionId, osDiskId, osSku, osDiskSizeGB, DataDisksGB=sum_diskSizeGB, diskSkuCount=count_sku\r\n| sort by diskSkuCount desc"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette  = "auto"
              showIcon = true
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmSize"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - Azure Compute Disks"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
        }, {
        comparison    = "isEqualTo"
        parameterName = "hardware"
        value         = "network"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "vmId"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "vmId"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No VMs found"
        query             = "Resources\r\n| where type =~ 'microsoft.compute/virtualmachines'\r\n| extend nics=array_length(properties.networkProfile.networkInterfaces)\r\n| mv-expand nic=properties.networkProfile.networkInterfaces\r\n| where nics == 1 or nic.properties.primary =~ 'true' or isempty(nic)\r\n| project vmId = id, vmName = name, vmSize=tostring(properties.hardwareProfile.vmSize), nicId = tostring(nic.id)\r\n\t| join kind=leftouter (\r\n \t\tResources\r\n  \t\t| where type =~ 'microsoft.network/networkinterfaces'\r\n  \t\t| extend ipConfigsCount=array_length(properties.ipConfigurations)\r\n  \t\t| mv-expand ipconfig=properties.ipConfigurations\r\n  \t\t| where ipConfigsCount == 1 or ipconfig.properties.primary =~ 'true'\r\n  \t\t| project nicId = id, privateIP= tostring(ipconfig.properties.privateIPAddress), publicIpId = tostring(ipconfig.properties.publicIPAddress.id), subscriptionId) on nicId\r\n| project-away nicId1\r\n| summarize by vmId, vmSize, nicId, privateIP, publicIpId, subscriptionId\r\n\t| join kind=leftouter (\r\n  \t\tResources\r\n  \t\t| where type =~ 'microsoft.network/publicipaddresses'\r\n  \t\t| project publicIpId = id, publicIpAddress = tostring(properties.ipAddress)) on publicIpId\r\n| project-away publicIpId1\r\n| sort by publicIpAddress desc"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette  = "auto"
              showIcon = true
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmSize"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - Azure Compute Networking"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
        }, {
        comparison    = "isEqualTo"
        parameterName = "hardware"
        value         = "orphaneddisks"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "id"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage      = "No oprhaned disks found"
        noDataMessageStyle = 3
        query              = "Resources  \r\n| where type contains \"microsoft.compute/disks\" \r\n| extend diskState = tostring(properties.diskState)\r\n| where managedBy == \"\"\r\n    or diskState == 'Unattached'\r\n| project id, diskState, resourceGroup, location, subscriptionId"
        queryType          = 1
        resourceType       = "microsoft.resourcegraph/resources"
        showExportToExcel  = true
        size               = 2
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette  = "auto"
              showIcon = true
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmSize"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        version = "KqlItem/1.0"
      }
      name = "query - Azure Compute - Orphaned Disks"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "azure"
        }, {
        comparison    = "isEqualTo"
        parameterName = "hardware"
        value         = "orphanednics"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "id"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage      = "No orphaned nics found"
        noDataMessageStyle = 3
        query              = "resources\r\n| where type =~ \"microsoft.network/networkinterfaces\"\r\n| join kind=leftouter (resources\r\n| where type =~ 'microsoft.network/privateendpoints'\r\n| extend nic = todynamic(properties.networkInterfaces)\r\n| mv-expand nic\r\n| project id=tostring(nic.id) ) on id\r\n| where isempty(id1)\r\n| where properties !has 'virtualmachine'\r\n| project id, resourceGroup, location, subscriptionId"
        queryType          = 1
        resourceType       = "microsoft.resourcegraph/resources"
        showExportToExcel  = true
        size               = 2
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette  = "auto"
              showIcon = true
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmSize"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - Azure Compute Orphaned NICs"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "compute"
        }, {
        comparison    = "isEqualTo"
        parameterName = "compute"
        value         = "arc"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        graphSettings = {
          centerContent = {
            columnMatch = "Count"
            formatter   = 1
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          topContent = {
            columnMatch = "vmSize"
            formatter   = 1
          }
          type = 0
        }
        gridSettings = {
          formatters = [{
            columnMatch = "status"
            formatter   = 1
            }, {
            columnMatch = "LastSeen"
            formatter   = 1
            }, {
            columnMatch = "FQDN"
            formatter   = 1
            }, {
            columnMatch = "OS"
            formatter   = 1
            }, {
            columnMatch = "ServerVersion"
            formatter   = 1
          }]
        }
        query        = "where type == \"microsoft.hybridcompute/machines\"\r\n| project MachineId=id, status = properties.status, \r\n\t\t\t  LastSeen = properties.lastStatusChange, \r\n\t\t\t  FQDN = properties.machineFqdn, \r\n\t\t\t  OS = properties.osName, \r\n\t\t\t  ServerVersion = properties.osVersion\r\n| extend ServerVersion = case(\r\n    ServerVersion has '10.0.17763', 'Server 2019',\r\n    ServerVersion has '10.0.16299', 'Server 2016',\r\n    ServerVersion has '10.0.14393', 'Server 2016',\r\n    ServerVersion has '6.3.9600', 'Server 2012 R2',\r\n\tServerVersion)"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 0
        tileSettings = {
          leftContent = {
            columnMatch = "Count"
            formatOptions = {
              palette  = "auto"
              showIcon = true
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "vmSize"
            formatOptions = {
              showIcon = true
            }
            formatter = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - ARC Machines Inventory"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "## NoShow - End Compute\r\n\r\n## NoShow - Begin PaaS"
      }
      name = "text - NoShow Beging Networking"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
      }
      content = {
        json = "## PaaS Resources\r\n\r\n💡 Select tab to view releated resources for PaaS Services\r\n\r\n\r\n"
      }
      name = "text - PaaS Text"
      styleSettings = {
        padding = "0 0 15px 0"
      }
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
      }
      content = {
        links = [{
          cellValue  = "paas"
          id         = "a4ee3213-3bfc-4333-b798-934e866c48de"
          linkLabel  = "Automation"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "automation"
          }, {
          cellValue  = "paas"
          id         = "c5ba791c-2cc3-4c32-8b5c-eab75cc0354c"
          linkLabel  = "Application Resources"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "apps"
          }, {
          cellValue  = "paas"
          id         = "4b819d18-9495-450b-99bd-40009f1babc7"
          linkLabel  = "Containers"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "containers"
          }, {
          cellValue  = "paas"
          id         = "ed78617d-664d-4727-87c6-91ac79010e2d"
          linkLabel  = "Data"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "data"
          }, {
          cellValue  = "paas"
          id         = "8d82d272-3094-4750-a058-9122b11ae50b"
          linkLabel  = "Events"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "events"
          }, {
          cellValue  = "paas"
          id         = "1dfce15d-7329-46ab-971a-09fc9fbc941b"
          linkLabel  = "IoT"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "iot"
          }, {
          cellValue  = "paas"
          id         = "98122f89-2281-4cee-9681-1212ee8ea496"
          linkLabel  = "ML/AI"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "mlai"
          }, {
          cellValue  = "paas"
          id         = "a4e4ea2e-4c32-4143-92bd-27473db8bc81"
          linkLabel  = "Storage and Backup"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "storage"
          }, {
          cellValue  = "paas"
          id         = "5623ad81-d28e-4b04-9d05-03197472a894"
          linkLabel  = "Windows Virtual Desktop"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "wvd"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "links - PaaS Tabs"
      styleSettings = {
        padding = "0 0 15px 0"
      }
      type = 11
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
      }
      content = {
        json = "### Count of all Resource Types\r\n\r\n\r\n\r\n"
      }
      name = "text - PaaS Text - Overview"
      styleSettings = {
        padding = "0 0 10px 0"
      }
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - Automation"
      }
      name = "text - NoShow Begin Automation"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "automation"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        noDataMessage           = "No resources found"
        query                   = "resources\r\n| where type has 'microsoft.automation'\r\n\tor type has 'microsoft.logic'\r\n\tor type has 'microsoft.web/customapis'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.automation/automationaccounts', 'Automation Accounts',\r\n\ttype == 'microsoft.web/serverfarms', \"App Service Plans\",\r\n\tkind == 'functionapp', \"Azure Functions\", \r\n\tkind == \"api\", \"API Apps\", \r\n\ttype == 'microsoft.web/sites', \"App Services\",\r\n\ttype =~ 'microsoft.web/connections', 'LogicApp Connectors',\r\n\ttype =~ 'microsoft.web/customapis','LogicApp API Connectors',\r\n\ttype =~ 'microsoft.logic/workflows','LogicApps',\r\n    type =~ 'microsoft.logic/integrationaccounts', 'Integration Accounts',\r\n\ttype =~ 'microsoft.automation/automationaccounts/runbooks', 'Automation Runbooks',\r\n    type =~ 'microsoft.automation/automationaccounts/configurations', 'Automation Configurations',\r\nstrcat(\"Not Translated: \", type))\r\n| summarize count() by type\r\n| where type !has \"Not Translated\""
        queryType               = 1
        resourceType            = "microsoft.resourcegraph/resources"
        size                    = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - Automation Overview"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "automation"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - Automation - Details "
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "automation"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No resources found"
        query             = "resources\r\n| where type has 'microsoft.automation'\r\n\t or type has 'microsoft.logic'\r\n\t or type has 'microsoft.web/customapis'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.automation/automationaccounts', 'Automation Accounts',\r\n\ttype =~ 'microsoft.web/connections', 'LogicApp Connectors',\r\n\ttype =~ 'microsoft.web/customapis','LogicApp API Connectors',\r\n\ttype =~ 'microsoft.logic/workflows','LogicApps',\r\n    type =~ 'microsoft.logic/integrationaccounts', 'Integration Accounts',\r\n\ttype =~ 'microsoft.automation/automationaccounts/runbooks', 'Automation Runbooks',\r\n\ttype =~ 'microsoft.automation/automationaccounts/configurations', 'Automation Configurations',\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend RunbookType = tostring(properties.runbookType)\r\n| extend LogicAppTrigger = properties.definition.triggers\r\n| extend LogicAppTrigger = iif(type =~ 'LogicApps', case(\r\n\tLogicAppTrigger has 'manual', tostring(LogicAppTrigger.manual.type),\r\n\tLogicAppTrigger has 'Recurrence', tostring(LogicAppTrigger.Recurrence.type),\r\n    LogicAppTrigger has 'When_an_Azure_Security_Center_Alert', 'Azure Security Center Alert',\r\n    LogicAppTrigger has 'When_an_Azure_Security_Center_Recommendation', 'Azure Security Center Recommendation',\r\n    LogicAppTrigger has 'When_a_response_to_an_Azure_Sentinel_alert', 'Azure Sentinel Alert',\r\n    LogicAppTrigger has 'When_Azure_Sentinel_incident_creation', 'Azure Sentinel Incident',\r\n\tstrcat(\"Unknown Trigger type\", LogicAppTrigger)), LogicAppTrigger)\r\n| extend State = case(\r\n\ttype =~ 'Automation Runbooks', properties.state, \r\n\ttype =~ 'LogicApps', properties.state,\r\n\ttype =~ 'Automation Accounts', properties.state,\r\n\ttype =~ 'Automation Configurations', properties.state,\r\n\t' ')\r\n| extend CreatedDate = case(\r\n\ttype =~ 'Automation Runbooks', properties.creationTime, \r\n\ttype =~ 'LogicApps', properties.createdTime,\r\n\ttype =~ 'Automation Accounts', properties.creationTime,\r\n\ttype =~ 'Automation Configurations', properties.creationTime,\r\n\t' ')\r\n| extend LastModified = case(\r\n\ttype =~ 'Automation Runbooks', properties.lastModifiedTime, \r\n\ttype =~ 'LogicApps', properties.changedTime,\r\n\ttype =~ 'Automation Accounts', properties.lastModifiedTime,\r\n\ttype =~ 'Automation Configurations', properties.lastModifiedTime,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| project Resource=id, subscriptionId, type, resourceGroup, RunbookType, LogicAppTrigger, State, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version = "KqlItem/1.0"
      }
      name = "query - PaaS - Automation Detailed"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - Automation"
      }
      name = "text - NoShow End - PaaS - Automation"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - Apps"
      }
      name = "text - NoShow Begin Automation"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "apps"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage = "No resources found"
        query         = "resources\r\n| where type has 'microsoft.web'\r\n\t or type =~ 'microsoft.apimanagement/service'\r\n\t or type =~ 'microsoft.network/frontdoors'\r\n\t or type =~ 'microsoft.network/applicationgateways'\r\n\t or type =~ 'microsoft.appconfiguration/configurationstores'\r\n| extend type = case(\r\n\ttype == 'microsoft.web/serverfarms', \"App Service Plans\",\r\n\tkind == 'functionapp', \"Azure Functions\", \r\n\tkind == \"api\", \"API Apps\", \r\n\ttype == 'microsoft.web/sites', \"App Services\",\r\n\ttype =~ 'microsoft.network/applicationgateways', 'App Gateways',\r\n\ttype =~ 'microsoft.network/frontdoors', 'Front Door',\r\n\ttype =~ 'microsoft.apimanagement/service', 'API Management',\r\n\ttype =~ 'microsoft.web/certificates', 'App Certificates',\r\n\ttype =~ 'microsoft.appconfiguration/configurationstores', 'App Config Stores',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - Apps Overview"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "apps"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - App Services Details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "apps"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No resources found"
        query             = "resources\r\n| where type has 'microsoft.web'\r\n\t or type =~ 'microsoft.apimanagement/service'\r\n\t or type =~ 'microsoft.network/frontdoors'\r\n\t or type =~ 'microsoft.network/applicationgateways'\r\n\t or type =~ 'microsoft.appconfiguration/configurationstores'\r\n| extend type = case(\r\n\ttype == 'microsoft.web/serverfarms', \"App Service Plans\",\r\n\tkind == 'functionapp', \"Azure Functions\", \r\n\tkind == \"api\", \"API Apps\", \r\n\ttype == 'microsoft.web/sites', \"App Services\",\r\n\ttype =~ 'microsoft.network/applicationgateways', 'App Gateways',\r\n\ttype =~ 'microsoft.network/frontdoors', 'Front Door',\r\n\ttype =~ 'microsoft.apimanagement/service', 'API Management',\r\n\ttype =~ 'microsoft.web/certificates', 'App Certificates',\r\n\ttype =~ 'microsoft.appconfiguration/configurationstores', 'App Config Stores',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Sku = case(\r\n\ttype =~ 'App Gateways', properties.sku.name, \r\n\ttype =~ 'Azure Functions', properties.sku,\r\n\ttype =~ 'API Management', sku.name,\r\n\ttype =~ 'App Service Plans', sku.name,\r\n\ttype =~ 'App Services', properties.sku,\r\n\ttype =~ 'App Config Stores', sku.name,\r\n\t' ')\r\n| extend State = case(\r\n\ttype =~ 'App Config Stores', properties.provisioningState,\r\n\ttype =~ 'App Service Plans', properties.status,\r\n\ttype =~ 'Azure Functions', properties.enabled,\r\n\ttype =~ 'App Services', properties.state,\r\n\ttype =~ 'API Management', properties.provisioningState,\r\n\ttype =~ 'App Gateways', properties.provisioningState,\r\n\ttype =~ 'Front Door', properties.provisioningState,\r\n\t' ')\r\n| mv-expand publicIpId=properties.frontendIPConfigurations\r\n| mv-expand publicIpId = publicIpId.properties.publicIPAddress.id\r\n| extend publicIpId = tostring(publicIpId)\r\n\t| join kind=leftouter(\r\n\t  \tResources\r\n  \t\t| where type =~ 'microsoft.network/publicipaddresses'\r\n  \t\t| project publicIpId = id, publicIpAddress = tostring(properties.ipAddress)) on publicIpId\r\n| extend PublicIP = case(\r\n\ttype =~ 'API Management', properties.publicIPAddresses,\r\n\ttype =~ 'App Gateways', publicIpAddress,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| project Resource=id, type, subscriptionId, Sku, State, PublicIP, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version = "KqlItem/1.0"
      }
      name = "query - PaaS - Apps Detailed"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - Apps"
      }
      name = "text - NoShow End PaaS - Apps"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - Events"
      }
      name = "text - NoShow Begin PaaS - Events"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "events"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage = "No resources found"
        query         = "resources\r\n| where type has 'microsoft.servicebus'\r\n\tor type has 'microsoft.eventhub'\r\n\tor type has 'microsoft.eventgrid'\r\n\tor type has 'microsoft.relay'\r\n| extend type = case(\r\n\ttype == 'microsoft.eventgrid/systemtopics', \"EventGrid System Topics\",\r\n\ttype =~ \"microsoft.eventgrid/topics\", \"EventGrid Topics\",\r\n\ttype =~ 'microsoft.eventhub/namespaces', \"EventHub Namespaces\",\r\n\ttype =~ 'microsoft.servicebus/namespaces', 'ServiceBus Namespaces',\r\n\ttype =~ 'microsoft.relay/namespaces', 'Relays',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - Events Overview"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "events"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - Events - Details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "events"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No resources found"
        query             = "resources\r\n| where type has 'microsoft.servicebus'\r\n\tor type has 'microsoft.eventhub'\r\n\tor type has 'microsoft.eventgrid'\r\n\tor type has 'microsoft.relay'\r\n| extend type = case(\r\n\ttype == 'microsoft.eventgrid/systemtopics', \"EventGrid System Topics\",\r\n\ttype =~ \"microsoft.eventgrid/topics\", \"EventGrid Topics\",\r\n\ttype =~ 'microsoft.eventhub/namespaces', \"EventHub Namespaces\",\r\n\ttype =~ 'microsoft.servicebus/namespaces', 'ServiceBus Namespaces',\r\n\ttype =~ 'microsoft.relay/namespaces', 'Relays',\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend Sku = case(\r\n\ttype =~ 'Relays', sku.name, \r\n\ttype =~ 'EventGrid System Topics', properties.sku,\r\n\ttype =~ 'EventGrid Topics', sku.name,\r\n\ttype =~ 'EventHub Namespaces', sku.name,\r\n\ttype =~ 'ServiceBus Namespaces', sku.sku,\r\n\t' ')\r\n| extend Endpoint = case(\r\n\ttype =~ 'Relays', properties.serviceBusEndpoint,\r\n\ttype =~ 'EventGrid Topics', properties.endpoint,\r\n\ttype =~ 'EventHub Namespaces', properties.serviceBusEndpoint,\r\n\ttype =~ 'ServiceBus Namespaces', properties.serviceBusEndpoint,\r\n\t' ')\r\n| extend Status = case(\r\n\ttype =~ 'Relays', properties.provisioningState,\r\n\ttype =~ 'EventGrid System Topics', properties.provisioningState,\r\n\ttype =~ 'EventGrid Topics', properties.publicNetworkAccess,\r\n\ttype =~ 'EventHub Namespaces', properties.status,\r\n\ttype =~ 'ServiceBus Namespaces', properties.status,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| project Resource=id, type, subscriptionId, resourceGroup, Sku, Status, Endpoint, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version = "KqlItem/1.0"
      }
      name = "query - PaaS - Events Detailed"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - Events"
      }
      name = "text - NoShow End PaaS - Events"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - Data"
      }
      name = "text - NoShow Begin PaaS - Data"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "data"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage = "No resources found"
        query         = "resources \r\n| where type has 'microsoft.documentdb'\r\n\tor type has 'microsoft.sql'\r\n\tor type has 'microsoft.dbformysql'\r\n\tor type has 'microsoft.sql'\r\n    or type has 'microsoft.purview'\r\n    or type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.analysisservices'\r\n\tor type has 'microsoft.datamigration'\r\n\tor type has 'microsoft.synapse'\r\n\tor type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.kusto'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.documentdb/databaseaccounts', 'CosmosDB',\r\n\ttype =~ 'microsoft.sql/servers/databases', 'SQL DBs',\r\n\ttype =~ 'microsoft.dbformysql/servers', 'MySQL',\r\n\ttype =~ 'microsoft.sql/servers', 'SQL Servers',\r\n    type =~ 'microsoft.purview/accounts', 'Purview Accounts',\r\n\ttype =~ 'microsoft.synapse/workspaces/sqlpools', 'Synapse SQL Pools',\r\n\ttype =~ 'microsoft.kusto/clusters', 'ADX Clusters',\r\n\ttype =~ 'microsoft.datafactory/factories', 'Data Factories',\r\n\ttype =~ 'microsoft.synapse/workspaces', 'Synapse Workspaces',\r\n\ttype =~ 'microsoft.analysisservices/servers', 'Analysis Services Servers',\r\n\ttype =~ 'microsoft.datamigration/services', 'DB Migration Service',\r\n\ttype =~ 'microsoft.sql/managedinstances/databases', 'Managed Instance DBs',\r\n\ttype =~ 'microsoft.sql/managedinstances', 'Managed Instnace',\r\n\ttype =~ 'microsoft.datamigration/services/projects', 'Data Migration Projects',\r\n\ttype =~ 'microsoft.sql/virtualclusters', 'SQL Virtual Clusters',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - Data Overview"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "data"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - Data - Details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "data"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Tier"
            formatter   = 1
            }, {
            columnMatch = "maxSizeGB"
            formatter   = 0
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 5
            }
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No resources found"
        query             = "resources \r\n| where type has 'microsoft.documentdb'\r\n\tor type has 'microsoft.sql'\r\n\tor type has 'microsoft.dbformysql'\r\n\tor type has 'microsoft.sql'\r\n    or type has 'microsoft.purview'\r\n    or type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.analysisservices'\r\n\tor type has 'microsoft.datamigration'\r\n\tor type has 'microsoft.synapse'\r\n\tor type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.kusto'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.documentdb/databaseaccounts', 'CosmosDB',\r\n\ttype =~ 'microsoft.sql/servers/databases', 'SQL DBs',\r\n\ttype =~ 'microsoft.dbformysql/servers', 'MySQL',\r\n\ttype =~ 'microsoft.sql/servers', 'SQL Servers',\r\n    type =~ 'microsoft.purview/accounts', 'Purview Accounts',\r\n\ttype =~ 'microsoft.synapse/workspaces/sqlpools', 'Synapse SQL Pools',\r\n\ttype =~ 'microsoft.kusto/clusters', 'ADX Clusters',\r\n\ttype =~ 'microsoft.datafactory/factories', 'Data Factories',\r\n\ttype =~ 'microsoft.synapse/workspaces', 'Synapse Workspaces',\r\n\ttype =~ 'microsoft.analysisservices/servers', 'Analysis Services Servers',\r\n\ttype =~ 'microsoft.datamigration/services', 'DB Migration Service',\r\n\ttype =~ 'microsoft.sql/managedinstances/databases', 'Managed Instance DBs',\r\n\ttype =~ 'microsoft.sql/managedinstances', 'Managed Instnace',\r\n\ttype =~ 'microsoft.datamigration/services/projects', 'Data Migration Projects',\r\n\ttype =~ 'microsoft.sql/virtualclusters', 'SQL Virtual Clusters',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Sku = case(\r\n\ttype =~ 'CosmosDB', properties.databaseAccountOfferType,\r\n\ttype =~ 'SQL DBs', sku.name,\r\n\ttype =~ 'MySQL', sku.name,\r\n\ttype =~ 'ADX Clusters', sku.name,\r\n\ttype =~ 'Purview Accounts', sku.name,\r\n\t' ')\r\n| extend Status = case(\r\n\ttype =~ 'CosmosDB', properties.provisioningState,\r\n\ttype =~ 'SQL DBs', properties.status,\r\n\ttype =~ 'MySQL', properties.userVisibleState,\r\n\ttype =~ 'Managed Instance DBs', properties.status,\r\n\t' ')\r\n| extend Endpoint = case(\r\n\ttype =~ 'MySQL', properties.fullyQualifiedDomainName,\r\n\ttype =~ 'SQL Servers', properties.fullyQualifiedDomainName,\r\n\ttype =~ 'CosmosDB', properties.documentEndpoint,\r\n\ttype =~ 'ADX Clusters', properties.uri,\r\n\ttype =~ 'Purview Accounts', properties.endpoints,\r\n\ttype =~ 'Synapse Workspaces', properties.connectivityEndpoints,\r\n\ttype =~ 'Synapse SQL Pools', sku.name,\r\n\t' ')\r\n| extend Tier = sku.tier\r\n| extend License = properties.licenseType\r\n| extend maxSizeGB = todouble(case(\r\n\ttype =~ 'SQL DBs', properties.maxSizeBytes,\r\n\ttype =~ 'MySQL', properties.storageProfile.storageMB,\r\n\ttype =~ 'Synapse SQL Pools', properties.maxSizeBytes,\r\n\t' '))\r\n| extend maxSizeGB = case(\r\n\t\ttype has 'SQL DBs', maxSizeGB /1000 /1000 /1000,\r\n\t\ttype has 'Synapse SQL Pools', maxSizeGB /1000 /1000 /1000,\r\n\t\ttype has 'MySQL', maxSizeGB /1000,\r\n\t\tmaxSizeGB)\r\n| extend Details = pack_all()\r\n| project Resource=id, resourceGroup, subscriptionId, type, Sku, Tier, Status, Endpoint, maxSizeGB, Details\r\n\r\n"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version = "KqlItem/1.0"
      }
      name = "query - PaaS - Data Detailed"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - Data"
      }
      name = "text - NoShow End PaaS - Data"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - Storage"
      }
      name = "text - NoShow Begin PaaS - Storage"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "storage"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage = "No resources found"
        query         = "resources \r\n| where type =~ 'microsoft.storagesync/storagesyncservices'\r\n\tor type =~ 'microsoft.recoveryservices/vaults'\r\n\tor type =~ 'microsoft.storage/storageaccounts'\r\n\tor type =~ 'microsoft.keyvault/vaults'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.storagesync/storagesyncservices', 'Azure File Sync',\r\n\ttype =~ 'microsoft.recoveryservices/vaults', 'Azure Backup',\r\n\ttype =~ 'microsoft.storage/storageaccounts', 'Storage Accounts',\r\n\ttype =~ 'microsoft.keyvault/vaults', 'Key Vaults',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - Data Overview "
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "storage"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - Storage - Details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "storage"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No resources found"
        query             = "resources \r\n| where type =~ 'microsoft.storagesync/storagesyncservices'\r\n\tor type =~ 'microsoft.recoveryservices/vaults'\r\n\tor type =~ 'microsoft.storage/storageaccounts'\r\n\tor type =~ 'microsoft.keyvault/vaults'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.storagesync/storagesyncservices', 'Azure File Sync',\r\n\ttype =~ 'microsoft.recoveryservices/vaults', 'Azure Backup',\r\n\ttype =~ 'microsoft.storage/storageaccounts', 'Storage Accounts',\r\n\ttype =~ 'microsoft.keyvault/vaults', 'Key Vaults',\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend Sku = case(\r\n\ttype !has 'Key Vaults', sku.name,\r\n\ttype =~ 'Key Vaults', properties.sku.name,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| project Resource=id, type, kind, subscriptionId, resourceGroup, Sku, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        version           = "KqlItem/1.0"
      }
      name = "query - PaaS - Data Detailed"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - Storage"
      }
      name = "text - NoShow End PaaS - Storage - Copy"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - Containers"
      }
      name = "text - NoShow Begin PaaS - Containers"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "containers"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage = "No Container resources found"
        query         = "resources\r\n| where type =~ 'microsoft.containerservice/managedclusters'\r\n\tor type =~ 'microsoft.containerregistry/registries'\r\n\tor type =~ 'microsoft.containerinstance/containergroups'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.containerservice/managedclusters', 'AKS',\r\n\ttype =~ 'microsoft.containerregistry/registries', 'Container Registry',\r\n\ttype =~ 'microsoft.containerinstance/containergroups', 'Container Instances',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type\t"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - Containers Overview"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "containers"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - Containers - Details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "containers"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "sku"
            formatter   = 1
            }, {
            columnMatch = "Tier"
            formatter   = 1
            }, {
            columnMatch = "State"
            formatter   = 1
            }, {
            columnMatch = "RestartCount"
            formatter   = 1
            }, {
            columnMatch = "Version"
            formatter   = 1
            }, {
            columnMatch = "NodeCount"
            formatter   = 1
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "Resource"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "id"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No Container resources found"
        query             = "resources\r\n| where type =~ 'microsoft.containerservice/managedclusters'\r\n\tor type =~ 'microsoft.containerregistry/registries'\r\n\tor type =~ 'microsoft.containerinstance/containergroups'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.containerservice/managedclusters', 'AKS',\r\n\ttype =~ 'microsoft.containerregistry/registries', 'Container Registry',\r\n\ttype =~ 'microsoft.containerinstance/containergroups', 'Container Instances',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Tier = sku.tier\r\n| extend sku = sku.name\r\n| extend State = case(\r\n\ttype =~ 'Container Registry', properties.provisioningState,\r\n\ttype =~ 'Container Instance', properties.instanceView.state,\r\n\tproperties.powerState.code)\r\n| extend Containers = properties.containers\r\n| mvexpand Containers\r\n| extend RestartCount = Containers.properties.instanceView.restartCount\r\n| extend Image = Containers.properties.image\r\n| extend RestartPolicy = properties.restartPolicy\r\n| extend IP = properties.ipAddress.ip\r\n| extend Version = properties.kubernetesVersion\r\n| extend AgentProfiles = properties.agentPoolProfiles\r\n| mvexpand AgentProfiles\r\n| extend NodeCount = AgentProfiles.[\"count\"]\r\n| extend Details = pack_all()\r\n| project id, type, location, resourceGroup, subscriptionId, sku, Tier, State, RestartCount, Version, NodeCount, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        version           = "KqlItem/1.0"
      }
      name = "query - PaaS - Containers Detailed "
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - Containers"
      }
      name = "text - NoShow End PaaS - Containers"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - ML/AI"
      }
      name = "text - NoShow Begin PaaS - ML/AI"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "mlai"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage = "No ML/AI resources found"
        query         = "resources\r\n| where type =~ 'Microsoft.MachineLearningServices/workspaces'\r\n\tor type =~ 'microsoft.cognitiveservices/accounts'\r\n| extend type = case(\r\n\ttype =~ 'Microsoft.MachineLearningServices/workspaces', 'ML Workspaces',\r\n\ttype =~ 'microsoft.cognitiveservices/accounts', 'Cognitive Services',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type\t"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - MLAI Overview"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "mlai"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - ML/AI - Details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "mlai"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "sku"
            formatter   = 1
            }, {
            columnMatch = "Tier"
            formatter   = 1
            }, {
            columnMatch = "Capabilities_value"
            formatOptions = {
              customColumnWidthSetting = "20ch"
              linkIsContextBlade       = true
              linkTarget               = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "Storage"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "AppInsights"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "State"
            formatter   = 1
            }, {
            columnMatch = "RestartCount"
            formatter   = 1
            }, {
            columnMatch = "Version"
            formatter   = 1
            }, {
            columnMatch = "NodeCount"
            formatter   = 1
            }, {
            columnMatch = "Resource"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "id"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No ML/AI resources found"
        query             = "resources\r\n| where type =~ 'Microsoft.MachineLearningServices/workspaces'\r\n\tor type =~ 'microsoft.cognitiveservices/accounts'\r\n| extend type = case(\r\n\ttype =~ 'Microsoft.MachineLearningServices/workspaces', 'ML Workspaces',\r\n\ttype =~ 'microsoft.cognitiveservices/accounts', 'Cognitive Services',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Tier = sku.tier\r\n| extend sku = sku.name\r\n| extend Endpoint = case(\r\n\ttype =~ 'ML Workspaces', properties.discoveryUrl,\r\n\ttype =~ 'Cognitive Services', properties.endpoint,\r\n\t' ')\r\n| extend Capabilities = properties.capabilities\r\n| mvexpand Capabilities\r\n| extend Capabilities.value\r\n| extend Storage = properties.storageAccount\r\n| extend AppInsights = properties.applicationInsights\r\n| extend Details = pack_all()\r\n| project id, type, location, resourceGroup, subscriptionId, sku, Tier, Endpoint, Capabilities_value, Storage, AppInsights, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        version           = "KqlItem/1.0"
      }
      name = "query - PaaS - MLAI Detailed "
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - ML/AI"
      }
      name = "text - NoShow End PaaS - ML/AI"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - IoT"
      }
      name = "text - NoShow Begin PaaS - IoT"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "iot"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage = "No IoT resources found"
        query         = "resources\r\n| where type =~ 'microsoft.devices/iothubs'\r\n\tor type =~ 'microsoft.iotcentral/iotapps'\r\n\tor type =~ 'microsoft.security/iotsecuritysolutions'\r\n| extend type = case (\r\n\ttype =~ 'microsoft.devices/iothubs', 'IoT Hubs',\r\n\ttype =~ 'microsoft.iotcentral/iotapps', 'IoT Apps',\r\n\ttype =~ 'microsoft.security/iotsecuritysolutions', 'IoT Security',\r\n\tstrcat(\"Not Translated: \", type))\r\n| summarize count() by type"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - IoT Overview"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "iot"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - IoT - Details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "iot"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "sku"
            formatter   = 1
            }, {
            columnMatch = "Tier"
            formatter   = 1
            }, {
            columnMatch = "Capabilities_value"
            formatOptions = {
              customColumnWidthSetting = "20ch"
              linkIsContextBlade       = true
              linkTarget               = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "Storage"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "AppInsights"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "State"
            formatter   = 1
            }, {
            columnMatch = "RestartCount"
            formatter   = 1
            }, {
            columnMatch = "Version"
            formatter   = 1
            }, {
            columnMatch = "NodeCount"
            formatter   = 1
            }, {
            columnMatch = "Resource"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "id"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No IoT resources found"
        query             = "resources\r\n| where type =~ 'microsoft.devices/iothubs'\r\n\tor type =~ 'microsoft.iotcentral/iotapps'\r\n\tor type =~ 'microsoft.security/iotsecuritysolutions'\r\n| extend type = case (\r\n\ttype =~ 'microsoft.devices/iothubs', 'IoT Hubs',\r\n\ttype =~ 'microsoft.iotcentral/iotapps', 'IoT Apps',\r\n\ttype =~ 'microsoft.security/iotsecuritysolutions', 'IoT Security',\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend Tier = sku.tier\r\n| extend sku = sku.name\r\n| extend State = properties.state\r\n| extend HostName = properties.hostName\r\n| extend EventHubEndPoint = properties.eventHubEndpoints.events.endpoint\r\n| extend Details = pack_all()\r\n| project id, type, location, resourceGroup, subscriptionId, sku, Tier, State, HostName, EventHubEndPoint, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        version           = "KqlItem/1.0"
      }
      name = "query - PaaS - IoT Detailed "
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - IoT"
      }
      name = "text - NoShow End PaaS - IoT"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin PaaS - WVD"
      }
      name = "text - NoShow Begin PaaS - WVD - Copy"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "wvd"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage = "No WVD Resources found"
        query         = "resources\r\n| where type has 'microsoft.desktopvirtualization'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.desktopvirtualization/applicationgroups', 'WVD App Groups',\r\n\ttype =~ 'microsoft.desktopvirtualization/hostpools', 'WVD Host Pools',\r\n\ttype =~ 'microsoft.desktopvirtualization/workspaces', 'WVD Workspaces',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 1
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "type"
          sortOrderField    = 1
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - PaaS - WVD Overview "
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "wvd"
      }]
      content = {
        json = "### Detailed View\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - PaaS Text - WVD - Details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "paas"
        }, {
        comparison    = "isEqualTo"
        parameterName = "paas"
        value         = "wvd"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "id"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        noDataMessage     = "No WVD resources found"
        query             = "resources\r\n| where type has 'microsoft.desktopvirtualization'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.desktopvirtualization/applicationgroups', 'WVD App Groups',\r\n\ttype =~ 'microsoft.desktopvirtualization/hostpools', 'WVD Host Pools',\r\n\ttype =~ 'microsoft.desktopvirtualization/workspaces', 'WVD Workspaces',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Details = pack_all()\r\n| project id, type, resourceGroup, subscriptionId, kind, location"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        version           = "KqlItem/1.0"
      }
      name = "query - PaaS - WVD Detailed"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End PaaS - WVD"
      }
      name = "text - NoShow End PaaS - WVD - Copy"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "## End PaaS\r\n\r\n\r\n## Begin Networking"
      }
      name = "text - NoShow Monitoring Security"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
      }
      content = {
        json = "## Networking Overview"
      }
      name = "text - Networking Overview"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        query                   = "where type has \"microsoft.network\"\r\n    or type has 'microsoft.cdn'\r\n| extend type = case(\r\n\ttype == 'microsoft.network/networkinterfaces', \"NICs\",\r\n\ttype == 'microsoft.network/networksecuritygroups', \"NSGs\", \r\n\ttype == \"microsoft.network/publicipaddresses\", \"Public IPs\", \r\n\ttype == 'microsoft.network/virtualnetworks', \"vNets\",\r\n\ttype == 'microsoft.network/networkwatchers/connectionmonitors', \"Connection Monitors\",\r\n\ttype == 'microsoft.network/privatednszones', \"Private DNS\",\r\n\ttype == 'microsoft.network/virtualnetworkgateways', @\"vNet Gateways\",\r\n\ttype == 'microsoft.network/connections', \"Connections\",\r\n\ttype == 'microsoft.network/networkwatchers', \"Network Watchers\",\r\n\ttype == 'microsoft.network/privateendpoints', \"Private Endpoints\",\r\n\ttype == 'microsoft.network/localnetworkgateways', \"Local Network Gateways\",\r\n\ttype == 'microsoft.network/privatednszones/virtualnetworklinks', \"vNet Links\",\r\n\ttype == 'microsoft.network/dnszones', 'DNS Zones',\r\n\ttype == 'microsoft.network/networkwatchers/flowlogs', 'Flow Logs',\r\n\ttype == 'microsoft.network/routetables', 'Route Tables',\r\n\ttype == 'microsoft.network/loadbalancers', 'Load Balancers',\r\n\ttype == 'microsoft.network/ddosprotectionplans', 'DDoS Protection Plans',\r\n\ttype == 'microsoft.network/applicationsecuritygroups', 'App Security Groups',\r\n\ttype == 'microsoft.network/azurefirewalls', 'Azure Firewalls',\r\n\ttype == 'microsoft.network/applicationgateways', 'App Gateways',\r\n\ttype == 'microsoft.network/frontdoors', 'Front Doors',\r\n\ttype == 'microsoft.network/applicationgatewaywebapplicationfirewallpolicies', 'AppGateway Policies',\r\n\ttype == 'microsoft.network/bastionhosts', 'Bastion Hosts',\r\n\ttype == 'microsoft.network/frontdoorwebapplicationfirewallpolicies', 'FrontDoor Policies',\r\n\ttype == 'microsoft.network/firewallpolicies', 'Firewall Policies',\r\n\ttype == 'microsoft.network/networkintentpolicies', 'Network Intent Policies',\r\n\ttype == 'microsoft.network/trafficmanagerprofiles', 'Traffic Manager Profiles',\r\n\ttype == 'microsoft.network/publicipprefixes', 'PublicIP Prefixes',\r\n\ttype == 'microsoft.network/privatelinkservices', 'Private Link',\r\n\ttype == 'microsoft.network/expressroutecircuits', 'Express Route Circuits',\r\n    type =~ 'microsoft.network/ipgroups', 'IPGroups',\r\n    type =~ 'microsoft.network/networkprofiles', 'Networkprofiles',\r\n    type =~ 'microsoft.cdn/cdnwebapplicationfirewallpolicies', 'CDN Web App Firewall Policies',\r\n\ttype =~ 'microsoft.cdn/profiles', 'CDN Profiles',\r\n\ttype =~ 'microsoft.cdn/profiles/afdendpoints', 'CDN Front Door Endpoints',\r\n\ttype =~ 'microsoft.cdn/profiles/endpoints', 'CDN Endpoints',\r\n\tstrcat(\"Not Translated: \", type))\r\n| summarize count() by type"
        queryType               = 1
        resourceType            = "microsoft.resourcegraph/resources"
        size                    = 2
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "count_"
          sortOrderField    = 2
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - Networking Summary"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
      }
      content = {
        json = "## Networking Details\r\n\r\n💡 select tab to view NSG Details\r\n\r\n💡 select 'View Details' to see full return from Azure Resource Graph"
      }
      name = "text - Neworking Details"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
      }
      content = {
        links = [{
          cellValue  = "network"
          id         = "5e8a9d46-8041-44fe-96a2-3a606143b199"
          linkLabel  = "NSG"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "nsg"
          }, {
          cellValue  = "network"
          id         = "11426c5c-1edb-41a5-bb7f-fbfb8bbc4bba"
          linkLabel  = "Unassociated NSGs"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "blanknsgs"
          }, {
          cellValue  = "network"
          id         = "5c167305-3eff-4612-a28a-8be527307914"
          linkLabel  = "NSG Rules"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "nsgrules"
          }, {
          cellValue  = "network"
          id         = "3bdf246a-ec97-44d9-b5c7-363578456580"
          linkLabel  = "NICs"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "NICs"
          }, {
          cellValue  = "network"
          id         = "2a1951d6-618a-4afc-9fda-0c308fde0d0f"
          linkLabel  = "vNets"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "vNets"
          }, {
          cellValue  = "network"
          id         = "732e7bb4-90f4-4079-92cb-7aeac3c4eab2"
          linkLabel  = "Subnets"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "Subnets"
          }, {
          cellValue  = "network"
          id         = "ab13797e-774b-49f2-b4d4-80c2caef9ef2"
          linkLabel  = "Peerings"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "Peerings"
          }, {
          cellValue  = "network"
          id         = "ada070bd-f0ce-4dde-8ea5-cd308602be32"
          linkLabel  = "AppGW"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "AppGW"
          }, {
          cellValue  = "network"
          id         = "3808aab1-bcaa-4bb7-9e17-0e9c6470f8cf"
          linkLabel  = "IPGroups"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "IPGroups"
          }, {
          cellValue  = "network"
          id         = "e8e3cf36-0049-451c-a4fb-09cc1d213aad"
          linkLabel  = "LBs"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "LBs"
          }, {
          cellValue  = "network"
          id         = "e8fd06d9-8557-4a92-a9f4-ea074c2d3943"
          linkLabel  = "ConMon"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "ConMon"
          }, {
          cellValue  = "network"
          id         = "a76bb41f-7d9f-4848-abeb-e3393fc9d325"
          linkLabel  = "AllIPs"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "AllIPs"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "links - Networking Details - Tabs"
      type = 11
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "blanknsgs"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        noDataMessage      = "No Unassociated NSGs Found"
        noDataMessageStyle = 3
        query              = "Resources\r\n| where type =~ 'microsoft.network/networksecuritygroups' and isnull(properties.networkInterfaces) and isnull(properties.subnets)\r\n| project Resource=id, resourceGroup, subscriptionId, location"
        queryType          = 1
        resourceType       = "microsoft.resourcegraph/resources"
        showExportToExcel  = true
        size               = 0
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "count_"
          sortOrderField    = 2
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - Networking Details - Unassociated NSGs"
      styleSettings = {
        padding = "0 0 100px 0"
      }
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "nsgrules"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "resourceGroup"
            formatOptions = {
              customColumnWidthSetting = "24.1429ch"
            }
            formatter = 0
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "id"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query             = "Resources\r\n    | where type =~ 'microsoft.network/networksecuritygroups'\r\n    | project id, nsgRules = parse_json(parse_json(properties).securityRules), networksecurityGroupName = name, subscriptionId, resourceGroup , location\r\n    | mvexpand nsgRule = nsgRules\r\n    | project id, location, access=nsgRule.properties.access,protocol=nsgRule.properties.protocol ,direction=nsgRule.properties.direction,provisioningState= nsgRule.properties.provisioningState ,priority=nsgRule.properties.priority, \r\n        sourceAddressPrefix = nsgRule.properties.sourceAddressPrefix, \r\n        sourceAddressPrefixes = nsgRule.properties.sourceAddressPrefixes,\r\n        destinationAddressPrefix = nsgRule.properties.destinationAddressPrefix, \r\n        destinationAddressPrefixes = nsgRule.properties.destinationAddressPrefixes, \r\n        networksecurityGroupName, networksecurityRuleName = tostring(nsgRule.name), \r\n        subscriptionId, resourceGroup,\r\n        destinationPortRanges = nsgRule.properties.destinationPortRanges,\r\n        destinationPortRange = nsgRule.properties.destinationPortRange,\r\n        sourcePortRanges = nsgRule.properties.sourcePortRanges,\r\n        sourcePortRange = nsgRule.properties.sourcePortRange\r\n| extend Details = pack_all()\r\n| project id, location, access, direction, subscriptionId, resourceGroup, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "count_"
          sortOrderField    = 2
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - Networking Details - NSG Rules"
      styleSettings = {
        padding = "0 0 200px 0"
      }
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "nsgrules"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        parameters = [{
          crossComponentResources = ["{Subscriptions}"]
          id                      = "2a6c17b5-ef20-4ca7-a6f4-00901eb54ed1"
          isHiddenWhenLocked      = true
          label                   = "NSG With Flow Logs and Traffic Analytics"
          name                    = "nsgWithTrafficAnalytics"
          query                   = "Resources\n| where type =~ 'Microsoft.Network/networkWatchers/flowlogs'\n| extend provisioningState = parse_json(properties).provisioningState \n| extend workspaceResourceId = tostring(parse_json(parse_json(parse_json(properties).flowAnalyticsConfiguration).networkWatcherFlowAnalyticsConfiguration).workspaceResourceId)\n| extend targetResourceId = iff(notempty(workspaceResourceId) and provisioningState == \"Succeeded\", tostring(parse_json(properties).targetResourceId), \"null\" ) \n| distinct targetResourceId\n"
          queryType               = 1
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Subscriptions}"]
          id                      = "c8a786fc-40ff-4594-83b5-6952c6928523"
          isHiddenWhenLocked      = true
          label                   = "NSG With Flow Logs"
          name                    = "nsgWithFlowLogs"
          query                   = "Resources\n| where type =~ 'Microsoft.Network/networkWatchers/flowlogs'\n| extend provisioningState = parse_json(properties).provisioningState \n| extend targetResourceId = iff(provisioningState == \"Succeeded\", tostring(parse_json(properties).targetResourceId), \"null\" ) \n| distinct targetResourceId\n"
          queryType               = 1
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
        }]
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        style        = "above"
        version      = "KqlParameterItem/1.0"
      }
      name = "query - Networking Details - NSG with Flow Logs and Traffic Analytics"
      type = 9
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "nsg"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "Resources\r\n| where type =~ 'microsoft.network/networksecuritygroups'\r\n| extend flowLogs = \"{nsgWithFlowLogs}\" has id\r\n| extend trafficAnalytics = \"{nsgWithTrafficAnalytics}\" has id\r\n| project subscriptionId, ['Resource group'] = strcat('/subscriptions/', subscriptionId, '/resourceGroups/', resourceGroup), ['Network Security Group'] = id, [\"Location\"]=location, [\"Flow Logs\"]=flowLogs, [\"Traffic Analytics\"]=trafficAnalytics\r\n\r\n"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "Network Security Groups"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "Network Security Groups"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "NICs"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "resources\r\n| where type == \"microsoft.network/networkinterfaces\"\r\n| project subscriptionId, ['Name'] = id, ['Resource group'] = strcat('/subscriptions/', subscriptionId, '/resourceGroups/', resourceGroup),\r\nprivateIP = tostring(properties.ipConfigurations[0].properties.privateIPAddress),\r\npublicIpId = tostring(properties.ipConfigurations[0].properties.publicIPAddress.id),\r\nASG = tostring((properties.ipConfigurations[0].properties.applicationSecurityGroups)[0].id),\r\n['VM'] = strcat('/subscriptions/', subscriptionId, '/resourceGroups/', resourceGroup,'/providers/Microsoft.Compute/virtualMachines/',split(properties.virtualMachine.id,\"/\")[8])\r\n\t| join kind=leftouter (\r\n  \t\tResources\r\n  \t\t| where type =~ 'microsoft.network/publicipaddresses'\r\n  \t\t| project publicIpId = id, publicIpAddress = tostring(properties.ipAddress)) on publicIpId\r\n| project-away publicIpId1\r\n| project subscriptionId, ['Name'],  ['Resource group'], privateIP, publicIpAddress, publicIpId, ASG, ['VM']\r\n"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "NetworkInterfaces"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "NICs"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "vNets"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "resources\r\n| where type == \"microsoft.network/virtualnetworks\"\r\n|  extend SubnetCount = array_length(properties.subnets)\r\n| project subscriptionId, ['Name'] = id, ['Resource group'] = strcat('/subscriptions/', subscriptionId, '/resourceGroups/', resourceGroup),\r\nPrefixes = tostring(properties.addressSpace.addressPrefixes), SubnetCount,\r\n['PeeringsCount'] = array_length(properties.virtualNetworkPeerings)"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "virtual Networks"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "vNets"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "Subnets"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "resources\r\n| where type =~ 'Microsoft.network/virtualNetworks'\r\n| extend Subnets=array_length(properties.subnets)\r\n| mv-expand Subnet=properties.subnets\r\n| where isnotempty(Subnets)\r\n| extend ['IPs']=iff(array_length(Subnet.properties.ipConfigurations) > 0,toint(array_length(Subnet.properties.ipConfigurations)),0)\r\n| extend ['delegatedTo']=iff(array_length(Subnet.properties.delegations) > 0,Subnet.properties.delegations[0].properties.serviceName,\"\")\r\n| extend totalIPs=toint(exp2((32-(split(Subnet.properties.addressPrefix,\"/\")[1])))-4)\r\n| extend ['AppGWIPs']=iff(array_length(Subnet.properties.applicationGatewayIPConfigurations) > 0,toint(array_length(Subnet.properties.applicationGatewayIPConfigurations)),0)\r\n| extend ['UsedIPs'] = iff(array_length(Subnet.properties.delegations) > 0, totalIPs, IPs + AppGWIPs)\r\n| project subscriptionId, VNetName = id, Name = tostring(split((Subnet.id),\"/\")[10]), addressPrefix=tostring(Subnet.properties.addressPrefix), Routetable = tostring(Subnet.properties.routeTable.id),\r\nUsedIPs,\r\nFreeIPs = exp2((32-(split(Subnet.properties.addressPrefix,\"/\")[1])))-4 -UsedIPs,\r\ntotalIPs,\r\ndelegatedTo"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "Subnets"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "Subnets"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "Peerings"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "resources\r\n| where type =~ 'Microsoft.network/virtualNetworks'\r\n| extend peerings=array_length(properties.virtualNetworkPeerings)\r\n| mv-expand peering=properties.virtualNetworkPeerings\r\n| where isnotempty(peerings)\r\n| project subscriptionId, networkId = id, VNetName = name, peeringState=tostring(peering.properties.peeringState), remote_vNet = tostring(peering.properties.remoteVirtualNetwork.id)"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "Peerings"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "Perrings"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "AppGW"
      }]
      content = {
        crossComponentResources = ["value::all"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "resources\r\n| where type == \"microsoft.network/applicationgateways\"\r\n| extend FEIP = tostring(properties.frontendIPConfigurations[0].properties.privateIPAddress)\r\n| extend FEPip = tostring(properties.frontendIPConfigurations[0].properties.publicIPAddress.id)\r\n| project subscriptionId, ['Name'] = id, location, resourceGroup, ['Pools'] = array_length(properties.backendAddressPools),\r\n SKU = tostring(properties.sku.tier),\r\n WAF = tostring(properties.webApplicationFirewallConfiguration.enabled),\r\n FEIP, FEPip"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "Application Gateway"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "AppGW"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "IPGroups"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = " resources\r\n| where type == \"microsoft.network/ipgroups\"\r\n| project subscriptionId, ['Name']=id, IPAddresses = properties.ipAddresses, IPAddressesCount = array_length(properties.ipAddresses)"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "IPGroups"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "IPGroups"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "LBs"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "resources\r\n| where type == \"microsoft.network/loadbalancers\"\r\n| project subscriptionId, ['Name']=id,\r\nBackenPools = array_length(properties.backendAddressPools),\r\nFEIPs = array_length(properties.frontendIPConfigurations),\r\nFEIP = tostring(properties.frontendIPConfigurations[0].properties.privateIPAddress),\r\nsubnet = tostring(properties.frontendIPConfigurations[0].properties.subnet.id),\r\nFEPip  = tostring(properties.frontendIPConfigurations[0].properties.publicIPAddress.id)\r\n| join kind=leftouter (\r\n  \t\tResources\r\n  \t\t| where type =~ 'microsoft.network/publicipaddresses'\r\n  \t\t| project FEPip = id, publicIpAddress = tostring(properties.ipAddress)) on FEPip\r\n| project-away FEPip1"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "Loadbalancers"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "Loadbalancers"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "ConMon"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "resources\r\n| where type == \"microsoft.network/networkwatchers/connectionmonitors\"\r\n| project subscriptionId, ['Name']=id,\r\nSource = tostring(properties.endpoints[0].resourceId),\r\nDestination =  properties.endpoints[1].address,\r\nProtocol = properties.testConfigurations[0].protocol,\r\nPort = properties.testConfigurations[0].tcpConfiguration.port,\r\nFrequency = properties.testConfigurations[0].testFrequencySec"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "ConnectionMonitors"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "ConnectionMonitors"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "network"
        }, {
        comparison    = "isEqualTo"
        parameterName = "network"
        value         = "AllIPs"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionId"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Resource group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Network Security Group"
            formatter   = 5
            }, {
            columnMatch = "Flow Logs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Traffic Analytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "success"
                text           = "Enabled"
                thresholdValue = "1"
                }, {
                operator       = "=="
                representation = "disabled"
                text           = "Disabled"
                thresholdValue = "0"
                }, {
                operator       = "Default"
                representation = "unknown"
                text           = "unknown"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "Subscription"
            formatOptions = {
              linkTarget = "Resource"
            }
            formatter = 5
            }, {
            columnMatch = "Flow logs"
            formatter   = 11
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 0
            }
            }, {
            columnMatch = "Resource"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Network Security Group"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query         = "resources\r\n| where type == \"microsoft.network/networkinterfaces\"  or type == \"microsoft.network/applicationgateways\" or type == \"microsoft.network/loadbalancers\" or type == \"microsoft.network/azurefirewalls\"\r\n| extend privateIP = tostring(properties.ipConfigurations[0].properties.privateIPAddress)\r\n| extend publicIpId = tostring(properties.ipConfigurations[0].properties.publicIPAddress.id)\r\n| extend FEIP = tostring(properties.frontendIPConfigurations[0].properties.privateIPAddress)\r\n| extend FEPipid = tostring(properties.frontendIPConfigurations[0].properties.publicIPAddress.id)\r\n\t| join kind=leftouter (\r\n  \t\tResources\r\n  \t\t| where type =~ 'microsoft.network/publicipaddresses'\r\n  \t\t| project publicIpId = id, PIP = tostring(properties.ipAddress)) on publicIpId\r\n\t| join kind=leftouter (\r\n  \t\tResources\r\n  \t\t| where type =~ 'microsoft.network/publicipaddresses'\r\n  \t\t| project FEPipid = id, FEPip = tostring(properties.ipAddress)) on FEPipid\r\n| project subscriptionId, ['Name'] = id,\r\nprivIP = iff(privateIP <> \"\",privateIP,FEIP),\r\npubIP = iff(PIP <> \"\",PIP,FEPip),\r\npubIPid = iff(publicIpId <> \"\",publicIpId,FEPipid)"
        queryType     = 1
        resourceType  = "microsoft.resourcegraph/resources"
        size          = 2
        sortBy        = []
        title         = "All IP Addresses"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "AppIPs"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "## End Networking\r\n\r\n\r\n## Begin Monitoring & Security"
      }
      name = "text - End Networking"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
      }
      content = {
        json = "## Monitor & Security  \r\n   \r\n   \r\n   \r\n### Workspaces Overview"
      }
      name = "text - Monitor & Security"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "Solutions"
            formatter   = 5
            }, {
            columnMatch = "AzureSecurityCenter"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureSecurityCenterFree"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureSentinel"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureMonitorVMs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "ServiceDesk"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureAutomation"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "ChangeTracking"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "UpdateManagement"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "UpdateCompliance"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureMonitorContainers"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "KeyVaultAnalytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "SQLHealthCheck"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
          }]
        }
        query        = "resources \r\n| where type =~ 'microsoft.operationalinsights/workspaces'\r\nor type =~ 'microsoft.insights/components'\r\n| summarize count() by type\r\n| extend type = case(\r\ntype == 'microsoft.insights/components', \"Application Insights\",\r\ntype == 'microsoft.operationalinsights/workspaces', \"Log Analytics workspaces\",\r\nstrcat(type, type))"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 4
        sortBy       = []
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - Monitoring Security Overview - Copy - Copy"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
      }
      content = {
        json = "### Azure Monitor Workbooks & Alerting Resources"
      }
      name = "text - Monitor & Security - Azure Monitor Alerts"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "Solutions"
            formatter   = 5
            }, {
            columnMatch = "AzureSecurityCenter"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureSecurityCenterFree"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureSentinel"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureMonitorVMs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "ServiceDesk"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureAutomation"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "ChangeTracking"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "UpdateManagement"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "UpdateCompliance"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureMonitorContainers"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "KeyVaultAnalytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "SQLHealthCheck"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
          }]
        }
        query        = "resources\r\n| where type has 'microsoft.insights/'\r\n     or type has 'microsoft.alertsmanagement/smartdetectoralertrules'\r\n     or type has 'microsoft.portal/dashboards'\r\n| where type != 'microsoft.insights/components'\r\n| extend type = case(\r\n \ttype == 'microsoft.insights/workbooks', \"Workbooks\",\r\n\ttype == 'microsoft.insights/activitylogalerts', \"Activity Log Alerts\",\r\n\ttype == 'microsoft.insights/scheduledqueryrules', \"Log Search Alerts\",\r\n\ttype == 'microsoft.insights/actiongroups', \"Action Groups\",\r\n\ttype == 'microsoft.insights/metricalerts', \"Metric Alerts\",\r\n\ttype =~ 'microsoft.alertsmanagement/smartdetectoralertrules','Smart Detection Rules',\r\n    type =~ 'microsoft.insights/webtests', 'URL Web Tests',\r\n    type =~ 'microsoft.portal/dashboards', 'Portal Dashboards',\r\n    type =~ 'microsoft.insights/datacollectionrules', 'Data Collection Rules',\r\n    type =~ 'microsoft.insights/autoscalesettings', 'Auto Scale Settings',\r\n    type =~ 'microsoft.insights/alertrules', 'Alert Rules',\r\nstrcat(\"Not Translated: \", type))\r\n| summarize count() by type"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 1
        sortBy       = []
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder        = true
          sortCriteriaField = "count_"
          sortOrderField    = 2
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - Monitoring Security Overview - Copy"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
      }
      content = {
        links = [{
          cellValue  = "monitor"
          id         = "ed3b3650-dd46-4a66-9acd-cbda10b14c04"
          linkLabel  = "Active Alerts"
          linkTarget = "parameter"
          preText    = "Active Alerts"
          style      = "link"
          subTarget  = "alerts"
          }, {
          cellValue  = "monitor"
          id         = "9224d88a-9c0d-49de-8b24-38b3f8c380d3"
          linkLabel  = "Workbooks & Alerting Resources"
          linkTarget = "parameter"
          preText    = "Monitor Resources"
          style      = "link"
          subTarget  = "alertresources"
          }, {
          cellValue  = "monitor"
          id         = "b90eaf7d-647e-4b37-ae0a-6fc6a49ce07c"
          linkLabel  = "App Monitoring"
          linkTarget = "parameter"
          preText    = "App Monitoring"
          style      = "link"
          subTarget  = "apm"
          }, {
          cellValue  = "monitor"
          id         = "1b181560-7b87-4f30-886c-2054a3648401"
          linkLabel  = "Log Analytics"
          linkTarget = "parameter"
          preText    = "Log Analytics"
          style      = "link"
          subTarget  = "loganalytics"
          }, {
          cellValue  = "monitor"
          id         = "d19b8a04-9a79-40ca-90a6-7ebc1be7fe75"
          linkLabel  = "Security Score"
          linkTarget = "parameter"
          preText    = "Security Score"
          style      = "link"
          subTarget  = "security"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "links - Monitor & Security - Tabs"
      type = 11
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin - Monitor & Security - Active Alerts"
      }
      name = "text - NoShow - Begin Active Alerts"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "alerts"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "name"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "name"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query             = "AlertsManagementResources\r\n| extend AlertStatus = properties.essentials.monitorCondition\r\n| extend AlertState = properties.essentials.alertState\r\n| extend AlertTime = properties.essentials.startDateTime\r\n| extend AlertSuppressed = properties.essentials.actionStatus.isSuppressed\r\n| extend Severity = properties.essentials.severity\r\n| where AlertStatus == 'Fired'\r\n| extend Details = pack_all()\r\n| project id, name, subscriptionId, resourceGroup, AlertStatus, AlertState, AlertTime, AlertSuppressed, Severity, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 2
        version           = "KqlItem/1.0"
      }
      name = "query - Monitor & Security - Active Alerts"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End - Monitor & Security - Active Alerts"
      }
      name = "text - NoShow - End Active Alerts"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin Monitor & Security - Alerting Resources"
      }
      name = "text - NoShow - Begin Alerting Resources"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "alertresources"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "name"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "id"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "name"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        query        = "resources\r\n| where type has 'microsoft.insights/'\r\n     or type has 'microsoft.alertsmanagement/smartdetectoralertrules'\r\n    or type has 'microsoft.portal/dashboards'\r\n| where type != 'microsoft.insights/components'\r\n| extend type = case(\r\n \ttype == 'microsoft.insights/workbooks', \"Workbooks\",\r\n\ttype == 'microsoft.insights/activitylogalerts', \"Activity Log Alerts\",\r\n\ttype == 'microsoft.insights/scheduledqueryrules', \"Log Search Alerts\",\r\n\ttype == 'microsoft.insights/actiongroups', \"Action Groups\",\r\n\ttype == 'microsoft.insights/metricalerts', \"Metric Alerts\",\r\n\ttype =~ 'microsoft.alertsmanagement/smartdetectoralertrules','Smart Detection Rules',\r\n    type =~ 'microsoft.portal/dashboards', 'Portal Dashboards',\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend Enabled = case(\r\n\ttype =~ 'Smart Detection Rules', properties.state,\r\n\ttype != 'Smart Detection Rules', properties.enabled,\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend WorkbookType = iif(type =~ 'Workbooks', properties.category, ' ')\r\n| extend Details = pack_all()\r\n| project name, type, subscriptionId, location, resourceGroup, Enabled, WorkbookType, Details"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 2
        version      = "KqlItem/1.0"
      }
      name = "query - Monitor & Security - Alerting Resources"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End - Monitor & Security - Alerting Resources"
      }
      name = "text - NoShow - End Alerting Resources"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin - Monitor & Security - App Monitoring"
      }
      name = "text - NoShow - Begin App Monitoring"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "apm"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        exportedParameters = [{
          fieldName     = "Resource"
          parameterName = "appinsight"
          parameterType = 5
        }]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Resource"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "name"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Resource"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        query        = "where type =~ 'microsoft.insights/components'\r\n| extend RetentionInDays = properties.RetentionInDays\r\n| extend IngestionMode = properties.IngestionMode\r\n| extend Details = pack_all()\r\n| project Resource=id, location, resourceGroup, subscriptionId, IngestionMode, RetentionInDays, Details"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 2
        version      = "KqlItem/1.0"
      }
      name = "query - Monitor & Security - App Monitoring"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End - Monitor & Security - App Monitoring"
      }
      name = "text - NoShow - End App Monitoring"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin - Monitor & Security - Log Analytics"
      }
      name = "text - NoShow - Begin - App Monitoring"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "loganalytics"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        exportedParameters = [{
          fieldName     = "workspace"
          parameterName = "workspace"
          parameterType = 5
        }]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Workspace"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Workspace"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        query             = "where type =~ 'microsoft.operationalinsights/workspaces'\r\n| extend Sku = properties.sku.name\r\n| extend RetentionInDays = properties.retentionInDays\r\n| extend Details = pack_all()\r\n| project Workspace=id, resourceGroup, location, subscriptionId, Sku, RetentionInDays, Details"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 0
        sortBy            = []
        version           = "KqlItem/1.0"
      }
      name = "query - Monitoring Security Overview - Copy"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "loganalytics"
      }]
      content = {
        json = "### Log Analytics workspaces with enabled Solutions\r\n\r\n💡 Select workspace to see data tables and resources logging to that workspace\r\n"
      }
      name = "text - Monitor & Security - workspace details"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "loganalytics"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        exportedParameters = [{
          fieldName     = "Workspace"
          parameterName = "workspace"
          parameterType = 5
        }]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Workspace"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Solutions"
            formatter   = 5
            }, {
            columnMatch = "AzureSecurityCenter"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureSecurityCenterFree"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureSentinel"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureMonitorVMs"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "ServiceDesk"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureAutomation"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "ChangeTracking"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "UpdateManagement"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "UpdateCompliance"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "AzureMonitorContainers"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "KeyVaultAnalytics"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
            }, {
            columnMatch = "SQLHealthCheck"
            formatOptions = {
              thresholdsGrid = [{
                operator       = "=="
                representation = "disabled"
                text           = "{0}{1}"
                thresholdValue = "Not Enabled"
                }, {
                operator       = "Default"
                representation = "Available"
                text           = "{0}{1}"
                thresholdValue = null
              }]
              thresholdsOptions = "icons"
            }
            formatter = 18
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Workspace"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        query             = "resources\r\n| where type == \"microsoft.operationsmanagement/solutions\"\r\n| project Solution=plan.name, Workspace=tolower(tostring(properties.workspaceResourceId)), subscriptionId\r\n\t| join kind=leftouter(\r\n\t\tresources\r\n\t\t| where type =~ 'microsoft.operationalinsights/workspaces'\r\n\t\t| project Workspace=tolower(tostring(id)),subscriptionId) on Workspace\r\n| summarize Solutions = strcat_array(make_list(Solution), \",\") by Workspace, subscriptionId\r\n| extend AzureSecurityCenter = iif(Solutions has 'Security','Enabled','Not Enabled')\r\n| extend AzureSecurityCenterFree = iif(Solutions has 'SecurityCenterFree','Enabled','Not Enabled')\r\n| extend AzureSentinel = iif(Solutions has \"SecurityInsights\",'Enabled','Not Enabled')\r\n| extend AzureMonitorVMs = iif(Solutions has \"VMInsights\",'Enabled','Not Enabled')\r\n| extend ServiceDesk = iif(Solutions has \"ITSM Connector\",'Enabled','Not Enabled')\r\n| extend AzureAutomation = iif(Solutions has \"AzureAutomation\",'Enabled','Not Enabled')\r\n| extend ChangeTracking = iif(Solutions has 'ChangeTracking','Enabled','Not Enabled')\r\n| extend UpdateManagement = iif(Solutions has 'Updates','Enabled','Not Enabled')\r\n| extend UpdateCompliance = iif(Solutions has 'WaaSUpdateInsights','Enabled','Not Enabled')\r\n| extend AzureMonitorContainers = iif(Solutions has 'ContainerInsights','Enabled','Not Enabled')\r\n| extend KeyVaultAnalytics = iif(Solutions has 'KeyVaultAnalytics','Enabled','Not Enabled')\r\n| extend SQLHealthCheck = iif(Solutions has 'SQLAssessment','Enabled','Not Enabled')"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 0
        sortBy            = []
        version           = "KqlItem/1.0"
      }
      name = "query - Monitoring Security Overview"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "loganalytics"
      }]
      content = {
        json = "\r\n\r\n💡 Workspace table usage for selected workspace on the left, resources reported to selected workspace on the right."
      }
      name = "text - Monitor & Security - workspace table usage"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "loganalytics"
      }]
      content = {
        crossComponentResources = ["{workspace}"]
        exportedParameters = [{
          fieldName     = "workspace"
          parameterName = "workspace"
          parameterType = 5
        }]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "Size"
            formatOptions = {
              customColumnWidthSetting = "341px"
              palette                  = "orange"
            }
            formatter = 3
            numberFormat = {
              options = {
                style = "decimal"
              }
              unit = 38
            }
          }]
          rowLimit = 500
        }
        noDataMessageStyle = 5
        query              = "Usage\r\n| summarize Size = sum(Quantity) by ['Table Name'] = DataType\r\n| sort by Size desc"
        queryType          = 0
        resourceType       = "microsoft.operationalinsights/workspaces"
        showExportToExcel  = true
        size               = 2
        sortBy             = []
        timeContext = {
          durationMs = 86400000
        }
        version = "KqlItem/1.0"
      }
      customWidth = "50"
      name        = "query - Monitoring Security - Workspace Usage - Copy"
      type        = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "loganalytics"
      }]
      content = {
        crossComponentResources = ["{workspace}"]
        exportedParameters = [{
          fieldName     = "workspace"
          parameterName = "workspace"
          parameterType = 5
        }]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "_ResourceId"
            formatter   = 5
            }, {
            columnMatch = "SubscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "_ResourceId"
            groupBy        = ["SubscriptionId"]
            treeType       = 1
          }
          rowLimit = 500
        }
        noDataMessageStyle = 5
        query              = "search * | distinct _ResourceId, SubscriptionId"
        queryType          = 0
        resourceType       = "microsoft.operationalinsights/workspaces"
        showExportToExcel  = true
        size               = 2
        sortBy             = []
        timeContext = {
          durationMs = 86400000
        }
        version = "KqlItem/1.0"
      }
      customWidth = "50"
      name        = "query - Monitoring Security - Workspace Usage"
      type        = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End - Monitor & Security - Log Analytics"
      }
      name = "text - NoShow - End - App Monitoring"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - Begin - Monitor & Security - Security"
      }
      name = "text - NoShow - Begin - App Monitoring - Security"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "security"
      }]
      content = {
        json = "### Azure Security Center Secure Store by Subscription"
      }
      name = "text - Monitor & Security - Secure Score Text"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "security"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = null
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "subscriptionSecureScore"
            formatOptions = {
              max     = 100
              min     = 0
              palette = "redGreen"
            }
            formatter = 8
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 1
            }
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "subscriptionSecureScore"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        query        = "securityresources\r\n| where type == \"microsoft.security/securescores\"\r\n| extend subscriptionSecureScore = round(100 * bin((todouble(properties.score.current))/ todouble(properties.score.max), 0.001))\r\n| where subscriptionSecureScore > 0\r\n| project subscriptionSecureScore, subscriptionId\r\n| order by subscriptionSecureScore asc"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 0
        version      = "KqlItem/1.0"
      }
      name = "query - Monitor & Security - Security Scores"
      type = 3
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "security"
      }]
      content = {
        json = "### Azure Security Center Secure Controls Score by Controls\r\n\r\nlists all security controls, the amount of unhealthy resources, their current score and their max score"
      }
      name = "text - Monitor & Security - Secure Score Text - Copy"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "monitor"
        }, {
        comparison    = "isEqualTo"
        parameterName = "monitor"
        value         = "security"
      }]
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              customColumnWidthSetting = "45ch"
              linkTarget               = null
              showIcon                 = true
            }
            formatter = 13
            }, {
            columnMatch = "SecureControl"
            formatter   = 5
            }, {
            columnMatch = "unhealthy"
            formatOptions = {
              min     = 0
              palette = "greenRed"
            }
            formatter = 8
            }, {
            columnMatch = "currentscore"
            formatOptions = {
              palette = "redGreen"
            }
            formatter = 8
            numberFormat = {
              options = {
                style = "decimal"
              }
              unit = 1
            }
            }, {
            columnMatch = "maxscore"
            formatOptions = {
              palette = "blue"
            }
            formatter = 8
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "subscriptionSecureScore"
            formatOptions = {
              max     = 100
              min     = 0
              palette = "redGreen"
            }
            formatter = 8
            numberFormat = {
              options = {
                style       = "decimal"
                useGrouping = false
              }
              unit = 1
            }
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "SecureControl"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        query        = "SecurityResources \r\n| where type == 'microsoft.security/securescores/securescorecontrols' \r\n| extend SecureControl = properties.displayName, unhealthy = properties.unhealthyResourceCount, currentscore = properties.score.current, maxscore = properties.score.max, subscriptionId\r\n| project SecureControl , unhealthy, currentscore, maxscore, subscriptionId"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 3
        version      = "KqlItem/1.0"
      }
      name = "query - Monitor & Security - Security Scores - Copy"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "### NoShow - End - Monitor & Security - Security"
      }
      name = "text - NoShow - End - App Monitoring - Security - Copy"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noshow"
        value         = "noshow"
      }
      content = {
        json = "## End Monitoring & Security\r\n\r\n## Begin Tagged Resoruces"
      }
      name = "text - NoShow End Monitoring"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "tags"
        }, {
        comparison    = "isEqualTo"
        parameterName = "Help"
        value         = "Yes"
      }]
      content = {
        json = "## Help File - Resource tags\r\n\r\nEvery environment has different standards for tagging. Therefore you may need to chance the Environment and Application parameters to reflect the tagging standards in your environment. "
      }
      name = "text - Show Help - Resource Tagging"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "Help"
        value         = "Yes"
        }, {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "notag"
      }]
      content = {
        json = "## Help File - Resource tags\r\n\r\nThe below query will list your untagged resources. Note that not all resources currently support tagging."
      }
      name = "text - Show Help - No Tags"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "tags"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        parameters = [{
          crossComponentResources = ["{Subscriptions}"]
          delimiter               = ","
          id                      = "9bbf2fdf-2afe-4df0-a469-d66a625baf9b"
          isRequired              = true
          multiSelect             = true
          name                    = "CostCenter"
          query                   = "resources   \r\n| where tags.CostCenter != ''   \r\n| distinct tostring(tags.CostCenter)"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = ["value::1", "value::all"]
            showDefault               = false
          }
          value   = []
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - Tagged Resources - Copy"
      type = 9
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "tags"
      }
      content = {
        json = "## Showing Resources for CostCenter: {CostCenter}"
      }
      name = "Show Text for Tagged Selections "
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "tags"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkIsContextBlade = false
              linkTarget         = "Resource"
              showIcon           = true
            }
            formatter = 13
            }, {
            columnMatch = "id"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
            }, {
            columnMatch = "Details"
            formatOptions = {
              linkIsContextBlade = true
              linkLabel          = "🔍 View Details"
              linkTarget         = "CellDetails"
            }
            formatter = 7
            }, {
            columnMatch = "tenantId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "id"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
        }
        query        = "resources\r\n| where type != 'microsoft.network/networkinterfaces'\r\n| where type != 'microsoft.compute/disks'\r\n| where tags.CostCenter in~ ({CostCenter}) or '*' in~ ({CostCenter})\r\n| extend type = case(\r\ntype =~ 'microsoft.network/networksecuritygroups', \"NSGs\", \r\ntype =~ \"microsoft.network/publicipaddresses\", \"Public IPs\", \r\ntype =~ 'microsoft.network/virtualnetworks', \"vNets\",\r\ntype =~ 'microsoft.network/networkwatchers/connectionmonitors', \"Connection Monitors\",\r\ntype =~ 'microsoft.network/privatednszones', \"Private DNS\",\r\ntype =~ 'microsoft.network/virtualnetworkgateways', \"vNet Gateways\",\r\ntype =~ 'microsoft.network/connections', \"Connections\",\r\ntype =~ 'microsoft.network/networkwatchers', \"Network Watchers\",\r\ntype =~ 'microsoft.network/privateendpoints', \"Private Endpoints\",\r\ntype =~ 'microsoft.network/localnetworkgateways', \"Local Network Gateways\",\r\ntype =~ 'microsoft.network/privatednszones/virtualnetworklinks', \"vNet Links\",\r\ntype =~ 'microsoft.web/serverfarms', \"App Service Plans\",\r\nkind == 'functionapp', \"Azure Functions\", \r\nkind == \"api\", \"API Apps\", \r\ntype =~ 'microsoft.web/sites', \"App Services\",\r\ntype =~ \"microsoft.compute/virtualmachines\", \"Azure Compute\",\r\ntype =~ \"microsoft.logic/workflows\", \"LogicApps\",\r\ntype =~ 'microsoft.keyvault/vaults', \"Key Vaults\",\r\ntype =~ 'microsoft.keyvault/vaults', \"Hybrid Compute\",\r\ntype =~ 'microsoft.storage/storageaccounts', \"Storage Accounts\",\r\ntype =~ 'microsoft.compute/availabilitysets', 'Availability Sets',\r\ntype =~ 'microsoft.insights/components','Application Insights',\r\ntype =~ 'microsoft.desktopvirtualization/applicationgroups', 'WVD Application Groups',\r\ntype =~ 'microsoft.desktopvirtualization/workspaces', 'WVD Workspaces',\r\ntype =~ 'microsoft.desktopvirtualization/hostpools', 'WVD Hostpools',\r\nstrcat(\"Not Translated: \", type))\r\n| extend Details = pack_all()\r\n| project id, subscriptionId, type, location, resourceGroup, Details\r\n\r\n\r\n"
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        size         = 0
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "query - Tagged Resources - Copy"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "tags"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        parameters = [{
          crossComponentResources = ["{Subscriptions}"]
          delimiter               = ","
          id                      = "f89867f4-907a-49cd-add8-bded49c43bed"
          isRequired              = true
          multiSelect             = true
          name                    = "Environment"
          query                   = "resources   \r\n| where tags.Environment != ''   \r\n| distinct tostring(tags.Environment)"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = ["value::1", "value::all"]
            showDefault               = false
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Subscriptions}"]
          delimiter               = ","
          id                      = "ef32b148-7ea7-4af4-aaf7-b6a87f2d00d7"
          isRequired              = true
          multiSelect             = true
          name                    = "Application"
          query                   = "resources \r\n| where tags.Environment in~ ({Environment}) or '*' in~ ({Environment})\r\n| where tags.Application != ''   \r\n| distinct tostring(tags.Application)  "
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = ["value::1", "value::all"]
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - Tagged Resources"
      type = 9
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "tags"
      }
      content = {
        json = "## Showing Resources for {Environment} and Application(s) {Application}"
      }
      name = "text - Show Text for Tagged Selections"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "tags"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        query                   = "resources\r\n| where type != 'microsoft.network/networkinterfaces'\r\n| where type != 'microsoft.compute/disks'\r\n| where tags.Environment in~ ({Environment}) or '*' in~ ({Environment})\r\n| where tags.Application in~ ({Application}) or '*' in~ ({Application})\r\n| extend type = case(\r\ntype =~ 'microsoft.network/networksecuritygroups', \"NSGs\", \r\ntype =~ \"microsoft.network/publicipaddresses\", \"Public IPs\", \r\ntype =~ 'microsoft.network/virtualnetworks', \"vNets\",\r\ntype =~ 'microsoft.network/networkwatchers/connectionmonitors', \"Connection Monitors\",\r\ntype =~ 'microsoft.network/privatednszones', \"Private DNS\",\r\ntype =~ 'microsoft.network/virtualnetworkgateways', \"vNet Gateways\",\r\ntype =~ 'microsoft.network/connections', \"Connections\",\r\ntype =~ 'microsoft.network/networkwatchers', \"Network Watchers\",\r\ntype =~ 'microsoft.network/privateendpoints', \"Private Endpoints\",\r\ntype =~ 'microsoft.network/localnetworkgateways', \"Local Network Gateways\",\r\ntype =~ 'microsoft.network/privatednszones/virtualnetworklinks', \"vNet Links\",\r\ntype =~ 'microsoft.web/serverfarms', \"App Service Plans\",\r\nkind == 'functionapp', \"Azure Functions\", \r\nkind == \"api\", \"API Apps\", \r\ntype =~ 'microsoft.web/sites', \"App Services\",\r\ntype =~ \"microsoft.compute/virtualmachines\", \"Azure Compute\",\r\ntype =~ \"microsoft.logic/workflows\", \"LogicApps\",\r\ntype =~ 'microsoft.keyvault/vaults', \"Key Vaults\",\r\ntype =~ 'microsoft.keyvault/vaults', \"Hybrid Compute\",\r\ntype =~ 'microsoft.storage/storageaccounts', \"Storage Accounts\",\r\ntype =~ 'microsoft.compute/availabilitysets', 'Availability Sets',\r\ntype =~ 'microsoft.insights/components','Application Insights',\r\ntype =~ 'microsoft.desktopvirtualization/applicationgroups', 'WVD Application Groups',\r\ntype =~ 'microsoft.desktopvirtualization/workspaces', 'WVD Workspaces',\r\ntype =~ 'microsoft.desktopvirtualization/hostpools', 'WVD Hostpools',\r\nstrcat(\"Not Translated: \", type))\r\n| summarize count() by type\r\n\r\n\r\n"
        queryType               = 1
        resourceType            = "microsoft.resourcegraph/resources"
        size                    = 0
        tileSettings = {
          leftContent = {
            columnMatch = "count_"
            formatOptions = {
              palette = "auto"
            }
            formatter = 12
            numberFormat = {
              options = {
                maximumFractionDigits    = 2
                maximumSignificantDigits = 3
              }
              unit = 17
            }
          }
          showBorder = true
          titleContent = {
            columnMatch = "type"
            formatter   = 1
          }
        }
        version       = "KqlItem/1.0"
        visualization = "tiles"
      }
      name = "query - Tagged Resources"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "tabs"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        query                   = "Resources\r\n| where tags.Environment in~ ({Environment}) or '*' in~ ({Environment})\r\n| where tags.Application in~ ({Application}) or '*' in~ ({Application})\r\n| summarize count() by type"
        queryType               = 1
        resourceType            = "microsoft.resourcegraph/resources"
        size                    = 0
        version                 = "KqlItem/1.0"
      }
      name = "query - Tagged Resources Summary"
      type = 3
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "noShow"
        value         = "noShow"
      }
      content = {
        json = "## NoShow - End Tagged Resources\r\n\r\n\r\n## NoShow - Begin Untagged Resources"
      }
      name = "text - NoShow Begin Untagged Resources"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "notag"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        parameters = [{
          crossComponentResources = ["{Subscriptions}"]
          delimiter               = ","
          id                      = "2ca6744f-0d53-48a0-ad15-95f6dbe5aa9d"
          isRequired              = true
          multiSelect             = true
          name                    = "ResourceType"
          query                   = "resources | where tags == ''\r\n| distinct type"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          timeContext = {
            durationMs = 86400000
          }
          type = 7
          typeSettings = {
            additionalResourceOptions = ["value::1", "value::all"]
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 1
        resourceType = "microsoft.resourcegraph/resources"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - Untagged Resource Type"
      type = 9
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "selectedTab"
        value         = "notag"
      }
      content = {
        crossComponentResources = ["{Subscriptions}"]
        gridSettings = {
          filter = true
          formatters = [{
            columnMatch = "$gen_group"
            formatOptions = {
              linkTarget = "Resource"
              showIcon   = true
            }
            formatter = 13
            }, {
            columnMatch = "Name"
            formatter   = 5
            }, {
            columnMatch = "subscriptionId"
            formatter   = 5
          }]
          hierarchySettings = {
            expandTopLevel = true
            finalBy        = "Name"
            groupBy        = ["subscriptionId"]
            treeType       = 1
          }
          rowLimit = 1000
        }
        query             = "resources | where tags == ''\r\n| where type in~ ({ResourceType}) or '*' in~ ({ResourceType})\r\n| project Name=id, subscriptionId\r\n"
        queryType         = 1
        resourceType      = "microsoft.resourcegraph/resources"
        showExportToExcel = true
        size              = 3
        version           = "KqlItem/1.0"
      }
      name = "query - Untagged Resources"
      type = 3
    }]
    version = "Notebook/1.0"
  })
  display_name        = "af-workbook_azure-all-resources-overview"
  location            = "westeurope"
  name                = "ca7e9390-9070-ff42-e8f2-1b2c771215ab"
  resource_group_name = azurerm_resource_group.res-1.name
  source_id           = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourcegroups/rg-monitoring-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_application_insights_workbook" "res-13" {
  data_json = jsonencode({
    "$schema"           = "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
    fallbackResourceIds = ["/subscriptions/342a7c25-9066-49c8-ad59-9009d1744b40/resourcegroups/rg-operlogs-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"]
    items = [{
      content = {
        json = "## Network Workbook\n"
      }
      name = "text - 2"
      type = 1
      }, {
      content = {
        parameters = [{
          id   = "f7a928b3-1291-4a31-9da0-b42e1988ecb1"
          name = "TimeRange"
          timeContext = {
            durationMs = 86400000
          }
          type = 4
          typeSettings = {
            selectableValues = [{
              durationMs = 1800000
              }, {
              durationMs = 3600000
              }, {
              durationMs = 14400000
              }, {
              durationMs = 43200000
              }, {
              durationMs = 86400000
              }, {
              durationMs = 172800000
              }, {
              durationMs = 259200000
              }, {
              durationMs = 604800000
            }]
          }
          value = {
            durationMs = 43200000
          }
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - 3"
      type = 9
      }, {
      content = {
        groupType = "editable"
        items = [{
          content = {
            gridSettings = {
              formatters = [{
                columnMatch = "Health"
                formatOptions = {
                  thresholdsGrid = [{
                    operator       = "=="
                    representation = "success"
                    text           = "{0}{1}"
                    thresholdValue = "100"
                    }, {
                    operator       = "<="
                    representation = "4"
                    text           = "{0}{1}"
                    thresholdValue = "50"
                    }, {
                    operator       = "<="
                    representation = "2"
                    text           = "{0}{1}"
                    thresholdValue = "75"
                    }, {
                    operator       = "Default"
                    representation = "4"
                    text           = "{0}{1}"
                    thresholdValue = null
                  }]
                  thresholdsOptions = "icons"
                }
                formatter = 18
                numberFormat = {
                  options = {
                    style       = "decimal"
                    useGrouping = false
                  }
                  unit = 1
                }
                }, {
                columnMatch = "DataProcessedTotal"
                formatter   = 0
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 2
                }
                }, {
                columnMatch = "DataProcessedAvg"
                formatter   = 0
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 2
                }
                }, {
                columnMatch = "SNatUsedAvg"
                formatter   = 0
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 1
                }
                }, {
                columnMatch = "SNatUsedTimeline"
                formatOptions = {
                  palette = "orange"
                }
                formatter = 21
              }]
            }
            query                    = "AzureMetrics \r\n| where ResourceProvider == \"MICROSOFT.NETWORK\"\r\n| where _ResourceId contains \"azurefirewalls\"\r\n| where MetricName == \"DataProcessed\"\r\n| summarize arg_max(TimeGenerated, *) by _ResourceId\r\n| project _ResourceId,DataProcessedTotal=Total,DataProcessedAvg=Average\r\n| join (\r\nAzureMetrics \r\n| where ResourceProvider == \"MICROSOFT.NETWORK\"\r\n| where _ResourceId contains \"azurefirewalls\"\r\n| where MetricName == \"FirewallHealth\"\r\n| summarize arg_max(TimeGenerated, *) by _ResourceId\r\n| project _ResourceId,Health=Minimum)  on _ResourceId\r\n| join (\r\nAzureMetrics \r\n| where ResourceProvider == \"MICROSOFT.NETWORK\"\r\n| where _ResourceId contains \"azurefirewalls\"\r\n| where MetricName == \"SNATPortUtilization\"\r\n| summarize arg_max(TimeGenerated, *) by _ResourceId\r\n| project _ResourceId,SNatUsedAvg=Average)  on _ResourceId\r\n| join(\r\nAzureMetrics\r\n| where ResourceProvider == \"MICROSOFT.NETWORK\"\r\n| where _ResourceId contains \"azurefirewalls\"\r\n| where MetricName == \"SNATPortUtilization\"\r\n| make-series SNatUsedTimeline = avg(Maximum) default = 0 on TimeGenerated from {TimeRange:start} to {TimeRange:end} step {TimeRange:grain} by _ResourceId) on _ResourceId\r\n| project _ResourceId,Health,DataProcessedTotal,DataProcessedAvg,SNatUsedAvg,SNatUsedTimeline"
            queryType                = 0
            resourceType             = "microsoft.operationalinsights/workspaces"
            size                     = 3
            timeContextFromParameter = "TimeRange"
            title                    = "Firewall overview"
            version                  = "KqlItem/1.0"
          }
          name = "Firewall overview"
          type = 3
          }, {
          content = {
            color = "orange"
            gridSettings = {
              filter = true
            }
            query        = "AzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePortInt:int \" to \" TargetIP \":\" TargetPortInt:int *\r\n| parse msg_s with * \". Action: \" Action1a\r\n| parse msg_s with * \" was \" Action1b \" to \" NatDestination\r\n| parse msg_s with Protocol2 \" request from \" SourceIP2 \" to \" TargetIP2 \". Action: \" Action2\r\n| extend\r\nSourcePort = tostring(SourcePortInt),\r\nTargetPort = tostring(TargetPortInt)\r\n| extend \r\n    Action = case(Action1a == \"\", case(Action1b == \"\",Action2,Action1b), Action1a),\r\n    Protocol = case(Protocol == \"\", Protocol2, Protocol),\r\n    SourceIP = case(SourceIP == \"\", SourceIP2, SourceIP),\r\n    TargetIP = case(TargetIP == \"\", TargetIP2, TargetIP),\r\n        //ICMP records don't have port information\r\n    SourcePort = case(SourcePort == \"\", \"N/A\", SourcePort),\r\n    TargetPort = case(TargetPort == \"\", \"N/A\", TargetPort),\r\n    //Regular network rules don't have a DNAT destination\r\n    NatDestination = case(NatDestination == \"\", \"N/A\", NatDestination)\r\n    | where Action contains \"Deny\"\r\n    | summarize RequestCount = count() by SourceIP, TargetIP, TargetPort\r\n    | top 20 by RequestCount "
            queryType    = 0
            resourceType = "microsoft.operationalinsights/workspaces"
            size         = 3
            timeContext = {
              durationMs = 43200000
            }
            title   = "Top20 blocked connections"
            version = "KqlItem/1.0"
          }
          name = "Top20 blocked connections"
          type = 3
          }, {
          content = {
            gridSettings = {
              filter = true
            }
            query                    = "// Application rule log data \r\n// Parses the application rule log data. \r\n// Application rule log data \r\n// Parses the application rule log data. \r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallApplicationRule\"\r\n//using :int makes it easier to pars but later we'll convert to string \r\n//as we're not interested to do mathematical functions on these fields\r\n//this first parse statement is valid for all entries as they all start with this format\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePortInt:int \" \" TempDetails\r\n//case 1: for records that end with: \"was denied. Reason: SNI TLS extension was missing.\"\r\n| parse TempDetails with \"was \" Action1 \". Reason: \" Rule1\r\n//case 2: for records that end with\r\n//\"to ocsp.digicert.com:80. Action: Allow. Rule Collection: RC1. Rule: Rule1\"\r\n//\"to v10.vortex-win.data.microsoft.com:443. Action: Deny. No rule matched. Proceeding with default action\"\r\n| parse TempDetails with \"to \" FQDN \":\" TargetPortInt:int \". Action: \" Action2 \".\" *\r\n//case 2a: for records that end with:\r\n//\"to ocsp.digicert.com:80. Action: Allow. Rule Collection: RC1. Rule: Rule1\"\r\n| parse TempDetails with * \". Rule Collection: \" RuleCollection2a \". Rule:\" Rule2a \"Web Category: \" WebCategory\r\n//case 2b: for records that end with:\r\n//for records that end with: \"to v10.vortex-win.data.microsoft.com:443. Action: Deny. No rule matched. Proceeding with default action\"\r\n| parse TempDetails with * \"Deny.\" RuleCollection2b \". Proceeding with\" Rule2b\r\n| extend SourcePort = tostring(SourcePortInt)\r\n|extend TargetPort = tostring(TargetPortInt)\r\n//make sure we only have Allowed / Deny in the Action Field\r\n | extend Action1 = case(Action1 == \"Deny\",\"Deny\",\"Unknown Action\")\r\n| extend Action = case(Action2 == \"\",Action1,Action2),\r\n    Rule = case(Rule2a == \"\",case(Rule1 == \"\",case(Rule2b == \"\",\"N/A\", Rule2b),Rule1),Rule2a), \r\n    RuleCollection = case(RuleCollection2b == \"\",case(RuleCollection2a == \"\",\"No rule matched\",RuleCollection2a),RuleCollection2b),\r\n    FQDN = case(FQDN == \"\", \"N/A\", FQDN),\r\n    TargetPort = case(TargetPort == \"\", \"N/A\", TargetPort)\r\n| where Action == \"Deny\"\r\n| summarize RequestCount = count() by FQDN, SourceIP, Action\r\n| top 20 by RequestCount "
            queryType                = 0
            resourceType             = "microsoft.operationalinsights/workspaces"
            size                     = 3
            timeContextFromParameter = "TimeRange"
            title                    = "Top 20 blocked FQDNs"
            version                  = "KqlItem/1.0"
          }
          name = "Top 20 blocked FQDNs"
          type = 3
          }, {
          content = {
            query        = "// get lookup data \r\nlet locationdata = \r\n    externaldata (IPRange:string,Site:string)\r\n    [@\"https://oihuew3gfubsta.blob.core.windows.net/locationdata/SiteIPRanges.csv?sp=r&st=2021-06-15T05:55:03Z&se=2099-06-15T13:55:03Z&spr=https&sv=2020-02-10&sr=c&sig=ty86NV47S9hVcx9FXdkN8yviz11GlRtSC%2BC%2BLMicxPU%3D\"] with(format=\"csv\", ignoreFirstRecord=true);\r\n// now turn remote data to scalar \r\nlet lookup = toscalar( locationdata |  summarize list_CIDR=make_set(IPRange) );\r\nAzureDiagnostics\r\n| where Category == \"AzureFirewallNetworkRule\"\r\n| parse msg_s with Protocol \" request from \" SourceIP \":\" SourcePortInt:int \" to \" TargetIP \":\" TargetPortInt:int *\r\n| parse msg_s with * \". Action: \" Action1a\r\n| parse msg_s with * \" was \" Action1b \" to \" NatDestination\r\n| parse msg_s with Protocol2 \" request from \" SourceIP2 \" to \" TargetIP2 \". Action: \" Action2\r\n| extend\r\nSourcePort = tostring(SourcePortInt),\r\nTargetPort = tostring(TargetPortInt)\r\n| extend \r\n    Action = case(Action1a == \"\", case(Action1b == \"\",Action2,Action1b), Action1a),\r\n    Protocol = case(Protocol == \"\", Protocol2, Protocol),\r\n    SourceIP = case(SourceIP == \"\", SourceIP2, SourceIP),\r\n    TargetIP = case(TargetIP == \"\", TargetIP2, TargetIP),\r\n        //ICMP records don't have port information\r\n    SourcePort = case(SourcePort == \"\", \"N/A\", SourcePort),\r\n    TargetPort = case(TargetPort == \"\", \"N/A\", TargetPort),\r\n    //Regular network rules don't have a DNAT destination\r\n    NatDestination = case(NatDestination == \"\", \"N/A\", NatDestination)\r\n    | where Action contains \"Deny\"\r\n\t| project SourceIP, TargetIP, TargetPort\r\n\t| mv-apply list_CIDR=lookup to typeof(string) on\r\n(\r\n    // Match each IP from 'ClientSideIPAddress' with the remote 'network' column \r\n    where ipv4_is_match (SourceIP, list_CIDR) //== false\r\n)\r\n// summarize to remove any duplicates\r\n| join kind=inner \r\n  (\r\n  // join to remote data again, to add enrichments \r\n  locationdata\r\n  ) on $left.list_CIDR == $right.IPRange\r\n// build final display \r\n// build final display \r\n    | summarize RequestCount = count() by SourceIP, TargetIP, TargetPort, Site\r\n    | top 20 by RequestCount "
            queryType    = 0
            resourceType = "microsoft.operationalinsights/workspaces"
            size         = 3
            timeContext = {
              durationMs = 43200000
            }
            title   = "Top20 blocked connections - known Locations"
            version = "KqlItem/1.0"
          }
          name = "Top20 blocked connections - known Locations"
          type = 3
        }]
        version = "NotebookGroup/1.0"
      }
      name = "group - 4"
      type = 12
      }, {
      content = {
        groupType = "editable"
        items = [{
          content = {
            gridSettings = {
              formatters = [{
                columnMatch = "S2SBandwidth"
                formatter   = 0
                numberFormat = {
                  options = {
                    style       = "decimal"
                    useGrouping = false
                  }
                  unit = 2
                }
                }, {
                columnMatch = "S2SBandwidthTimeline"
                formatOptions = {
                  palette = "orange"
                }
                formatter = 21
                }, {
                columnMatch = "TunnelEgress"
                formatter   = 0
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 2
                }
                }, {
                columnMatch = "TunnelIngress"
                formatter   = 0
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 2
                }
                }, {
                columnMatch = "TunnelEgressPacketDropTSMismatch"
                formatter   = 0
                numberFormat = {
                  options = {
                    style       = "decimal"
                    useGrouping = false
                  }
                  unit = 17
                }
                }, {
                columnMatch = "TunnelIngressPacketDropTSMismatch"
                formatter   = 0
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 17
                }
                }, {
                columnMatch = "AverageBandwidth"
                formatter   = 0
                numberFormat = {
                  options = {
                    style = "decimal"
                  }
                  unit = 2
                }
              }]
            }
            query                    = "AzureMetrics \r\n| where MetricName == \"AverageBandwidth\"\r\n| summarize arg_max(TimeGenerated, *) by _ResourceId\r\n| project _ResourceId,S2SBandwidthLatest=Average\r\n| join(\r\nAzureMetrics \r\n| where MetricName == \"AverageBandwidth\"\r\n| summarize S2SBandwidthAvg =  avg(Average) by bin(TimeGenerated, {TimeRange:start}), _ResourceId\r\n| project _ResourceId,S2SBandwidthAvg)  on _ResourceId\r\n| join(\r\nAzureMetrics\r\n| where MetricName == \"AverageBandwidth\"\r\n| make-series S2SBandwidthTimeline = avg(Average) default = 0 on TimeGenerated from {TimeRange:start} to {TimeRange:end} step {TimeRange:grain} by _ResourceId) on _ResourceId\r\n| join(\r\nAzureMetrics \r\n| where MetricName == \"TunnelEgressBytes\" \r\n| summarize arg_max(TimeGenerated, *) by _ResourceId\r\n| project _ResourceId,TunnelEgressLatest=Average)  on _ResourceId\r\n| join(\r\nAzureMetrics \r\n| where MetricName == \"TunnelIngressBytes\" \r\n| summarize arg_max(TimeGenerated, *) by _ResourceId\r\n| project _ResourceId,TunnelIngressLatest=Average)  on _ResourceId\r\n| join(\r\nAzureMetrics \r\n| where MetricName == \"TunnelEgressPacketDropTSMismatch\"\r\n| summarize arg_max(TimeGenerated, *) by _ResourceId\r\n| project _ResourceId,TunnelEgressPacketDropTSMismatch=Average)  on _ResourceId\r\n| join(\r\nAzureMetrics \r\n| where MetricName == \"TunnelIngressPacketDropTSMismatch\"\r\n| summarize arg_max(TimeGenerated, *) by _ResourceId\r\n| project _ResourceId,TunnelIngressPacketDropTSMismatch=Average)  on _ResourceId\r\n| project Gateway=_ResourceId,S2SBandwidthLatest,S2SBandwidthAvg,S2SBandwidthTimeline,TunnelEgressLatest,TunnelIngressLatest,TunnelEgressPacketDropTSMismatch,TunnelIngressPacketDropTSMismatch\r\n"
            queryType                = 0
            resourceType             = "microsoft.operationalinsights/workspaces"
            size                     = 3
            sortBy                   = []
            timeContextFromParameter = "TimeRange"
            version                  = "KqlItem/1.0"
          }
          name = "query - 0"
          type = 3
        }]
        title   = "VPN Metrics"
        version = "NotebookGroup/1.0"
      }
      name = "VPN Metrics"
      type = 12
      }, {
      content = {
        groupType = "editable"
        items = [{
          content = {
            gridSettings = {
              filter = true
            }
            query                    = "AzureDiagnostics\r\n| where Category == \"TunnelDiagnosticLog\"\r\n| project-rename Status = status_s, RemoteIP = remoteIP_s, Reason = stateChangeReason_s\r\n| sort by TimeGenerated\r\n| project Resource, OperationName, Status, RemoteIP, Reason,TimeGenerated"
            queryType                = 0
            resourceType             = "microsoft.operationalinsights/workspaces"
            size                     = 3
            timeContextFromParameter = "TimeRange"
            title                    = "TunnelDiagnosticLog"
            version                  = "KqlItem/1.0"
          }
          name = "TunnelDiagnosticLog"
          type = 3
          }, {
          content = {
            query                    = "AzureDiagnostics \r\n| where Level != \"Informational\"\r\n| where Category == \"GatewayDiagnosticLog\"\r\n| project-rename Status = operationStatus_s\r\n| sort by TimeGenerated\r\n| project Resource, OperationName, Level, Status, Message, TimeGenerated"
            queryType                = 0
            resourceType             = "microsoft.operationalinsights/workspaces"
            size                     = 3
            timeContextFromParameter = "TimeRange"
            title                    = "GatewayDiagnosticLog"
            version                  = "KqlItem/1.0"
          }
          name = "GatewayDiagnosticLog"
          type = 3
        }]
        title   = "VPN Diagnostics"
        version = "NotebookGroup/1.0"
      }
      name = "VPN Diagnostics"
      type = 12
    }]
    version = "Notebook/1.0"
  })
  display_name        = "af-workbook_network"
  location            = "westeurope"
  name                = "dc9a801f-deb3-70aa-3611-db6639ec2531"
  resource_group_name = azurerm_resource_group.res-1.name
  source_id           = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourcegroups/rg-monitoring-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_application_insights_workbook" "res-14" {
  data_json = jsonencode({
    "$schema"           = "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
    fallbackResourceIds = []
    items = [{
      content = {
        json = "# On-Premises connectivity status\n---\n\nThis workbook displays multiple tables:\n1. Overview about available **connection monitor** data\n1. The current status of vpn-connections in scope (virtual network gateway and vWan vpn-gateway)\n2. The last vpn-tunnel log entries in descending order.\n3. The last BGP route updates received on express-route, vpn, vwan-components\n\nOnly data of the last 30 days is displayed.\nData can only be shown if the log-generating components (VPN-gateway, ExpressRoute-gateway, ...) are configured to send their logs (diagnostic settings) to the Log Analytics Workspace used by this workbook."
      }
      name = "text - 2"
      type = 1
      }, {
      content = {
        crossComponentResources = ["value::tenant"]
        parameters = [{
          crossComponentResources = ["value::tenant"]
          description             = "This parameter is sourced from Azure Resource Graph. It is used to get the local vpn-endpoint names and display in the next table."
          id                      = "865c6d33-7bb3-4c9c-a330-2b76a9a1f045"
          isHiddenWhenLocked      = true
          label                   = "List of external vpn endpoints"
          name                    = "vpnEndpointList"
          query                   = "resources\r\n| where type =~ 'microsoft.network/vpnsites' or type =~ 'Microsoft.Network/localNetworkGateways'\r\n| project endpointIp = pack_array(properties.vpnSiteLinks[0].properties.ipAddress, properties.vpnSiteLinks[1].properties.ipAddress, properties.gatewayIpAddress), name\r\n| mv-expand endpointIp\r\n| where not( isempty( endpointIp))\r\n| project table = pack_array(endpointIp, name)\r\n| summarize list = make_list(table)\r\n| project returnstring = tostring(list)"
          queryType               = 1
          resourceType            = "microsoft.resources/tenants"
          timeContext = {
            durationMs = 86400000
          }
          type    = 1
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["value::tenant"]
          id                      = "9f60c63a-57b8-475f-a2ff-9ddb05089073"
          label                   = "List of Connection Monitor Resource IDs"
          name                    = "conMonResourceIdList"
          query                   = "resources\r\n| where type =~ 'microsoft.network/networkwatchers/connectionmonitors'\r\n| project id, label= tostring(split(id, \"/\", 10)[0]), selected = true"
          queryType               = 1
          resourceType            = "microsoft.resources/tenants"
          timeContext = {
            durationMs = 86400000
          }
          type = 5
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 1
        resourceType = "microsoft.resources/tenants"
        style        = "pills"
        version      = "KqlParameterItem/1.0"
      }
      name = "parameters - 6"
      type = 9
      }, {
      content = {
        chartId   = "workbook4290b005-17e5-4dc1-b1b1-63224b766697"
        chartType = 2
        gridSettings = {
          rowLimit = 10000
        }
        metricScope = 0
        metrics = [{
          aggregation = 4
          metric      = "microsoft.network/networkwatchers/connectionmonitors--ChecksFailedPercent"
          namespace   = "microsoft.network/networkwatchers/connectionmonitors"
          splitBy     = "TestGroupName"
        }]
        resourceIds       = ["{conMonResourceIdList}"]
        resourceParameter = "conMonResourceIdList"
        resourceType      = "microsoft.network/networkwatchers/connectionmonitors"
        size              = 0
        timeContext = {
          durationMs = 172800000
        }
        title   = "Connection Monitor Overview"
        version = "MetricsItem/2.0"
      }
      name = "metric - 7"
      type = 10
      }, {
      content = {
        graphSettings = {
          type = 0
        }
        gridSettings = {
          filter = true
        }
        query        = "let endpoints = datatable(ip:string, Endpoint:string)\r\n    {vpnEndpointList};\r\nAzureDiagnostics\r\n  | where Category == \"TunnelDiagnosticLog\"\r\n  | summarize arg_max(TimeGenerated, *) by remoteIP_s, instance_s\r\n  | extend timeDiff = split(format_timespan(now()-TimeGenerated, 'dd:hh:mm'),\":\")\r\n  | extend Status_since = strcat(timeDiff[0], ' days, ',timeDiff[1],' hours, ',timeDiff[2], ' min')\r\n  | join kind=leftouter endpoints on $left.remoteIP_s == $right.ip\r\n  | sort by TimeGenerated desc\r\n  | project  Endpoint, EndpointIP=remoteIP_s, AzureGatewayInstance = instance_s, InstanceIP=ikeSAs_LocalEndpoint_s, OperationName, Status=status_s, StateChangeReason=stateChangeReason_s, Status_since, TimeGenerated"
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        size         = 1
        tileSettings = {
          leftContent = {
            columnMatch = "status_s"
            formatter   = 1
          }
          rightContent = {
            columnMatch = "TimeGenerated"
          }
          secondaryContent = {
            columnMatch = "stateChangeReason_s"
          }
          showBorder = false
          subtitleContent = {
            columnMatch = "remoteIP_s"
          }
          titleContent = {
            columnMatch = "instance_s"
          }
        }
        timeContext = {
          durationMs = 2592000000
        }
        title         = "Current vpn-tunnel status"
        version       = "KqlItem/1.0"
        visualization = "table"
      }
      name = "Current vpn-tunnel status"
      type = 3
      }, {
      content = {
        gridSettings = {
          filter   = true
          rowLimit = 50
        }
        query        = "AzureDiagnostics\r\n  | where Category == \"TunnelDiagnosticLog\"\r\n  | project  TimeGenerated, instance_s, ikeSAs_LocalEndpoint_s, OperationName, status_s, stateChangeReason_s, remoteIP_s\r\n  | sort by TimeGenerated desc "
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        size         = 0
        timeContext = {
          durationMs = 2592000000
        }
        title   = "VPN-tunnel logfile"
        version = "KqlItem/1.0"
      }
      name = "Logfile vpn-tunnels"
      type = 3
      }, {
      content = {
        gridSettings = {
          filter = true
        }
        noDataMessage = "It seems that no ExpressRoute Circuit is provisioned or no ExpressRoute Circuit logs are received."
        query         = "// BGP route table \r\nAzureDiagnostics\r\n| where TimeGenerated > ago(30d)\r\n| where Category == \"PeeringRouteLog\" // ExpressRoute\r\n| extend network_s = column_ifexists('network_s', '') //error handling if column doesnt exist - otherwise summarize-operation will fail\r\n| extend path_s = column_ifexists('path_s', '')\r\n| summarize arg_max(TimeGenerated, *) by network_s, path_s // only the newest log entry per network and asn-path is shown\r\n| project TimeGenerated , ResourceType , network_s , path_s , OperationName"
        queryType     = 0
        resourceType  = "microsoft.operationalinsights/workspaces"
        size          = 0
        timeContext = {
          durationMs = 2592000000
        }
        title   = "BGP routes learned over the last 30 days (Express Route Circuit)"
        version = "KqlItem/1.0"
      }
      name = "query - 3"
      type = 3
      }, {
      content = {
        gridSettings = {
          filter = true
        }
        noDataMessage          = "It seems that no vpn-gateway is provisioned or no vpn-gateway logs are received."
        query                  = "// BGP route table \r\nAzureDiagnostics\r\n| where TimeGenerated > ago(30d)\r\n| where Category == \"RouteDiagnosticLog\"\r\n| extend routes_s = column_ifexists('routes_s', '')\r\n| summarize arg_max(TimeGenerated, *) by routes_s, peerAsn_d // only the newest log entry per network and asn-path is shown\r\n| project TimeGenerated , ResourceType , routes_s , peerAsn_d , OperationName\r\n"
        queryType              = 0
        resourceType           = "microsoft.operationalinsights/workspaces"
        showExpandCollapseGrid = true
        size                   = 0
        title                  = "BGP routes learned over the last 30 days (VPN Gateways)"
        version                = "KqlItem/1.0"
        visualization          = "table"
      }
      name = "query - 4"
      type = 3
    }]
    version = "Notebook/1.0"
  })
  display_name        = "af-workbook_connection-monitoring"
  location            = "westeurope"
  name                = "e05464a0-b0b0-91a6-da44-531bc216a048"
  resource_group_name = azurerm_resource_group.res-1.name
  source_id           = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourcegroups/rg-monitoring-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_application_insights_workbook" "res-15" {
  data_json = jsonencode({
    "$schema"           = "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
    fallbackResourceIds = ["azure monitor"]
    items = [{
      content = {
        links = [{
          cellValue  = "TabName"
          id         = "a24f7f98-dc7a-42b2-b764-c9e99ff33754"
          linkLabel  = "Overview"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "Overview"
          }, {
          cellValue  = "TabName"
          id         = "c46c1b48-bcd5-48f3-b515-44a2f3d78669"
          linkLabel  = "Summary"
          linkTarget = "parameter"
          style      = "primary"
          subTarget  = "Summary"
          workbookContext = {
            componentIdSource = "workbook"
            gallerySource     = "workbook"
            resourceIdsSource = "workbook"
            templateId        = "13bf0ff5-c132-4c85-910e-9de00bb3d26e"
            templateIdSource  = "static"
            typeSource        = "workbook"
          }
          }, {
          cellValue  = "TabName"
          id         = "d82feaf3-d662-4fe9-b7c9-ab07bdba600f"
          linkLabel  = "Backup Instances"
          linkTarget = "parameter"
          style      = "secondary"
          subTarget  = "BackupItems"
          workbookContext = {
            componentIdSource = "workbook"
            gallery           = "Azure Monitor"
            gallerySource     = "static"
            resourceIdsSource = "workbook"
            templateId        = "Community-Workbooks/Azure Backup/Storage"
            templateIdSource  = "static"
            typeSource        = "default"
          }
          }, {
          cellValue  = "TabName"
          id         = "0af01583-e55c-4b0a-a395-fd5037f30095"
          linkLabel  = "Usage"
          linkTarget = "parameter"
          style      = "secondary"
          subTarget  = "Usage"
          workbookContext = {
            componentIdSource = "workbook"
            gallery           = "Azure Monitor"
            gallerySource     = "static"
            resourceIdsSource = "workbook"
            templateId        = "Community-Workbooks/Azure Backup/Protected Instances"
            templateIdSource  = "static"
            typeSource        = "default"
          }
          }, {
          cellValue  = "TabName"
          id         = "fbbecb40-83ec-4fe8-a5e0-973f8b14b22f"
          linkLabel  = "Jobs"
          linkTarget = "parameter"
          style      = "secondary"
          subTarget  = "JobDistribution"
          workbookContext = {
            componentIdSource = "workbook"
            gallery           = "Azure Monitor"
            gallerySource     = "static"
            resourceIdsSource = "workbook"
            templateId        = "Community-Workbooks/Azure Backup/Job Distribution"
            templateIdSource  = "static"
            typeSource        = "default"
          }
          }, {
          cellValue  = "TabName"
          id         = "4101ac0a-663b-4c00-ad04-d5e0a9b5c126"
          linkLabel  = "Policies"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "PolicyDetails"
          }, {
          cellValue  = "TabName"
          id         = "883f8a53-19af-4f96-bce4-3e60c0d391e7"
          linkLabel  = "Optimize"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "Optimize"
          }, {
          cellValue  = "TabName"
          id         = "fd346de8-b14d-4ce9-9014-bcdf8c44b55a"
          linkLabel  = "Policy Adherence"
          linkTarget = "parameter"
          style      = "link"
          subTarget  = "Policy Adherence"
        }]
        style   = "tabs"
        version = "LinkItem/1.0"
      }
      name = "Tabs"
      type = 11
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Overview"
      }
      content = {
        json = "<div style=\"text-align:left;float:left;\"><span style=\"font-size:16px;font-weight:600\">Select Log Analytics Workspace </span> <br> <span style=\"font-size:12px;\"> <a href=\"https://aka.ms/AzureBackupDiagnosticsAutomationDoc\" target=\"_blank\"> How to configure vault diagnostic settings for backup reports </a> </span> </div> <div style=\"text-align:right; float:right\"> <span style=\"font-size:12px;\"> <a href=\"https://aka.ms/AzureBackupReportOld\" target=\"_blank\"> What happened to the Power BI reports? </a> </span> </div>"
      }
      name = "Overview-InstructionText"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Overview"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        doNotRunWhenHidden      = true
        parameters = [{
          delimiter   = ","
          description = "Subscriptions to filter the list of workspaces"
          id          = "d1f42f81-eb8f-4653-a0ff-38564d7487b4"
          isRequired  = true
          multiSelect = true
          name        = "Subscriptions"
          quote       = "'"
          type        = 6
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            includeAll                = false
            selectAllValue            = ""
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Subscriptions}"]
          delimiter               = ","
          description             = "LA Workspaces configured in vault diagnostic settings"
          id                      = "2373a24f-ad32-4909-a7f6-59b373dcde6c"
          isRequired              = true
          multiSelect             = true
          name                    = "Workspaces"
          query                   = "where type =~ 'microsoft.operationalinsights/workspaces' | project id"
          queryType               = 1
          quote                   = "'"
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 5
          typeSettings = {
            additionalResourceOptions = []
          }
          value   = ["/subscriptions/342a7c25-9066-49c8-ad59-9009d1744b40/resourceGroups/rg-operlogs-prd-weu/providers/Microsoft.OperationalInsights/workspaces/log-operationallogs-prd-weu"]
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "above"
        version      = "KqlParameterItem/1.0"
      }
      customWidth = "50"
      name        = "Overview-WorkspaceParameterBlock"
      type        = 9
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Overview"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "VaultsUsingAzureDiagnostics"
        value         = ""
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
      }]
      content = {
        json  = "You have vault(s) using **legacy diagnostics settings**. Please use the latest diagnostics settings for all your vaults to make them eligible for reporting upgrades. [Learn more](https://aka.ms/AzureBackupUseResourceSpecific)"
        style = "warning"
      }
      name = "ResourceSpecificTextBox1"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Overview"
      }]
      content = {
        json = "_____"
      }
      name = "Overview-DividingLine1"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
      }
      content = {
        json = "<div style=\"text-align:left;float:left;\"><span style=\"font-size:16px;font-weight:600\">Report Filters </span> </div> <div style=\"text-align:right; float:right\"> <span style=\"font-size:12px;\"> <a href=\"https://aka.ms/AzureBackupReportDocs\" target=\"_blank\"> How to use backup reports? </a> </span> </div>"
      }
      name = "Overview-ReportFiltersTitle"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
      }
      content = {
        json = "<p> <span style=\"font-size:12px; font-style:italic\"> Filters are applied left to right and top to bottom on each page. <a href=\"https://aka.ms/AzureBackupReportFilters\" target=\"_blank\">Learn More</a> </span> </p>"
      }
      name = "Overview-InstructionText2"
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        doNotRunWhenHidden      = true
        parameters = [{
          description = "Time Range"
          id          = "8c4ae44c-fa9a-4498-aedc-736a56e64b43"
          label       = "Time Range"
          name        = "TimeRange"
          timeContext = {
            durationMs = 0
          }
          timeContextFromParameter = "TimeRange"
          type                     = 4
          typeSettings = {
            allowCustom = true
            selectableValues = [{
              durationMs = 259200000
              }, {
              durationMs = 604800000
              }, {
              durationMs = 1209600000
              }, {
              durationMs = 2419200000
              }, {
              durationMs = 2592000000
              }, {
              durationMs = 5184000000
              }, {
              durationMs = 7776000000
            }]
          }
          value = {
            durationMs = 604800000
          }
          version = "KqlParameterItem/1.0"
          }, {
          description = "Use this parameter to avoid querying data that is sent to the legacy Azure Diagnostics table. Excluding the legacy table improves query performance time. <a href=\"https://docs.microsoft.com/azure/backup/backup-azure-diagnostic-events#legacy-event\">Learn more </a>"
          id          = "78c86854-fe3c-44c5-8ee3-23d4210827d1"
          isRequired  = true
          jsonData    = "[\r\n    { \"value\":\"True\",  \"selected\":true},\r\n    { \"value\":\"False\"}\r\n]"
          label       = "Exclude Legacy Table"
          name        = "ExcludeLegacyEvent"
          type        = 2
          typeSettings = {
            additionalResourceOptions = []
            showDefault               = false
          }
          value   = "False"
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "above"
        version      = "KqlParameterItem/1.0"
      }
      customWidth = "36"
      name        = "Overview-TimeRangeParameterBlock"
      styleSettings = {
        maxWidth = "100%"
      }
      type = 9
      }, {
      conditionalVisibility = {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
      }
      content = {
        doNotRunWhenHidden = true
        parameters = [{
          delimiter   = ","
          description = "Use to filter reports by backup solution"
          id          = "8ce61d1d-e371-40bf-ad53-7ba78afb976f"
          isRequired  = true
          jsonData    = "\r\n[    \r\n{ \"value\": \"Azure Backup Agent\", \t\t\t\t\t\t\"label\": \"Azure Backup Agent\" },\r\n{ \"value\": \"Azure Backup Server\", \t\t\t\"label\": \"Azure Backup Server\" },\r\n{ \"value\": \"Azure Storage (Azure Files) Backup\", \t\t\t\t\"label\": \"Azure Storage (Azure Files) Backup\" },\r\n{ \"value\": \"Azure Virtual Machine Backup\", \t\t\t\t\t\t\"label\": \"Azure Virtual Machine Backup\" },\r\n{ \"value\": \"DPM\", \t\t\t\t\t\t\"label\": \"DPM\" },\r\n{ \"value\": \"SAP HANA in Azure VM Backup\", \"label\": \"SAP HANA in Azure VM Backup\" },\r\n{ \"value\": \"SQL in Azure VM Backup\",     \"label\": \"SQL in Azure VM Backup\" }\r\n]"
          label       = "Backup Solution"
          multiSelect = true
          name        = "DatasourceType"
          quote       = ""
          type        = 2
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            selectAllValue            = "*"
            showDefault               = false
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          delimiter               = ","
          description             = "Subscription(s) under which the vault(s) exist"
          id                      = "678680e5-76b5-4db8-bbef-5f73942caf2e"
          isRequired              = true
          label                   = "Subscription Name"
          multiSelect             = true
          name                    = "VaultSubscription"
          query                   = "// function Params - Report Filters\r\nlet RangeStart = startofday({TimeRange:start});\r\nlet RangeEnd = iff(startofday({TimeRange:end}) == startofday(now()) ,startofday({TimeRange:end}) - 1d , startofday({TimeRange:end}));\r\nlet VaultSubscriptionList = \"*\";\r\nlet VaultLocationList = \"*\";\r\nlet VaultList = \"*\";\r\nlet VaultTypeList = \"*\";\r\nlet ExcludeLegacyEvent = @\"{ExcludeLegacyEvent}\";\r\nlet BackupSolutionList = @\"{DatasourceType}\";\r\n// function Params - other Filters\r\nlet ProtectionInfoList = \"*\";\r\nlet Item_search =  \"*;*\";\r\nlet ItemArray = split(Item_search, \";\");\r\nlet ItemArray_length = array_length(ItemArray);\r\nlet BackupInstanceName = iff(ItemArray_length == 2, ItemArray[1], ItemArray[0] );\r\nlet DatasourceSetName = iff(ItemArray_length == 2, ItemArray[0], \"\");\r\nlet DisplayAllFields = false;\r\n// calling LA System Function\r\n_AzureBackup_GetBackupInstances(RangeStart, RangeEnd, VaultSubscriptionList, VaultLocationList, VaultList, VaultTypeList, ExcludeLegacyEvent, BackupSolutionList, ProtectionInfoList, DatasourceSetName, BackupInstanceName, DisplayAllFields)\r\n// query to transform function output\r\n| distinct VaultSubscriptionId"
          queryType               = 0
          quote                   = ""
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 6
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            selectAllValue            = "*"
            showDefault               = false
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          delimiter               = ","
          description             = "Location(s) in which the vault(s) were created"
          id                      = "2a83acc5-2123-476f-8a4c-da2fddf231a1"
          isRequired              = true
          label                   = "Vault Location"
          multiSelect             = true
          name                    = "VaultLocation"
          query                   = "// function Params - Report Filters\r\nlet RangeStart = startofday({TimeRange:start});\r\nlet RangeEnd = iff(startofday({TimeRange:end}) == startofday(now()) ,startofday({TimeRange:end}) - 1d , startofday({TimeRange:end}));\r\nlet VaultSubscriptionList = todynamic( replace(\"/subscriptions/\", \"\", @\"{VaultSubscription}\"));\r\nlet VaultLocationList = \"*\";\r\nlet VaultList = \"*\";\r\nlet VaultTypeList = \"*\";\r\nlet ExcludeLegacyEvent = @\"{ExcludeLegacyEvent}\";\r\nlet BackupSolutionList = @\"{DatasourceType}\";\r\n// function Params - other Filters\r\nlet ProtectionInfoList = \"*\";\r\nlet Item_search =  \"*;*\";\r\nlet ItemArray = split(Item_search, \";\");\r\nlet ItemArray_length = array_length(ItemArray);\r\nlet BackupInstanceName = iff(ItemArray_length == 2, ItemArray[1], ItemArray[0] );\r\nlet DatasourceSetName = iff(ItemArray_length == 2, ItemArray[0], \"\");\r\nlet DisplayAllFields = false;\r\n// calling LA System Function\r\n_AzureBackup_GetBackupInstances(RangeStart, RangeEnd, VaultSubscriptionList, VaultLocationList, VaultList, VaultTypeList, ExcludeLegacyEvent, BackupSolutionList, ProtectionInfoList, DatasourceSetName, BackupInstanceName, DisplayAllFields)\r\n// query to transform function output\r\n| distinct VaultLocation"
          queryType               = 0
          quote                   = ""
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 2
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            selectAllValue            = "*"
            showDefault               = false
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          delimiter               = ","
          description             = "Name(s) of the vault(s)"
          id                      = "fefd31fa-2774-43ca-8cc3-44d477c969f0"
          isRequired              = true
          label                   = "Vault Name"
          multiSelect             = true
          name                    = "VaultName"
          query                   = "// function Params - Report Filters\r\nlet RangeStart = startofday({TimeRange:start});\r\nlet RangeEnd = iff(startofday({TimeRange:end}) == startofday(now()) ,startofday({TimeRange:end}) - 1d , startofday({TimeRange:end}));\r\nlet VaultSubscriptionList = todynamic( replace(\"/subscriptions/\", \"\", @\"{VaultSubscription}\"));\r\nlet VaultLocationList = todynamic( @\"{VaultLocation}\"); \r\nlet VaultList = \"*\";\r\nlet VaultTypeList = \"*\";\r\nlet ExcludeLegacyEvent = @\"{ExcludeLegacyEvent}\";\r\n// calling LA System Function\r\n_AzureBackup_GetVaults(RangeStart, RangeEnd, VaultSubscriptionList, VaultLocationList, VaultList, VaultTypeList, ExcludeLegacyEvent)\r\n// query to transform function output\r\n| distinct Name "
          queryType               = 0
          quote                   = ""
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 2
          typeSettings = {
            additionalResourceOptions = ["value::all"]
            selectAllValue            = "*"
            showDefault               = false
          }
          value   = ["value::all"]
          version = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "above"
        version      = "KqlParameterItem/1.0"
      }
      customWidth = "64"
      name        = "Overview-ReportParameterBlock"
      styleSettings = {
        maxWidth = "100%"
      }
      type = 9
      }, {
      conditionalVisibility = {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
      }
      content = {
        crossComponentResources = ["{Workspaces}"]
        parameters = [{
          crossComponentResources = ["{Subscriptions}"]
          id                      = "3c5a3e26-bce4-43d9-a22d-e963a0d734af"
          isHiddenWhenLocked      = true
          name                    = "ResourceGroupId"
          query                   = "resources | where type==\"microsoft.operationalinsights/workspaces\" | project name, resourceGroupId=strcat(\"/subscriptions/\",subscriptionId,\"/resourceGroups/\",resourceGroup) | where \"{Workspaces}\" contains name | project resourceGroupId | take 1"
          queryType               = 1
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Subscriptions}"]
          id                      = "897957ad-a946-4b3b-98f0-02008d30ff0f"
          isHiddenWhenLocked      = true
          name                    = "WorkspaceName"
          query                   = "resources | where type==\"microsoft.operationalinsights/workspaces\" \r\n| project name, resourceGroupId=strcat(\"/subscriptions/\",subscriptionId,\"/resourceGroups/\",resourceGroup) \r\n| where \"{Workspaces}\" contains name \r\n| where \"{ResourceGroupId}\" has resourceGroupId\r\n| take 1\r\n"
          queryType               = 1
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Subscriptions}"]
          id                      = "75065a95-e81f-470f-805e-427558ee0ea3"
          isHiddenWhenLocked      = true
          name                    = "WorkspaceResourceGroup"
          query                   = "resources | where type==\"microsoft.operationalinsights/workspaces\" \r\n| project name, resourceGroupId=strcat(\"/subscriptions/\",subscriptionId,\"/resourceGroups/\",resourceGroup), resourceGroup, subscriptionId \r\n| where \"{WorkspaceName}\" has name \r\n| where \"{ResourceGroupId}\" has resourceGroupId\r\n| take 1\r\n| project resourceGroup\r\n"
          queryType               = 1
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Subscriptions}"]
          id                      = "2581aa73-ab5f-4f2c-82f1-1b4d0f9708ad"
          isHiddenWhenLocked      = true
          name                    = "WorkspaceSubscriptionId"
          query                   = "resources | where type==\"microsoft.operationalinsights/workspaces\" \r\n| project name, resourceGroupId=strcat(\"/subscriptions/\",subscriptionId,\"/resourceGroups/\",resourceGroup), resourceGroup, subscriptionId \r\n| where \"{WorkspaceName}\" has name \r\n| where \"{ResourceGroupId}\" has resourceGroupId\r\n| take 1\r\n| project subscriptionId\r\n"
          queryType               = 1
          resourceType            = "microsoft.resourcegraph/resources"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          id                      = "5327529a-bd07-4305-bf65-4b36a3c787b9"
          isHiddenWhenLocked      = true
          name                    = "LogicApp_VaultSubscriptionList"
          query                   = "let VaultSubscriptionList = todynamic( replace(\"/subscriptions/\", \"\", @\"{VaultSubscription}\"));\r\nprint VaultSubscriptionList"
          queryType               = 0
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          id                      = "e404488a-5db7-42ba-9b44-996f1d8cd7b2"
          isHiddenWhenLocked      = true
          name                    = "LogicApp_VaultLocationList"
          query                   = "let VaultLocationList = todynamic( @\"{VaultLocation}\"); \r\nprint VaultLocationList"
          queryType               = 0
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          id                      = "8005c310-7839-42ff-a3a4-01e5a6c45223"
          isHiddenWhenLocked      = true
          name                    = "LogicApp_VaultList"
          query                   = "let VaultList = todynamic( @\"{VaultName}\"); \r\nprint VaultList"
          queryType               = 0
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          id                      = "2e3d4cd7-7393-4cc4-ab9e-793311eb291c"
          isHiddenWhenLocked      = true
          name                    = "LogicApp_DatasourceTypeList"
          query                   = "let DatasourceTypeList = @\"{DatasourceType}\";\r\nprint DatasourceTypeList"
          queryType               = 0
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          id                      = "376631ff-44ae-4824-b470-ac32d82cd4f2"
          isHiddenWhenLocked      = true
          name                    = "LogicApp_ExcludeLegacyEvent"
          query                   = "let ExcludeLegacyEvent = @\"{ExcludeLegacyEvent}\";\r\nprint ExcludeLegacyEvent"
          queryType               = 0
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          id                      = "5d1a9bc1-34ab-491d-bfa6-f7fc8402f3dc"
          isHiddenWhenLocked      = true
          name                    = "LogicApp_AggregationType"
          query                   = "// function Params - Report Filters\r\nlet RangeStart = startofday({TimeRange:start});\r\nlet RangeEnd = iff(startofday({TimeRange:end}) == startofday(now()) ,startofday({TimeRange:end}) - 1d , startofday({TimeRange:end}));\r\nprint AggregationType=iff(datetime_diff('day',RangeEnd,RangeStart)<=30,\"Daily\",iff(datetime_diff('day',RangeEnd,RangeStart)<=90,\"Weekly\",\"Monthly\"))\r\n\r\n\r\n\r\n\r\n\r\n"
          queryType               = 0
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
          }, {
          crossComponentResources = ["{Workspaces}"]
          id                      = "892dcb11-ee52-478b-aac2-10892fb837ae"
          isHiddenWhenLocked      = true
          name                    = "LogicApp_TimeRangeInDays"
          query                   = "// function Params - Report Filters\r\nlet RangeStart = startofday({TimeRange:start});\r\nlet RangeEnd = startofday({TimeRange:end});\r\nprint TimeRangeInDays = datetime_diff('day',RangeEnd,RangeStart)\r\n\r\n"
          queryType               = 0
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "above"
        version      = "KqlParameterItem/1.0"
      }
      customWidth = "60"
      name        = "Overview-ReportParameterBlock - Copy"
      styleSettings = {
        maxWidth = "100%"
      }
      type = 9
      }, {
      conditionalVisibility = {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
      }
      content = {
        json = "<span style=\"font-size:12px;font-style:italic\"> All datetimes are in UTC. Data for the current partial day is not shown in the reports. <a href=\"https://aka.ms/AzureBackupReportTimezone\" target=\"_blank\">Learn More</a></span></div>"
      }
      name = "Overview-InstructionText2a"
      styleSettings = {
        margin  = "0% 0% 0% 0%"
        padding = "0% 0% 0% 0%"
      }
      type = 1
      }, {
      conditionalVisibility = {
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Overview"
      }
      content = {
        json = "________________"
      }
      name = "Overview-DividingLine2a"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isNotEqualTo"
        parameterName = "TabName"
        value         = "Overview"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "VaultsUsingAzureDiagnostics"
        value         = ""
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
      }]
      content = {
        json  = "You have vault(s) using **legacy diagnostics settings**. Please use the latest diagnostics settings for all your vaults to make them eligible for reporting upgrades. <a href=\"https://aka.ms/AzureBackupUseResourceSpecific\" target=\"_blank\">Learn More</a>"
        style = "warning"
      }
      name = "ResourceSpecificTextBox2"
      type = 1
      }, {
      content = {
        crossComponentResources = ["{Workspaces}"]
        parameters = [{
          crossComponentResources = ["{Workspaces}"]
          id                      = "396c89aa-fd11-4736-8eb9-40c10a04be21"
          isHiddenWhenLocked      = true
          name                    = "AggregationType"
          query                   = "// function Params - Report Filters\r\nlet RangeStart = startofday({TimeRange:start});\r\nlet RangeEnd = iff(startofday({TimeRange:end}) == startofday(now()) ,startofday({TimeRange:end}) - 1d , startofday({TimeRange:end}));\r\nprint AggregationType=iff(datetime_diff('day',RangeEnd,RangeStart)<=30,\"Daily\",iff(datetime_diff('day',RangeEnd,RangeStart)<=90,\"Weekly\",\"Monthly\"))\r\n\r\n"
          queryType               = 0
          resourceType            = "microsoft.operationalinsights/workspaces"
          type                    = 1
          version                 = "KqlParameterItem/1.0"
        }]
        queryType    = 0
        resourceType = "microsoft.operationalinsights/workspaces"
        style        = "above"
        version      = "KqlParameterItem/1.0"
      }
      name = "AggregationTypeParam"
      type = 9
      }, {
      conditionalVisibilities = [{
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "CustomBackupManagementTypeParam"
      }]
      content = {
        json = "__________________________________________________________________________________________"
      }
      name = "Overview-DividingLine2"
      styleSettings = {
        padding = "0px 0px 10px 0px"
      }
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        json = "_________________"
      }
      name = "text - 73"
      type = 1
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Policy Adherence"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        groupType          = "template"
        items              = []
        loadFromTemplateId = "community-Workbooks/Azure Backup/policyadherence-tab"
        version            = "NotebookGroup/1.0"
      }
      name = "PolicyAdherence-group"
      type = 12
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "PolicyDetails"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        groupType          = "template"
        items              = []
        loadFromTemplateId = "community-Workbooks/Azure Backup/policydetails-tab"
        version            = "NotebookGroup/1.0"
      }
      name = "policy-group"
      type = 12
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "JobDistribution"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        groupType          = "template"
        items              = []
        loadFromTemplateId = "community-Workbooks/Azure Backup/jobdistribution-tab"
        version            = "NotebookGroup/1.0"
      }
      name = "jobs-group"
      type = 12
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Usage"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        groupType          = "template"
        items              = []
        loadFromTemplateId = "community-Workbooks/Azure Backup/usage-tab"
        version            = "NotebookGroup/1.0"
      }
      name = "usage-group"
      type = 12
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "BackupItems"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        groupType          = "template"
        items              = []
        loadFromTemplateId = "community-Workbooks/Azure Backup/backupitems-tab"
        version            = "NotebookGroup/1.0"
      }
      name = "backupitems-group"
      type = 12
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Summary"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        groupType          = "template"
        items              = []
        loadFromTemplateId = "community-Workbooks/Azure Backup/summary-tab"
        version            = "NotebookGroup/1.0"
      }
      name = "summary-group"
      type = 12
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Optimize"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        exportParameters   = true
        groupType          = "template"
        items              = []
        loadFromTemplateId = "community-Workbooks/Azure Backup/optimize-tab"
        loadType           = "always"
        version            = "NotebookGroup/1.0"
      }
      name = "Optimize-group"
      type = 12
      }, {
      conditionalVisibilities = [{
        comparison    = "isEqualTo"
        parameterName = "TabName"
        value         = "Email"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "Workspaces"
        }, {
        comparison    = "isNotEqualTo"
        parameterName = "DatasourceType"
      }]
      content = {
        groupType          = "template"
        items              = []
        loadFromTemplateId = "community-Workbooks/Azure Backup/optimize-tab"
        version            = "NotebookGroup/1.0"
      }
      name = "Email-group"
      type = 12
    }]
    version = "Notebook/1.0"
  })
  display_name        = "af-workbook_azure-backup-overview"
  location            = "westeurope"
  name                = "ef2f0e55-bc7b-f77c-daf1-a4a7ec5865f2"
  resource_group_name = azurerm_resource_group.res-1.name
  source_id           = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourcegroups/rg-monitoring-prd-weu/providers/microsoft.operationalinsights/workspaces/log-operationallogs-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_log_analytics_workspace" "res-16" {
  location            = "westeurope"
  name                = "log-operationallogs-prd-weu"
  resource_group_name = azurerm_resource_group.res-1.name
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_role_assignment" "res-17" {
  principal_id       = "716019d2-fca4-402c-8f4a-3716444b9194"
  role_definition_id = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7"
  scope              = azurerm_log_analytics_workspace.res-16.id
}
resource "azurerm_resource_group" "res-18" {
  location = "westeurope"
  name     = "rg-queryalerts-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-19" {
  description                       = "Query - Azure Firewall Threat Intelligence Alert"
  evaluation_frequency              = "PT15M"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-azfw-threatintelligence-alert-weu-prd-sev1"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 1
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "PT15M"
  criteria {
    operator                = "GreaterThan"
    query                   = "// Threat Intelligence rule log data \n// Parses the Threat Intelligence rule log data. \nAzureDiagnostics\n| where OperationName  == \"AzureFirewallThreatIntelLog\"\n| parse column_ifexists(\"msg_s\",0) with Protocol \" request from \" SourceIP \":\" SourcePortInt:int \" to \" TargetIP \":\" TargetPortInt:int *\n| parse column_ifexists(\"msg_s\",0) with * \". Action: \" Action \".\" Message\n| parse column_ifexists(\"msg_s\",0) with Protocol2 \" request from \" SourceIP2 \" to \" TargetIP2 \". Action: \" Action2\n| extend SourcePort = tostring(SourcePortInt),TargetPort = tostring(TargetPortInt)\n| extend Protocol = case(Protocol == \"\", Protocol2, Protocol),SourceIP = case(SourceIP == \"\", SourceIP2, SourceIP),TargetIP = case(TargetIP == \"\", TargetIP2, TargetIP),SourcePort = case(SourcePort == \"\", \"N/A\", SourcePort),TargetPort = case(TargetPort == \"\", \"N/A\", TargetPort)\n| sort by TimeGenerated desc \n| project TimeGenerated, column_ifexists(\"msg_s\",0) , Protocol, SourceIP,SourcePort,TargetIP,TargetPort,Action,Message"
    threshold               = 0
    time_aggregation_method = "Count"
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-20" {
  description                       = "This alert will watch Keys, Secrets and Certificates regarding the Event ExpiredEventGridNotification (have expired)"
  evaluation_frequency              = "P1D"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-kv-expired-weu-prd-sev1"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 1
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "P1D"
  action {
    action_groups = [azurerm_monitor_action_group.res-2.id]
  }
  criteria {
    operator                = "GreaterThan"
    query                   = "let expriationtime = 0;\nlet event = \"Expired!\";\nAzureDiagnostics\n| where ResourceProvider ==\"MICROSOFT.KEYVAULT\"\n//FIXME ADD ALL SUBSCRIPTIONS / RESOURCEGROUPS that shall be included in this query\n| where ResourceId has_any ( //Add SubscriptionID or ResourceGroupID that shall be monitored, searches for substrings so <subscriptions/SUBID/> or <SUBID> will work\n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n    // \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-include/\"\n)\n| where not(_ResourceId has_any(\n    \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/someRGtoExclude/\"\n)) \n| where OperationName contains \"ExpiredEventGridNotification\"\n| project column_ifexists(\"eventGridEventProperties_data_VaultName_s\",0), ResourceGroup, column_ifexists(\"eventGridEventProperties_data_ObjectName_s\",0),column_ifexists(\"eventGridEventProperties_data_ObjectType_s\",0), event,column_ifexists(\"eventGridEventProperties_data_EXP_d\",0)\n| extend expriationunixtime=column_ifexists(\"eventGridEventProperties_data_EXP_d\",0)\n| extend expriationtime = unixtime_seconds_todatetime(expriationunixtime)\n| extend Vault=column_ifexists(\"eventGridEventProperties_data_VaultName_s\",0)\n| extend Object=column_ifexists(\"eventGridEventProperties_data_ObjectName_s\",0)\n| extend Type=column_ifexists(\"eventGridEventProperties_data_ObjectType_s\",0)\n| project-reorder Vault, Object, Type, event, expriationtime, ResourceGroup"
    threshold               = 0
    time_aggregation_method = "Count"
    dimension {
      name     = "Object"
      operator = "Include"
      values   = ["*"]
    }
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-21" {
  description                       = "This alert will watch Keys, Secrets and Certificates regarding the Event NearExpiryEventGridNotification (expire in 30days)"
  evaluation_frequency              = "P1D"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-kv-will-expire-weu-prd-sev2"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 2
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "P1D"
  action {
    action_groups = [azurerm_monitor_action_group.res-2.id]
  }
  criteria {
    operator                = "GreaterThan"
    query                   = "//get certs/keys/secrests that will expire in 30 days\n//https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/key-vault/general/logging.md\n//https://docs.microsoft.com/en-us/azure/event-grid/event-schema-key-vault?tabs=event-grid-event-schema\nlet expriationtime = 0;\nlet event = \"expires in 30 days\";\nAzureDiagnostics\n| where ResourceProvider ==\"MICROSOFT.KEYVAULT\"\n//FIXME ADD ALL SUBSCRIPTIONS / RESOURCEGROUPS that shall be included in this query\n| where ResourceId has_any ( //Add SubscriptionID or ResourceGroupID that shall be monitored, searches for substrings so <subscriptions/SUBID/> or <SUBID> will work\n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n    // \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-include/\"\n) \n| where not(_ResourceId has_any(\n    \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/someRGtoExclude/\"\n))\n| where OperationName contains \"NearExpiryEventGridNotification\"\n| project column_ifexists(\"eventGridEventProperties_data_VaultName_s\",0), ResourceGroup, column_ifexists(\"eventGridEventProperties_data_ObjectName_s\",0),column_ifexists(\"eventGridEventProperties_data_ObjectType_s\",0), event,column_ifexists(\"eventGridEventProperties_data_EXP_d\",0)\n| extend expriationunixtime=column_ifexists(\"eventGridEventProperties_data_EXP_d\",0)\n| extend expriationtime = unixtime_seconds_todatetime(expriationunixtime)\n| extend Vault=column_ifexists(\"eventGridEventProperties_data_VaultName_s\",0)\n| extend Object=column_ifexists(\"eventGridEventProperties_data_ObjectName_s\",0)\n| extend Type=column_ifexists(\"eventGridEventProperties_data_ObjectType_s\",0)\n| where Object <> \"\"\n| project-reorder Vault, Object, Type, event, expriationtime, ResourceGroup"
    threshold               = 0
    time_aggregation_method = "Count"
    dimension {
      name     = "Object"
      operator = "Include"
      values   = ["*"]
    }
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-22" {
  description                       = "Update Management failed Update Window"
  evaluation_frequency              = "PT6H"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-updatemanagement-failed-update-window-weu-prd-sev2"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 2
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "PT6H"
  action {
    action_groups = [azurerm_monitor_action_group.res-2.id]
  }
  criteria {
    operator                = "GreaterThan"
    query                   = "arg('').patchinstallationresources\n| where properties.lastModifiedDateTime > ago(10d)\n| where type in~ ( \"microsoft.compute/virtualmachines/patchinstallationresults\", \"microsoft.hybridcompute/machines/patchinstallationresults\", \"microsoft.compute/virtualmachines/patchassessmentresults\", \"microsoft.hybridcompute/machines/patchassessmentresults\", \"microsoft.maintenance/maintenanceconfigurations/applyupdates\" )\n| where properties.status !in~ (\"Succeeded\" )\n| parse id with vmResourceId \"/patchInstallationResults\" *\n| where subscriptionId in~ (\n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n    // \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-include/\"\n)\n| extend timestamp=todatetime(properties.lastModifiedDateTime)\n| extend status = tostring(properties.status)\n| extend type = tostring(split(type, \"/\")[-1])\n| extend os = tostring(properties.osType)\n| extend vm = tostring(split(vmResourceId,\"/\")[-1])\n| extend errordetails = properties.errorDetails.details\n| summarize max(timestamp) by vmResourceId, vm, os, status"
    threshold               = 0
    time_aggregation_method = "Count"
    dimension {
      name     = "vm"
      operator = "Include"
      values   = ["*"]
    }
  }
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-23" {
  description                       = "Azure Foundation Core VM Backup alert"
  evaluation_frequency              = "PT6H"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-vm-backup-weu-prd-sev1"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 1
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "PT6H"
  action {
    action_groups = [azurerm_monitor_action_group.res-2.id]
  }
  criteria {
    operator                = "GreaterThan"
    query                   = "AddonAzureBackupJobs\n//FIXME ADD ALL SUBSCRIPTIONS / RESOURCEGROUPS that shall be included in this query\n| where ResourceId has_any ( //Add SubscriptionID or ResourceGroupID that shall be monitored, searches for substrings so <subscriptions/SUBID/> or <SUBID> will work\n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n    // \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-include/\"\n) \n| where not(ResourceId has_any( //FIXME add resourcegroup-ids or resource-ids that are within a subscription or resourcegroup listed above to exclude them from this alert\n    \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-exclude/\"\n)) \n| where JobOperation == \"Backup\"\n| where JobStatus == 'Failed'\n| extend Computer=split(BackupItemUniqueId, ';', 4) \n| extend ResourceGroup=split(BackupItemUniqueId, ';', 3)\n| extend Vault=split(ResourceId, '/', 8)\n| summarize AggregatedValue=count()  by tostring(Vault), tostring(Computer), tostring(ResourceGroup), tostring(JobFailureCode), JobStatus"
    threshold               = 0
    time_aggregation_method = "Count"
    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-24" {
  description                       = "Azure Foundation Core VM CPU alert"
  evaluation_frequency              = "PT6H"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-vm-cpu-weu-prd-sev2"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 2
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "PT6H"
  action {
    action_groups = [azurerm_monitor_action_group.res-2.id]
  }
  criteria {
    metric_measure_column   = "avg_CounterValue"
    operator                = "GreaterThan"
    query                   = "Perf\n//FIXME ADD ALL SUBSCRIPTIONS / RESOURCEGROUPS that shall be included in this query\n| where _ResourceId has_any ( //Add SubscriptionID or ResourceGroupID that shall be monitored, searches for substrings so <subscriptions/SUBID/> or <SUBID> will work\n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n    // \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-include/\"\n) \n| where not(_ResourceId has_any( //FIXME add resourcegroup-ids or resource-ids that are within a subscription or resourcegroup listed above to exclude them from this alert\n    \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-exclude/\"\n)) \n| where column_ifexists(\"ObjectName\",0) == \"Processor\" and column_ifexists(\"CounterName\",0) == \"% Processor Time\"\n| summarize avg(CounterValue) by column_ifexists(\"Computer\",0)\n| where avg_CounterValue > 0\n| project Computer, avg_CounterValue, AlertType_s = strcat(\"High CPU Usage (avg \", \" over \", 0, \"%)\"), Severity = 2, SeverityName_s = \"WARNING\", AffectedCI_s = strcat(Computer, \": \", avg_CounterValue)"
    threshold               = 90
    time_aggregation_method = "Average"
    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-25" {
  description                       = "Azure Foundation Core VM Disk alert"
  evaluation_frequency              = "PT1H"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-vm-diskspace-weu-prd-sev0"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 0
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "PT1H"
  action {
    action_groups = [azurerm_monitor_action_group.res-4.id]
  }
  criteria {
    metric_measure_column   = "FreeDiskSpacePercent"
    operator                = "LessThan"
    query                   = "Perf\n| where _ResourceId has_any ( \n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n)\n| where not(_ResourceId has_any(\n      \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/someRGtoExclude/\"\n))        \n| where ObjectName in (\"LogicalDisk\", \"Logical Disk\") and CounterName == \"% Free Space\"\n| where (InstanceName !has \"\\\\\" and InstanceName  has \":\") or (InstanceName == '/')\n| summarize avg(CounterValue) by Computer, InstanceName\n| project Computer, InstanceName, FreeDiskSpacePercent = avg_CounterValue"
    threshold               = 5
    time_aggregation_method = "Average"
    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-26" {
  description                       = "Azure Foundation Core VM Disk alert"
  evaluation_frequency              = "PT1H"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-vm-diskspace-weu-prd-sev1"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 1
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "PT1H"
  action {
    action_groups = [azurerm_monitor_action_group.res-2.id]
  }
  criteria {
    metric_measure_column   = "FreeDiskSpacePercent"
    operator                = "LessThan"
    query                   = "Perf\n| where _ResourceId has_any ( \n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n)\n| where not(_ResourceId has_any(\n      \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/someRGtoExclude/\"\n))        \n| where ObjectName in (\"LogicalDisk\", \"Logical Disk\") and CounterName == \"% Free Space\"\n| where (InstanceName !has \"\\\\\" and InstanceName  has \":\") or (InstanceName == '/')\n| summarize avg(CounterValue) by Computer, InstanceName\n| project Computer, InstanceName, FreeDiskSpacePercent = avg_CounterValue"
    threshold               = 15
    time_aggregation_method = "Average"
    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-27" {
  description                       = "Azure Foundation Core VM Heartbeat alert"
  evaluation_frequency              = "PT5M"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-vm-heartbeat-weu-prd-sev1"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 1
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "PT15M"
  action {
    action_groups = [azurerm_monitor_action_group.res-2.id]
  }
  criteria {
    operator                = "GreaterThan"
    query                   = "Heartbeat\n| where TimeGenerated > ago(15m)\n//FIXME ADD ALL SUBSCRIPTIONS / RESOURCEGROUPS that shall be included in this query\n| where ResourceId has_any ( //Add SubscriptionID or ResourceGroupID that shall be monitored, searches for substrings so <subscriptions/SUBID/> or <SUBID> will work\n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n    // \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-include/\"\n)\n| where not(ResourceId has_any( //FIXME add resourcegroup-ids or resource-ids that are within a subscription or resourcegroup listed above to exclude them from this alert\n    \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rgname-to-exclude/\"\n))  \n| summarize LastCall = max(TimeGenerated) by Computer, Resource\n| where LastCall < ago (12m) //will filter short outages //12min to only create one ticket in 15min window"
    threshold               = 0
    time_aggregation_method = "Count"
    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-28" {
  description                       = "Azure Foundation Core VM Memory alert"
  evaluation_frequency              = "PT5M"
  location                          = "westeurope"
  mute_actions_after_alert_duration = "P1D"
  name                              = "AIXTRON-AF-vm-memory-weu-prd-sev0"
  resource_group_name               = azurerm_resource_group.res-18.name
  scopes                            = [azurerm_log_analytics_workspace.res-16.id]
  severity                          = 0
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  window_duration = "PT4H"
  action {
    action_groups = [azurerm_monitor_action_group.res-4.id]
  }
  criteria {
    metric_measure_column   = "PercentMemUsed"
    operator                = "GreaterThan"
    query                   = "//Used Memory in percent (Sev2) Win and Linux\n//use for subscription based or resourcegroup based alerting\nPerf  \n| where _ResourceId has_any (\n    \"778d3aa1-696a-41dc-a946-f5b22444ae57\", // tfstate\n    \"1e8a66a9-dab0-4f00-8869-ae92ba63d2d4\", // audit\n    \"af6bb952-3026-4b50-9aaa-f925d0d0ca4f\", // mgmt\n    \"e198d41d-52ba-429d-9430-ed63721c40d7\"  // connectivity\n    \"fc7d069e-d1ed-42b1-ade4-c8548e10f249\" // vwan\n) \n| where not(_ResourceId has_any(\n    \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/someRGtoExclude/\"\n))\n| where ObjectName == \"Memory\"\n| where CounterName == \"% Used Memory\" or CounterName == \"% Committed Bytes In Use\"\n| summarize\n        mtgPerf=max(TimeGenerated),\n        CounterValue=avg(CounterValue),\n        SampleCount=count(CounterValue)\n        by Computer\n    | join kind=inner\n        (\n        Heartbeat\n        | summarize max(TimeGenerated) by Computer\n        )\n        on Computer\n| extend PercentMemUsed=round(CounterValue)\n| where PercentMemUsed > 0\n| project Computer, TimeGenerated=mtgPerf, PercentMemUsed, AlertType_s = \"Low Available Memory\", Severity = 2, SeverityName_s = \"WARNING\", AffectedCI_s = strcat(Computer, \"/%UsedMemory/\"), AlertTitle_s = strcat(Computer, \": Low Available Memory\"), AlertDetails_s = strcat(\"Computer: \", Computer, \"\\r\\nAverage % Memory Used: \", PercentMemUsed, \" MB\\r\\nSample Period: Last \", \"\\r\\nSample Count: \", SampleCount, \"\\r\\nAlert Threshold: > \", 0, \"%\")"
    threshold               = 85
    time_aggregation_method = "Average"
    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
  }
}

######################
######Resources in the subscription 1e8a66a9-dab0-4f00-8869-ae92ba63d2d4:
resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "rg-alerting-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_monitor_activity_log_alert" "res-1" {
  description         = "This alert will monitor the Resource Health of the infrastructure subscription 1e8a66a9-dab0-4f00-8869-ae92ba63d2d4"
  location            = "westeurope"
  name                = "AIXTRON-AF-resourcehealth-infra-weu-prd-1e8a66a9-dab0-4f00-8869-ae92ba63d2d4"
  resource_group_name = azurerm_resource_group.res-0.name
  scopes              = ["/subscriptions/1e8a66a9-dab0-4f00-8869-ae92ba63d2d4"]
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
  action {
    action_group_id = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourceGroups/rg-monitoring-prd-weu/providers/Microsoft.Insights/actionGroups/acg-GKSupport-prd-weu"
  }
  action {
    action_group_id = "/subscriptions/af6bb952-3026-4b50-9aaa-f925d0d0ca4f/resourceGroups/rg-monitoring-prd-weu/providers/Microsoft.Insights/actionGroups/acg-GKSupportPD-prd-weu"
  }
  criteria {
    category = "ResourceHealth"
    levels   = ["Critical"]
    status   = "Active"
  }
}
resource "azurerm_resource_group" "res-2" {
  location = "westeurope"
  name     = "rg-audittrail-prd-weu"
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}
resource "azurerm_log_analytics_workspace" "res-3" {
  location            = "westeurope"
  name                = "log-audittrail-prd-weu"
  resource_group_name = azurerm_resource_group.res-2.name
  tags = {
    company          = "tbd"
    costcenter       = "tbd"
    department       = "tbd"
    owner            = "tbd"
    technicalcontact = "tbd"
  }
}