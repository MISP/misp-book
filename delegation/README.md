# Delegation

In information sharing, privacy of the reporting organisation can be important in such case as:

- an incident doesn't want to be linked to a potential victim.
- to avoid the relation of an organisation with the information shared.

MISP has a functionality to delegate the publication and completely remove the binding between the information shared and its organisation. If you want to publish an event without you or your organisation being tied to it, you can delegate the publication to an other organisation. That also means they will take the ownership of the event.

> [warning] You need to have a role with "Delegation access" to delegate an event.
> 
> [warning] Also activate MISP.delegation parameter in your instance.

### Send a delegation request

To do so, you first need to put the distribution of the event as "your organisation only".  
![Delegation possible](./figures/delegationpossible.png)  
Otherwise the delegation option will not be available.  
![Delegation impossible](./figures/delegationimpossible.png)  

When the "Delegate Publishing" option is clicked, a pop-up will show up:  
![Delegation Popup](./figures/delagationpopup.png)  
Here you can choose 
- to which organisation you wish to delegate the event among all those registered on the server. For this example we are going to ask Setec Astronomy to publish the event for us.
- The distribution option you would like to put on the event. You can let the other organisation (called "recipient") choose if you don't mind it. For this example, we will request the recipient to share it to all communities, but it is only a suggestion, and the recipient will be able to modify the diffusion setting if wanted.  
![Desired Distribution](./figures/desireddistribution.png)  
- Finally you can leave a free message to the recipient organisation.
![Distribution ready](./figures/delegationpopup2.png)  

Once the request is sent, a message will appear on the event to remind you of your request.
![Reminder](./figures/delegationrequested.png)  
You can also see more details by clicking on "View request details"  
![Request Details](./figures/requestdetails.png)  
And you can also discard the request your self, by using this pop-up or the link in the left menu.

### Answer a delegation request

As the recipient organisation, you will then receive the request of delegation. You will be notified by a red circle around the envelope on the top right of the screen.  
![Notification](./figures/delegationwaiting.png)  
When you click it, you will be redirected as usual on the dashboard, where we can see one delegation request on the left frame.  
![Dashboard](./figures/dashboard.png)  
Clicking on the "view" link then redirect to an event list view showing all the events other organisations wish to delegate to your organisation. Here we only see one event, from Acme Factory.
![Delegated list](./figures/delagated.png)  
And here are the metadata of the so called event.  
![Delegated event](./figures/delegatedevent.png)  
You will be able to view the details by clicking the so called link.  
![Delegated event](./figures/recipientdetails.png)  
If your role have publishing rights, you will be able to manage the delegation request by using one of the two links in the left menu.  
You can either discard it:  
![Discard request](./figures/discarddelegation.png)  
Or accept the delegation:  
![Accept request](./figures/acceptdelegation.png)  
Please notice that the distribution desired by the requester will not automatically be set on the event, which will stay as distributed to your own organisation only if the parameter is not modified.
