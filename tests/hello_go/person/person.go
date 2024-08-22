package person

import "fmt"

type Person struct {
	Name string
	Id int
}

type Do interface {
	eat(food string)
	play(item string)
}

func (p *Person) Eat(food string) {
	fmt.Printf("%s is eating %s\n", p.Name, food)
}

func (p *Person) Play(item string) {
	fmt.Printf("%s is playing %s\n", p.Name, item)
}
