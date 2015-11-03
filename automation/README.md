<!-- toc -->

##  Automation

Automation functionality is designed to automatically generate signatures for intrusion detection systems. To enable signature generation for a given attribute, Signature field of this attribute must be set to Yes. Note that not all attribute types are applicable for signature generation, currently we only support NIDS signature generation for IP, domains, host names, user agents etc., and hash list generation for MD5/SHA1 values of file artifacts. Support for more attribute types is planned. To to make this functionality available for automated tools an authentication key is used. This makes it easier for your tools to access the data without further form-based-authentication.

### Automation URL

The documentation will include a default MISP url (https://<misp url>/) in the examples. Don't forget to replace it with your MISP url.

### Automation key

The authentication of the automation is performed via a secure key available in the MISP UI interface. Make sure you keep that key secret as it gives access to the entire database! The API key is available in the event actions menu under automation.

Since version 2.2 the usage of the authentication key in the url is deprecated. Instead, pass the auth key in an Authorization header in the request. The legacy option of having the auth key in the url is temporarily still supported but not recommended.

The authorization is performed by using the following header:

~~~~
Authorization: YOUR API KEY
~~~~

### XML Export

An automatic export of all events and attributes (except file attachments) is available under a custom XML format.

You can configure your tools to automatically download the following file:

~~~~
https://<misp url>/events/xml/download
~~~~

If you only want to fetch a specific event append the eventid number:

~~~~
https://<misp url>/events/xml/download/1
~~~~

You can post an XML or JSON object containing additional parameters in the JSON query format or XML query format. Query
parameters provide a way to filter the output to specific parameters.


#### JSON query format

The URL is appended with json:

~~~~
https://<misp url>/events/xml/download.json 
~~~~

The query parameters can be the following:

~~~~json
{"request": {"eventid":["!51","!62"],"withAttachment":false,"tags":["APT1","!OSINT"],"from":false,"to":"2015-02-15"}}
~~~~

#### XML query format

The URL is path is:

~~~~
https://<misp url>/events/xml/download
~~~~

The query parameters can be the following:

~~~~xml
<request><eventid>!51</eventid><eventid>!62</eventid><withAttachment>false</withAttachment><tags>APT1</tags><tags>!OSINT</tags><from>false</from><to>2015-02-15</to></request>
~~~~

#### XML download and URL parameters

The XML download also accepts two additional the following optional parameters in the url:

~~~~
https://<misp url>/events/xml/download/[eventid]/[withattachments]/[tags]/[from]/[to]/[last]
~~~~

   eventid: Restrict the download to a single event
   withattachments: A boolean field that determines whether attachments should be encoded and a second parameter that controls the eligible tags.
   tags: To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag
   commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will
   automatically search for colons instead). For example, to include tag1 and tag2 but exclude tag3 you would use:
~~~~
https://<misp url>/events/xml/download/false/true/tag1&&tag2&&!tag3
~~~~

   from: Events with the date set to a date after the one specified in the from field (format: 2015-02-15)
   to: Events with the date set to a date before the one specified in the to field (format: 2015-02-15)
   last: Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)

The keywords false or null should be used for optional empty parameters in the URL. Also check out the User Guide to read about the [REST API](../using-the-system/README.md#rest-api).

### CSV export

An automatic export of attributes is available as CSV. Only attributes that are flagged "to_ids" will get exported.

You can configure your tools to automatically download the following file:

~~~~
https://<misp url>/events/csv/download
~~~~

You can specify additional flags for CSV exports as follows:

~~~~
https://<misp url>/events/csv/download/[eventid]/[ignore]/[tags]/[category]/[type]/[includeContext]/[from]/[to]/[last]
~~~~

eventid: Restrict the download to a single event
ignore: Setting this flag to true will include attributes that are not marked "to_ids".
tags: To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag
commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will automatically search for colons instead). For example, to include tag1 and tag2 but exclude tag3 you would use:

For example, to only download a csv generated of the "domain" type and the "Network activity" category attributes all events except for the one and further restricting it to events that are tagged "tag1" or "tag2" but not "tag3", only allowing attributes that are IDS flagged use the following syntax:

~~~~
https://<misp url>/events/csv/download/false/false/tag1&&tag2&&!tag3/Network%20activity/domain
~~~~

category: The attribute category, any valid MISP attribute category is accepted.
type: The attribute type, any valid MISP attribute type is accepted.
includeContext: Include the event data with each attribute.
from: Events with the date set to a date after the one specified in the from field (format: 2015-02-15)
to: Events with the date set to a date before the one specified in the to field (format: 2015-02-15)
last: Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)

The keywords false or null should be used for optional empty parameters in the URL.

To export the attributes of all events that are of the type "domain", use the following syntax:

~~~~
https://<misp url>/events/csv/download/false/false/false/false/domain
~~~~

