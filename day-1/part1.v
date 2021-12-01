import os

fn main() {
	//read file into []string
	values := os.read_lines('input.txt') or {println(err) return}

	mut prev := values[0].int()

	mut increase_count := 0

	for val in values {
		if val.int() > prev {
			increase_count++
		}
		prev = val.int()
	}

	println(increase_count)
}