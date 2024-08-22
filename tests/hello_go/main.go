package main

import (
	"fmt"
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

func main() {
	fmt.Println("hello world")
	for _, item := range []int{1, 2} {
		fmt.Println(item)
	}
	p1 := Person{Name: "Peter", Id: 1}
	// p2 := Person{name: "Alex", id: 2}
	p1.eat("stuff")
}
