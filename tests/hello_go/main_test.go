package main

import "testing"

func TestPerson_eat(t *testing.T) {
	type fields struct {
		name string
		id   int
	}
	type args struct {
		food string
	}
	tests := []struct {
		name   string
		fields fields
		args   args
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			p := &Person{
				name: tt.fields.name,
				id:   tt.fields.id,
			}
			p.eat(tt.args.food)
		})
	}
}

func TestPerson_play(t *testing.T) {
	type fields struct {
		name string
		id   int
	}
	type args struct {
		item string
	}
	tests := []struct {
		name   string
		fields fields
		args   args
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			p := &Person{
				name: tt.fields.name,
				id:   tt.fields.id,
			}
			p.play(tt.args.item)
		})
	}
}

func Test_main(t *testing.T) {
	tests := []struct {
		name string
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			main()
		})
	}
}
