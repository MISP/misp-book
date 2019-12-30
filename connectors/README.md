# External Connectors

Below you will find various tweaks and tips when integrating 3rd party connectors.

## Microsoft Azure Sentinel 

[Azure Sentinel](https://azure.microsoft.com/en-us/services/azure-sentinel/)

## Microsoft Defender ATP

[Microsoft Defender ATP](https://www.microsoft.com/en-us/microsoft-365/windows/microsoft-defender-atp/)

# MISP to Microsoft Graph Security Script
The script provides clients with MISP instances to migrate threat indicators to the Microsoft Graph Security API. 

For more information on Microsoft Security Graph visit [Microsoft Graph] (https://developer.microsoft.com/en-us/graph)

## Prerequisites
Before installing the sample:
* Install Python 3.x version from https://www.python.org/. 
* To register your application for access to Microsoft Graph, you'll need either a [Microsoft account](https://www.outlook.com/) or an [Office 365 for business account](https://msdn.microsoft.com/en-us/office/office365/howto/setup-development-environment#bk_Office365Account). If you don't have one of these, you can create a Microsoft account for free at [outlook.com](https://www.outlook.com/). 

## Getting Started
After the prerequisites are installed or met, perform the following steps to use these scripts:

1. Download or clone this repository.
1. Go to directory `security-api-solutions/Samples/MISP`
1. Install dependencies.  In the command line, run `pip3 install requests requests-futures pymisp` 
1. To run script, go to the root directory of misp-graph-script and enter `PYTHONHASHSEED=0 python3 script.py` in the command line. 

## App Registration
To configure the samples, you'll need to register a new application in the Microsoft [Application Registration Portal](https://apps.dev.microsoft.com/).
### Follow these steps to register a new application
1. Sign in to the [Azure Portal](https://portal.azure.com/) using either your personal or work or school account.

1. Under My Azure Active Directory, choose App registrations (if you are suggested to use the preview, use that) choose New registration.

1. Enter an application name, and choose Register

1. Next you'll see the registration page for your app. Copy and save the `Application (client) Id` & `Directory (tenant) ID` field.You will need it later to complete the configuration process.

1. Under Certificates & secrets, choose `New client secret` and give it a name. A new password will be displayed under Client secrets. Copy this password. This will be your `client secret`.  You will need it later to complete the configuration process.

1. Under Authentication, find Implicit grant choose both `Access tokens` & `ID tokens` and save.

1. Under API permissions click `Add a permission`, choose Microsoft Graph, under `Application permissions`, under ThreatIndicators add ThreatIndicators.ReadWrite.OwnedBy. You will be taken back to the API permissions screen, click `Grant admin consent for Default Directory`
    >Note: See the [Microsoft Graph permissions reference](https://developer.microsoft.com/en-us/graph/docs/concepts/permissions_reference) for more information about Graph's permission model.
    
1. Modify the RequestManager.py file to comment out line 121-124. (This allows the script to run without failing due to line 123 being divided by `avg_speed` incase it starts as `0`.

1. Modify the script.py to add in `config.misp_verifycert` at line 13. Ensure it looks like below.
```
 misp = PyMISP(config.misp_domain, config.misp_key, config.misp_verifycert)
```

1. Modify config.py file to add in `misp_verifycert = False` anywhere in the file.

As the final step in configuring the script, modify the config.py file in the root folder of your cloned repo.

Update tenent, client_id, and client_secret in config.py
```
graph_auth = {
    'tenant': '<tenant id>',
    'client_id': '<client id>',
    'client_secret': '<client secret>',
}
```
Once changes are complete, save the config file.

## Configurations
### Target Product
`targetProduct = "Azure Sentinel"`
**or**
`targetProduct = "Microsoft Defender ATP"`

### Misp Event Filter
Filters can be set in the config.py file under the "misp_event_filters" property

Below is a list of parameters that can be passed to the filter (source: https://pymisp.readthedocs.io/modules.html):
* values – values to search for
* not_values – values not to search for
* type_attribute – Type of attribute
* category – Category to search
* org – Org reporting the event
* tags – Tags to search for
* not_tags – Tags not to search for
* date_from – First date (Format: '2019-01-01')
* date_to – Last date (Format: '2019-01-01')
* last – Last published events (for example 5d or 12h or 30m)
* eventid – Evend ID
* withAttachments – return events with or without the attachments
* uuid – search by uuid
* publish_timestamp – the publish timestamp (Note: Uses UNIX timestamp.  Format: '1551811160')
* published – return only published events (Format: True or False)

A list or a specific value can be passed to the above parameters. If a list is passed to the parameter, the filtered events are the result of the union of provided list.

This field needs to be a list that contains multiple filters. The filtered events are the result of the intersection of provided filters.

#### First Example of How This Field can be Configured
```
misp_event_filters = [
    {
        "type_attribute": 'mutex'
    },
    {
        "type_attribute": 'filename|md5'
    },
]
```
An event meets this filtering criteria if the event has an attribute with attribute type of 'mutex' AND the event has an attribute with attribute type of 'filename|md5'.

#### Second Example of How This Field can be Configured
```
misp_event_filters = [
    {
        "type_attribute": ['mutex', 'filename|md5']
    }
]
```
An event meets this filtering criteria if the event has an attribute with attribute type of 'mutex' OR the event has an attribute with attribute type of 'filename|md5'.

#### Third Example of How This Field can be Configured
```
misp_event_filters = [
    {
        "values": 'http://www.test.com'
    }
]
```
An event meets this filtering criteria if the event has an attribute with attribute value of 'http://www.test.com'.

#### Fourth Example of How This Field can be Configured
```
misp_event_filters = []
```
This gets all events.

### Action
Possible **action** values are: `alert`, `allow`, `block`.

`action = "alert"` (This is default).

### Passive Only
`passiveOnly = False` (This is default).

### Days to Expire
This property is used to specify the amount of days the records will expire in Microsoft Graph Security API. The default value for days to expire is 30.  

`days_to_expire = 5`

### Misp Key
The Misp Auth Key is required to fetch data from your Misp instance.
Configure a sync user.

`misp_key = '<misp key>'`

### Misp Domain
Misp Domain is the base URL of your MISP instance.

### Verify Cert
This gives you the option to choose if python should validate the certificate of the misp instance. (This allows ease within testing environments) 

`misp_verifycert = False` IT IS RECOMENDED TO USE A VALID SSL CERT IN PRODUCTION AND CHANGE THIS TO TRUE

## Instructions on Reading TiIndicators That Have Been Pushed
In the command line, run `python3 script.py -r`

## Instructions on Seeing All Requests That Resulted in Errors
1. In the command line, run `cd logs` to go to the logs folder.
2. * To print all the requests that resulted in errors to the console, simply run `cat *_error_*` in the command line.
   * To aggregate all the requests that resulted in errors to a file, run `cat *_error_* > <filename>.txt` in the command line.

## Script Output
As the script runs, it prints out the request body sent to the Graph API and the response from the Graph API.

Every request is logged as a json file under the directory "logs". The name of the json file is the datetime of when the request is completed.

## Schedule with CRONTAB
Below is a CRONTAB entry example of running the script every Sunday at 2am

0 2 * * Sun /home/mark/misp-graph-script/python3 script.sh



This README.md has been adapted from the README.md found here [Microsoft Graph MISP sample](https://github.com/microsoftgraph/security-api-solutions/blob/master/Samples/MISP/README.md)
