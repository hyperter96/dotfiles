package main

import (
	"fmt"

	"github.com/BooleanCat/option"
)

type Person struct {
	Name string `json:"name,omitempty"`
	Id   int    `json:"id,omitempty"`
}

// person eats sth
func (p *Person) eat(food string) {
	fmt.Printf("%s is eating %s\n", p.Name, food)
}

// person plays sth
func (p *Person) play(item string) {
	fmt.Printf("%s is playing %s\n", p.Name, item)
}

func FindPerson(p option.Option[*Person]) string {
	return p.UnwrapOrElse(func() *Person {
		return &Person{Name: "Foo"}
	}).Name
}

func main() {
	fmt.Println("hello world")
	for _, item := range []int{1, 2} {
		fmt.Println(item)
	}
	p1 := &Person{Name: "Peter", Id: 1}
	// p2 := Person{name: "Alex", id: 2}
	p1.eat("stuff")
	// var p2 *Person
	fmt.Println(FindPerson(option.Some(p1)))
	fmt.Println(FindPerson(option.None[*Person]()))
}
