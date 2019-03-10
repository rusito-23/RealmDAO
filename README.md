# RealmDAO
## Framework for iOS in Swift

### Introduction
This framework provides a DAO extra layer to use Realm in iOS development with Swift.
The main objective is to have basic transactions available for every Realm Object created in your project, without the need to re-write the code every time.

### Object creation
First, we need to understand the Transferrable protocol:

``` swift
public protocol Transferrable {
	associatedtype S
	
	func transfer() -> S	
}
```

This protocol gives us the possibility to create a Data Transfer Object for our entity:

``` swift
class Animal: Object, Transferrable {
	typealias S = AnimalTransfer
	
	func transfer() -> S {
		return AnimalTransfer()
	}
}
```

But if we feel like we don't need this extra transfer object, we can also make the function return itself:

``` swift
class Animal: Object, Transferrable {
	typealias S = Animal
	
	func transfer() -> S {
		return self
	}
}
```

It is important to understand that this transfer object is the one that will be returned from the genericDAO, not the Realm Object!

### Usage

Once we have created our objects, all we need to do is call the genericDao implementation:

``` swift
let animalDAO = GenericDAO<Animal>()
```

and at this point we can call the functions we need:

``` swift
let animals: [AnimalTransfer] = animalDAO.findAll()
let animal: AnimalTransfer = animalDAO.findByPrimaryKey(pk)
//..
```


