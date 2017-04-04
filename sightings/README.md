<!-- toc -->

## Sightings

Basically, sighting is a system allowing people to react on attributes on an event. It was originally designed to provide an easy method for user to tell when they see a given attribute, giving it more credibility.

Now sightings have been improved to also provide a method to signal false positives, but also to give an expiration date for some attributes.

### Explanations

As said before, Sighting is a way for a user to say that they have seen or notice an attribute and confirm its validity. An attribute can been spotted several times by the same user, that is why a single user can use sighting several times on a single attribute.

Sometimes, some attributes can be considered as false positives, even if the false positive list do not detect them (for instance, if the IDS flag is set to false) so they can also be notified. As well as concerning sighting, the same user can signal a single attribute as a false positive several times.

It also happens that some attributes are only valid a certain time (for instance, in case of a phishing campagn that is assumed to be up for only one week). In this case, people can also assign an expiration date to an attribute, but this time, there can be only one valid expiration date per *organisation*.

### Using sightings on an event (GUI)

Sighting is applied to every attribute, under the column "Sightings", easily identifiable with its colored number. This column shows three icons and three values.

![attribute](./figures/attributesighting.png)

These three values show respectively:
- The number of sighting on the attribute, in green.
- The number of times the attribute have been marked as false positive, in red.
- The number of different expiration dates that have been affected on this attribute, in orange

Concerning the three icons:
- The first one (Thumb up) allow to add a sighting on an attribute.
- The second one (Thumb down) WIPWIPWIPWIPWIPWIPWIPWIPWIP
