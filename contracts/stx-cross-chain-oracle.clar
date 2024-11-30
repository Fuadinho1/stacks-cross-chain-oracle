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



;; Oracle Rewards Pool
(define-data-var rewards-pool uint u0)

;; Register as an Oracle Provider
(define-public (register-provider (initial-stake uint))
  (begin
    ;; Prevent re-registration
    (asserts! (is-none (map-get? oracle-providers tx-sender)) ERR-PROVIDER-ALREADY-EXISTS)

    ;; Minimum stake requirement
    (asserts! (>= initial-stake u1000) ERR-INSUFFICIENT-FUNDS)

    ;; Transfer initial stake
    (try! (stx-transfer? initial-stake tx-sender (as-contract tx-sender)))

    ;; Register provider
    (map-set oracle-providers tx-sender {
      reputation: u100,
      stake: initial-stake,
      is-active: true,
      total-submissions: u0,
      successful-submissions: u0
    })

    (ok true)
  )
)


;; ;; Governance and Access Control
(define-map authorized-providers 
  principal 
  { 
    reputation: uint, 
    total-submissions: uint, 
    successful-submissions: uint 
  }
)

;; Retrieve Oracle Data
(define-read-only (get-data (data-key (string-ascii 50)))
  (map-get? oracle-data data-key)
)



;; Stake STX to Become a High-Reputation Provider
(define-public (stake-for-reputation (amount uint))
  (let (
    (current-balance (stx-get-balance tx-sender))
  )
  (begin
    ;; Ensure sufficient STX balance
    (asserts! (>= current-balance amount) ERR-INSUFFICIENT-FUNDS)

    ;; Transfer STX to contract
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))

    ;; Update provider reputation
    (let (
      (provider-info (unwrap! 
        (map-get? authorized-providers tx-sender) 
        ERR-UNAUTHORIZED
      ))
    )
      (map-set authorized-providers tx-sender (merge provider-info {
        reputation: (+ (get reputation provider-info) (/ amount u100))
      }))
    )

    (ok true)
  ))
)







;; Variable to track current block height
(define-data-var current-block-height uint u0)

;; Function to increment block height
(define-public (increment-block-height)
    (begin
        (var-set current-block-height 
            (+ (var-get current-block-height) u1)
        )
        (ok true)
    )
)

;; Function to get current block height
(define-read-only (get-block-height)
    (var-get current-block-height)
)

;; Function to manually set block height (useful for testing or initialization)
(define-public (set-block-height (new-height uint))
    (begin
        (var-set current-block-height new-height)
        (ok true)
    )
)
