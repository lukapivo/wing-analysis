import argparse
from itertools import groupby

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--surf', action="store_true")
    parser.add_argument('filename', type=str, help='Input filename')
    parser.add_argument('-o', '--output', help='Output filename')

    args = parser.parse_args()
    print("Hello from foiltools!")

    if args.surf:
        with open(args.filename) as f:
            lines = f.readlines()

        # print(lines)

        

        sections = list(list(g) for _, g in groupby(lines, key='\n'.__ne__))

        preamble = lines[0]
        top = sections[2]
        bottom = sections[4]
        del bottom[0]

        print(bottom)

        output = list(reversed(top)) + bottom

        if args.output is not None:
            dest = args.output
        else:
            # print(args.filename.split('.'))
            dest = args.filename.replace('.dat','.surf')
        # print(dest)
        with open(dest, 'w') as f:
            f.write(''.join(output))


if __name__ == "__main__":
    main()
