# Surveyor


## What does Surveyor want to be?

Surveyor is a tool to collect citizen feedback through text messages. It will allow users to engage with government by texting keywords, sending photos, and voting in polls.

The data collected in Surveyor will be synced with DGRI's CRM, Nationbuilder.

## Features
*Consult the [issues page](https://github.com/downtowngr/surveyor/issues) for feature prioritization*

### Voting
* An administrator can create an event-based poll.
* A poll can have an unlimited number of responses, each represented by a keyword.
* A phone number can vote for more than one keyword in a poll, but cannot vote for the same keyword more than once.
* A poll can have an open and closing time when votes are allowed.
* Follow up question can be made

### Administration
* Dashboard of all active keywords and hashtags.
* Ability to respond to feedback texts.
* Ability to send follow up questions to polls, check-ins, and feedback.
* Archive of all texts received by every number.

### Check-in
* Keywords can function as a check-in to an event.
* User check-ins are tracked.

### Feedback
* A user can text in a keyword (or perhaps hashtag?) with other information. 
* An administrator can set a follow up question to a keyword.

### Suggestion Line
* Ask for restaurant recommendations, event recommendations, etc.

## Considerations

The keyword and hashtags share a phone number's namespace. There will need to be a way to view all keywords within this namespace.

User data will be synced with Nationbuilder

## Prerequisites

* Postgres
* Twilio (API)
* Nationbuilder (API)

# License

The MIT License (MIT)
Copyright © 2014 Downtown Grand Rapids Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
