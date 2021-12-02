import os

struct Position {
mut:
	x int
	y int
}

fn main() {
	//read file into []string
	values := os.read_lines('input.txt') or {println(err) return}

	mut pos := Position{0,0}

	for val in values {
		tuple := val.split(" ")
		instruction := tuple[0]
		distance := tuple[1].int()
		match instruction {
			'forward' {pos.x += distance}
			'up' {pos.y -= distance}
			'down' {pos.y += distance}
			else {}
		}
	}

	product := pos.x * pos.y
	print("Product of length * depth = $product")
}