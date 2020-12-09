!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:32'!
test01PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:38'!
test02PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio hasAccount: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:45'!
test03PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:51'!
test04ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:57'!
test05ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:10:03'!
test06PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify hasAccounts ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:33'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:48'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:54'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:01'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:08'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #TransferOperationTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferOperationTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferOperationTest methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 18:12:22'!
test01TransferCorrectlyChangesAccountsBalances

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: senderAccount.
	Deposit register: 100 * peso on: receiverAccount.
	
	TransferOperation register: 50 * peso from: senderAccount to: receiverAccount.
		
	self assert: 50 * peso equals: senderAccount balance.
	self assert: 150 * peso equals: receiverAccount balance.! !

!TransferOperationTest methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 18:16:59'!
test02TransferValueMustBePositive

	| senderAccount receiverAccount transferenceAmount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: senderAccount.
	
	transferenceAmount := 50 * peso.
	self assert: transferenceAmount equals: 
		(TransferOperation register: transferenceAmount from: senderAccount to: receiverAccount) transferedAmount ! !

!TransferOperationTest methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 18:21:30'!
test03SenderAndReceiverAccountsRegisterTransferCorrectly

	| senderAccount receiverAccount transference |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: senderAccount.
	
	transference := TransferOperation register: 50 * peso from: senderAccount to: receiverAccount.
	self assert: (senderAccount hasRegistered: transference outgoingTransference).
	self assert: (receiverAccount hasRegistered: transference incomingTransfer).
! !

!TransferOperationTest methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 18:24:12'!
test04BothLegsOfTheTransferKnowTheirCounterparts

	| senderAccount receiverAccount transference incomingTransference outgoingTransference |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: senderAccount.
	
	transference := TransferOperation register: 50 * peso from: senderAccount to: receiverAccount.
	incomingTransference _ transference outgoingTransference.
	outgoingTransference _ transference incomingTransfer.
	self assert: incomingTransference counterpart = outgoingTransference.
	self assert: outgoingTransference counterpart = incomingTransference.! !

!TransferOperationTest methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 18:25:27'!
test05BothLegsHaveTheSameValue

	| senderAccount receiverAccount transference transferenceValue |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: senderAccount.
	transferenceValue _ 50 * peso.
	transference := TransferOperation register: transferenceValue from: senderAccount to: receiverAccount.
	self assert: transference outgoingTransference value = transferenceValue.
	self assert: transference incomingTransfer value = transferenceValue.! !

!TransferOperationTest methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 18:26:15'!
test06SenderAccountWithInsufficientFundsCannotMakeATransfer

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	Deposit register: 50 * peso on: senderAccount.
	Deposit register: 100 * peso on: receiverAccount.
	
	self should: [TransferOperation register: 100 * peso from: senderAccount to: receiverAccount.]
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Insufficient Funds'.
						self assert: 50 * peso equals: senderAccount balance.
						self assert: 100 * peso equals: receiverAccount balance.].! !

!TransferOperationTest methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 18:28:29'!
test07AnInvalidSenderAccountCancelsTransfer
	| receiverAccount |
	receiverAccount := ReceptiveAccount new.
	self should: [TransferOperation register: 100 * peso from: 5 to: receiverAccount]
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Invalid Sender Account'.
						self assert: receiverAccount balance equals: 0 * peso].! !

!TransferOperationTest methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 18:27:51'!
test08AnInvalidReceiverAccountCancelsTransfer
	| senderAccount |
	senderAccount := ReceptiveAccount new.
	self should: [TransferOperation register: 100 * peso from: senderAccount to: 'Hola!!']
		raise: Error
		withExceptionDo: [:anError | 
						self assert: anError messageText equals: 'Invalid Receiver Account'.
						self assert: senderAccount balance equals: 0 * peso].! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AG 12/9/2020 17:11:54'!
addYourselfTo: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'AG 12/9/2020 17:25:30'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #AdditiveTransaction category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #AdditiveTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AdditiveTransaction methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:11:28'!
addYourselfTo: aBalance

	^aBalance + self value! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AdditiveTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !

!Deposit methodsFor: 'initialization' stamp: 'AG 12/9/2020 17:26:37'!
value

	^value! !


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

!IncomingTransfer methodsFor: 'initialization' stamp: 'AG 12/9/2020 17:34:23'!
counterpart

	^transfer outgoingTransference! !

!IncomingTransfer methodsFor: 'initialization' stamp: 'AG 12/9/2020 17:34:23'!
initializeAsPartOf: aTransfer 
	
	transfer _ aTransfer.! !

!IncomingTransfer methodsFor: 'initialization' stamp: 'AG 12/9/2020 17:34:23'!
value

	^transfer transferedAmount ! !

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

!SubtractiveTransaction methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:11:39'!
addYourselfTo: aBalance

	^aBalance - self value! !


!classDefinition: #OutgoingTransfer category: 'ServiciosFinancieros-Ejercicio'!
SubtractiveTransaction subclass: #OutgoingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:34:44'!
counterpart

	^transfer incomingTransfer! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:34:51'!
initializeasPartOf: aTransfer

	transfer _ aTransfer.! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:34:30'!
value

	^transfer transferedAmount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
OutgoingTransfer class
	instanceVariableNames: ''!

!OutgoingTransfer class methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:35:03'!
registerAsPartOf: aTransfer

	^self new initializeasPartOf: aTransfer.

	! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
SubtractiveTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'AG 12/9/2020 17:27:41'!
value

	^value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


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

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

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
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AG 12/9/2020 18:10:39'!
initialize

	transactions := OrderedCollection new.
	balance := 0 * peso.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AG 12/9/2020 18:09:16'!
balance
	
	"^transactions sum: [ :aTransaction | aTransaction transactionValue ] 	ifEmpty: [ 0 * peso ]."
	"| balance |
	balance _ 0 * peso.
	transactions do: [:aTransaction | balance _ aTransaction addYourselfTo: balance ].
	^balance"
	^balance! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AG 12/9/2020 18:35:20'!
register: aTransaction
	
	(aTransaction isKindOf: AccountTransaction) ifFalse: [self error: 'Invalid transaction'].
	
	transactions add: aTransaction.
	balance := aTransaction addYourselfTo: balance.
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #TransferOperation category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferOperation
	instanceVariableNames: 'transferedAmount outgoingTransfer incomingTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferOperation methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:35:33'!
incomingTransfer
	
	^incomingTransfer! !

!TransferOperation methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:35:33'!
initializeWithAmount: aTransferenceAmount from: anOriginAccount to: aDestinationAccount

	transferedAmount _ aTransferenceAmount.
	
	incomingTransfer _ IncomingTransfer registerAsPartOf: self.
	outgoingTransfer _ OutgoingTransfer registerAsPartOf: self.
	
	anOriginAccount register: outgoingTransfer.
	aDestinationAccount register: incomingTransfer.
! !

!TransferOperation methodsFor: 'as yet unclassified' stamp: 'AG 12/9/2020 17:35:27'!
outgoingTransference
	
	^outgoingTransfer! !

!TransferOperation methodsFor: 'as yet unclassified' stamp: 'AG 12/7/2020 19:26:48'!
transferedAmount
	
	^transferedAmount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferOperation class' category: 'ServiciosFinancieros-Ejercicio'!
TransferOperation class
	instanceVariableNames: ''!

!TransferOperation class methodsFor: 'instance creation' stamp: 'AG 12/9/2020 17:52:26'!
register: aTransferAmount from: aSenderAccount to: aReceiverAccount 
	
	(aSenderAccount isKindOf: ReceptiveAccount) ifFalse: [self error: 'Invalid Sender Account'].
	(aReceiverAccount isKindOf: ReceptiveAccount) ifFalse: [self error: 'Invalid Receiver Account'].

	aTransferAmount < aSenderAccount balance ifFalse: [self error: 'Insufficient Funds'].
	
	^self new initializeWithAmount: aTransferAmount from: aSenderAccount to: aReceiverAccount.
	! !

