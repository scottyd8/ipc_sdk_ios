## [1.0.34] - 2017-06-21

### Fixed 
-   EMV certification bugs

## [1.0.33] - 2017-05-24

### Changed 
-   The framework has been split into 2 separate binaries to support simulator or device builds
-   The device framework is located in the root sdk folder
-   The simulator framework is located at sdk/simulator-support
-   Simulator frameworks cannot be submitted to the App Store and are for testing only

## [1.0.33] - 2017-05-17

### Added 
-   iOS  Demo App Enhancements
-   New transactions flows added
-   Retrieve transaction
-   Search transactions
-   Update Transactions
-   Capture functionality
-   Manual card entry on PED

### Fixed 
-   Unsettled debit transactions now correctly fall back to void
-   When this void occurs, the entire transaction will be voided, including cashback amounts
-   This must be taken into account by the merchant when processing a void on debit
-   Assorted bug fixes




## [1.0.32] - 2017-05-05
### Added
-	iOS SDK Documentation Update


## [1.0.32] - 2017-04-24
### Added 
-	Tip functionality on Pin-pad
-	Debit cashback support 
-	Auto-select AID functionality. A card with both Credit and Debit AIDs will prompt for Credit/Debit. If multiple AIDs are still present for the chosen type, the AID will be chosen automatically.
-	Update Transaction functionality to append level 2 data to an existing transaction
-	Retrieve a specific transaction by transactionID
-	Search and return an array of completed transactions

### Fixed 
-	Numerous bug fixes