import os

fn main() {
	//read file into string
	inputs := os.read_file('input.txt') or {println(err) return}
	split_inputs := inputs.split('\n\r\n')

	bingo_calls := split_inputs.first().split(',')

	mut bingo_sheets := split_inputs[1..].map(fn (v string) [][]string {
		return v.split('\n').map(it.split(' ').filter(it != ''))
	})

	for call in bingo_calls {
		println('current call: $call')
		for i, sheet in bingo_sheets {
			for j, line in sheet {
				for k, num in line {
					if num == call {
						bingo_sheets[i][j][k] = 'X'
					}
				}
			}

			if check_winner(sheet) {
				remaining_sheet_sum := calc_remaining_sheet_sum(sheet)
				for line in sheet {
					println(line)
				}
				product := remaining_sheet_sum * call.int()
				println('Sum of remaining numbers * current call = $remaining_sheet_sum * $call = $product')
				exit(0)
			}
		}
	}
}

fn check_winner(sheet [][]string) bool{
	// println(sheet)
	for line in sheet {
		if line.all(it == 'X') {
			return true
		}
	}

	line_len := sheet.first().len

	for i in 0 .. line_len -1 {
		mut temp := []string{}
		for line in sheet {
			temp << line[i]
		}
		if temp.all(it == 'X') {
			return true
		}
	}

	return false
}

fn calc_remaining_sheet_sum(sheet [][]string) int{
	mut sum := 0

	for line in sheet {
		ints := line.filter(it != 'X').map(it.int())
		for val in ints {
			sum += val
		}
	}
	return sum
}
