$alphas = 'abcdefghijklmnopqrstuvwxyz'

def rotx(x, str, cipher=:encrypt)
	if cipher == :encrypt
		return encrypt(x,str)
	elsif cipher == :decrypt
		return decrypt(x,str)
	end
end

def encrypt(x,str)
	# encrypt logic
	return str.each_char.collect { |ch|
		if /^[a-z]$/ === ch
			idx = $alphas.index(ch)+x
			if idx > 25
				idx = idx%26
			end
			$alphas[idx].chr
		elsif /^[A-Z]$/ === ch
			idx = $alphas.index(ch.downcase)+x
			if idx > 25
				idx = idx%26
			end
			$alphas[idx].chr.upcase
		else
			# regex that matches non-alphabetic characters to keep in the orig_str.
			if ch.match(/[[:space:]|\,\.\!\?\;]|\n,\t/)
				ch
			end
		end
	}.join("")
end

def decrypt(x,str)
	# decrypt logic
	return str.each_char.collect { |ch|
		if /^[a-z]$/ === ch
			idx = $alphas.index(ch)-x
			if idx < 0
				idx = idx%26
			end
			$alphas[idx].chr
		elsif /^[A-Z]$/ === ch
			idx = $alphas.index(ch.downcase)-x
			if idx < 0
				idx = idx%26
			end
			$alphas[idx].chr.upcase
		else
			ch
		end
	}.join("")
end

# the number of characters to rotate. can be any number > 0
rotate = 1000000
# the original string to be encrypted
orig_str = 'the string to encrypt'

puts enc_str = rotx(rotate,orig_str)
puts rotx(rotate,enc_str,:decrypt)
