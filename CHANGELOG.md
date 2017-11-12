## [2.0.1] - 2017-11-11

### Fixed 
-   Resolved a minor issue where the terminal connection sequence was not occuring in the correct order. This should yield minimal improvements to terminal connection times. 
-   Resolved an issue where transactions were not getting voided correctly when the card chip was unable to verify ARPC response from the issuer.

## [1.0.38] - 2017-11-11

### Fixed  
-   Resolved an issue where transactions were not getting voided correctly when the card chip was unable to verify ARPC response from the issuer.

## [2.0.0] - 2017-10-19

### ADDED 
-   Implemented Quick Chip Features into the new SDK (Version 2.0 only).
-   PED on ready state and perform Quick chip and Regular EMV transactions.
-   Broke the confirm amount dispaly on the PED to reflect the Base, Gratuity(if applicable), Cashback(if applicable) and Total amounts.
-   Added a new flag to enable and disable grautuity prompt on PED.
-   Added Gratuity on POS support. Below are the three cases.                                                                                      
-   If gratuity value is sent from POS to SDK and the gratuity flag is on, PED will reflect the value of the gratuity and enable the user to modify if needed.
-   If gratuity value is sent from POS to SDK and the gratuity flag is off, PED will not show the gratuity screen but the gratuity value is going to be sent to the Gateway API.
-   If gratuity value is not sent from POS to SDK and the gratuity flag is off, PED will not show the gratuity screen and the value will be sent as zero for gratuity by default to the Gateway API. 

	
## [1.0.37] - 2017-09-25

### Fixed 
-   Tied the Auth token to the Device and the version of the Worldpay SDK Integrated.


## [1.0.36] - 2017-08-31

### Fixed 
-   Resolved an issue where SDK Framework info.plist file contained value "iPhoneSimulator"


## [1.0.35] - 2017-07-14

### Fixed 
-   EMV certification bugs
-	Auto-select AID functionality
-	Updated libraries to make them consistent


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
