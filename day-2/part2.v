import os

struct Submarine {
mut:
	x int
	y int
	aim int
}

fn main() {
	//read file into []string
	values := os.read_lines('input.txt') or {println(err) return}

	mut sub := Submarine{0,0, 0}

	for val in values {
		tuple := val.split(" ")
		instruction := tuple[0]
		distance := tuple[1].int()
		match instruction {
			'forward' {
				sub.x += distance
				sub.y += sub.aim * distance
				}
			'up' {sub.aim -= distance}
			'down' {sub.aim += distance}
			else {}
		}
	}

	product := sub.x * sub.y
	print("Product of length * depth = $product")
}