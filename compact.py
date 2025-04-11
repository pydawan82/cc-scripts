"""Compact Lua file"""
import io
import re

def compact_lua(s: str):
    s = '\n'.join(l for l in s.splitlines() if not l.startswith('--'))
    return ' '.join(s for s in Compress._WS.split(s) if s)


class Compress(io.TextIOBase):
    _f: io.TextIOBase
    _WS = re.compile(r'\s+')

    def __init__(self, f: io.TextIOBase):
        super().__init__()
        self._f = f

    def read(self, size: int = -1):
        s = compact_lua(self._f.read(size))

        if size >= 0 and len(s) < size:
            s += self.read(size - len(s))

        return s

    def write(self, s: str):
        self._f.write(compact_lua(s))

    def __enter__(self):
        self._f.__enter__()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return self._f.__exit__(exc_type, exc_val, exc_tb)


if __name__ == '__main__':
    with Compress(open('lib/json.lua')) as f:
        print(f.read(-1))
