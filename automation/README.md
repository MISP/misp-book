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

