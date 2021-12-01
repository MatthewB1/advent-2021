import os

fn main() {
	//read file into []string
	mut values := os.read_lines('input.txt') or {println(err) return}

	mut increase_count := 0
	mut prevsum := 0

	//increase length of array, must be a better way of doing this lol
	values << []string{len:48}
	
	valcap := values.cap
	for i :=0; i < valcap - 2; i++ {
		sum := values[i].int() + values[i+1].int() + values[i+2].int()
		if  sum > prevsum {
			increase_count++
		}
		prevsum = sum
	}
	//when printing, ignore first
	println(increase_count - 1)
}
