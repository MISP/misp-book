<!-- toc -->

#  Automation API

Automation functionality is designed to automatically generate signatures for intrusion detection systems. To enable signature generation for a given attribute, Signature field of this attribute must be set to Yes. Note that not all attribute types are applicable for signature generation, currently we only support NIDS signature generation for IP, domains, host names, user agents etc., and hash list generation for MD5/SHA1 values of file artifacts. Support for more attribute types is planned. To to make this functionality available for automated tools an authentication key is used. This makes it easier for your tools to access the data without further form-based-authentication.

### Automation URL

The documentation will include a default MISP url in the examples. Don't forget to replace it with your MISP url.

Default MISP url in the documentation:

~~~~
https://<misp url>/
~~~~

### Automation key

The authentication of the automation is performed via a secure key available in the MISP UI interface. Make sure you keep that key secret as it gives access to the entire database! The API key is available in the event actions menu under automation.

Since version 2.2 the usage of the authentication key in the url is deprecated. Instead, pass the auth key in an Authorization header in the request. The legacy option of having the auth key in the url is temporarily still supported but not recommended.

The authorization is performed by using the following header:

~~~~
Authorization: YOUR API KEY
~~~~

### Accept and Content-Type headers

When performing your request, depending on the type of request, you might need to explicitly specify in what content type you want to get your results. This is done by setting one of the below Accept headers:

~~~~
Accept: application/json
Accept: application/xml
~~~~

When submitting data in a POST, PUT or DELETE operation you also need to specify in what content-type you encoded the payload. This is done by setting one of the below Content-Type headers:

~~~~
Content-Type: application/json
Content-Type: application/xml
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

<dl>
<dt>eventid</dt>
<dd>Restrict the download to a single event</dd>
<dt>withattachments</dt>
<dd>A boolean field that determines whether attachments should be encoded and a second parameter that controls the eligible tags.</dd>
<dt>tags</dt> 
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag
   commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will
   automatically search for colons instead). For example, to include tag1 and tag2 but exclude tag3 you would use:<dd>
</dl>

~~~~
https://<misp url>/events/xml/download/false/true/tag1&&tag2&&!tag3
~~~~

<dl>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m). This filter will use the published timestamp of the event.</dd>
</dl>

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

<dl>
<dt>eventid</dt>
<dd>Restrict the download to a single event</dd>
<dt>ignore</dt>
<dd>Setting this flag to true will include attributes that are not marked "to_ids".</dd>
<dt>tags</dt>
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag
commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will automatically search for colons instead).</dd>
</dl>

For example, to include tag1 and tag2 but exclude tag3 you would use:

For example, to only download a csv generated of the "domain" type and the "Network activity" category attributes all events except for the one and further restricting it to events that are tagged "tag1" or "tag2" but not "tag3", only allowing attributes that are IDS flagged use the following syntax:

~~~~
https://<misp url>/events/csv/download/false/false/tag1&&tag2&&!tag3/Network%20activity/domain
~~~~

<dl>
<dt>category</dt>
<dd>The attribute category, any valid MISP attribute category is accepted.</dd>
<dt>type</dt>
<dd>The attribute type, any valid MISP attribute type is accepted.</dd>
<dt>includeContext</dt>
<dd>Include the event data with each attribute.</dd>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m). This filter will use the published timestamp of the event.</dd>
</dl>

The keywords false or null should be used for optional empty parameters in the URL.

To export the attributes of all events that are of the type "domain", use the following syntax:

~~~~
https://<misp url>/events/csv/download/false/false/false/false/domain
~~~~

### NIDS rules export

Automatic export of all network related attributes is available under the Snort or Suricata rule format. Only published events and attributes marked as IDS Signature are exported.

You can configure your tools to automatically download the following file:

~~~~
https://<misp url>/events/nids/suricata/download
https://<misp url>/events/nids/snort/download
~~~~

The full API syntax is as follows:

~~~~
https://<misp url>/events/nids/[format]/download/[eventid]/[frame]/[tags]/[from]/[to]/[last]
~~~~

<dl>
<dt>format</dt>
<dd>The export format, can be "suricata" or "snort"</dd>
<dt>eventid</dt>
<dd>Restrict the download to a single event</dd>
<dt>frame</dt>
<dd>Some commented out explanation framing the data. The reason to disable this would be if you would like to concatenate a list of exports from
   various select events in order to avoid unnecessary duplication of the comments.</dd>
<dt>tags</dt>
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag
   commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will
   automatically search for colons instead). For example, to include tag1 and tag2 but exclude tag3 you would use:</dd>
</dl>

~~~~
https://<misp url>/events/nids/snort/download/false/false/tag1&&tag2&&!tag3
~~~~

<dl>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 6d or 12h or 30m). This filter will use the published timestamp of the event.</dd>
</dl>

The keywords false or null should be used for optional empty parameters in the URL.

An example for a Suricata export for all events excluding those tagged tag1, without all of the commented information at the start of the file would look like this:

~~~~
https://<misp url>/events/nids/suricata/download/null/true/!tag1
~~~~

Administration is able to maintain a white-list containing host, domain name and IP numbers to exclude from the NIDS export.

## Hash - HIDS database export

Automatic export of MD5/SHA1 checksums contained in file-related attributes. This list can be used to feed forensic software when searching for
   suspicious files. Only published events and attributes marked as IDS Signature are exported.

You can configure your tools to automatically download all the MD5 hashes from MISP:

~~~~
https://<misp url>/events/hids/md5/download
~~~~

Or the SHA1 hashes:

~~~~
https://<misp url>/events/hids/sha1/download
~~~~

The API's full format is as follow:

~~~~
https://<misp url>/events/hids/[format]/download/[tags]/[from]/[to]/[last]
~~~~

<dl>
<dt>format</dt>
<dd>The export format, can be "md5" or "sha1"</dd>
<dt>tags</dt>
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag
   commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will
   automatically search for colons instead). For example, to include tag1 and tag2 but exclude tag3 you would use:</dd>
</dl>

~~~~
https://<misp url>/events/hids/md5/download/tag1&&tag2&&!tag3
~~~~

<dl>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m). This filter will use the published timestamp of the event.</dd>
</dl>

The keywords false or null should be used for optional empty parameters in the URL.

For example, to only show sha1 values from events tagged tag1, use:

~~~~
https://<misp url>/events/hids/sha1/download/tag1
~~~~

## STIX export

You can export MISP events in MITRE's STIX format (to read more about [STIX](https://stix.mitre.org/)). The STIX XML export is currently very slow and can lead to timeouts with larger events or collections of events. The STIX JSON return format does not suffer from this issue.

Usage of the API:

~~~~
https://<misp url>/events/stix/download
~~~~

Search parameters can be passed to the function via url parameters or by POSTing an xml or json object (depending on the return type). The following parameters can be passed to the STIX export tool: id, withAttachments, tags. Both id and tags can use the && (and) and ! (not) operators to build queries. Using the url parameters, the syntax is as follows:

~~~~
https://<misp url>/events/stix/download/[id]/[withAttachments]/[tags]/[from]/[to]/[last]
~~~~

<dl>
<dt>id</dt>
<dd>The event's ID</dd>
<dt>withAttachments</dt>
<dd>Encode attachments where applicable</dd>
<dt>tags</dt>
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will automatically search for colons instead).</dd>
</dl>

For example, to include tag1 and tag2 but exclude tag3 you would use:

~~~~
https://<misp url>/events/stix/download/false/true/tag1&&tag2&&!tag3 
~~~~

<dl>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m). This filter will use the published timestamp of the event.</dd>
</dl>

You can post an XML or JSON object containing additional parameters in the following formats.

If you use JSON query objects:

~~~~
https://<misp url>/events/stix/download.json
~~~~

~~~~json
{"request": {"id":["!51","!62"],"withAttachment":false,"tags":["APT1","!OSINT"],"from":false,"to":"2015-02-15"}}                                            
~~~~

If you use XML query objects:

~~~~
https://<misp url>/events/stix/download
~~~~

~~~~xml
<request><id>!51</id><id>!62</id><withAttachment>false</withAttachment><tags>APT1</tags><tags>!OSINT</tags><from>false</from><to>2015-02-15</to></request>
~~~~

### Various ways to narrow down the search results of the STIX export

For example, to retrieve all events tagged "APT1" but excluding events tagged "OSINT" and excluding events #51 and #62 without any attachments:
~~~~
https://<misp url>/events/stix/download/!51&&!62/false/APT1&&!OSINT/2015-02-15
~~~~

To export the same events using a POST request use:
~~~~
https://<misp url>/events/stix/download.json
~~~~

Together with this JSON object in the POST message:

~~~~json
{"request": {"id":["!51","!62"],"tags":["APT1","!OSINT"],"from":"2015-02-15"}}
~~~~
XML is automatically assumed when using the STIX export:

~~~~
https://<misp url>/events/stix/download
~~~~

The same search could be accomplished using the following POSTed XML object (note that ampersands need to be escaped, or alternatively separate id and tag elements can be used):

~~~~xml
<request><id>!51</id><id>!62</id><tags>APT1</tags><tags>!OSINT</tags><from>2015-02-15</from></request>
~~~~

## RPZ export

You can export RPZ zone files for DNS level firewall by using the RPZ export functionality of MISP. The file generated will include all of the IDS
flagged domain, hostname and IP-src/IP-dst attribute values that you have access to.

It is possible to further restrict the exported values using the following filters:

<dl>
<dt>tags</dt>
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag
   commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search when passed through the url. Use semicolons
   instead (the search will automatically search for colons instead).</dd>
<dt>id</dt>
<dd>The event's ID</dd>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-03)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-03)</dd>
</dl>

MISP will inject header values into the zone file as well as define the action taken for each of the values that can all be overwritten. By default these values are either the default values shipped with the application, or ones that are overwritten by your site administrator. The values are as follows:

| Value name | Default value |
| --- | :---: |
|RPZ_policy| DROP|
|RPZ_walled_garden| 127.0.0.1|
|RPZ_serial| $date00|
|RPZ_refresh| 2h|
|RPZ_retry| 30m|
|RPZ_expiry| 30d|
|RPZ_minimum_ttl| 1h|
|RPZ_ttl| 1w|
|RPZ_ns| localhost.|
|RPZ_email| root.localhost|

To override the above values, either use the url parameters as described below:

~~~~
https://<misp url>/attributes/rpz/download/[tags]/[eventId]/[from]/[to]/[policy]/[walled_garden]/[ns]/[email]/[serial]/[refresh]/[retry]/[expiry]/[minim
um_ttl]/[ttl]
~~~~

Or POST an XML or JSON object with the above listed options:

~~~~xml
<request><tags>OSINT&&!OUTDATED</tags><policy>walled-garden</policy><walled_garden>teamliquid.net</walled_garden><refresh>5h</refresh></request>
~~~~

~~~~json
{"request": {"tags": ["OSINT", "!OUTDATED"], "policy": "walled-garden", "walled_garden": "teamliquid.net", "refresh": "5h"}
~~~~

## Text export

An export of all attributes of a specific type to a plain text file. By default only published and IDS flagged attributes are exported.

You can configure your tools to automatically download the following files:

~~~~
https://<misp url>/attributes/text/download/md5
https://<misp url>/attributes/text/download/sha1
https://<misp url>/attributes/text/download/sha256
https://<misp url>/attributes/text/download/filename
https://<misp url>/attributes/text/download/filename|md5
https://<misp url>/attributes/text/download/filename|sha1
https://<misp url>/attributes/text/download/filename|sha256
https://<misp url>/attributes/text/download/ip-src
https://<misp url>/attributes/text/download/ip-dst
https://<misp url>/attributes/text/download/hostname
https://<misp url>/attributes/text/download/domain
https://<misp url>/attributes/text/download/email-src
https://<misp url>/attributes/text/download/email-dst
https://<misp url>/attributes/text/download/email-subject
https://<misp url>/attributes/text/download/email-attachment
https://<misp url>/attributes/text/download/url
https://<misp url>/attributes/text/download/http-method
https://<misp url>/attributes/text/download/user-agent
https://<misp url>/attributes/text/download/regkey
https://<misp url>/attributes/text/download/regkey|value
https://<misp url>/attributes/text/download/AS
https://<misp url>/attributes/text/download/snort
https://<misp url>/attributes/text/download/pattern-in-file
https://<misp url>/attributes/text/download/pattern-in-traffic
https://<misp url>/attributes/text/download/pattern-in-memory
https://<misp url>/attributes/text/download/yara
https://<misp url>/attributes/text/download/vulnerability
https://<misp url>/attributes/text/download/attachment
https://<misp url>/attributes/text/download/malware-sample
https://<misp url>/attributes/text/download/link
https://<misp url>/attributes/text/download/comment
https://<misp url>/attributes/text/download/text
https://<misp url>/attributes/text/download/other
https://<misp url>/attributes/text/download/named pipe
https://<misp url>/attributes/text/download/mutex
https://<misp url>/attributes/text/download/target-user
https://<misp url>/attributes/text/download/target-email
https://<misp url>/attributes/text/download/target-machine
https://<misp url>/attributes/text/download/target-org
https://<misp url>/attributes/text/download/target-location
https://<misp url>/attributes/text/download/target-external
~~~~

To restrict the results by tags, use the usual syntax. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will automatically search for colons instead). To get ip-src values from events tagged tag1 but not tag2 use:

~~~~
https://<misp url>/attributes/text/download/ip-src/tag1&&
~~~~

As of version 2.3.38, it is possible to restrict the text exports on two additional flags. The first allows the user to restrict based on event ID,
whilst the second is a boolean switch allowing non IDS flagged attributes to be exported. Additionally, choosing "all" in the type field will return
all eligible attributes.

~~~~
https://<misp url>/attributes/text/download/[type]/[tags]/[event_id]/[allowNonIDS]/[from]/[to]/[last]
~~~~

<dl>
<dt>type</dt>
<dd>The attribute type, any valid MISP attribute type is accepted.</dd>
<dt>tags</dt>
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will automatically search for colons instead).</dd>
</dl>

For example, to include tag1 and tag2 but exclude tag3 you would use:

~~~~
https://<misp url>/attributes/text/download/all/tag1&&tag2&&!tag3 
~~~~

<dl>
<dt>event_id</dt>
<dd>Restrict the results to the given event IDs.</dd>
<dt> allowNonIDS</dt>
<dd>Allow attributes to be exported that are not marked as "to_ids".</dd>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m). This filter will use the published timestamp of the event.</dd>
</dl>

The keywords false or null should be used for optional empty parameters in the URL.

For example, to retrieve all attributes for event #5, including non IDS marked attributes too, use the following line:

~~~~
https://<misp url>/attributes/text/download/all/null/5/true
~~~~

## RESTful searches with XML result export

It is possible to search the database for attributes based on a list of criteria.

To return an event with all of its attributes, relations, shadowAttributes, use the following syntax:

~~~~
https://<misp url>/events/restSearch/download/[value]/[type]/[category]/[org]/[tag]/[quickfilter]/[from]/[to]/[last]
~~~~

<dl>
<dt>value</dt>
<dd>Search for the given value in the attributes' value field.</dd>
<dt>type</dt>
<dd>The attribute type, any valid MISP attribute type is accepted.</dd>
<dt>category</dt>
<dd>The attribute category, any valid MISP attribute category is accepted.</dd>
<dt>org</dt>
<dd>Search by the creator organisation by supplying the organisation idenfitier.</dd>
<dt>tags</dt>
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag
   commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will automatically search for colons instead).</dd>
</dl>

For example, to include tag1 and tag2 but exclude tag3 you would use:

~~~~
https://<misp url>/events/restSearch/download/null/null/null/null/tag1&&tag2&&!tag3
~~~~

<dl>
<dt>quickfilter</dt>
<dd>Enabling this (by passing "1" as the argument) will make the search ignore all of the other arguments, except for the auth key and value. MISP will return an xml / json (depending on the header sent) of all events that have a sub-string match on value in the event info, event orgc, or any of the attribute value1 / value2 fields, or in the attribute comment.</dd>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m). This filter will use the published timestamp of the event.</dd>
<dt>eventid</dt>
<dd>The events that should be included / excluded from the search</dd>
</dl>

The keywords false or null should be used for optional empty parameters in the URL.

For example, to find any event with the term "red october" mentioned, use the following syntax (the example is shown as a POST request instead of a GET, which is highly recommended):

POST to:

~~~~
https://<misp url>/events/restSearch/download
~~~~

POST message payload (XML):

~~~~xml
   <request><value>red october</value><searchall>1</searchall><eventid>!15</eventid></request>
~~~~

POST message payload (JSON):

~~~~json
{"request": {"value":"red october","searchall":1,"eventid":"!15"}} 
~~~~

To just return a list of attributes, use the following syntax:

<dl>
<dt>value</dt>
<dd>Search for the given value in the attributes' value field.</dd>
<dt>type</dt>
<dd>The attribute type, any valid MISP attribute type is accepted.</dd>
<dt>category</dt>
<dd>The attribute category, any valid MISP attribute category is accepted.</dd>
<dt>org</dt>
<dd>Search by the creator organisation by supplying the organisation identifier.</dd>
<dt>tags</dt>
<dd>To include a tag in the results just write its names into this parameter. To exclude a tag prepend it with a '!'. You can also chain several tag commands together with the '&&' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will automatically search for colons instead).</dd>
<dt>from</dt>
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15). This filter will use the date of the event.</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m). This filter will use the published timestamp of the event.</dd>
<dt>eventid</dt>
<dd>The events that should be included / excluded from the search</dd>
</dl>

The keywords false or null should be used for optional empty parameters in the URL.

~~~~
https://<misp url>/attributes/restSearch/download/[value]/[type]/[category]/[org]/[tag]/[from]/[to]/[last]/[eventid]
~~~~

Value, type, category and org are optional. It is possible to search for several terms in each category by joining them with the '&&' operator. It is
also possible to negate a term with the '!' operator. Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the
search will automatically search for colons instead). For example, in order to search for all attributes created by your organisation that contain
192.168 or 127.0 but not 0.1 and are of the type ip-src, excluding the events that were tagged tag1 use the following syntax:

~~~~
https://<misp url>/attributes/restSearch/download/192.168&&127.0&&!0.1/ip-src/false/CIRCL/!tag1
~~~~

You can also use search for IP addresses using CIDR. Make sure that you use '|' (pipe) instead of '/' (slashes). Please be aware the colons (:) cannot be used in the tag search. Use semicolons instead (the search will automatically search for colons instead). See below for an example:

~~~~
https://<misp url>/attributes/restSearch/download/192.168.1.1|16/ip-src/null/CIRCL 
~~~~

## Export attributes of event with specified type as XML

If you want to export all attributes of a pre-defined type that belong to an event, use the following syntax:

~~~~
https://<misp url>/attributes/returnAttributes/download/[id]/[type]/[sigOnly]
~~~~

sigOnly is an optional flag that will block all attributes from being exported that don't have the IDS flag turned on. It is possible to search for several types with the '&&' operator and to exclude values with the '!' operator. For example, to get all IDS signature attributes of type md5 and sha256, but not filename|md5 and filename|sha256 from event 25, use the following:

~~~~
https://<misp url>/attributes/returnAttributes/download/25/md5&&sha256&&!filename/true
~~~~

## Download attachment or malware sample

If you know the attribute ID of a malware-sample or an attachment, you can download it with the following syntax:

~~~~
https://<misp url>/attributes/downloadAttachment/download/[Attribute_id]
~~~~

## Download malware sample by hash

You can also download samples by knowing its MD5 hash. Simply pass the hash along as a JSON/XML object or in the URL (with the URL having overruling the passed objects) to receive a JSON/XML object back with the zipped sample base64 encoded along with some contextual information.

You can also use this API to get all samples from events that contain the passed hash. For this functionality, just pass the "allSamples" flag along.
Note that if you are getting all samples from matching events, you can use all supported hash types (md5, sha1, sha256) for the lookup.

You can also get all the samples from an event with a given event ID, by passing along the eventID parameter. Make sure that either an event ID or a hash is passed along, otherwise an error message will be returned. Also, if no hash is set, the allSamples flag will get set automatically.   

https://<misp url>/attributes/downloadSample/[hash]/[allSamples]/[eventID]

POST message payload (XML):

~~~~
<request><hash>7c12772809c1c0c3deda6103b10fdfa0</hash><allSamples>1</allSamples><eventID>13</eventID</request>
~~~~

POST message payload (json):

~~~~
{"request": {"hash": "7c12772809c1c0c3deda6103b10fdfa0", "allSamples": 1, "eventID": 13}}
~~~~

A description of all the parameters in the passed object:

<dl>
<dt>hash</dt>
<dd>A hash in MD5 format. If allSamples is set, this can be any one of the following: md5, sha1, sha256.</dd>
<dt>allSamples</dt>
<dd>If set, it will return all samples from events that have a match for the hash provided above.</dd>
<dt>eventID</dt>
<dd>If set, it will only fetch data from the given event ID.</dd>
</dl>

## Upload malware samples using the "Upload Sample" API

~~~~
https://<misp url>/events/upload_sample/[Event_id]
~~~~

This API will allow you to populate an event that you have modify rights to with malware samples (and all related hashes). Alternatively, if you do not supply an event ID, it will create a new event for you.

The files have to be base64 encoded and POSTed as explained below. All samples will be zipped and password protected (with the password being "infected"). The hashes of the original file will be captured as additional attributes.

The event ID is optional. MISP will accept either a JSON or an XML object posted to the above URL.

The general structure of the expected objects is as follows:

~~~~json
{"request": {"files": [{"filename": filename1, "data": base64encodedfile1}, {"filename": filename2, "data": base64encodedfile2}],
   "optional_parameter1", "optional_parameter2", "optional_parameter3"}} 
~~~~

JSON:

~~~~json
{"request":{"files": [{"filename": "test1.txt", "data": "dGVzdA=="}, {"filename": "test2.txt", "data": "dGVzdDI="}], "distribution": 1, "info" : "test", "event_id": 15}}
~~~~

XML:

~~~~xml
<request><files><filename>test3.txt</filename><data>dGVzdA==</data></files><files><filename>test4.txt</filename><data>dGVzdDI=</data></files><info>test</info><distribution>1</distribution><event_id>15</event_id></request>
~~~~

The following optional parameters are expected:

<dl>
<dt>event_id</dt>
<dd>The Event's ID is optional. It can be either supplied via the URL or the POSTed object, but the URL has priority if both are provided. Not supplying an event ID will cause MISP to create a single new event for all of the POSTed malware samples. You can define the default settings for the event, otherwise a set of default settings will be used.</dd>
<dt>distribution</dt>
<dd>The distribution setting used for the attributes and for the newly created event, if relevant. [0-3]</dd>
<dt>to_ids</dt>
<dd>You can flag all attributes created during the transaction to be marked as "to_ids" or not.</dd>
<dt>category</dt>
<dd>The category that will be assigned to the uploaded samples. Valid options are: Payload delivery, Artifacts dropped, Payload Installation, External Analysis.</dd>
<dt>info</dt>
<dd>Used to populate the event info field if no event ID supplied. Alternatively, if not set, MISP will simply generate a message showing that it's a malware sample collection generated on the given day.</dd>
<dt>analysis</dt>
<dd>The analysis level of the newly created event, if applicable. [0-2] threat_level_id: The threat level ID of the newly created event, if applicatble. [0-3]</dd>
<dt>comment</dt>
<dd>This will populate the comment field of any attribute created using this API.</dd>
</dl>

## Add or remove tags from events

You can add or remove an existing tag from an event in the following way:

~~~~
https://<misp url>/events/addTag
https://<misp url>/events/removeTag
~~~~

Just POST a JSON object in the following format (to the appropriate API depending on whether you want to add or delete a tag from an event):

~~~~json
{"request": {"Event": {"id": "228", "tag": "8"}}}
~~~~

Where "tag" is the ID of the tag. You can also use the name of the tag the following way (has to be an exact match):

~~~~json
{"request": {"Event": {"id": "228", "tag": "OSINT"}}}
~~~~

## Proposals API

You can interact with the proposals via the API directly since version 2.3.148.

|HTTP|URL|Explanation|Expected Payload|Response|
|----|---|-----------|----------------|--------|
|GET|/shadow_attributes/view/[proposal_id]|View a proposal|N/A|ShadowAttribute object|
|POST|/shadow_attributes/add/[event_id]|Propose a new attribute to an event|ShadowAttribute object|ShadowAttribute object|
|POST|/shadow_attributes/edit/[attribute_id]|Propose an edit to an attribute|ShadowAttribute object|ShadowAttribute object|
|POST|/shadow_attributes/accept/[proposal_id]|Accept a proposal|N/A|Message|
|POST|/shadow_attributes/discard/[proposal_id]|Discard a proposal|N/A|Message|

When posting a shadow attribute object, use the following format

JSON:

~~~~json
{"request": {"ShadowAttribute": {"value": "5.5.5.5", "to_ids": false, "type": "ip-dst", "category": "Network activity"}}}
~~~~

XML:

~~~~xml
<request><ShadowAttribute><value>5.5.5.5</value><to_ids>0</to_ids><type>ip-src</type><category>Network activity</category></ShadowAttribute></request>
~~~~

None of the above fields are mandatory, but at least one of them has to be provided.

## Sightings API

MISP allows Sightings data to be conveyed in several ways. 

The most basic way is to POST a blank message to the Sightings API with the attribute ID or attribute UUID. This will create a sightings entry with the creation of the entry as the timestamp for the organisation of the authenticated user.

~~~~
https://<misp url>/sightings/add/[attribute_id]
https://<misp url>/sightings/add/[attribute_uuid]
~~~~

Alternatively, it is possible to POST a JSON object and gain additional granularity. The following fields are recognised by the API:

<dl>
<dt>id</dt>
<dd>The attribute's ID</dd>
<dt>uuid</dt>
<dd>The attribute's UUID</dd>
<dt>value</dt>
<dd>Will create a sighting for any attribute with the given value or for composite attributes, for the value matching any element of the attribute value</dd>
<dt>values</dt>
<dd>Expects a list, MISP will create sightings for any attribute matching any of the given values or for composite attributes, for any of the values matching any element of the attribute value</dd>
<dt>timestamp</dt>
<dd>Unix timestamp of the sighting, overrides the current time</dd>
</dl>

Some examples:

To create a sighting for attribute #9001:

~~~~json
{"id":"9001"}
~~~~

To create a sighting for any attribute with the value being teamliquid.net or 173.231.136.216 with the time of sighting being :

~~~~json
{"values":["teamliquid.net", "173.231.136.216"], "timestamp":1460558710}
~~~~

It is also possible to POST a STIX indicator with sighting data to the following URL (keep in mind that the content type has to be XML):

~~~~
https://<misp url>/sightings/add/stix
~~~~

MISP will use the sighting's related observables to gather all values and create sightings for each attribute that matches any of the values. If no related observables are provided in the Sighting object, then MISP will fall back to the Indicator itself and use its observables' values to create the sightings. The time of the sighting is the current time, unless the timestamp attribute is set on the Sightings object, in which case that is taken.

An example STIX sightings document:

~~~~xml
<stix:STIX_Package
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:stix="http://stix.mitre.org/stix-1"
    xmlns:indicator="http://stix.mitre.org/Indicator-2"
    xmlns:stixCommon="http://stix.mitre.org/common-1"
    xmlns:cybox="http://cybox.mitre.org/cybox-2"
    xmlns:AddressObject="http://cybox.mitre.org/objects#AddressObject-2"
    xmlns:DomainNameObj="http://cybox.mitre.org/objects#DomainNameObject-1"
    xmlns:cyboxVocabs="http://cybox.mitre.org/default_vocabularies-2"
    xmlns:stixVocabs="http://stix.mitre.org/default_vocabularies-1"
    xmlns:example="http://example.com/"
    xsi:schemaLocation="
    http://stix.mitre.org/stix-1 ../stix_core.xsd
    http://stix.mitre.org/Indicator-2 ../indicator.xsd
    http://cybox.mitre.org/objects#DomainNameObject-1 http://cybox.mitre.org/XMLSchema/objects/Domain_Name/1.0/Domain_Name_Object.xsd
    http://stix.mitre.org/common-1 http://stix.mitre.org/XMLSchema/common/1.1.1/stix_common.xsd
    http://cybox.mitre.org/default_vocabularies-2 ../cybox/cybox_default_vocabularies.xsd
    http://stix.mitre.org/default_vocabularies-1 ../stix_default_vocabularies.xsd
    http://cybox.mitre.org/objects#AddressObject-2 ../cybox/objects/Address_Object.xsd"
    id="example:STIXPackage-33fe3b22-0201-47cf-85d0-97c02164528d"
    timestamp="2014-05-08T09:00:00.000000Z"
    version="1.1.1"
    >
    <stix:STIX_Header>
        <stix:Title>Example watchlist that contains IP information.</stix:Title>
        <stix:Package_Intent xsi:type="stixVocabs:PackageIntentVocab-1.0">Indicators - Watchlist</stix:Package_Intent>
    </stix:STIX_Header>
    <stix:Indicators>
        <stix:Indicator xsi:type="indicator:IndicatorType" id="example:Indicator-2e20c5b2-56fa-46cd-9662-8f199c69d2c9" timestamp="2014-05-08T09:00:00.000000Z">
          <indicator:Type xsi:type="stixVocabs:IndicatorTypeVocab-1.1">Domain Watchlist</indicator:Type>
          <indicator:Observable id="example:Observable-87c9a5bb-d005-4b3e-8081-99f720fad62b">
              <cybox:Object id="example:Object-12c760ba-cd2c-4f5d-a37d-18212eac7928">
                  <cybox:Properties xsi:type="DomainNameObj:DomainNameObjectType" type="FQDN">
                      <DomainNameObj:Value condition="Equals" apply_condition="ANY">malicious1.example.com##comma##malicious2.example.com##comma##malicious3.example.com</DomainNameObj:Value>
                  </cybox:Properties>
              </cybox:Object>
          </indicator:Observable>
          <indicator:Sightings>
            <indicator:Sighting timestamp="2014-05-08T09:00:00.000000Z">
              <indicator:Source>
                <stixCommon:Identity>
                  <stixCommon:Name>FooBar Inc.</stixCommon:Name>
                </stixCommon:Identity>
              </indicator:Source>
              <indicator:Related_Observables>
                <indicator:Related_Observable>
                  <stixCommon:Observable id="example:Observable-45b3acdf-1888-4bcc-89a9-6d9f8116fede">
                    <cybox:Object id="example:Object-a3d36250-42fa-4653-9172-87b87598390c">
                      <cybox:Properties xsi:type="DomainNameObj:DomainNameObjectType" type="FQDN">
                        <DomainNameObj:Value>malicious2.example.com</DomainNameObj:Value>
                      </cybox:Properties>
                    </cybox:Object>
                  </stixCommon:Observable>
                </indicator:Related_Observable>
              </indicator:Related_Observables>
            </indicator:Sighting>
          </indicator:Sightings>
        </stix:Indicator>
    </stix:Indicators>
</stix:STIX_Package>
~~~~

POSTing this as the message's body to MISP will sight any attributes visible to the user with he value "malicious2.example.com". For composite types, a match on a component will also trigger a sighting (so for example for attributes of type domain|ip a domain match would be sufficient).

If no Related observables are set in the Sighting itself, MISP will fall back to the observable directly contained in the indicator. So in the following example:

~~~~xml
<stix:STIX_Package
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:stix="http://stix.mitre.org/stix-1"
    xmlns:indicator="http://stix.mitre.org/Indicator-2"
    xmlns:stixCommon="http://stix.mitre.org/common-1"
    xmlns:cybox="http://cybox.mitre.org/cybox-2"
    xmlns:AddressObject="http://cybox.mitre.org/objects#AddressObject-2"
    xmlns:DomainNameObj="http://cybox.mitre.org/objects#DomainNameObject-1"
    xmlns:cyboxVocabs="http://cybox.mitre.org/default_vocabularies-2"
    xmlns:stixVocabs="http://stix.mitre.org/default_vocabularies-1"
    xmlns:example="http://example.com/"
    xsi:schemaLocation="
    http://stix.mitre.org/stix-1 ../stix_core.xsd
    http://stix.mitre.org/Indicator-2 ../indicator.xsd
    http://cybox.mitre.org/objects#DomainNameObject-1 http://cybox.mitre.org/XMLSchema/objects/Domain_Name/1.0/Domain_Name_Object.xsd
    http://stix.mitre.org/common-1 http://stix.mitre.org/XMLSchema/common/1.1.1/stix_common.xsd
    http://cybox.mitre.org/default_vocabularies-2 ../cybox/cybox_default_vocabularies.xsd
    http://stix.mitre.org/default_vocabularies-1 ../stix_default_vocabularies.xsd
    http://cybox.mitre.org/objects#AddressObject-2 ../cybox/objects/Address_Object.xsd"
    id="example:STIXPackage-33fe3b22-0201-47cf-85d0-97c02164528d"
    timestamp="2014-05-08T09:00:00.000000Z"
    version="1.1.1"
    >
    <stix:STIX_Header>
        <stix:Title>Example watchlist that contains IP information.</stix:Title>
        <stix:Package_Intent xsi:type="stixVocabs:PackageIntentVocab-1.0">Indicators - Watchlist</stix:Package_Intent>
    </stix:STIX_Header>
    <stix:Indicators>
        <stix:Indicator xsi:type="indicator:IndicatorType" id="example:Indicator-2e20c5b2-56fa-46cd-9662-8f199c69d2c9" timestamp="2014-05-08T09:00:00.000000Z">
          <indicator:Type xsi:type="stixVocabs:IndicatorTypeVocab-1.1">Domain Watchlist</indicator:Type>
          <indicator:Observable id="example:Observable-87c9a5bb-d005-4b3e-8081-99f720fad62b">
              <cybox:Object id="example:Object-12c760ba-cd2c-4f5d-a37d-18212eac7928">
                  <cybox:Properties xsi:type="DomainNameObj:DomainNameObjectType" type="FQDN">
                      <DomainNameObj:Value condition="Equals" apply_condition="ANY">malicious1.example.com##comma##malicious2.example.com##comma##malicious3.example.com</DomainNameObj:Value>
                  </cybox:Properties>
              </cybox:Object>
          </indicator:Observable>
          <indicator:Sightings>
            <indicator:Sighting timestamp="2014-05-08T09:00:00.000000Z">
              <indicator:Source>
                <stixCommon:Identity>
                  <stixCommon:Name>FooBar Inc.</stixCommon:Name>
                </stixCommon:Identity>
              </indicator:Source>
            </indicator:Sighting>
          </indicator:Sightings>
        </stix:Indicator>
    </stix:Indicators>
</stix:STIX_Package>
~~~~

MISP would create sightings for attributes matching any of the following: malicious1.example.com, malicious2.example.com, malicious3.example.com

# Describe types API

MISP can procedurally describe all attribute types and attribute categories it currently supports including the category - type mappings. To access this information simply send a GET request to:

~~~~
https://<misp url>/attributes/describeTypes
~~~~

Depending on the headers passed the returned data will be a JSON object or an XML, with 3 main sections: types, categories, category\_type\_mappings.

# Attribute statistics API

If you are interested in the attribute type or attribute category data distribution on your instance, MISP offers an API that will create an aggregates list. To access the API, simple sent a GET request to:

~~~~
https://<misp url>/attributes/attributeStatistics/[context]/[percentage]
~~~~

Where the following parameters can be set:

<dl>
<dt>Context</dt>
<dd>Set whether you are interested in the type or category statistics of your instance. This parameter can be either set to "type" or "category", with type being the default setting if the parameter is not set.</dd>
<dt>Percentage</dt>
<dd>An optional field, if set, it will return the results in percentages instead of the count.</dd>
</dl>

The results are always returned as JSON.

Sample output of the types in percentages from CIRCL's MISP instance:

~~~~json
{
    "AS": "0.015%",
    "attachment": "0.177%",
    "btc": "0.005%",
    "campaign-name": "0.005%",
    "comment": "1.47%",
    "domain": "15.992%",
    "domain|ip": "0.005%",
    "email-attachment": "0.207%",
    "email-dst": "0.121%",
    "email-src": "0.192%",
    "email-subject": "0.146%",
    "filename": "3.698%",
    "filename|md5": "0.349%",
    "filename|sha1": "0.894%",
    "filename|sha256": "0.652%",
    "hostname": "17.558%",
    "http-method": "0.045%",
    "ip-dst": "7.087%",
    "ip-src": "2.707%",
    "link": "5.748%",
    "malware-sample": "0.702%",
    "malware-type": "0.005%",
    "md5": "21.064%",
    "mutex": "0.278%",
    "named pipe": "0.03%",
    "other": "1.495%",
    "pattern-in-file": "0.192%",
    "pattern-in-memory": "0.303%",
    "pattern-in-traffic": "0.051%",
    "regkey": "0.126%",
    "regkey|value": "0.187%",
    "sha1": "8.921%",
    "sha256": "5.597%",
    "snort": "0.045%",
    "target-machine": "0.248%",
    "target-org": "0.01%",
    "target-user": "0.106%",
    "text": "0.934%",
    "threat-actor": "0.005%",
    "url": "2.258%",
    "user-agent": "0.081%",
    "vulnerability": "0.182%",
    "whois-registrant-email": "0.01%",
    "x509-fingerprint-sha1": "0.01%",
    "yara": "0.086%"
}
~~~~

# Automation using PyMISP

PyMISP is a Python library to access MISP platforms via their REST API.

PyMISP allows you to fetch events, add or update events/attributes, add or update samples or search for attributes.

[PyMISP is available](https://github.com/MISP/PyMISP) including a documentation with various examples.


