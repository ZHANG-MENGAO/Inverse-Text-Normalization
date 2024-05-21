# the file path to the libriheavy dataset. Should contain libriheavy_cuts_{split}.jsonl
data_path = "/home/mazhang/pt/libriheavy"

# The spilits that are going to be processed
splits = ['small', 'medium', 'dev', 'test_clean', 'test_clean_large', 'test_other', 'test_other_large']

# symbols to be kept, because they are meaningful and not caused by errors                
# the errors here means the errorous word present in the BookText for example:tne$r(their)
# By default all non-ascii characters will be dropped by dropping the whole instance      
# all ascii symbols will be dropped by eliminating the mismatches containing them         
non_ascii_exceptions = "αβρ£°´"
ascii_exceptions = "!\"$&',.:;?"

# Defines the symbols and patterns to be dropped. 
# The instance will be dropped if it contains the following ascii
bad_ascii = "+=@\|"
# The patterns that will be removed
patterns_remove = [
    r"[\(\)_`~*]",                  # remove ()_`~*
    r"<.*?>",                   # remove <> and content within
    r"\[[iI]llustration.*?\]",  # remove [illustration xxx]
    r"\[FN#.*?\]",              # remove [FN#]
    r"\[\d*?\]",                # remove [num]
    r"'(?<!\$)\b[^$\s]+\$\D[^$\s]*\b'", # remove errornous text containing $
]

# threshold for dropping least similar instances
threshold_ratio = 0.6