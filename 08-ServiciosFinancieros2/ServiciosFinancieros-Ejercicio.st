!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'MR 12/10/2020 20:42:49'!
test01

	| anAccount |
	
	anAccount _ ReceptiveAccount new.
	
	self assert:  anAccount accountSummary isEmpty! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'MR 12/10/2020 20:46:38'!
test02

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert:  aPortfolio accountSummary isEmpty! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'MR 12/10/2020 21:22:40'!
test03

	| anAccount aSummary |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount. 
	aSummary _ anAccount accountSummary.
	
	self assert: 1 equals: aSummary size.
	self assert: (aSummary includes: 'Depósito por 100 pesos') ! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'MR 12/10/2020 21:26:35'!
test04

	| anAccount aPortfolio aSummary |
	
	anAccount _ ReceptiveAccount new.
	aPortfolio _ Portfolio with: anAccount.
	Deposit register: 100 * peso on: anAccount. 
	aSummary _ aPortfolio accountSummary.
	
	self assert: 1 equals: aSummary size.
	self assert: (aSummary includes: 'Depósito por 100 pesos') ! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'MR 12/10/2020 21:07:51'!
test05

	| aRootPortfolio aPortfolio |
	
	aPortfolio _ Portfolio new.
	aRootPortfolio _ Portfolio with: aPortfolio.
	
	self assert: aRootPortfolio accountSummary isEmpty.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'MR 12/10/2020 21:22:06'!
test06

	| anAccount aSummary |
	
	anAccount _ ReceptiveAccount new.
	Withdraw register: 50 * peso on: anAccount. 
	aSummary _ anAccount accountSummary.
	
	self assert: 1 equals: aSummary size.
	self assert: (aSummary includes: 'Extracción por 50 pesos') ! !


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

!Account methodsFor: 'as yet unclassified' stamp: 'MR 12/10/2020 21:04:59'!
accountSummary

	^self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

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


!Portfolio methodsFor: 'summary' stamp: 'MR 12/10/2020 21:18:43'!
accountSummary
	
	| anAccountSummary |
	
	anAccountSummary _ OrderedCollection new.
	accounts do: [:anAccount | anAccountSummary addAllLast: anAccount accountSummary].
		
	^anAccountSummary! !

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


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MR 12/9/2020 20:44:53'!
balance
	
	^transactions sum: [:aTransaction | aTransaction valueToRecordInBalance ] ifEmpty: [0 * peso].
	! !

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


!ReceptiveAccount methodsFor: 'summary' stamp: 'MR 12/10/2020 21:33:48'!
accountSummary

	| anAccountSummary aTransaction |
	
	anAccountSummary _ OrderedCollection new.
	transactions ifEmpty: [^anAccountSummary].
	aTransaction _ transactions at: 1.
	(aTransaction isKindOf: Deposit) ifTrue: [	anAccountSummary add: 'Depósito por ', aTransaction value.].
	(aTransaction isKindOf: Withdraw) ifTrue: [	anAccountSummary add: 'Extracción por ', aTransaction value.].
	
	^anAccountSummary! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AG 12/9/2020 17:25:30'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'MR 12/9/2020 21:43:03'!
valueToRecordInBalance

	^self subclassResponsibility ! !

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


!classDefinition: #AdditiveTransaction category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #AdditiveTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AdditiveTransaction methodsFor: 'private' stamp: 'MR 12/9/2020 20:43:07'!
valueToRecordInBalance

	^self value! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AdditiveTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'AG 12/9/2020 17:26:37'!
value

	^value! !


!Deposit methodsFor: 'initialization' stamp: 'MR 12/9/2020 22:00:20'!
initializeFor: aValue

	value _ aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #IncomingTransfer category: 'ServiciosFinancieros-Ejercicio'!
AdditiveTransaction subclass: #IncomingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!IncomingTransfer methodsFor: 'value' stamp: 'AG 12/9/2020 17:34:23'!
value

	^transfer transferedAmount ! !


!IncomingTransfer methodsFor: 'counterpart' stamp: 'MR 12/9/2020 19:47:51'!
counterpart

	^transfer outgoingTransfer! !


!IncomingTransfer methodsFor: 'initialization' stamp: 'AG 12/9/2020 17:34:23'!
initializeAsPartOf: aTransfer 
	
	transfer _ aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
IncomingTransfer class
	instanceVariableNames: ''!

!IncomingTransfer class methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:35:09'!
registerAsPartOf: aTransfer

	^self new initializeAsPartOf: aTransfer! !


!classDefinition: #SubtractiveTransaction category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #SubtractiveTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!SubtractiveTransaction methodsFor: 'private' stamp: 'MR 12/9/2020 20:43:26'!
valueToRecordInBalance

	^self value negated! !


!classDefinition: #OutgoingTransfer category: 'ServiciosFinancieros-Ejercicio'!
SubtractiveTransaction subclass: #OutgoingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OutgoingTransfer methodsFor: 'initialization' stamp: 'MR 12/9/2020 20:20:08'!
initializeAsPartOf: aTransfer

	transfer _ aTransfer.! !


!OutgoingTransfer methodsFor: 'counterpart' stamp: 'AG 12/9/2020 17:34:44'!
counterpart

	^transfer incomingTransfer! !


!OutgoingTransfer methodsFor: 'value' stamp: 'AG 12/9/2020 17:34:30'!
value

	^transfer transferedAmount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
OutgoingTransfer class
	instanceVariableNames: ''!

!OutgoingTransfer class methodsFor: 'as yet unclassified' stamp: 'MR 12/9/2020 20:20:08'!
registerAsPartOf: aTransfer

	^self new initializeAsPartOf: aTransfer.

	! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
SubtractiveTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'MR 12/9/2020 22:00:57'!
initializeFor: aValue

	value _ aValue ! !


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
