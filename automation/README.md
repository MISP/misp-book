<!-- toc -->

##  Automation

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
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15)</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)</dd>
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
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15)</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)</dd>
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
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15)</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 6d or 12h or 30m)</dd>
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
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15)</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)</dd>
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
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15)</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)</dd>
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
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15)</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)</dd>
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
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15)</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)</dd>
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
<dd>Events with the date set to a date after the one specified in the from field (format: 2015-02-15)</dd>
<dt>to</dt>
<dd>Events with the date set to a date before the one specified in the to field (format: 2015-02-15)</dd>
<dt>last</dt>
<dd>Events published within the last x amount of time, where x can be defined in days, hours, minutes (for example 5d or 12h or 30m)</dd>
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

