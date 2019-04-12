## PyMISP - Python Library to access MISP

PyMISP is a Python library to access MISP platforms via their REST API.

PyMISP allows you to fetch events, add or update events/attributes, add or update samples or search for attributes.

Note that you need to have Auth Key access in your MISP instance to use PyMISP

### Capabilities

* Add, get, update, publish, delete events
* Add or remove tags
* Add file attributes:  hashes, registry key, patterns, pipe, mutex
* Add network attributes:  IP dest/src, hostname, domain, url, UA, ...
* Add Email attributes:  source, destination, subject, attachment, ...
* Upload/download samples
* Update sightings
* Proposals:  add, edit, accept, discard
* Full text search and search by attributes
* Get STIX event
* Export statistics
And even more, just look at the api.py file

### Installation

You can install PyMISP by either using pip or by getting the last version from the [GitHub repository](https://github.com/MISP/PyMISP)

#### Install from pip
~~~~
pip install pymisp
~~~~

#### Install the latest version from the repository
~~~~
git clone https://github.com/MISP/PyMISP.git && cd PyMISP
python setup.py install
~~~~

Note that you will also need to install [requests](http://docs.python-requests.org/) if you don't have it already.

### Getting started

You now need to get your automation key. You can find it on the automation page:

~~~~
https://<misp url>/events/automation
~~~~

or on your profile

~~~~
https://<misp url>/users/view/me
~~~~

If you did not install using the repository, you can still fetch it to get examples to work on:
~~~~
git clone https://github.com/MISP/PyMISP.git
~~~~

In order to use these, you need to create a file named keys.py in the examples folder and edit it to put the url of your MISP instance and your automation key.
~~~~
cd examples
cp keys.py.sample keys.py
vim keys.py
~~~~

Once you are done with it, you are ready to start.

This is how **keys.py** looks:

{% codesnippet "/pymisp/keys.py", language="python" %}{% endcodesnippet %}

### Using PyMISP

To have a better understanding of how to use PyMISP, we will have a look at one of the existing examples: add\_named\_attribute.py
This script allow us to add an attribute to an existing event while knowing only its type (the category is determined by default).
~~~~python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pymisp import PyMISP
from keys import misp_url, misp_key
import argparse
~~~~
First of all, it is obvious that we need to import PyMISP.
Then we also need to know both the instance with which we will work and the API key to use: Both should be stored in the keys.py file.
Finally we import argparse library so the script can handle arguments.
~~~~python
# For python2 & 3 compat, a bit dirty, but it seems to be the least bad one
try:
    input = raw_input
except NameError:
    pass
~~~~
Just a few lines to be sure that python 2 and 3 are supported
~~~~python
def init(url, key):
    return PyMISP(url, key, True, 'json', debug=True)
~~~~
This function will create a PyMISP object that will be used later to interact with the MISP instance.
As seen in the [api.py](https://github.com/CIRCL/PyMISP/blob/master/pymisp/api.py#L85), a PyMISP object need to know both the URL of the MISP instance and the API key to use. It can also take additional and not mandatory data, such as the use or not of SSL or the name of the export format.
~~~~python
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Create an event on MISP.')
    parser.add_argument("-e", "--event", type=int, help="The id of the event to update.")
    parser.add_argument("-t", "--type", help="The type of the added attribute")
    parser.add_argument("-v", "--value", help="The value of the attribute")
    args = parser.parse_args()
~~~~
Then the function starts by preparing the awaited arguments:
* event: The event that will get a new attribute
* type: The type of the attribute that will be added. See [here](../categories-and-types/README.md) for more information
* value: The value of the new attribute
~~~~python
    misp = init(misp_url, misp_key)
~~~~
Thanks to the previously created function, we create a PyMISP object.
~~~~python
    event = misp.get_event(args.event)
    event = misp.add_named_attribute(event, args.type, args.value)
~~~~
In order to add the new argument, we first need to fetch the event in the MISP database using the [get\_event](https://github.com/CIRCL/PyMISP/blob/master/pymisp/api.py#L223) function which only need the event\_id. Then only once we have it, we can call the function [add\_named\_attribute](https://github.com/CIRCL/PyMISP/blob/master/pymisp/api.py#L372) that will add the argument.
~~~~python
	print(event)
~~~~
Finally the new event is printed, so we can check that the attribute was correctly added, and that a category was attached to it automatically.

### Existing examples

As the name implies you will find several example scripts in the examples folder. For each you can get help if you do `scriptname.py -h`

Let us have a look at some of these examples:

#### add_named_attribute.py

Allow to add an argument to an existing event by giving only the type of the attribute. The category will be set with a default value.

Arguments:
* **event**: The id of the event to update.
* **type**: The type of the added attribute.
* **value**: The value of the attribute.

#### add_user.py

Allow to add a user by giving the mandatory fields as entries.

Arguments:
* **email**: Email linked to the account.
* **org_id**: Organisation linked to the user.
* **role_id**: Role linked to the user.

#### add_user_json.py

Add the user described in the given json. If no file is provided, returns a json listing all the fields used to describe a user.

Arguments:
* **json_file**: The name of the json file describing the user you want to create.

#### create_events.py

Allow a user to create a new event on the MISP instance.

Arguments:
* **distrib**: The distribution setting used for the attributes and for the newly created event, if relevant. [0-3].
* **info**: Used to populate the event info field if no event ID supplied.
* **analysis**: The analysis level of the newly created event, if applicable. [0-2]
* **threat**: The threat level ID of the newly created event, if applicable. [1-4]

#### del.py

Delete an event or an attribute from a MISP instance. The event has the priority: if both are set, only the event will be deleted.

Arguments:
* **event**: Event ID to delete.
* **attribute**: Attribute ID to delete.

#### delete_user.py

Delete the user with the given id. Keep in mind that disabling users (by setting the disabled flag via an edit) is always preferred to keep user associations to events intact.

Arguments:
* **user_id**: The id of the user you want to delete.

#### edit_user.py

Edit the email of the user designed by the user_id.

Arguments:
* **user_id**: The name of the json file describing the user you want to modify.
* **email**: Email linked to the account.

#### edit_user_json.py

Edit the user designed by the user_id. If no file is provided, returns a json listing all the fields used to describe a user.

Arguments:
* **user_id**: The name of the json file describing the user you want to modify.
* **json_file**: The name of the json file describing your modifications.

#### get.py

Get an event from a MISP instance in json format.

Arguments:
* **event**: Event ID to get.
* **output**: Output file

#### last.py

Download latest events from a MISP instance. A output file can be created to store these events.

Arguments:
* **last**: can be defined in days, hours, minutes (for example 5d or 12h or 30m).
* **output**: Output file

#### searchall.py

Get all the events matching a value.

Arguments:
* **search**: String to search.
* **quiet**: Only display URLs to MISP
* **output**: Output file

#### sharing_groups.py

Get a list of the sharing groups from the MISP instance.
No argument.

#### sighting.py

Add sighting.

Arguments:
* **json_file**: The name of the json file describing the attribute you want to add sighting to.

#### stats.py

Output attributes statistics from a MISP instance.
No argument.

#### suricata.py

Download Suricata events.

Arguments:
* **all**: Download all suricata rules available.
* **event**: Download suricata rules from one event.

#### tags.py

Get tags from MISP instance.
No argument.

#### tagstatistics.py

Get statistics from tags.

Arguments:
* **percentage**: An optional field, if set, it will return the results in percentages, otherwise it returns exact count.
* **namesort**: An optional field, if set, values are sort by the namespace, otherwise the sorting will happen on the value.

#### up.py

Update an existing event regarding the data inside a given json file.

Arguments:
* **event**: Event ID to modify.
* **input**: Input file

#### upload.py

Send malware sample to MISP.

Arguments:
* **upload**: File or directory of files to upload.
* **event**: Not supplying an event ID will cause MISP to create a single new event for all of the POSTed malware samples.
* **distrib**: The distribution setting used for the attributes and for the newly created event, if relevant. [0-3].
* **ids**: You can flag all attributes created during the transaction to be marked as \"to_ids\" or not.
* **categ**: The category that will be assigned to the uploaded samples. Valid options are: Payload delivery, Artefacts dropped, Payload Installation, External Analysis.
* **info**: Used to populate the event info field if no event ID supplied.
* **analysis**: The analysis level of the newly created event, if applicable. [0-2]
* **threat**: The threat level ID of the newly created event, if applicable. [1-4]
* **comment**: Comment for the uploaded file(s).

#### users_list.py

Get a list of the sharing groups from the MISP instance.
No argument.

### Going further

#### feed-generator

It is used to generate the CIRCL OSINT feed. This script export the events as json, based on tags, organisation, events, ...
It automatically update the dumps and the metadata file.

Here is an example of a config file:
~~~~
url = ''
key = ''
ssl = True
outputdir = 'output'
# filters = {'tag' : 'tlp : white|feed-export|!privint', 'org':'CIRCL'}
filters = {}

valid_attribute_distribution_levels = ['0', '1', '2', '3', '4', '5']

~~~~

#### Consuming feed

As the feed is a simple set of MISP json files, the files can be easily imported
directly into any MISP instance. The script below processes the manifest file of an OSINT
feed and reimport them in a MISP directly.

~~~~python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pymisp import PyMISP
import requests

url = 'https://www.circl.lu/doc/misp/feed-osint/'
osintcircl = requests.get('{}manifest.json'.format(url))

misp = PyMISP('http://misp.test/', 'key', False, 'json')
for uri in osintcircl.json():
        req = requests.get('{}{}.json'.format(url,uri))
        misp.add_event(req.json())
~~~~

#### ioc-2-misp

Allow to import OpenIOC files into MISP easily. It is also possible to set specific tags on these events.

#### Situational Awareness

* attribute_treemap.py generate a tree-map showing the distribution of the attributes on the MISP instance.
* tags_* : these functions help having statistics and graphs about the tag repartition.

#### Simple example on fetching the last events

{% codesnippet "/pymisp/last.py", language="python" %}{% endcodesnippet %}

