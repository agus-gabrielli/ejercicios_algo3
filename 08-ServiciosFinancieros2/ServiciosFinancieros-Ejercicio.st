!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/16/2020 12:13:14'!
accountWithADeposit
	
	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	
	^anAccount.! !

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/16/2020 12:55:03'!
accountWithMultipleTransactions

	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount. 
	Deposit register: 75 * peso on: anAccount. 
	Withdraw register: 25 * peso on: anAccount.
	Deposit register: 50 * peso on: anAccount. 
	Withdraw register: 100 * peso on: anAccount.	
	Withdraw register: 75 * peso on: anAccount.
	
	^anAccount! !

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/16/2020 12:25:47'!
expectedAccountSummaryForAccountWithASingleDeposit

	| anExpectedAccountSummary |
	
	anExpectedAccountSummary _ OrderedCollection new.
	
	anExpectedAccountSummary add: 'Depósito por 100 pesos'.
	anExpectedAccountSummary add: 'Balance = 100 pesos'.
	
	^anExpectedAccountSummary ! !

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/16/2020 12:25:55'!
expectedAccountSummaryForAccountWithASingleIncomingTransfer

	| anExpectedAccountSummary |
	
	anExpectedAccountSummary _ OrderedCollection new.
	anExpectedAccountSummary add: 'Entrada por transferencia de 100 pesos'.
	anExpectedAccountSummary add: 'Balance = 100 pesos'.
	
	^anExpectedAccountSummary
	
	! !

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/16/2020 12:26:01'!
expectedAccountSummaryForAccountWithASingleOutgoingTransfer

	| anExpectedAccountSummary |
	
	anExpectedAccountSummary _ OrderedCollection new.
	anExpectedAccountSummary add: 'Depósito por 100 pesos'.
	anExpectedAccountSummary add: 'Salida por transferencia de 100 pesos'.
	anExpectedAccountSummary add: 'Balance = 0 pesos'.
	
	^anExpectedAccountSummary
	! !

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 15:33:24'!
expectedAccountSummaryForAccountWithASingleWithdraw

	| anExpectedAccountSummary |
	
	anExpectedAccountSummary _ OrderedCollection new.
	anExpectedAccountSummary add: 'Extracción por 100 pesos'.
	anExpectedAccountSummary add: 'Balance = -100 pesos'.
	
	^anExpectedAccountSummary ! !

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/16/2020 12:26:19'!
expectedAccountSummaryForAccountWithMultipleDeposits

	| anExpectedAccountSummary |

	anExpectedAccountSummary _ OrderedCollection new.
	anExpectedAccountSummary add: 'Depósito por 100 pesos'.
	anExpectedAccountSummary add: 'Depósito por 100 pesos'.
	anExpectedAccountSummary add: 'Balance = 200 pesos'.
	
	^anExpectedAccountSummary! !

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/16/2020 12:26:24'!
expectedAccountSummaryForAccountWithMultipleTransactions
	
	| anExpectedAccountSummary |
	
	anExpectedAccountSummary _ OrderedCollection new.
	anExpectedAccountSummary add: 'Depósito por 100 pesos'.
	anExpectedAccountSummary add: 'Depósito por 75 pesos'.
	anExpectedAccountSummary add: 'Extracción por 25 pesos'.
	anExpectedAccountSummary add: 'Depósito por 50 pesos'.
	anExpectedAccountSummary add: 'Extracción por 100 pesos'.
	anExpectedAccountSummary add: 'Extracción por 75 pesos'.
	anExpectedAccountSummary add: 'Balance = 25 pesos'.
	
	^anExpectedAccountSummary ! !

!AccountSummaryTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 15:33:54'!
expectedAccountSummaryForAccountWithoutTransactions

	| anExpectedAccountSummary |
	
	anExpectedAccountSummary _ OrderedCollection new.
	anExpectedAccountSummary add: 'Balance = 0 pesos'.
	
	^anExpectedAccountSummary! !


!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:43:20'!
test01EmptyAccountSummaryIsCorrect

	| anAccount |

	anAccount _ ReceptiveAccount new.
	
	self assert: self expectedAccountSummaryForAccountWithoutTransactions 
		equals: (AccountSummaryReport generateReportFor: anAccount). .! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:43:28'!
test02EmptyPortfolioSummaryIsCorrect

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
		
	self assert: self expectedAccountSummaryForAccountWithoutTransactions 
		equals: (AccountSummaryReport generateReportFor: aPortfolio).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:43:32'!
test03SummaryOfAnAccountWithADepositIsCorrect

	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount. 
	
	self assert: self expectedAccountSummaryForAccountWithASingleDeposit
		equals: (AccountSummaryReport generateReportFor: anAccount).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:43:37'!
test04SummaryOfPortfolioWithAccountWithOneTransactionIsCorrect

	| anAccount aPortfolio |
	
	anAccount _ ReceptiveAccount new.
	aPortfolio _ Portfolio with: anAccount.
	Deposit register: 100 * peso on: anAccount. 
	
	self assert: self expectedAccountSummaryForAccountWithASingleDeposit 
		equals: (AccountSummaryReport generateReportFor: aPortfolio)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:43:41'!
test05SummaryOfComposedPortfolioWithoutAccountsIsCorrect

	| aRootPortfolio aPortfolio |
	
	aPortfolio _ Portfolio new.
	aRootPortfolio _ Portfolio with: aPortfolio.
	
	self assert: self expectedAccountSummaryForAccountWithoutTransactions 
		equals: (AccountSummaryReport generateReportFor: aRootPortfolio).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:43:46'!
test06SummaryOfAnAccountWithAWithdrawIsCorrect

	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Withdraw register: 100 * peso on: anAccount. 
	
	self assert: self expectedAccountSummaryForAccountWithASingleWithdraw 
		equals: (AccountSummaryReport generateReportFor: anAccount)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:43:51'!
test07SummaryOfComposedPortfolioWithMultipleAccountsIsCorrect

	|  aRootPortfolio aPortfolio |
	
	aPortfolio _ Portfolio with: self accountWithADeposit.
	aRootPortfolio _ Portfolio with: aPortfolio with: self accountWithADeposit.
	
	self assert: self expectedAccountSummaryForAccountWithMultipleDeposits
		equals: (AccountSummaryReport generateReportFor: aRootPortfolio).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:44:31'!
test08SummariesOfAccountsInvolvedInATransferIsCorrect

	| anOriginAccount aDestinationAccount |
	
	anOriginAccount _ self accountWithADeposit.
	aDestinationAccount _ ReceptiveAccount new.
	TransferOperation register: 100 * peso from: anOriginAccount to: aDestinationAccount. 
	
	self assert: self expectedAccountSummaryForAccountWithASingleOutgoingTransfer 
		equals: (AccountSummaryReport generateReportFor: anOriginAccount).
	self assert: self expectedAccountSummaryForAccountWithASingleIncomingTransfer
		equals: (AccountSummaryReport generateReportFor: aDestinationAccount).
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:44:50'!
test09SummaryOfAccountWithMultipleTransactionsIsCorrect

	| anAccount |
	
	anAccount _ self accountWithMultipleTransactions.
	
	self assert: self expectedAccountSummaryForAccountWithMultipleTransactions
		equals: (AccountSummaryReport generateReportFor: anAccount)
	
	
! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioDetailedTreePrinterTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 17:34:28'!
expectedDetailedPortfolioTreeForComposedPortfolioWithAccountsWithTransactions
	
	| expectedTree |
	
	expectedTree _ OrderedCollection new.
	expectedTree add: 'Portfolio de la familia'.
	expectedTree add: '   Cuenta Mia'.
	expectedTree add: '      Depósito por 100 pesos'.
	expectedTree add: '      Extracción por 50 pesos'.
	expectedTree add: '      Balance = 50 pesos'.
	expectedTree add: '   Portfolio de hijos'.
	expectedTree add: '      Cuenta de Juan'.
	expectedTree add: '         Depósito por 100 pesos'.
	expectedTree add: '         Extracción por 50 pesos'.
	expectedTree add: '         Balance = 50 pesos'.
	expectedTree add: '      Cuenta de Angeles'.
	expectedTree add: '         Depósito por 100 pesos'.
	expectedTree add: '         Salida por transferencia de 75 pesos'.
	expectedTree add: '         Balance = 25 pesos'.
	expectedTree add: '      Balance = 75 pesos'.
	expectedTree add: '   Balance = 125 pesos'.
		
	^expectedTree
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 17:30:14'!
expectedDetailedPortfolioTreeForEmptyPortfolio
	
	| expectedTree |
	
	expectedTree _ OrderedCollection new.
	expectedTree add: 'Mi Portfolio'.
	expectedTree add: '   Balance = 0 pesos'.
	
	^expectedTree
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 17:33:07'!
expectedDetailedPortfolioTreeForPortfolioWithAccountWithTransactions
	
	| expectedTree |
	
	expectedTree _ OrderedCollection new.
	expectedTree add: 'Mi Portfolio'.
	expectedTree add: '   Mi cuenta'.
	expectedTree add: '      Depósito por 100 pesos'.
	expectedTree add: '      Extracción por 50 pesos'.
	expectedTree add: '      Balance = 50 pesos'.
	expectedTree add: '   Balance = 50 pesos'.
		
	^expectedTree
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 17:31:22'!
expectedDetailedPortfolioTreeForPortfolioWithEmptyAccount
	
	| expectedTree |

	expectedTree _ OrderedCollection new.
	expectedTree add: 'Mi Portfolio'.
	expectedTree add: '   Mi cuenta'.
	expectedTree add: '      Balance = 0 pesos'.
	expectedTree add: '   Balance = 0 pesos'.
		
	^expectedTree
	
	! !


!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MR 12/17/2020 17:30:55'!
test01DetailedPortfolioTreeForEmptyPortfolioIsCorrect
	
	| myPortfolio |
	
	myPortfolio _ Portfolio named: 'Mi Portfolio'.
	
	self assert: self expectedDetailedPortfolioTreeForEmptyPortfolio 
		equals: (PortfolioDetailedTreePrinterReport generateReportFor: myPortfolio).  
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MR 12/17/2020 17:32:39'!
test02DetailedPortfolioTreeForPortfolioWithEmptyAccountIsCorrect
	
	| myPortfolio myAccount |
	
	myAccount _ ReceptiveAccount named: 'Mi cuenta'.
	myPortfolio _ Portfolio named: 'Mi Portfolio' with: myAccount.
		
	self assert: self expectedDetailedPortfolioTreeForPortfolioWithEmptyAccount 
		equals: (PortfolioDetailedTreePrinterReport generateReportFor: myPortfolio).  
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MR 12/17/2020 17:33:36'!
test03DetailedPortfolioTreeForPortfolioWithAccountWithTransactionsIsCorrect
	
	| myPortfolio myAccount |
	
	myAccount _ ReceptiveAccount named: 'Mi cuenta'.
	Deposit register: 100 * peso on: myAccount.
	Withdraw register: 50 * peso on: myAccount.
	myPortfolio _ Portfolio named: 'Mi Portfolio' with: myAccount.
		
	self assert: self expectedDetailedPortfolioTreeForPortfolioWithAccountWithTransactions 
		equals: (PortfolioDetailedTreePrinterReport generateReportFor: myPortfolio).  
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MR 12/17/2020 17:35:13'!
test04DetailedPortfolioTreeForComposedPortfolioWithAccountsWithTransactionsIsCorrect
	
	| familyPortfolio myAccount angiesAccount childrenPortfolio johnsAccount |
	
	myAccount _ ReceptiveAccount named: 'Cuenta Mia'.
	Deposit register: 100 * peso on: myAccount.
	Withdraw register: 50 * peso on: myAccount.
	johnsAccount _ ReceptiveAccount named: 'Cuenta de Juan'.
	Deposit register: 100 * peso on: johnsAccount.
	Withdraw register: 50 * peso on: johnsAccount.
	angiesAccount _ ReceptiveAccount named: 'Cuenta de Angeles'.
	Deposit register: 100 * peso on: angiesAccount.
	TransferOperation register: 75 * peso from: angiesAccount to: ReceptiveAccount new. 
	childrenPortfolio _ Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
		
	self assert: self expectedDetailedPortfolioTreeForComposedPortfolioWithAccountsWithTransactions 
		equals: (PortfolioDetailedTreePrinterReport generateReportFor: familyPortfolio).  
	
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'test objects' stamp: 'MR 12/16/2020 12:35:21'!
accountWithASingleDeposit

	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	
	^anAccount! !


!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/9/2020 22:02:27'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/9/2020 22:02:40'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/9/2020 22:02:49'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/9/2020 22:02:57'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/9/2020 22:03:13'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/9/2020 22:03:25'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/9/2020 22:03:32'!
test07BalanceOfAnEmptyPortfolioIsZero

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: aPortfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/16/2020 12:36:39'!
test08BalanceOfAPortfolioWithASingleAccountEqualsTheAccountBalance

	| aPortfolio anAccount |
	
	anAccount _ self accountWithASingleDeposit.
	aPortfolio _ Portfolio with: anAccount.
	
	self assert: aPortfolio balance equals: 100 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/16/2020 12:37:58'!
test09BalanceOfAComposedPortfolioIsTheSumOfTheBalancesOfTheAccountsItContains

	| aPortfolio aRootPortfolio |
	
	aPortfolio _ Portfolio with: self accountWithASingleDeposit .
	aRootPortfolio _ Portfolio with: self accountWithASingleDeposit with: aPortfolio.
	
	self assert: aRootPortfolio balance equals: 200 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:45:46'!
test10EmptyPortfolioDoesNotKnowAnyTransactions

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self deny: (aPortfolio hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/9/2020 22:04:01'!
test11PortfolioKnowsATransactionRegisteredInOneOfItsAccounts

	| aPortfolio anAccount aDeposit |
	
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 100 * peso on: anAccount.
	aPortfolio _ Portfolio with: anAccount.
	
	self assert: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:47:14'!
test12PortfolioDoesNotKnowATransactionNotRegisteredInItsAccounts

	| aPortfolio anAccount |
	
	anAccount _ ReceptiveAccount new.
	aPortfolio _ Portfolio with: anAccount.
	
	self deny: (aPortfolio hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'MR 12/16/2020 12:40:12'!
test13AComposedPortfolioKnowsATransactionRegisteredInOneOfItsLeafAccounts

	| aPortfolio aRootPortfolio anAccount anotherAccount aTransfer |
	
	anAccount _ self accountWithASingleDeposit .
	anotherAccount _ ReceptiveAccount new.
	aTransfer _ TransferOperation register: 50 * peso from: anAccount to: anotherAccount.
	aPortfolio _ Portfolio with: anAccount.
	aRootPortfolio _ Portfolio with: anotherAccount with: aPortfolio.
	
	self assert: (aRootPortfolio hasRegistered: (aTransfer outgoingTransfer)).! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTreePrinterTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 17:26:11'!
expectedPortfolioTreeForComposedPortfolioWithAccounts

	| expectedTree |
		
	expectedTree _ OrderedCollection new.
	expectedTree add: 'Portfolio de la familia'.
	expectedTree add: '   Mi cuenta'.
	expectedTree add: '   Portfolio de hijos'.
	expectedTree add: '      Cuenta de Juan'.
	expectedTree add: '      Cuenta de Angeles'.
	
	^expectedTree! !

!PortfolioTreePrinterTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 17:21:55'!
expectedPortfolioTreeForEmptyPortfolio

	| expectedTree |
	
	expectedTree _ OrderedCollection new.
	expectedTree add: 'Portfolio vacio'.
	
	^expectedTree! !

!PortfolioTreePrinterTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 17:23:52'!
expectedPortfolioTreeForEmptyReceptiveAccount

	| expectedTree |
	
	expectedTree _ OrderedCollection new.
	expectedTree add: 'Mi cuenta'.
	
	^expectedTree! !

!PortfolioTreePrinterTest methodsFor: 'test objects' stamp: 'MR 12/17/2020 17:24:57'!
expectedPortfolioTreeForPortfolioWithAccountIsCorrect

	| expectedTree |
		
	expectedTree _ OrderedCollection new.
	expectedTree add: 'Mi portfolio'.
	expectedTree add: '   Mi cuenta'.
	
	^expectedTree! !


!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'MR 12/17/2020 17:22:17'!
test01PortfolioTreeForEmptyPortfolioIsCorrect

	| aPortfolio |
	
	aPortfolio _ Portfolio named: 'Portfolio vacio'.
		
	self assert: self expectedPortfolioTreeForEmptyPortfolio 
		equals: (PortfolioTreePrinterReport generateReportFor: aPortfolio).! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'MR 12/17/2020 17:24:17'!
test02PortfolioTreeForEmptyReceptiveAccountIsCorrect

	| anAccount |
	
	anAccount _ ReceptiveAccount named: 'Mi cuenta'.
		
	self assert: self expectedPortfolioTreeForEmptyReceptiveAccount 
		equals: (PortfolioTreePrinterReport generateReportFor: anAccount).! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'MR 12/17/2020 17:19:06'!
test03PortfolioTreeForPortfolioWithAccountIsCorrect

	| myPortfolio myAccount expectedTree |
	
	myAccount _ ReceptiveAccount named: 'Mi cuenta'.
	myPortfolio _ Portfolio named: 'Mi portfolio' with: myAccount.
	
	expectedTree _ OrderedCollection new.
	expectedTree add: 'Mi portfolio'.
	expectedTree add: '   Mi cuenta'.
	
	self assert: expectedTree 
		equals: (PortfolioTreePrinterReport generateReportFor: myPortfolio).! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'MR 12/17/2020 17:29:05'!
test04PortfolioTreeForComposedPortfolioWithAccountsIsCorrect

	| myAccount angiesAccount childrenPortfolio familyPortfolio johnsAccount |
	
	myAccount _ ReceptiveAccount named: 'Mi cuenta'.	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: 	angiesAccount. 
	myAccount := ReceptiveAccount named: 'Mi cuenta'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	self assert: self expectedPortfolioTreeForComposedPortfolioWithAccounts 
		equals: (PortfolioTreePrinterReport generateReportFor: familyPortfolio).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'setUp/tearDown' stamp: 'MR 12/17/2020 16:03:51'!
setUp

	account _ ReceptiveAccount new 	! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MR 12/17/2020 16:03:59'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MR 12/17/2020 16:04:09'!
test02DepositIncreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MR 12/17/2020 16:04:20'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Withdraw register: 50 * peso on: account.
		
	self assert: -50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MR 12/17/2020 16:04:53'!
test04WithdrawValueMustBePositive 

	| aWithdrawValue |
	
	account _ ReceptiveAccount new.
	aWithdrawValue := 50 * peso.
	
	self assert: aWithdrawValue 
		equals: (Withdraw register: aWithdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MR 12/17/2020 16:05:21'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| aDeposit aWithdraw |
	
	aDeposit _ Deposit register: 100 * peso on: account.
	aWithdraw _ Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: aDeposit).
	self assert: (account hasRegistered: aWithdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MR 12/17/2020 16:05:40'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit _  Deposit for: 100 * peso.
	withdraw _ Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: 'originAccount destinationAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNetTest methodsFor: 'tests' stamp: 'AG 12/15/2020 23:56:31'!
test01EmptyAccountTransferNetIsZero

	| aReportResult |
	
	aReportResult _ TransferNetReport new generateReportFor: originAccount .	
	
	self assert: aReportResult equals: 0 * peso. ! !

!TransferNetTest methodsFor: 'tests' stamp: 'MR 12/16/2020 12:42:32'!
test02TransferNetsOfAccountsInvolvedInATransferAreCorrect

	TransferOperation register: 75 * peso from: originAccount to: destinationAccount.
		
	self assert: -75 * peso 
		equals: (TransferNetReport new generateReportFor: originAccount). 
	self assert: 75 * peso 
		equals: (TransferNetReport new generateReportFor: destinationAccount).! !

!TransferNetTest methodsFor: 'tests' stamp: 'MR 12/16/2020 12:42:50'!
test03TransferNetsOfAccountsInvolvedInMultipleTransfersAreCorrect

	TransferOperation register: 60 * peso from: originAccount to: destinationAccount.
	TransferOperation register: 40 * peso from: destinationAccount to: originAccount.
	TransferOperation register: 10 * peso from: destinationAccount to: originAccount.
	TransferOperation register: 5 * peso from: originAccount to: destinationAccount.
		
	self assert: -15 * peso 
		equals: (TransferNetReport new generateReportFor: originAccount). 
	self assert: 15 * peso 
		equals: (TransferNetReport new generateReportFor: destinationAccount).! !

!TransferNetTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:51:09'!
test04EmptyPortfolioTransferNetIsZero

	self assert: 0 * peso 
		equals: (TransferNetReport new generateReportFor: Portfolio new). ! !

!TransferNetTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:51:56'!
test05TransferNetOfPortfolioWithOneAccountReturnsTransferNetOfAccount
	
	| aPortfolio |
	
	aPortfolio _ Portfolio with: originAccount.
	
	TransferOperation register: 75 * peso from: originAccount to: destinationAccount.
	
	self assert: -75 * peso 
		equals: (TransferNetReport new generateReportFor: aPortfolio).! !

!TransferNetTest methodsFor: 'tests' stamp: 'MR 12/17/2020 15:52:24'!
test06TransferNetOfComposedPortfolioIsTheSumOfTheTransferNetsOfItsAccounts

	| aRootPortfolio aPortfolio anOffshoreAccount |
	
	anOffshoreAccount _ ReceptiveAccount new. 
	aPortfolio _ Portfolio with: originAccount. 
	aRootPortfolio _ Portfolio with: aPortfolio with: destinationAccount.
	
	TransferOperation register: 50 * peso from: originAccount to: anOffshoreAccount.
	TransferOperation register: 25 * peso from: anOffshoreAccount to: destinationAccount.
		
	self assert: -25 * peso 
		equals: (TransferNetReport new generateReportFor: aRootPortfolio).! !


!TransferNetTest methodsFor: 'setUp/tearDown' stamp: 'MR 12/17/2020 15:50:48'!
setUp

	originAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: originAccount. 
	
	destinationAccount _ ReceptiveAccount new.
	! !


!classDefinition: #TransferOperationTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferOperationTest
	instanceVariableNames: 'originAccount destinationAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferOperationTest methodsFor: 'setUp/tearDown' stamp: 'MR 12/17/2020 15:54:53'!
setUp

	originAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: originAccount.
	
	destinationAccount _ ReceptiveAccount new.
	! !


!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/17/2020 15:56:13'!
test01TransferCorrectlyChangesAccountsBalances

	TransferOperation register: 25 * peso from: originAccount to: destinationAccount.
		
	self assert: 75 * peso equals: originAccount balance.
	self assert: 25 * peso equals: destinationAccount balance.! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/17/2020 15:56:40'!
test02TransferValueMustBePositive

	| aTransferAmount |
	
	aTransferAmount _ 50 * peso.
	
	self assert: aTransferAmount 
		equals: 	(TransferOperation register: aTransferAmount from: originAccount to: destinationAccount) transferedAmount ! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/17/2020 15:57:26'!
test03SenderAndReceiverAccountsRegisterTransferCorrectly

	| aTransfer |
	
	aTransfer _ TransferOperation register: 50 * peso from: originAccount to: destinationAccount.
	
	self assert: (originAccount hasRegistered: aTransfer outgoingTransfer).
	self assert: (destinationAccount hasRegistered: aTransfer incomingTransfer).
! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/17/2020 15:57:58'!
test04BothLegsOfTheTransferKnowTheirCounterparts

	| aTransfer anIncomingTransfer anOutgoingTransfer |
	
	aTransfer _ TransferOperation register: 50 * peso from: originAccount to: destinationAccount.
	anIncomingTransfer _ aTransfer outgoingTransfer.
	anOutgoingTransfer _ aTransfer incomingTransfer.
	
	self assert: anIncomingTransfer counterpart = anOutgoingTransfer.
	self assert: anOutgoingTransfer counterpart = anIncomingTransfer.! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/17/2020 15:58:30'!
test05BothLegsHaveTheSameValue

	| aTransfer aTransferValue |
	
	aTransferValue _ 50 * peso.
	aTransfer _ TransferOperation register: aTransferValue from: originAccount to: destinationAccount.
	
	self assert: aTransfer outgoingTransfer value = aTransferValue.
	self assert: aTransfer incomingTransfer value = aTransferValue.! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/17/2020 16:01:03'!
test06SenderAccountWithInsufficientFundsCannotMakeATransfer
	
	Deposit register: 50 * peso on: destinationAccount.
	
	self should: [TransferOperation register: 300 * peso from: originAccount to: destinationAccount.]
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Insufficient Funds'.
						self assert: 100 * peso equals: originAccount balance.
						self assert: 50 * peso equals: destinationAccount balance.].! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/17/2020 16:01:15'!
test07AnInvalidSenderAccountCancelsTransfer
	
	self should: [TransferOperation register: 100 * peso from: 5 to: destinationAccount]
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Invalid Sender Account'.
						self assert: destinationAccount balance equals: 0 * peso].! !

!TransferOperationTest methodsFor: 'transfer tests' stamp: 'MR 12/17/2020 16:01:30'!
test08AnInvalidReceiverAccountCancelsTransfer
	
	self should: [TransferOperation register: 100 * peso from: originAccount to: 'Hola!!']
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Invalid Receiver Account'.
						self assert: originAccount balance equals: 100 * peso].! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'reporting - private' stamp: 'MR 12/16/2020 14:22:45'!
participateInReport: aReport

	^self subclassResponsibility ! !


!Account methodsFor: 'naming' stamp: 'MR 12/17/2020 16:29:32'!
changeAccountNameTo: aNewName

	^self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'MR 12/17/2020 16:29:03'!
accountName

	^self subclassResponsibility! !

!Account methodsFor: 'accessing' stamp: 'MR 12/16/2020 12:52:14'!
balance

	^self subclassResponsibility ! !

!Account methodsFor: 'accessing' stamp: 'AG 12/15/2020 23:30:10'!
transactionsDo: aBlock

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Ejercicio'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'MR 12/17/2020 16:47:56'!
named: aName 

	^self new changeAccountNameTo: aName;
			yourself.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'MR 12/17/2020 16:39:09'!
initialize

	accounts _ OrderedCollection new.
	parents _ OrderedCollection new.
	name _ 'Undefined name'! !


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


!Portfolio methodsFor: 'accessing' stamp: 'MR 12/17/2020 16:21:45'!
accountName

	^name! !

!Portfolio methodsFor: 'accessing' stamp: 'MR 12/16/2020 13:46:35'!
accountsDo: aBlock.

	accounts do: aBlock! !

!Portfolio methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accessing' stamp: 'MR 12/9/2020 20:45:58'!
balance
	
	^accounts sum: [:anAccount | anAccount balance] ifEmpty: [0 * peso]
	! !


!Portfolio methodsFor: 'reporting - private' stamp: 'MR 12/16/2020 14:22:17'!
participateInReport: aReport

	aReport considerPortfolio: self.! !


!Portfolio methodsFor: 'naming' stamp: 'MR 12/17/2020 16:22:20'!
changeAccountNameTo: aNewName
	
	^name _ aNewName! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'MR 12/17/2020 16:22:20'!
named: aName with: anAccount
	
	^(self with: anAccount)
		changeAccountNameTo: aName;
		yourself.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'MR 12/17/2020 16:22:20'!
named: aName with: anAccount with: anotherAccount
	
	^(self with: anAccount with: anotherAccount)
		changeAccountNameTo: aName;
		yourself.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MR 12/17/2020 16:39:26'!
initialize

	transactions _ OrderedCollection new.
	name _ 'Undefined name'! !


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


!ReceptiveAccount methodsFor: 'accessing' stamp: 'MR 12/17/2020 16:21:45'!
accountName

	^name! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'AG 12/13/2020 18:25:48'!
balance
	
	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'MR 12/14/2020 20:08:38'!
transactionsDo: aBlock.

	transactions do: aBlock! !


!ReceptiveAccount methodsFor: 'naming' stamp: 'MR 12/17/2020 16:22:20'!
changeAccountNameTo: aName
 
	name _ aName.! !


!ReceptiveAccount methodsFor: 'reporting - private' stamp: 'MR 12/16/2020 14:22:31'!
participateInReport: aReport

	aReport considerReceptiveAccount: self.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AG 12/9/2020 17:25:30'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting - private' stamp: 'AG 12/15/2020 23:34:14'!
participateInReport: aReport

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'AG 12/13/2020 18:18:48'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'AG 12/9/2020 17:26:37'!
value

	^value! !


!Deposit methodsFor: 'reporting - private' stamp: 'AG 12/15/2020 23:06:05'!
participateInReport: aReport

	^aReport considerDeposit: self! !


!Deposit methodsFor: 'initialization' stamp: 'MR 12/9/2020 22:00:20'!
initializeFor: aValue

	value _ aValue ! !


!Deposit methodsFor: 'balance' stamp: 'AG 12/13/2020 18:17:50'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'MR 12/17/2020 16:41:54'!
register: aValue on: anAccount

	| aTransaction |
	
	aTransaction _ self for: aValue.
	anAccount register: aTransaction.
		
	^aTransaction! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'MR 12/17/2020 16:42:22'!
registerAsPartOf: aTransfer

	^self new initializeAsPartOf: aTransfer.
! !


!classDefinition: #IncomingTransfer category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #IncomingTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!IncomingTransfer methodsFor: 'counterpart' stamp: 'MR 12/9/2020 19:47:51'!
counterpart

	^transfer outgoingTransfer! !


!IncomingTransfer methodsFor: 'reporting - private' stamp: 'AG 12/15/2020 23:05:50'!
participateInReport: aReport

	^aReport considerIncomingTransfer: self! !


!IncomingTransfer methodsFor: 'balance' stamp: 'AG 12/13/2020 18:18:22'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #OutgoingTransfer category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #OutgoingTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OutgoingTransfer methodsFor: 'balance' stamp: 'AG 12/13/2020 18:18:30'!
affectBalance: aBalance

	^aBalance - self value! !


!OutgoingTransfer methodsFor: 'reporting - private' stamp: 'AG 12/15/2020 23:05:39'!
participateInReport: aReport

	^aReport considerOutgoingTransfer: self! !


!OutgoingTransfer methodsFor: 'counterpart' stamp: 'AG 12/9/2020 17:34:44'!
counterpart

	^transfer incomingTransfer! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'reporting - private' stamp: 'AG 12/15/2020 23:05:03'!
participateInReport: aReport

	^aReport considerWithdraw: self! !


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

!Withdraw class methodsFor: 'instance creation' stamp: 'MR 12/17/2020 16:41:59'!
register: aValue on: anAccount

	| aTransaction |
	
	aTransaction _ self for: aValue.
	anAccount register: aTransaction.
		
	^aTransaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Report methodsFor: 'report creation' stamp: 'MR 12/14/2020 20:00:21'!
generateReportFor: anAccount
	
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'report creation' stamp: 'MR 12/17/2020 16:43:29'!
generateReportFor: anAccount

	^self new generateReportFor: anAccount
	! !


!classDefinition: #AccountSummaryReport category: 'ServiciosFinancieros-Ejercicio'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummaryReport methodsFor: 'report creation - private' stamp: 'MR 12/16/2020 12:30:43'!
considerDeposit: aDeposit

	accountSummary add: 'Depósito por ', aDeposit value asString.
	
	

	! !

!AccountSummaryReport methodsFor: 'report creation - private' stamp: 'MR 12/16/2020 12:30:43'!
considerIncomingTransfer: anIncomingTransfer

	accountSummary add: 'Entrada por transferencia de ', anIncomingTransfer value asString.

	

	
	
	

	! !

!AccountSummaryReport methodsFor: 'report creation - private' stamp: 'MR 12/16/2020 12:30:43'!
considerOutgoingTransfer: anOutgoingTransfer

	accountSummary add: 'Salida por transferencia de ', anOutgoingTransfer value asString.

	
	
	
	

	! !

!AccountSummaryReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 18:09:54'!
considerPortfolio: aPortfolio

	aPortfolio accountsDo: [:anAccount | anAccount participateInReport: self].
	
	
	

	! !

!AccountSummaryReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 18:10:02'!
considerReceptiveAccount: aReceptiveAccount

	aReceptiveAccount transactionsDo: [:aTransaction | aTransaction participateInReport: self]. 
	
	
	

	! !

!AccountSummaryReport methodsFor: 'report creation - private' stamp: 'MR 12/16/2020 12:30:43'!
considerWithdraw: aWithdraw

	accountSummary add: 'Extracción por ', aWithdraw value asString.

	

	
	
	

	! !


!AccountSummaryReport methodsFor: 'report creation' stamp: 'MR 12/17/2020 18:09:45'!
generateReportFor: anAccount

	self initialize.
	anAccount participateInReport: self.
	accountSummary add: 'Balance = ', anAccount balance asString.
	
	^accountSummary 
	
	
	

	! !


!AccountSummaryReport methodsFor: 'initialization' stamp: 'MR 12/16/2020 12:30:43'!
initialize

	accountSummary _ OrderedCollection new.! !


!classDefinition: #PortfolioTreePrinterReport category: 'ServiciosFinancieros-Ejercicio'!
Report subclass: #PortfolioTreePrinterReport
	instanceVariableNames: 'portfolioTree currentDepth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTreePrinterReport methodsFor: 'initialization' stamp: 'MR 12/17/2020 18:13:52'!
initialize

	currentDepth _ ''.
	portfolioTree _ OrderedCollection new.! !


!PortfolioTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 16:51:31'!
considerPortfolio: aPortfolio

	portfolioTree add: currentDepth, aPortfolio accountName.
	self increaseDepth.
	aPortfolio accountsDo: [:anAccount | anAccount participateInReport: self].
	self decreaseDepth! !

!PortfolioTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 16:21:45'!
considerReceptiveAccount: aReceptiveAccount

	portfolioTree add: currentDepth, aReceptiveAccount accountName.! !

!PortfolioTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 16:52:53'!
decreaseDepth

	^currentDepth _ currentDepth truncateTo: (currentDepth size -3)! !

!PortfolioTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 16:51:22'!
increaseDepth

	^ currentDepth _ currentDepth, '   '! !


!PortfolioTreePrinterReport methodsFor: 'report creation' stamp: 'MR 12/17/2020 18:12:35'!
generateReportFor: anAccount 
	
	self initialize.
	anAccount participateInReport: self.
	
	^portfolioTree.! !


!classDefinition: #PortfolioDetailedTreePrinterReport category: 'ServiciosFinancieros-Ejercicio'!
PortfolioTreePrinterReport subclass: #PortfolioDetailedTreePrinterReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioDetailedTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 17:00:48'!
considerDeposit: aDeposit

	portfolioTree add: currentDepth, 'Depósito por ', aDeposit value asString.! !

!PortfolioDetailedTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 17:00:51'!
considerIncomingTransfer: anIncomingTransfer

	portfolioTree add: currentDepth, 'Entrada por transferencia de ', anIncomingTransfer value asString.
! !

!PortfolioDetailedTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 17:00:54'!
considerOutgoingTransfer: anOutgoingTransfer

	portfolioTree add: currentDepth, 'Salida por transferencia de ', anOutgoingTransfer value asString.
! !

!PortfolioDetailedTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 17:00:59'!
considerPortfolio: aPortfolio

	portfolioTree add: currentDepth, aPortfolio accountName.
	self increaseDepth.
	aPortfolio accountsDo: [:anAccount | anAccount participateInReport: self].
	portfolioTree add: currentDepth, 'Balance = ', aPortfolio balance asString.
	self decreaseDepth.
	! !

!PortfolioDetailedTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 17:01:06'!
considerReceptiveAccount: aReceptiveAccount

	portfolioTree add: currentDepth, aReceptiveAccount accountName.
	self increaseDepth.
	aReceptiveAccount transactionsDo: [:aTransaction | aTransaction participateInReport: self].
	portfolioTree add: currentDepth, 'Balance = ', aReceptiveAccount balance asString.
	self decreaseDepth! !

!PortfolioDetailedTreePrinterReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 17:01:09'!
considerWithdraw: aWithdraw

	portfolioTree add: currentDepth, 'Extracción por ', aWithdraw value asString.
! !


!classDefinition: #TransferNetReport category: 'ServiciosFinancieros-Ejercicio'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNetReport methodsFor: 'report creation - private' stamp: 'AG 12/15/2020 23:09:59'!
considerDeposit: aDeposit

	! !

!TransferNetReport methodsFor: 'report creation - private' stamp: 'MR 12/16/2020 12:30:50'!
considerIncomingTransfer: anIncomingTransfer

	^transferNet _ transferNet + anIncomingTransfer value 

	! !

!TransferNetReport methodsFor: 'report creation - private' stamp: 'MR 12/16/2020 12:30:50'!
considerOutgoingTransfer: anOutgoingTransfer

	^transferNet _ transferNet - anOutgoingTransfer value 

	! !

!TransferNetReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 18:19:09'!
considerPortfolio: aPortfolio

	aPortfolio accountsDo: [:anAccount | anAccount participateInReport: self ]. 
	



	! !

!TransferNetReport methodsFor: 'report creation - private' stamp: 'MR 12/17/2020 18:18:46'!
considerReceptiveAccount: aReceptiveAccount

	aReceptiveAccount transactionsDo: [:aTransaction | aTransaction participateInReport: self ]. 
	



	! !

!TransferNetReport methodsFor: 'report creation - private' stamp: 'AG 12/15/2020 23:09:54'!
considerWithdraw: aWithdraw



	! !


!TransferNetReport methodsFor: 'report creation' stamp: 'MR 12/17/2020 18:18:09'!
generateReportFor: anAccount
	
	self initialize.
	anAccount participateInReport: self.
	
	^transferNet 

	! !


!TransferNetReport methodsFor: 'initialization' stamp: 'MR 12/16/2020 12:30:50'!
initialize

	transferNet _ 0 * peso

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
