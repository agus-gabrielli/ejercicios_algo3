!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummaryTest methodsFor: 'private' stamp: 'MR 12/14/2020 21:55:27'!
expectedAccountSummaryForTest07

	| aSummary |

	aSummary _ OrderedCollection new.
	aSummary add: 'Depósito por 100 pesos'.
	aSummary add: 'Depósito por 200 pesos'.
	aSummary add: 'Balance = 300 pesos'.
	
	^aSummary! !

!AccountSummaryTest methodsFor: 'private' stamp: 'MR 12/14/2020 21:14:51'!
expectedAccountSummaryForTest09
	
	| anExpectedSummary |
	
	anExpectedSummary _ OrderedCollection new.
	anExpectedSummary add: 'Depósito por 100 pesos'.
	anExpectedSummary add: 'Depósito por 75 pesos'.
	anExpectedSummary add: 'Extracción por 25 pesos'.
	anExpectedSummary add: 'Depósito por 50 pesos'.
	anExpectedSummary add: 'Extracción por 100 pesos'.
	anExpectedSummary add: 'Extracción por 75 pesos'.
	anExpectedSummary add: 'Balance = 25 pesos'.
	
	^anExpectedSummary ! !

!AccountSummaryTest methodsFor: 'private' stamp: 'MR 12/14/2020 21:45:23'!
expectedDestinationAcountSummaryForTest08

	| aSummary |
	
	aSummary _ OrderedCollection new.
	aSummary add: 'Entrada por transferencia de 50 pesos'.
	aSummary add: 'Balance = 50 pesos'.
	
	^aSummary
	
	! !

!AccountSummaryTest methodsFor: 'private' stamp: 'MR 12/14/2020 21:44:28'!
expectedOriginAcountSummaryForTest08

	| aSummary |
	
	aSummary _ OrderedCollection new.
	aSummary add: 'Depósito por 50 pesos'.
	aSummary add: 'Salida por transferencia de 50 pesos'.
	aSummary add: 'Balance = 0 pesos'.
	
	^aSummary
	! !

!AccountSummaryTest methodsFor: 'private' stamp: 'MR 12/14/2020 21:51:03'!
firstReceptiveAccountForTest07
	
	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	
	^anAccount.! !

!AccountSummaryTest methodsFor: 'private' stamp: 'MR 12/14/2020 21:42:28'!
originReceptiveAccountForTest08
	
	| anOriginAccount |
	
	anOriginAccount _ ReceptiveAccount new.
	Deposit register: 50*peso on: anOriginAccount.
	
	^anOriginAccount
	! !

!AccountSummaryTest methodsFor: 'private' stamp: 'MR 12/14/2020 21:29:47'!
receptiveAccountForTest09

	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount. 
	Deposit register: 75 * peso on: anAccount. 
	Withdraw register: 25 * peso on: anAccount.
	Deposit register: 50 * peso on: anAccount. 
	Withdraw register: 100 * peso on: anAccount.	
	Withdraw register: 75 * peso on: anAccount.
	
	^anAccount! !

!AccountSummaryTest methodsFor: 'private' stamp: 'MR 12/14/2020 21:52:24'!
secondReceptiveAccountForTest07

	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 200 * peso on: anAccount.
	
	^anAccount.! !


!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 20:16:23'!
test01EmptyAccountSummaryIsCorrect

	| anAccount anAccountSummary |
	
	anAccount _ ReceptiveAccount new.
	anAccountSummary _ AccountSummary new generateReportFor: anAccount.
	
	self assert: 1 equals: anAccountSummary size. 
	self assert: anAccountSummary includes: 'Balance = 0 pesos'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 20:16:53'!
test02EmptyPortfolioSummaryIsCorrect

	| aPortfolio aPortfolioSummary |
	
	aPortfolio _ Portfolio new.
	aPortfolioSummary _ AccountSummary new generateReportFor: aPortfolio.
	
	self assert: 1 equals: aPortfolioSummary size. 
	self assert: aPortfolioSummary includes: 'Balance = 0 pesos'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 20:11:49'!
test03SummaryOfAnAccountWithADepositIsCorrect

	| anAccount aSummary |
	
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount. 
	aSummary _ AccountSummary new generateReportFor: anAccount.
	
	self assert: 2 equals: aSummary size.
	self assert: (aSummary at: 1) equals: 'Depósito por 100 pesos'. 
	self assert: (aSummary at: 2) equals: 'Balance = 100 pesos'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 20:17:33'!
test04SummaryOfPortfolioWithAccountWithOneTransactionIsCorrect

	| anAccount aPortfolio aPortfolioSummary |
	
	anAccount _ ReceptiveAccount new.
	aPortfolio _ Portfolio with: anAccount.
	Deposit register: 100 * peso on: anAccount. 
	aPortfolioSummary _ AccountSummary new generateReportFor: aPortfolio.
	
	self assert: 2 equals: aPortfolioSummary size.
	self assert: (aPortfolioSummary at: 1) equals: 'Depósito por 100 pesos'. 
	self assert: (aPortfolioSummary at: 2) equals: 'Balance = 100 pesos'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 20:18:24'!
test05SummaryOfComposedPortfolioWithoutAccountsIsCorrect

	| aRootPortfolio aPortfolio aRootPortfolioSummary|
	
	aPortfolio _ Portfolio new.
	aRootPortfolio _ Portfolio with: aPortfolio.
	aRootPortfolioSummary _ AccountSummary new generateReportFor: aRootPortfolio.
	
	self assert: aRootPortfolioSummary includes: 'Balance = 0 pesos'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 20:19:36'!
test06SummaryOfAnAccountWithADepositIsCorrect

	| anAccount aSummary |
	
	anAccount _ ReceptiveAccount new.
	Withdraw register: 50 * peso on: anAccount. 
	aSummary _ AccountSummary new generateReportFor: anAccount.
	
	self assert: 2 equals: aSummary size.
	self assert: (aSummary at: 1) equals: 'Extracción por 50 pesos'.
	self assert: (aSummary at: 2) equals: 'Balance = -50 pesos'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 21:57:33'!
test07SummaryOfComposedPortfolioWithMultipleAccountsIsCorrect

	|  aRootPortfolio aPortfolio aRootPortfolioAccountSummary |
	
	aPortfolio _ Portfolio with: self firstReceptiveAccountForTest07.
	aRootPortfolio _ Portfolio with: aPortfolio with: self secondReceptiveAccountForTest07.
	
	aRootPortfolioAccountSummary _ AccountSummary new generateReportFor: aRootPortfolio.
	
	self assert: aRootPortfolioAccountSummary equals: self expectedAccountSummaryForTest07.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 21:47:01'!
test08SummariesOfAccountsInvolvedInATransferIsCorrect

	| anOriginAccount aDestinationAccount aSummaryofAnOriginAccount aSummaryofADestinationAccount |
	
	anOriginAccount _ self originReceptiveAccountForTest08.
	aDestinationAccount _ ReceptiveAccount new.
	
	TransferOperation register: 50 * peso from: anOriginAccount to: aDestinationAccount. 
	
	aSummaryofAnOriginAccount _ AccountSummary new generateReportFor: anOriginAccount.
	aSummaryofADestinationAccount _ AccountSummary new generateReportFor: aDestinationAccount.
	
	self assert: aSummaryofAnOriginAccount equals: self expectedOriginAcountSummaryForTest08.
	self assert: aSummaryofADestinationAccount equals: self expectedDestinationAcountSummaryForTest08.
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/14/2020 21:31:13'!
test09SummaryOfAccountWithMultipleTransactionsIsCorrect

	| anAccount anAccountSummary |
	
	anAccount _ self receptiveAccountForTest09.
	
	anAccountSummary _ AccountSummary new generateReportFor: anAccount.
	
	self assert: anAccountSummary equals: self expectedAccountSummaryForTest09
	
	
! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:02:27'!
test01PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| anAccount aPortfolio |
	
	anAccount _ ReceptiveAccount new.
	aPortfolio _ Portfolio with: anAccount.
	
	self 
		should: [ aPortfolio add: anAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: aPortfolio accountsSize.
			self assert: (aPortfolio hasAccount: anAccount) ]! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:02:40'!
test02PortfolioCanNotIncludeAccountOfItsPortfolios

	| anAccount aSimplePortfolio aComposedPortfolio |
	
	anAccount _ ReceptiveAccount new.
	aSimplePortfolio _ Portfolio with: anAccount.
	aComposedPortfolio _ Portfolio with: aSimplePortfolio.
	
	self 
		should: [ aComposedPortfolio add: anAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: aComposedPortfolio accountsSize.
			self assert: (aComposedPortfolio hasAccount: aSimplePortfolio) ]! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:02:49'!
test03PortfolioCanNotIncludeItself

	| anAccount aSimplePortfolio |
	
	anAccount _ ReceptiveAccount new.
	aSimplePortfolio _ Portfolio with: anAccount.
	
	self 
		should: [ aSimplePortfolio add: aSimplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: aSimplePortfolio accountsSize.
			self assert: (aSimplePortfolio hasAccount: anAccount) ]! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:02:57'!
test04ComposedPortfolioCanNotHaveParentPortfolioAccount

	| anAccount aSimplePortfolio aComposedPortfolio |
	
	anAccount _ ReceptiveAccount new.
	aSimplePortfolio _ Portfolio new.
	aComposedPortfolio _ Portfolio with: aSimplePortfolio.
	aComposedPortfolio add: anAccount.
	
	self 
		should: [ aSimplePortfolio add: anAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: aSimplePortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:03:13'!
test05ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| anAccount aLeftParentPortfolio aLeftRootParentPortfolio aPortfolio aRightParentPortfolio aRightRootParentPortfolio |
	
	anAccount _ ReceptiveAccount new.
	aPortfolio _ Portfolio new.
	aLeftParentPortfolio _ Portfolio with: aPortfolio .
	aLeftRootParentPortfolio _ Portfolio with: aLeftParentPortfolio.
	aLeftRootParentPortfolio add: anAccount.
	
	aRightParentPortfolio _ Portfolio with: aPortfolio .
	aRightRootParentPortfolio _ Portfolio with: aRightParentPortfolio.
	aRightRootParentPortfolio add: anAccount.

	self 
		should: [ aPortfolio add: anAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: aPortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:03:25'!
test06PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| aPortfolioToAdd aPortfolioToModify aRootPortfolio aSharedAccount |
	
	aSharedAccount _ ReceptiveAccount new.
	aPortfolioToModify _ Portfolio new.
	aRootPortfolio _ Portfolio with: aSharedAccount with: aPortfolioToModify.
	aPortfolioToAdd _ Portfolio with: aSharedAccount.
	
	self 
		should: [ aPortfolioToModify add: aPortfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: aPortfolioToModify hasAccounts ]! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:03:32'!
test07BalanceOfAnEmptyPortfolioIsZero

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: aPortfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:03:39'!
test08BalanceOfAPortfolioWithASingleAccountEqualsTheAccountBalance

	| aPortfolio anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	aPortfolio _ Portfolio with: anAccount.
	
	self assert: aPortfolio balance equals: 100 * peso.! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:03:47'!
test09BalanceOfAComposedPortfolioIsTheSumOfTheBalancesOfTheAccountsItContains

	| aPortfolio aRootPortfolio anAccount anotherAccount|
	
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	Deposit register: 200 * peso on: anotherAccount.
	aPortfolio _ Portfolio with: anAccount.
	aRootPortfolio _ Portfolio with: anotherAccount with: aPortfolio.
	
	self assert: aRootPortfolio balance equals: 300 * peso.! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:03:51'!
test10EmptyPortfolioDoesNotKnowAnyTransactions

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	Deposit for: 100 * peso.
	
	self deny: (aPortfolio hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:04:01'!
test11PortfolioKnowsATransactionRegisteredInOneOfItsAccounts

	| aPortfolio anAccount aDeposit |
	
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 100 * peso on: anAccount.
	aPortfolio _ Portfolio with: anAccount.
	
	self assert: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:04:10'!
test12PortfolioDoesNotKnowATransactionNotRegisteredInItsAccounts

	| aPortfolio anAccount aDeposit |
	
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit for: 100 * peso.
	aPortfolio _ Portfolio with: anAccount.
	
	self deny: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'MR 12/9/2020 22:04:19'!
test13AComposedPortfolioKnowsATransactionRegisteredInOneOfItsLeafAccounts

	| aPortfolio aRootPortfolio anAccount anotherAccount aTransfer |
	
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: 300 * peso on: anAccount.
	aTransfer _ TransferOperation register: 50 * peso from: anAccount to: anotherAccount.
	aPortfolio _ Portfolio with: anAccount.
	aRootPortfolio _ Portfolio with: anotherAccount with: aPortfolio.
	
	self assert: (aRootPortfolio hasRegistered: (aTransfer outgoingTransfer)).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'receptive account tests' stamp: 'MR 12/9/2020 22:04:45'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| anAccount |
	
	anAccount _ ReceptiveAccount new.

	self assert: 0 equals: anAccount balance
! !

!ReceptiveAccountTest methodsFor: 'receptive account tests' stamp: 'MR 12/9/2020 22:04:49'!
test02DepositIncreasesBalanceOnTransactionValue 

	| anAccount |
	
	anAccount _ ReceptiveAccount  new.
	Deposit register: 100 * peso on: anAccount.
		
	self assert: 100 * peso equals: anAccount balance
! !

!ReceptiveAccountTest methodsFor: 'receptive account tests' stamp: 'MR 12/9/2020 22:04:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	Withdraw register: 50 * peso on: anAccount.
		
	self assert: 50 * peso equals: anAccount balance
! !

!ReceptiveAccountTest methodsFor: 'receptive account tests' stamp: 'MR 12/9/2020 22:04:55'!
test04WithdrawValueMustBePositive 

	| anAccount aWithdrawValue |
	
	anAccount _ ReceptiveAccount new.
	aWithdrawValue := 50 * peso.
	
	self assert: aWithdrawValue equals: (Withdraw register: aWithdrawValue on: anAccount) value
! !

!ReceptiveAccountTest methodsFor: 'receptive account tests' stamp: 'MR 12/9/2020 22:05:03'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| anAccount aDeposit aWithdraw |
	
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 100 * peso on: anAccount.
	aWithdraw _ Withdraw register: 50 * peso on: anAccount.
		
	self assert: (anAccount hasRegistered: aDeposit).
	self assert: (anAccount hasRegistered: aWithdraw).
! !

!ReceptiveAccountTest methodsFor: 'receptive account tests' stamp: 'MR 12/9/2020 22:05:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| anAccount deposit withdraw |
	
	anAccount _ ReceptiveAccount new.
	deposit _  Deposit for: 100 * peso.
	withdraw _ Withdraw for: 50 * peso.
		
	self deny: (anAccount hasRegistered: deposit).
	self deny: (anAccount hasRegistered: withdraw).
! !


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:28:59'!
test01EmptyAccountTransferNetIsZero

	| anAccount aReportResult |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	aReportResult _ TransferNet new generateReportFor: anAccount.	
	
	self assert: aReportResult equals: 0 * peso. ! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:30:53'!
test02TransferNetsOfAccountsInvolvedInATransferAreCorrect

	| anOriginAccount aDestinationAccount anOriginReportResult aDestinationReportResult |
	
	anOriginAccount _ ReceptiveAccount new.
	aDestinationAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anOriginAccount.
	TransferOperation register: 75 * peso from: anOriginAccount to: aDestinationAccount.
	anOriginReportResult _ TransferNet new generateReportFor: anOriginAccount.	
	aDestinationReportResult _ TransferNet new generateReportFor: aDestinationAccount.	
		
	self assert: -75 * peso equals: anOriginReportResult. 
	self assert: 75 * peso equals: aDestinationReportResult.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:33:52'!
test03TransferNetsOfAccountsInvolvedInMultipleTransfersAreCorrect

	| anOriginAccount aDestinationAccount anOriginReportResult aDestinationReportResult |
	
	anOriginAccount _ ReceptiveAccount new.
	aDestinationAccount _ ReceptiveAccount new.
	Deposit register: 300 * peso on: anOriginAccount.
	TransferOperation register: 150 * peso from: anOriginAccount to: aDestinationAccount.
	TransferOperation register: 100 * peso from: aDestinationAccount to: anOriginAccount.
	TransferOperation register: 25 * peso from: aDestinationAccount to: anOriginAccount.
	TransferOperation register: 125 * peso from: anOriginAccount to: aDestinationAccount.
	TransferOperation register: 75 * peso from: aDestinationAccount to: anOriginAccount.
	TransferOperation register: 25 * peso from: anOriginAccount to: aDestinationAccount.
	
	anOriginReportResult _ TransferNet new generateReportFor: anOriginAccount.	
	aDestinationReportResult _ TransferNet new generateReportFor: aDestinationAccount.		
	
	self assert: -100 * peso equals: anOriginReportResult. 
	self assert: 100 * peso equals: aDestinationReportResult.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:34:36'!
test04EmptyPortfolioTransferNetIsZero

	| aPortfolio aPortfolioTransferNet |
	
	aPortfolio _ Portfolio new.
	
	aPortfolioTransferNet _ TransferNet new generateReportFor: aPortfolio.	
	
	self assert: aPortfolioTransferNet equals: 0 * peso. ! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:35:49'!
test05TransferNetOfPortfolioWithOneAccountReturnsTransferNetOfAccount

	| aPortfolio anOriginAccount aDestinationAccount aPortfolioTransferNet |
	
	anOriginAccount _ ReceptiveAccount new.
	aDestinationAccount _ ReceptiveAccount new.
	aPortfolio _ Portfolio with: anOriginAccount.
	Deposit register: 100 * peso on: anOriginAccount.
	TransferOperation register: 75 * peso from: anOriginAccount to: aDestinationAccount.
	
	aPortfolioTransferNet _ TransferNet new generateReportFor: aPortfolio.	
	
	self assert: -75 * peso equals: aPortfolioTransferNet.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:36:19'!
test06TransferNetOfComposedPortfolioIsTheSumOfTheTransferNetsOfItsAccounts

	| aRootPortfolio aPortfolio anOriginAccount aDestinationAccount anOffshoreAccount aRootPortfolioTransferNet |
	
	anOriginAccount _ ReceptiveAccount new.
	aDestinationAccount _ ReceptiveAccount new.
	anOffshoreAccount _ ReceptiveAccount new. 
	aPortfolio _ Portfolio with: anOriginAccount.
	aRootPortfolio _ Portfolio with: aPortfolio with: aDestinationAccount.
	Deposit register: 5000 * peso on: anOriginAccount.
	TransferOperation register: 4000 * peso from: anOriginAccount to: anOffshoreAccount.
	TransferOperation register: 3500 * peso from: anOffshoreAccount to: aDestinationAccount.
	
	aRootPortfolioTransferNet _ TransferNet new generateReportFor: aRootPortfolio.	
	
	self assert: -500 * peso equals: aRootPortfolioTransferNet.! !


!classDefinition: #TransferOperationTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferOperationTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/9/2020 22:05:25'!
test01TransferCorrectlyChangesAccountsBalances

	| aSenderAccount aReceiverAccount |
	
	aSenderAccount _ ReceptiveAccount new.
	aReceiverAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: aSenderAccount.
	Deposit register: 100 * peso on: aReceiverAccount.
	TransferOperation register: 50 * peso from: aSenderAccount to: aReceiverAccount.
		
	self assert: 50 * peso equals: aSenderAccount balance.
	self assert: 150 * peso equals: aReceiverAccount balance.! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/9/2020 22:05:32'!
test02TransferValueMustBePositive

	| aSenderAccount aReceiverAccount aTransferAmount |
	
	aSenderAccount _ ReceptiveAccount new.
	aReceiverAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: aSenderAccount.
	aTransferAmount _ 50 * peso.
	
	self assert: aTransferAmount equals: 
		(TransferOperation register: aTransferAmount from: aSenderAccount to: aReceiverAccount) transferedAmount ! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/9/2020 22:05:40'!
test03SenderAndReceiverAccountsRegisterTransferCorrectly

	| aSenderAccount aReceiverAccount aTransfer |
	
	aSenderAccount _ ReceptiveAccount new.
	aReceiverAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: aSenderAccount.
	aTransfer _ TransferOperation register: 50 * peso from: aSenderAccount to: aReceiverAccount.
	
	self assert: (aSenderAccount hasRegistered: aTransfer outgoingTransfer).
	self assert: (aReceiverAccount hasRegistered: aTransfer incomingTransfer).
! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/9/2020 22:06:03'!
test04BothLegsOfTheTransferKnowTheirCounterparts

	| aSenderAccount aReceiverAccount aTransfer anIncomingTransfer anOutgoingTransfer |
	
	aSenderAccount _ ReceptiveAccount new.
	aReceiverAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: aSenderAccount.
	aTransfer _ TransferOperation register: 50 * peso from: aSenderAccount to: aReceiverAccount.
	anIncomingTransfer _ aTransfer outgoingTransfer.
	anOutgoingTransfer _ aTransfer incomingTransfer.
	
	self assert: anIncomingTransfer counterpart = anOutgoingTransfer.
	self assert: anOutgoingTransfer counterpart = anIncomingTransfer.! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/9/2020 22:06:11'!
test05BothLegsHaveTheSameValue

	| aSenderAccount aReceiverAccount aTransfer aTransferValue |
	
	aSenderAccount _ ReceptiveAccount new.
	aReceiverAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: aSenderAccount.
	aTransferValue _ 50 * peso.
	aTransfer _ TransferOperation register: aTransferValue from: aSenderAccount to: aReceiverAccount.
	
	self assert: aTransfer outgoingTransfer value = aTransferValue.
	self assert: aTransfer incomingTransfer value = aTransferValue.! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/9/2020 22:06:17'!
test06SenderAccountWithInsufficientFundsCannotMakeATransfer

	| aSenderAccount aReceiverAccount |
	
	aSenderAccount _ ReceptiveAccount new.
	aReceiverAccount _ ReceptiveAccount new.
	Deposit register: 50 * peso on: aSenderAccount.
	Deposit register: 100 * peso on: aReceiverAccount.
	
	self should: [TransferOperation register: 100 * peso from: aSenderAccount to: aReceiverAccount.]
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Insufficient Funds'.
						self assert: 50 * peso equals: aSenderAccount balance.
						self assert: 100 * peso equals: aReceiverAccount balance.].! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/9/2020 22:06:23'!
test07AnInvalidSenderAccountCancelsTransfer
	
	| aReceiverAccount |
	
	aReceiverAccount _ ReceptiveAccount new.
	
	self should: [TransferOperation register: 100 * peso from: 5 to: aReceiverAccount]
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Invalid Sender Account'.
						self assert: aReceiverAccount balance equals: 0 * peso].! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/9/2020 22:06:27'!
test08AnInvalidReceiverAccountCancelsTransfer
	
	| aSenderAccount |
	
	aSenderAccount _ ReceptiveAccount new.
	
	self should: [TransferOperation register: 100 * peso from: aSenderAccount to: 'Hola!!']
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Invalid Receiver Account'.
						self assert: aSenderAccount balance equals: 0 * peso].! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'reports' stamp: 'MR 12/10/2020 21:04:59'!
accountSummary

	^self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'MR 12/13/2020 23:09:33'!
transferNet

	^self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!
!Portfolio commentStamp: '<historical>' prior: 0!
Revisar implementacion de account summary, esta dando el balance por cada cuenta en ves de total!


!Portfolio methodsFor: 'initialization' stamp: 'MR 12/9/2020 22:01:37'!
initialize

	accounts _ OrderedCollection new.
	parents _ OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'testing' stamp: 'MR 12/9/2020 19:54:27'!
hasRegistered: aDeposit 
	
	^accounts anySatisfy: [:anAccount | anAccount hasRegistered: aDeposit]! !


!Portfolio methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !


!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'MR 12/9/2020 22:02:01'!
rootParents
	
	| rootParents |
	
	rootParents _ Set new.
	self addRootParentsTo: rootParents.
	
	^rootParents! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'balance' stamp: 'MR 12/9/2020 20:45:58'!
balance
	
	^accounts sum: [:anAccount | anAccount balance] ifEmpty: [0 * peso]
	! !


!Portfolio methodsFor: 'reports' stamp: 'MR 12/14/2020 20:14:48'!
transactionsDo: aBlock.

	accounts do: [:anAccount | anAccount transactionsDo: aBlock]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MR 12/9/2020 22:04:33'!
initialize

	transactions _ OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AG 12/13/2020 18:25:48'!
balance
	
	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MR 12/9/2020 20:44:10'!
register: aTransaction
	
	(aTransaction isKindOf: AccountTransaction) ifFalse: [self error: 'Invalid transaction'].
	
	transactions add: aTransaction.
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'MR 12/14/2020 20:08:38'!
transactionsDo: aBlock.

	transactions do: aBlock! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AG 12/9/2020 17:25:30'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'MR 12/13/2020 23:46:10'!
summaryLegend

	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'private' stamp: 'MR 12/9/2020 21:43:03'!
valueToRecordInBalance

	^self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'AG 12/13/2020 18:18:48'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MR 12/9/2020 21:58:38'!
register: aValue on: anAccount

	| aTransaction |
	
	aTransaction _ self for: aValue.
	anAccount register: aTransaction.
		
	^aTransaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'AG 12/9/2020 17:26:37'!
value

	^value! !


!Deposit methodsFor: 'private' stamp: 'AG 12/13/2020 19:08:05'!
summaryLegend

	^'Depósito por ', value asString.! !


!Deposit methodsFor: 'balance' stamp: 'AG 12/13/2020 18:17:50'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'MR 12/9/2020 22:00:20'!
initializeFor: aValue

	value _ aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransaction methodsFor: 'initialization' stamp: 'AG 12/13/2020 18:21:15'!
initializeAsPartOf: aTransfer 
	
	transfer _ aTransfer.! !


!TransferTransaction methodsFor: 'value' stamp: 'AG 12/13/2020 18:21:40'!
value

	^transfer transferedAmount ! !


!classDefinition: #IncomingTransfer category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #IncomingTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!IncomingTransfer methodsFor: 'counterpart' stamp: 'MR 12/9/2020 19:47:51'!
counterpart

	^transfer outgoingTransfer! !


!IncomingTransfer methodsFor: 'private' stamp: 'AG 12/13/2020 19:08:53'!
summaryLegend

	^'Entrada por transferencia de ', self value asString.! !


!IncomingTransfer methodsFor: 'balance' stamp: 'AG 12/13/2020 18:18:22'!
affectBalance: aBalance

	^aBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
IncomingTransfer class
	instanceVariableNames: ''!

!IncomingTransfer class methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:35:09'!
registerAsPartOf: aTransfer

	^self new initializeAsPartOf: aTransfer! !


!classDefinition: #OutgoingTransfer category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #OutgoingTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OutgoingTransfer methodsFor: 'balance' stamp: 'AG 12/13/2020 18:18:30'!
affectBalance: aBalance

	^aBalance - self value! !


!OutgoingTransfer methodsFor: 'private' stamp: 'AG 12/13/2020 19:09:10'!
summaryLegend

	^'Salida por transferencia de ', self value asString.! !


!OutgoingTransfer methodsFor: 'counterpart' stamp: 'AG 12/9/2020 17:34:44'!
counterpart

	^transfer incomingTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
OutgoingTransfer class
	instanceVariableNames: ''!

!OutgoingTransfer class methodsFor: 'as yet unclassified' stamp: 'MR 12/9/2020 20:20:08'!
registerAsPartOf: aTransfer

	^self new initializeAsPartOf: aTransfer.

	! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'private' stamp: 'AG 12/13/2020 19:08:18'!
summaryLegend

	^'Extracción por ', value asString.! !


!Withdraw methodsFor: 'initialization' stamp: 'MR 12/9/2020 22:00:57'!
initializeFor: aValue

	value _ aValue ! !


!Withdraw methodsFor: 'balance' stamp: 'AG 12/13/2020 18:18:07'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'value' stamp: 'AG 12/9/2020 17:27:41'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'MR 12/9/2020 21:59:02'!
for: aValue

	^self new initializeFor: aValue ! !


!classDefinition: #Report category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Report methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:00:21'!
generateReportFor: anAccount
	
	^self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Ejercicio'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:24:29'!
generateReportFor: anAccount

	| aReport |
	
	aReport _ OrderedCollection new.
	anAccount transactionsDo: [:aTransaction | aReport add: aTransaction summaryLegend]. 
	aReport add: 'Balance = ', anAccount balance asString.
	
	^aReport
	
	
	

	! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Ejercicio'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'MR 12/14/2020 20:32:43'!
generateReportFor: anAccount

	| aTransferNetBalance |
	
	aTransferNetBalance _ 0 * peso.
	anAccount transactionsDo: [:aTransaction | (aTransaction isKindOf: TransferTransaction) ifTrue: [aTransferNetBalance _ aTransaction affectBalance: aTransferNetBalance]]. 
		
	^aTransferNetBalance

	! !


!classDefinition: #TransferOperation category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferOperation
	instanceVariableNames: 'transferedAmount outgoingTransfer incomingTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferOperation methodsFor: 'accesing' stamp: 'AG 12/9/2020 17:35:33'!
incomingTransfer
	
	^incomingTransfer! !

!TransferOperation methodsFor: 'accesing' stamp: 'MR 12/9/2020 19:47:51'!
outgoingTransfer
	
	^outgoingTransfer! !

!TransferOperation methodsFor: 'accesing' stamp: 'AG 12/7/2020 19:26:48'!
transferedAmount
	
	^transferedAmount! !


!TransferOperation methodsFor: 'initialization' stamp: 'MR 12/9/2020 21:52:13'!
initializeWithAmount: aTransferenceAmount from: anOriginAccount to: aDestinationAccount

	transferedAmount _ aTransferenceAmount.
	incomingTransfer _ IncomingTransfer registerAsPartOf: self.
	outgoingTransfer _ OutgoingTransfer registerAsPartOf: self.
	
	anOriginAccount register: outgoingTransfer.
	aDestinationAccount register: incomingTransfer.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferOperation class' category: 'ServiciosFinancieros-Ejercicio'!
TransferOperation class
	instanceVariableNames: ''!

!TransferOperation class methodsFor: 'instance creation' stamp: 'MR 12/9/2020 21:59:52'!
register: aTransferAmount from: aSenderAccount to: aReceiverAccount 
	
	(aSenderAccount isKindOf: ReceptiveAccount) ifFalse: [self error: 'Invalid Sender Account'].
	(aReceiverAccount isKindOf: ReceptiveAccount) ifFalse: [self error: 'Invalid Receiver Account'].
	aTransferAmount > aSenderAccount balance ifTrue: [self error: 'Insufficient Funds'].
	
	^self new initializeWithAmount: aTransferAmount from: aSenderAccount to: aReceiverAccount.
	! !
