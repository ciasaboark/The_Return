#The Return

by Jonathan Nelson

## Introduction
The return is a text based adventure game set in the 1920s.  The unnamed protagonist awakes within a house with no memory of who or where he is.  Soon after awakening the player will discover that the front door of the house has been barricaded.  Using commands the player can guide the protagonist through the house, exploring the rooms and the items within.  In order to complete the game, the player must find a way to open the front door and escape.  Completing the game, however, is not the same as winning.  Further exploration will review hidden passages and items, and allow the player to unravel the story of how our protagonist came to the house, as well as who he is, or, at least, who he used to be.  The story is loosely based of “The Outsider” by H.P. Lovecraft.


## Game Interaction
The player interacts with the game entirely though text commands.  The commands available include
* help – prints a list of possible commands
* go <direction> –  where <direction> is one of north, south, east, west, up, or down.
* back – to move backwards one room
* look – to get a description of the current room and any known items
* look <item> – to get a description of a specific item in the room or the players inventory
* take <item> – to try to take an item with you
* drop <item> – to drop an item into the current room
* inventory – to see a list of all the items the player is carrying
* use <item> – to try to use an item
* sleep – to sleep for a bit
* a hidden command – ?

## Extensions
In addition to the project requirements the game has been extended with the following features
* The player has the ability to use items.  Whether or not an item can be used is based on the player's current room.  Some items are removed from the players inventory after use, while others can be used repeatedly.  The use of items varies.  Some items open room connections, while others are only used to expand the atmosphere of the game (such as the musicbox).
* The player begins the game in a semi-random room.  This is selected from a list of possible starting rooms returned by Game:createWorld.  The player stores this list for use with the sleep command.
* The sleep command acts as a teleporter, placing the player in a semi-random room upon waking.  The room selection is semi-random to keep the player from waking in a room that they might not have discovered.  The sleep command also erases the players movement history, so that the back command will not work when first waking.
* The player can gather points as they explore.  These points are assigned to items within the game that hold significance to the back-story.  When the player looks at an item in the game that item's points (if any) are transferred to the points property as a running tally calculated as (1 +  (items points ^1/4)).  This effectively clamps the value for any given item to a range of 2 – 26, preventing any one item from having too much weight, while still allowing items to be prioritized by importance.
* The game can check whether or not the player has view any specific item through the Player:hasViewed method.  To enable the game to check which specific items the player has viewed the item points are distributed as unique base2 powers (1, 2, 4, 8, 16...).   When the player looks at an item these points are added to the players flags property.  
* A sound server was created to give the game additional depth.  The sound server is implemented as a singleton, and is interacted with solely through notifications.  After creation the sound server begins playing a background track, and listens for notifications that the player has changed rooms, or that an item has been picked up, dropped, or used.  The sound server then determines the appropriate action for each notification, changing the ambient sound, or playing a one-time sound effect.
* Rooms descriptions are generated dynamically.  When the player uses the look command a description is built from the room description plus all first-level objects in the room (see below for object nesting).  This generated description takes the form of a full paragraph of text, forcing the player to read through for references to room exits and items.  If the player removes an object from the room the description of the room will change accordingly.
* Items can be used as a container for other items.  In general the game only uses this relationship one level deep (the item closet may contain the item coat), but there is no limit to the depth of the nesting.   If the player looks at the closet then a description of the closet plus any second level items is given.  This also causes those items to be moved from the closet to the current room, so that a subsequent look will list the room description, plus the description of the closet, plus the description of the coat.  This was done to make it easier for the player to keep track of what items they have discovered in each room.
* The game contains multiple endings based on the number of points the player has collected.  If the total points is below a certain threshold then a generic ending is given.  If the player has uncovered all of the back story then a full ending is given. If the players points fall in-between, then an ending is generated based on whether or not the player has viewed certain items.
* The game as a small number of hidden items placed in the rooms.  These items are not required for game completion and (most) do not count towards the players points.  Unlike most items, which have their names capitalized, these items are referenced in lowercase, and may only be referenced vaguely.
