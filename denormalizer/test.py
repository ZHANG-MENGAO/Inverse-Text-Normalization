import sys
import argparse

def change():
    sys.argv = sys.argv[0:1]

print(sys.argv)
parser = argparse.ArgumentParser()
parser.add_argument("--lr")
parser.add_argument("--dropout")
args = parser.parse_args()
print(args)

change()
print(sys.argv)
parser = argparse.ArgumentParser()
parser.add_argument("--lr")
parser.add_argument("--dropout")
args = parser.parse_args()
print(args)