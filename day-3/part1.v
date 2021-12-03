import os
import strconv

fn main() {
	//read file into []string
	values := os.read_lines('input.txt') or {println(err) return}

	runeslist := values.map(fn (v string) []rune {
		return v.runes()
	})

	gamma, epsilon := calc_gamma_epsilon(runeslist)

	product := gamma * epsilon

	println("product of gamma * epsilon = $product")
}

fn calc_gamma_epsilon(runes_list [][]rune) (i64, i64) {
	array_len := runes_list[0].len

	mut gamma_runes := []rune{}

	for i :=0; i < array_len; i++ {
		mut vals := []rune{}
		for runes in runes_list {
			vals << runes[i]
		}
		gamma_runes << mode_rune(vals)
	}

	//epislon is inverted gamma
	epsilon_runes := gamma_runes.map(fn (r rune) rune {
		match r {
			`1` {return `0`}
			`0` {return `1`}
			else {return `?`}
		}
	})
	
	
	gamma := strconv.parse_int(gamma_runes.string(), 2, 32) or {println(err) return 0,0}
	epislon := strconv.parse_int(epsilon_runes.string(), 2, 32) or {println(err) return 0,0}
	return gamma, epislon
}

fn mode_rune(runes []rune) rune {
	mut rune_counts := map[rune]int{}

	for r in runes{
		match rune_counts[r] {
			0 { rune_counts[r] = 1 }
			else {rune_counts[r]++ }
		}
	}

	mut invert_map := map[int]rune{}
	for k, v in rune_counts {
		invert_map[v] = k
	}

	mut max_val := 0

	for key in invert_map.keys() {
		if key > max_val {
			max_val = key
		}
	}

	return invert_map[max_val]
}