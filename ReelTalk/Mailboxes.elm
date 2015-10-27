module ReelTalk.Mailboxes (Addresses, Signals, addresses, signals) where

import Signal exposing (Mailbox, Address, mailbox)
import Signal

type alias Addresses =
  {
    newReview : Address (),
    requestUser : Address ()
  }

addresses : Addresses
addresses =
  {
    newReview = newReview.address,
    requestUser = requestUser.address
  }

type alias Signals =
  {
    newReview : Signal (),
    requestUser : Signal ()
  }


signals : Signals
signals =
  {
    newReview = newReview.signal,
    requestUser = requestUser.signal
  }


newReview : Signal.Mailbox ()
newReview =
  Signal.mailbox ()

requestUser : Signal.Mailbox  ()
requestUser =
  Signal.mailbox ()
