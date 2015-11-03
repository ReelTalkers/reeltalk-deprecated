module ReelTalk.Mailboxes (Addresses, Signals, addresses, signals) where

import Signal exposing (Mailbox, Address, mailbox)
import Signal

type alias Addresses =
  {
    newReview : Address (),
    requestUser : Address (),
    requestColorScheme : Address String
  }

addresses : Addresses
addresses =
  {
    newReview = newReview.address,
    requestUser = requestUser.address,
    requestColorScheme = requestColorScheme.address
  }

type alias Signals =
  {
    newReview : Signal (),
    requestUser : Signal (),
    requestColorScheme : Signal String
  }


signals : Signals
signals =
  {
    newReview = newReview.signal,
    requestUser = requestUser.signal,
    requestColorScheme = requestColorScheme.signal
  }


newReview : Signal.Mailbox ()
newReview =
  Signal.mailbox ()

requestUser : Signal.Mailbox  ()
requestUser =
  Signal.mailbox ()

requestColorScheme : Signal.Mailbox String
requestColorScheme =
  Signal.mailbox ""
