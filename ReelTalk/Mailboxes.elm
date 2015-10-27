module ReelTalk.Mailboxes (Addresses, Signals, addresses, signals) where

import Signal exposing (Mailbox, Address, mailbox)
import Signal

type alias Addresses =
  {
    newReview : Address ()
  }

addresses : Addresses
addresses =
  {
    newReview = newReview.address
  }

type alias Signals =
  {
    newReview : Signal ()
  }


signals : Signals
signals =
  {
    newReview = newReview.signal
  }


newReview : Signal.Mailbox ()
newReview =
  Signal.mailbox ()
