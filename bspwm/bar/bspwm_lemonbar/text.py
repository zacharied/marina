from enum import Enum, auto

class Style(Enum):
    REGULAR   = auto()
    BOLD      = auto()
    ITALIC  = auto()
    MONOSPACE = auto()
    ICON   = auto()

class Decoration(Enum):
    UNDERLINE = auto()
    OVERLINE  = auto()

class Alignment(Enum):
    LEFT   = auto()
    CENTER = auto()
    RIGHT  = auto()

class Layer(Enum):
    BACKGROUND = auto()
    FOREGROUND = auto()

_style_options = {
    Style.REGULAR:   '-',
    Style.BOLD:      '2',
    Style.ITALIC:    '3',
    Style.MONOSPACE: '4',
    Style.ICON:      '5'
}

def style(s, text):
    return '%{{T{0}}}{1}%{{T-}}'.format(_style_options[s], text)

_decorate_options = {
    Decoration.UNDERLINE: 'u',
    Decoration.OVERLINE: 'o'
}

def decorate(d, text):
    return '%{{+{0}}}{1}%{{-{0}}}'.format(_decorate_options[d], text)

_align_options = {
    Alignment.LEFT: 'l',
    Alignment.CENTER: 'c',
    Alignment.RIGHT: 'r'
}
def align(a, text):
    return '%{' + _align_options[a] + '}' + text

def offset(o):
    return '%{{O{}}}'.format(o)

_color_options = {
    Layer.BACKGROUND: 'B',
    Layer.FOREGROUND: 'F'
}

def color(layer, color, text):
    return '%{{{l}{c}}}%{{U{c}}}{t}%{{{l}-}}'.format(l=_color_options[layer], c=color, t=text)
