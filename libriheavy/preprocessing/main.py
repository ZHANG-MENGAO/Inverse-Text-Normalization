import re
import json
from tqdm import tqdm
import constants
from utility import *
import os

#after label
def post_clean(text):
    # Remove "" 
    text = re.sub(r'"', '', text)
    # Remove ' which is in not before < #TODO need change if format changes
    # move to label
    return text

def label_punctuation(text):

    punctuation_labels = {
        '.': {
            'salutation': r'(?<!\w)(Mrs\.|Ms\.|Mr\.|Dr\.)(?!\w)',
            'decimal': r'(\b(\d+\.\d+)\b)',
            'ellipsis': r'\.\.\.(\.*)',
            'acronym': r'\b[A-Za-z]\.([A-Za-z]\.)+',
            'name': r'\b[A-Z]\.\s[A-Z][a-z]+',
        },
        ',': {
            'date': r'(\b(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},\s+\d{4})\b',
            'enumeration': r'\b(\d{1,3}(,\d{3})*\b)',
            'pause': r'(?!\d{1,3}(,\d{3})*)(?!(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},\s+\d{4})\b,',
        },
        '&': {
            'et': r'\s&c\.',
            'and': r'(?<!<)&(?!c\.)',
        },
        '$': {
            'dollar': r'\$\d+(\.\d+)?',
        },
        ':': {
            'list': r'as follows\s*:',
            'conversation': r':\s*\"',
        },
        "\'": {
            'possess': r'\'s\s(?!a |an\b)',
            'contraction': r"(n)\'|\'(?=re|m|n|ve|d|t|n|em|s\sa|s\san\b)",
        },
        ';': {
            'semicolon': r';',
        },
        '—': {
            'unfinished': r'—\"',

        }
    }


    # Define substitution patterns for each label
    substitution_patterns = {
        'salutation': lambda match: match.group().replace('.','<. salutation>'),
        'decimal': lambda match: match.group().replace('.', '<. decimal>'),
        'ellipsis': '<... ellipsis>',
        'acronym': lambda match: match.group().replace('.', '<. acronym>'),
        'name': lambda match: match.group().replace('.', '<. name>'),
        # 'end_of_sentence': '<. end_of_sentence>',
        'enumeration': lambda match: match.group().replace(',', '<, enumeration>'),
        'pause': '<, pause>',
        'date': lambda match: match.group().replace(',', '<, date>'),
        'et': lambda match: match.group().replace('&','<&, et>'),
        'and': lambda match: match.group().replace('&','<&, and>'),
        'dollar': lambda match: match.group().replace('$', '<$ dollar>'),
        'list': lambda match: match.group().replace(':','<: list>'),
        'conversation': lambda match: match.group().replace(':','<: conversation>'),
        # 'explanation': lambda match: match.group().replace(':','<: explanation>'),
        'possess': lambda match: match.group().replace('\'','<\' possess>'),
        'contraction': lambda match: match.group().replace('\'','<\' contraction>'),
        'semicolon': '<; semicolon>',
        'unfinished': '.'
    }

    #TODO need to change if change label format
    post_punctuation_labels = {
        '.': {
            'end': r'(?<!<)\.',}, # not in form <. xxx>
        ':': {
            'explanation': r'(?<!<):',}, # not in form <: xxx>
        '\:': {
            'quote': r'(?<!<)\'',
        },
        '—': {
            'dash': r'—',
        }
        }
        
    post_substitution_patterns = {
        'end': '<. end>',
        'explanation': '<: explanation>',
        'quote': lambda match: match.group().replace("'",''),
        'dash': '',
    }

    labeled_text = text

    for punctuation, label_patterns in punctuation_labels.items():
        for label, pattern in label_patterns.items():
            regex_pattern = re.compile(pattern)
            replacement = substitution_patterns.get(label, f'<{punctuation} {label}>')
            if callable(replacement):  # If the replacement is a function, apply it
                labeled_text = regex_pattern.sub(replacement, labeled_text)
            else:
                labeled_text = re.sub(regex_pattern, replacement, labeled_text)
    
    for punctuation, label_patterns in post_punctuation_labels.items():
        for label, pattern in label_patterns.items():
            regex_pattern = re.compile(pattern)
            replacement = post_substitution_patterns.get(label, f'<{punctuation} {label}>')
            if callable(replacement):  # If the replacement is a function, apply it
                labeled_text = regex_pattern.sub(replacement, labeled_text)
            else:
                labeled_text = re.sub(regex_pattern, replacement, labeled_text)

    return labeled_text

def overwrite_labels(file_path):
    label_mapping = {
        "<. salutation>": ".",
        "<. decimal>": ".",
        "<. acronym>": ".",
        "<. name>": ".",
        "<. end>": " .",
        "<, enumeration>": " ,",
        "<, pause>": " ,",
        "<, date>": ",",
        "<&, et>":"",
        "<&, and>":"&",
        "<$ dollar>":"$",
        "<: list>":" :",
        "<: conversation>":" :",
        "<: explanation>":" :",
        "<\' possess>":"\'",
        "<\' contraction>":"\'",
        "<; semicolon>":" ;",
        # Add more mappings as needed
    }

    with open(file_path, 'r') as file:
        lines = file.readlines()

    with open(file_path, 'w') as file:
        for line in lines:
            for label, replacement in label_mapping.items():
                line = line.replace(label, replacement)

            file.write(line)

def overwrite_labels_inplace(written):
    label_mapping = {
        "<. salutation>": ".",
        "<. decimal>": ".",
        "<. acronym>": ".",
        "<. name>": ".",
        "<. end>": " .",
        "<, enumeration>": " ,",
        "<, pause>": " ,",
        "<, date>": ",",
        "<&, et>":"",
        "<&, and>":"&",
        "<$ dollar>":"$",
        "<: list>":" :",
        "<: conversation>":" :",
        "<: explanation>":" :",
        "<\' possess>":"\'",
        "<\' contraction>":"\'",
        "<; semicolon>":" ;",
        "<. . . ellipsis>": ""
        # Add more mappings as needed
    }
    for label, replacement in label_mapping.items():
        written = written.replace(label, replacement)
    return written


if __name__=='__main__':

    # first extract written/spoken text pair from jsonl file, 
    # may require large memory space because loaded all the instances.
    instances, discarded = extract_text(
        constants.splits, 
        constants.data_path, 
        constants.non_ascii_exceptions, 
        constants.bad_ascii
    )

    instances = clean(instances, constants.splits, constants.patterns_remove)

    ###############################################################
    # Aligns BookText and ASRTranscript and clean mismatches      #
    ###############################################################
    discard_symbol = 0
    for split in constants.splits:
        insts_split = instances[split]
        new_insts_split = []
        for ins in tqdm(insts_split):
            match_result, ratio = align_strings(ins["BookText"], ins["ASRTranscript"])
            if ratio < constants.threshold_ratio:
                discarded += 1
                continue
            if any([not x.isalnum() and 
                    x not in constants.ascii_exceptions and 
                    x not in constants.non_ascii_exceptions 
                    for x in ins["BookText"].strip().replace(" ", "")]):
                discard_symbol += 1
                discarded += 1
                continue

            ins = clean_mismatched(ins, match_result, constants.ascii_exceptions, constants.non_ascii_exceptions)
            # update match_result
            ins["match_result"], ins["ratio"] = align_strings(ins["BookText"], ins["ASRTranscript"])
            new_insts_split.append(ins)
        instances[split] = new_insts_split

    print("original number of instances: ", discarded+sum([len(i) for i in instances.values()]))
    print("After cleaning: ", sum([len(i) for i in instances.values()]))
    print("dropped instances: ", discarded)
    print("dropped instances because of nonexception ascii symbols:", discard_symbol)
    print("dropped percentage: ", discarded /(discarded+sum([len(i) for i in instances.values()])))
            
    ###############################################################
    # Use Sequential Pattern Mining to deep clean the dataset     #
    ###############################################################
    patterns = get_frequent_patterns(instances)
    print(patterns[:100])
    instances = clean_sequential_patterns(instances, patterns)
    save_instances(instances, constants.data_path)

    # for split in splits:
    #     input_file_path = f"{data_path}/libriheavy_clean_{split}.jsonl"
    #     output_file_path = f"{data_path}/libriheavy_clean_{split}_clean.jsonl"
    #     with open(input_file_path, 'r') as input_file, open(output_file_path, 'w') as output_file:
    #         # Process each line in the input file
    #         lines = input_file.readlines()
    #         for line in tqdm(lines):
    #             jsonObj = json.loads(line.strip())
    #             # Apply transformations to the current line
    #             transformed_line = clean(jsonObj["written"])
    #             transformed_line = label_punctuation(transformed_line)
    #             transformed_line = post_clean(transformed_line)
    #             transformed_line = overwrite_labels_inplace(transformed_line)
    #             # transformed_line += '\t'
    #             # new_line = "\t".join([transformed_line, spoken])
    #             jsonObj["written"] = transformed_line
    #             new_line = json.dumps(jsonObj)
    #             # Write the transformed line to the output file
    #             if '\n' not in new_line:
    #                 new_line += '\n'
    #             output_file.write(new_line)
    #     # overwrite_labels(output_file_path)
