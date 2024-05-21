import pandas as pd
import os
import difflib
import json
import re

def extract_text(splits:list, data_path:str, non_ascii_exceptions:str, bad_ascii:str):
    """
    Extract written and spoken form text pair from libriheavy jsonl files and return the instances extracted,
    Each extracted instance is a written/spoken text pair, 
    will discard instances that contains non-ascii characters or specified bad ascii characters

    Parameters:
    - splits (list): splits for extraction
    - data_path (str): the path where libriheavy locates
    - non_ascii_exceptions (str): the non-ascii characters to be kept
    - bad_ascii (str): specified bad ascii characters

    Return:
    - dict: where key is the split name and value is the instances
    - int: the number of instances discarded
    """
    instances = {}
    discarded = 0
    for split in splits:
        file_path = os.path.join(data_path, f"libriheavy_cuts_{split}.jsonl")
        print("Extracting text from:", file_path)
        jsonObj = pd.read_json(path_or_buf=file_path, lines=True)['supervisions'].to_list()
        instances[split] = []
        for row in jsonObj:
            temp = row[0]['custom']['texts']
            if all([(x.isascii() or x in non_ascii_exceptions) and x not in bad_ascii for x in temp[0]]):
                instances[split].append({"BookText": temp[0], "ASRTranscript": temp[1]})
            else:
                discarded += 1
        print(f'number of instances for the {split} split: {len(instances[split])}')

    total = sum([len(instances[split]) for split in splits])+discarded
    print(f"total number of instances before discarding selected instances: {total}")
    print(f"number of instances dropped: {discarded} ({round(discarded/total*100, 2)}%)")
    return instances, discarded

def clean(instances:dict, splits:list, patterns_remove:list):
    for split in splits:
        ins_split = instances[split]
        for ins in ins_split:
            for pattern in patterns_remove:
                ins["BookText"] = re.sub(pattern, "", ins["BookText"])

            # Replace multiple dots, question marks, exclamation marks, commas and space with a single one
            ins["BookText"] = re.sub(r'\.{2,}', ".", ins["BookText"])
            ins["BookText"] = re.sub(r'\?{2,}', "?", ins["BookText"])
            ins["BookText"] = re.sub(r'\!{2,}', "!", ins["BookText"])
            ins["BookText"] = re.sub(r'\,{2,}', ",", ins["BookText"])
            ins["BookText"] = re.sub(r"\s+", " ", ins["BookText"])
    return instances

def align_strings(str1:str, str2:str):
    """
    Align the two strings using difflib.SequenceMatcher
    
    Parameters:
    - str1 (str): string 1 (written)
    - str2 (str): string 2 (spoken)
    
    Return:
    - match_result (list): a list of tuples, each tuple is either a pair of strings (match) or a pair of lists (mismatch). 
    - ratio (float): the similarity ratio of the two strings. 
    """
    def preprocess_for_match(in_str:str):
        out_string = ""
        for char in in_str:
            if char.isalnum():
                out_string += char
            else:
                out_string += " "+char+" "
        return out_string
    
    # Tokenize the strings into words
    str1 = preprocess_for_match(str1)
    str2 = preprocess_for_match(str2)
    words1 = str1.lower().split()
    words2 = str2.lower().split()

    # Use difflib to find the matching and unmatched sequences
    matcher = difflib.SequenceMatcher(None, words1, words2)
    matching_blocks = matcher.get_matching_blocks()

    # Extract aligned pairs of words and unmatched sequences
    match_result = []
    p1 = 0
    p2 = 0

    for block in matching_blocks:
        i, j, size = block
        # if not match
        if i>p1 or j>p2:
            match_result.append((words1[p1:i], words2[p2:j]))
        p1 = i+size
        p2 = j+size
        # if match
        if size > 0:
            match_result.extend(zip(words1[i:i+size], words2[j:j+size]))

    return match_result, matcher.ratio()

def clean_mismatched(instance:dict, match_result:list, ascii_exception:str, non_ascii_exceptions:str):
    """
    """
    for idx, match in enumerate(match_result):
        # if it is a mismatch
        if isinstance(match[0], list):
            BookText, ASRTranscript = match
            BTEmpty = (len(BookText)==0)
            ATEmpty = (len(ASRTranscript)==0)
            BTContainWords = any([x.isalnum() for x in BookText])
            BTContainSymbols = any([not x.isalnum() and x not in ascii_exception and x not in non_ascii_exceptions for x in BookText])
            
            if (
                BTContainSymbols or # the book text contains non-acceptable ascii symbols
                (idx==0 and (BTContainWords or not ATEmpty)) or # remove the mismatch at the beginning
                (idx==len(match_result)-1 and (BTContainWords or not ATEmpty)) or # remove the mismatch at the end
                #BTEmpty or # do not remove for now # remove excessive words in asr transcript
                ATEmpty and BTContainWords # contains words and not pronounced
            ):
                BookText = " ".join(BookText)
                ASRTranscript = " ".join(ASRTranscript)
                instance = remove_substring(instance, BookText, ASRTranscript)
    return instance

def remove_substring(instance:dict, BookText:str, ASRTranscript:str):
    if BookText:
        result = find_substring(instance["BookText"], BookText)
        if result is not None:
            start, end = result
            # print(f"replacing booktext: {BookText}\n In: {instance['BookText']}\nOther: {instance['ASRTranscript']}")
            instance["BookText"] = instance["BookText"][:start] + instance["BookText"][end+1:]
        else:
            print(f"Not found! Trying to find \n{BookText}\nIn: {instance['BookText']}")

    if ASRTranscript:
        result = find_substring(instance["ASRTranscript"], ASRTranscript)
        if result is not None:
            start, end = result
            # print(f"replacing asrtranscript: {ASRTranscript}\n In: {instance['ASRTranscript']}\nOther: {instance['BookText']}")
            instance["ASRTranscript"] = instance["ASRTranscript"][:start] + instance["ASRTranscript"][end+1:]
        else:
            print(f"Not found! Trying to find \n{ASRTranscript}\nIn: {instance['ASRTranscript']}")
    
    return instance

def find_substring(string:str, query:str):
    """
    Find the substring of the string that contains query, ignoring spaces and cases.
    
    Parameters:
    - string (str): the string we are looking at.
    - query (str): the string we want to find.
    
    Return:
    str: the substring"""
    if len(query)==0:
        return None
    start = 0
    end = 0
    temp_p = 0
    query = query.replace(" ", "")
    while start<=len(string)-len(query) and end<len(string):
            if string[end].lower()==query[temp_p].lower():
                end += 1
                temp_p += 1
                if temp_p == len(query):
                    return start, end
            elif string[end] == " ":
                end += 1
            else:
                start = start+1
                end = start
                temp_p = 0
    return None

def print_match_result(match_result):
    #TODO: print the matching result. e.g.:
    # I have an apple  , and I like it
    #             x                    
    # I have an orange , and I like it
    return None

def get_frequent_patterns(instances:dict):
    def preprocess_mismatch(mismatch):
        processed_sequences = []
        for ele in mismatch:
            if isinstance(ele[0], list):
                sequence = []
                w = [x for x in ele[0] if x.isalnum() or x.find("'")!=-1]
                sequence.extend(w)
                sequence.append("|")
                sequence.extend(ele[1])
                if len(sequence)>1:
                    processed_sequences.append(sequence)
        return processed_sequences
    
    mismatch_sequences = []
    for insts_split in instances.values():
        for ins in insts_split:
            mismatch_sequences.extend(preprocess_mismatch(ins["match_result"]))

    return mismatch_sequences

def clean_sequential_patterns():
    pass

def save_instances(instances:dict, data_path:str):
    for split, insts in instances.items():
        save_path = os.path.join(data_path, f"libriheavy_clean_{split}.jsonl")
        print(f"Saving {save_path}")
        with open(save_path, "w") as write_file:
            for ins in insts:
                to_write = json.dumps(ins) + "\n"
                write_file.write(to_write)

def get_mismatched(match_result:list):
    """
    Return the printable mismatched items in the match_result of an instance
    
    Paramters:
    - match_result (list): the data structure returned by align_strings() function
    
    Return:
    list: a list of strings, each string follows this format: {xxx}->{yyy}
    """
    result = []
    for written_ele, spoken_ele in match_result:
        if isinstance(written_ele, list):
            result.append("{{{}}}->{{{}}}".format(" ".join(written_ele), " ".join(spoken_ele)))
    return result

#**************************************************************************************************#
#********************** above end of mengao's processing of uncommon symbols **********************#
#**************************************************************************************************#