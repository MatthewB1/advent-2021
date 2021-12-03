import os
import strconv

fn main() {
	//read file into []string
	values := os.read_lines('input.txt') or {println(err) return}

	runeslist := values.map(fn (v string) []rune {
		return v.runes()
	})

	oxygen := calc_rating(runeslist, 'most_common')
	carbon := calc_rating(runeslist, 'least_common')
	product := oxygen * carbon

	println("product of oxygen * carbon: $oxygen * $carbon = $product")
}

fn calc_rating(in_runes_list [][]rune, filter string) (i64)	 {
	array_len := in_runes_list[0].len

	mut runes_list := in_runes_list.clone()
	for i := 0; i < array_len; i++ {
		mut vals := []rune{}
		for runes in runes_list {
			vals << runes[i]
		}
		match filter {
			'most_common' { runes_list = runes_list.filter(it[i] == mode_rune(vals, `1`)) }
			'least_common' { runes_list = runes_list.filter(it[i] != mode_rune(vals, `1`)) }
			else {}
		}	
	}

	result := runes_list.first()
	rating := strconv.parse_int(result.string(), 2, 32) or {println(err) return 0}
	return rating
}

fn mode_rune(runes []rune, prio rune) rune {
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

	//count is equal, return priority rune
	if invert_map.keys().len == 1 {
		return prio
	}

	mut max_val := 0

	for key in invert_map.keys() {
		if key > max_val {
			max_val = key
		}
	}

	return invert_map[max_val]
}