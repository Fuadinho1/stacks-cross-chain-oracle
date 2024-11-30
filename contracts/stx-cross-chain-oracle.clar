;; Enhanced Cross-Chain Oracle Smart Contract

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INVALID-DATA (err u2))
(define-constant ERR-INSUFFICIENT-FUNDS (err u3))
(define-constant ERR-PROVIDER-ALREADY-EXISTS (err u4))
(define-constant ERR-DATA-EXPIRATION (err u5))

;; Data Storage for Oracle Providers
(define-map oracle-providers 
  principal 
  { 
    reputation: uint,
    stake: uint,
    is-active: bool,
    total-submissions: uint,
    successful-submissions: uint
  }
)

;; Data Storage for Oracle Data with Metadata
(define-map oracle-data 
  (string-ascii 50)  
  { 
    value: (string-ascii 200), 
    provider: principal,
    timestamp: uint,
    expiration: uint
  }
)

;; Voting for Oracle Network Upgrades
(define-map network-proposals
  uint
  {
    proposal-type: (string-ascii 50),
    proposed-value: uint,
    total-votes: uint,
    votes-for: uint,
    votes-against: uint,
    status: bool
  }
)


