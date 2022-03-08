# Project Requirements

## General

- [x] All resources should be unit tested.

- [x] Methods should not have more than 5 lines, unless necessary for a reason that you can defend. If you need more lines, create a private method for each piece of additional logic that doesn't fit within the 5-line limit.

- [x] Methods should not have more than four arguments. Values in an options hash each count as one argument toward the four-argument total.

## Users

- [x] The app will have user accounts with password-protected logins. Please use the Devise gem to manage these accounts.

- [x] All user accounts should be email verified.

- [x] Passwords must be stored encrypted in the database.

- [x] Password and login forms must use type="password" inputs

- [x] User accounts have three levels of permissions. You can use either the CanCanCan gem or the Pundit gem to manage permissions.

- [x] Site admins have access to the admin section of the site and all other pages/resources.

- [x] Regular users have access to view events but cannot manage an event they haven't created, and can't view admin pages.

- [x] Event creators have regular user permissions, plus the ability to manage events they created. They are actually just regular users who have created an event.

## Events

##### Events should have the following fields and associated resources :

- [x] a creator_id specifying the User record that created the event.

- [x] a location from ~~Mapzen's~~ Mapbox's location API.

- [x] an event time, stored as a datetime object.

- [x] a description field written by the event creator, stored as a text value.

- [x] Event pages should display the event's time, its description, a list of people who have RSVPed, a map showing the location of the event (generated using ~~tangram.js and the Mapzen API~~ Mapbox API), and an RSVP button.

- [x] For the event's creator, it should also show an edit button.

## RSVPs

- [x] Any user should be able to RSVP to an event by clicking on an RSVP button on an event page while logged in.

- [ ] Clicking on an RSVP button while not logged in should redirect the user to the login page, then create the RSVP if the login was successful, and redirect back to the event page after that.

- [x] When an RSVP is created, the event creator should be notified.

- [x] Email notifications should be sent to all users who RSVPed to an event, one day before the event takes place.

## Test RSVPs

- [x] Write a set of unit and controller tests that test the RSVP functionality, to prove that it does what's described above.
